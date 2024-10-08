package com.spring.javaclassS15.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.pagenation.PageProcess;
import com.spring.javaclassS15.service.MemberService;
import com.spring.javaclassS15.vo.MemberPetVO;
import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PageVO;
import com.spring.javaclassS15.vo.WishPlaceVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	@Autowired
	PageProcess pageProcess;
	
	// 로그인 폼
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();

		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
	//로그인 처리
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response, HttpSession session,
		String mid, String pwd, String idSave) {
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sPhoto", vo.getPhoto());
			session.setAttribute("sLevel", vo.getLevel());
			
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				cookieMid.setPath("/");		// 검색을 루트부터
				cookieMid.setMaxAge(60*60*24*7);		//쿠키의 만료시간을 7일로 지정
				response.addCookie(cookieMid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cMid")) {
							cookies[i].setMaxAge(0);	// 만료시긴을 0으로 줘서 삭제
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			memberService.setMemberLastDate(mid);
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strToday = sdf.format(today);
			
			if(!strToday.equals(vo.getLastDate().substring(0,10))) {
				// 오늘 처음 방문한 경우(오늘 방문카운트는 1로, 기존 포인트에 +10)
				vo.setTodayCnt(1);
				vo.setPoint((vo.getPoint() + 10));
			}
			else {
				// 오늘 다시 방문한경우(오늘 방문카운트는 오늘방문카운트 + 1, 포인트증가는? 오늘 방문횟수가 1회전까지라면 기존포인트에 +10)
				vo.setTodayCnt(vo.getTodayCnt() + 1);
				if(vo.getTodayCnt() <= 1) vo.setPoint(vo.getPoint() + 10);
			}
			memberService.setLoginUpdate(vo);
			
			return "redirect:/message/memberLoginOK?mid="+mid;
		}
		else return "redirect:/message/memberLoginNO";
	}
	
	// 카카오 로그인
	@RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
	public String kakaoLoginGet(String nickName, String email, String accessToken, HttpServletRequest request,
			HttpSession session) throws MessagingException {
		
		// 카카오 로그아웃을 위한 카카오앱키를 세션에ㅔ 저장시켜둔다.
		session.setAttribute("sAccessToken", accessToken);
		session.setAttribute("sLogin", "kakao");
		
		// 카카오 로그인한 회원인 경우에는 우리 회원인지를 조사한다.. (넘어온 이메일을 @기준으로 아이디와 분리해서 기존 member2테이블의 아이디와 비교한다.)
		MemberVO vo = memberService.getMemberNickNameEmailCheck(nickName, email);
		
		// 현재 카카오로그인에 의한 우리 회원이 아니였다면, 자동으로 우리 회원에 가입처리한다.
		// 필수 입력 : 아이디, 닉네임, 이메일, 성명(닉네임으로 대체), 비밀번호(임시비밀번호 발급처리)
		String newMember = "NO"; // 신규회원인지에 대한 정의(신규회원:OK, 기존회원:NO)
		if(vo == null) {
			// 아이디 결정하기
			String mid = email.substring(0, email.indexOf("@"));
			
			// 만약 기존에 같은 아이디가 존재함다면 가입처리 불가..
			MemberVO vo2 = memberService.getMemberIdCheck(mid);
			if(vo2 != null) return "redirect:/message/midSamSearch";
			
			// 비밀번호 (임시비밀번호 발급처리)
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			session.setAttribute("sImsiPwd", pwd);
			
			// 새로 발급된 비밀번호를 암호화 시켜서 db에 저장처리한다. (카카오 로그인한 신입회원은 바로 정회원으로 등급 업 시켜준다.)
			memberService.setKakaoMemberInput(mid, passwordEncoder.encode(pwd), nickName, email);
			
			// 새로 발급받은 임시비밀번호를 메일로 전송한다.
			javaclassProvide.mailSend(email, "임시비밀번호를 발급하였습니다.", pwd); 	// 예외처리
			
			// 새로 가입처리된 회원의 정보를 다시 vo에 담아준다.
			vo = memberService.getMemberIdCheck(mid);
			
			// 비밀번호를 새로 발급처리했을때 sLogin세션을 발생시켜주고, memberMain창에 비밀번호 변경 메세지를 지속적으로 뿌려준다.
			session.setAttribute("sLoginNew", "OK");
			
			newMember = "OK";
		}
		
		// 로그인 인증완료시 처리할 부분(세션, 기타 설정값)
		// 1. 세션처리
		session.setAttribute("sMid", vo.getMid());
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sPhoto", vo.getPhoto());
		session.setAttribute("sLevel", vo.getLevel());
		
		// 3. 기타처리(DB에처리해야할것들 (반뭉카운트, 포인트,,, 등))
		// 방문포인트 : 1회방문시 point 10점할당, 1일 최대 50점까지 할당가능
		// 숙제,,
		//int point = 10;
		
		// 방문카운트
		//memberService.setMemberInforUpdate(vo.getMid(), point);
		
		// 로그인 완료 후 모든 처리가 끝나면 필요한 메세지처리 후 memberMain으로 보낸다.
		if(newMember.equals("NO")) return "redirect:/message/memberLoginOK?mid="+vo.getMid();	//기존회원이니까 기존 로그인 완료 alert
		else return "redirect:/message/memberLoginNewOK?mid="+vo.getMid();	//카카오로 처음 로그인한 신규회원이니까 임시메세지 발급 메세지
	}
	
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		session.invalidate();
		return "redirect:/message/memberLogout";
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberAddressSearchOK", method = RequestMethod.POST)
	public ArrayList<String> memberAddressSearchOKPost(String search, String searchSelector) throws IOException {
		Connection conn = Jsoup.connect(search);
		
		Document document = conn.get();
		
		Elements selects = document.select(searchSelector);
		
		ArrayList<String> vos = new ArrayList<String>();
		
		for (Element select : selects) {
			vos.add(select.html());
		}
		
		return vos;
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {			//, MultipartFile fName
		if(memberService.getMemberIdCheck(vo.getMid()) != null) return "redirect:/message/memberJoinIdNO";
		if(memberService.getmemberNickCheck(vo.getNickName()) != null) return "redirect:/message/memberJoinNickNO";
		
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
//		if(!fName.getOriginalFilename().equals(""))vo.setPhoto(memberService.fileUpload(fName, vo.getMid()));
//		else vo.setPhoto("noimage.png");
		
		int res = memberService.setMemberJoinOK(vo);
		
		if(res != 0) return "redirect:/message/memberJoinOK";
		else return "redirect:/message/memberJoinNO";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberNickCheck", method = RequestMethod.POST)
	public String memberNickCheckPost(String nickName) {
		
		MemberVO vo = memberService.getmemberNickCheck(nickName);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	@RequestMapping(value = "/memberMain", method = RequestMethod.GET)
	public String memberMainGet() {
		return "member/memberMain";
	}
	
	@RequestMapping(value = "/memberMypage", method = RequestMethod.GET)
	public String memberMypageGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		List<MemberPetVO> pVos = memberService.getMemberPetList(mid);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pVos", pVos);
		return "member/memberMypage";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String memberUpdatePost(MemberVO vo, MultipartFile updateFName, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		
		if(!updateFName.getOriginalFilename().equals("")) {
			if(!vo.getPhoto().equals("noimage.png")) {		// 새로등록하려고 하는 사진이있는데 기본프로필이 아니면 기존 db에있는 사진을 지운 후 update
				javaclassProvide.deleteFile(vo.getPhoto(), "member");
			}
			vo.setPhoto(memberService.fileUpload(updateFName, mid));
		}
		else if(updateFName.getOriginalFilename().equals("")) vo.setPhoto(vo.getPhoto());
		
		System.out.println("컨트롤러 vo : " + vo);
		int res = memberService.setMemberUpdateOK(vo, mid);
		if(res != 0) return "redirect:/message/memberUpdateOK";
		else return "redirect:/message/memberUpdateNO";
	}
	
	@RequestMapping(value = "/memberMypagePetInsert", method = RequestMethod.POST)
	public String memberMypagePetInsertPost(MemberPetVO petVO, MultipartFile fName, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		if(!fName.getOriginalFilename().equals("")) petVO.setPetPhoto(memberService.fileUploadPet(fName, mid));
		else petVO.setPetPhoto("noimage-pet.png");
		
		int res = memberService.setMemberPetInsertOK(petVO, mid);
		if(res != 0) return "redirect:/message/petInsertOK";
		else return "redirect:/message/petInsertNO";
	}
	
	@RequestMapping(value = "/memberMypagePetUpdate", method = RequestMethod.POST)
	public String memberMypagePetUpdatePost(MemberPetVO petVO, MultipartFile updateFName, HttpSession session, int idx) {
		String mid = (String) session.getAttribute("sMid");
		if(!updateFName.getOriginalFilename().equals("")) {
			if(!petVO.getPetPhoto().equals("noimage-pet.png")) {		// 새로등록하려고 하는 사진이있는데 기본프로필이 아니면 기존 db에있는 사진을 지운 후 update
				javaclassProvide.deleteFile(petVO.getPetPhoto(), "memberPet");
			}
			petVO.setPetPhoto(memberService.fileUploadPet(updateFName, mid));
		}
		else petVO.setPetPhoto(petVO.getPetPhoto());
		
		int res = memberService.setMemberMypagePetUpdateOK(petVO, idx);
		if(res != 0) return "redirect:/message/petUpdateOK";
		else return "redirect:/message/petUpdateNO";
	}

	@ResponseBody
	@RequestMapping(value = "/memberPetDelete", method = RequestMethod.POST)
	public String memberPetDeletePost(int idx, String petPhoto) {
		if(!petPhoto.equals("noimage-pet.png")) javaclassProvide.deleteFile(petPhoto, "memberPet");
		
		return memberService.setMemberPetDeleteOK(idx)+ "";
	}
	
	@RequestMapping(value = "/wishPlace", method = RequestMethod.GET)
	public String wishPlaceGet(String mid, Model model,
			@RequestParam(name="part", defaultValue = "cafe", required = false) String part,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "wishCafe", mid, "cafe",0);
		PageVO pageVOh = pageProcess.totRecCnt(pag, pageSize, "wishHospital", mid, "hospital",0);
		
		String cafePart = "cafe";
		String hospitalPart = "hospital";
		
		List<WishPlaceVO> cafeVos = memberService.getCafeWishPlace(mid, cafePart, pageVO.getStartIndexNo(), pageSize);
		List<WishPlaceVO> hospitalVos = memberService.getHospitalWishPlace(mid, hospitalPart, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("cafeVos", cafeVos);
		model.addAttribute("hospitalVos", hospitalVos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("pageVOh", pageVOh);
		
		return "member/wishPlace";
	}
	
}
