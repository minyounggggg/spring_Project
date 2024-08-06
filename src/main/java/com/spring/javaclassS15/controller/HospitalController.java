package com.spring.javaclassS15.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import com.spring.javaclassS15.service.HospitalService;
import com.spring.javaclassS15.vo.HospitalReviewVO;
import com.spring.javaclassS15.vo.HospitalVO;
import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PageVO;
import com.spring.javaclassS15.vo.PetCafeReviewVO;
import com.spring.javaclassS15.vo.PetCafeVO;
import com.spring.javaclassS15.vo.WishPlaceVO;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/hospital")
public class HospitalController {
	
	@Autowired
	HospitalService hospitalService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	@Autowired
	PageProcess pageProcess;
	
	
	@RequestMapping(value = "/hospitalForm", method = RequestMethod.GET)
	public String hospitalFormGet() {
		return "hospital/hospitalForm";
	}
	
	// CSV파일을 MySQL파일로 변환하기
	@ResponseBody
	@RequestMapping(value = "/hospitalForm", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String csvFormPost(MultipartFile fName, HttpServletRequest request) throws IOException {
		return hospitalService.fileCsvToMysql(fName);
	}

	@RequestMapping(value = "/hospital", method = RequestMethod.GET)
	public String hospitalGet(Model model, HttpSession session, HttpServletRequest request) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO memberVO = hospitalService.getMemberinfo(mid);
		HospitalVO vo = new HospitalVO();
		List<HospitalVO> vos = hospitalService.getHospitalMap();
		List<HospitalReviewVO> hospitalReviewVos = hospitalService.gethospitalReview();
		request.setAttribute("cafeReviewVos2", hospitalReviewVos);
		
		model.addAttribute("cafeReviewVos", hospitalReviewVos);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("vo", vo);
		model.addAttribute("jsonVos", JSONArray.fromObject(vos));
		return "hospital/hospital";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reviewMiniView", method = RequestMethod.POST)
	public List<HospitalReviewVO> reviewMiniViewGet(Model model, int idx) {
		List<HospitalReviewVO> vos = hospitalService.getReviewMiniViewList(idx);
		model.addAttribute("vos", vos);
		//model.addAttribute("miniViewVos", JSONArray.fromObject(vos));
		//System.out.println("vos : " + vos);
		return vos;
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
	
	@RequestMapping(value = "/hospitalReviewList", method = RequestMethod.GET)
	public String hospitalReviewListGet(int idx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "hospitalReview", "", "", idx);
		
		List<HospitalReviewVO> vos = hospitalService.getHospitalReviewList(idx, pageVO.getStartIndexNo(), pageSize);
		HospitalVO hospitalVO = hospitalService.getHospitalInfo(idx);
		
		model.addAttribute("vos", vos);
		model.addAttribute("cafeVO", hospitalVO);
		model.addAttribute("pageVO", pageVO);
		return "hospital/hospitalReviewList";
	}
	
	@RequestMapping(value = "/hospitalReviewContent", method = RequestMethod.GET)
	public String hospitalReviwContentGet(int idx, int placeIdx, Model model) {
		HospitalReviewVO vo = hospitalService.getHospitalReviewContent(idx);
		//PetCafeVO cafeVO = petPlaceService.getCafeInfoContent();
		HospitalVO hospitalVO = hospitalService.getHospitalInfo(placeIdx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("cafeVO", hospitalVO);
		return "hospital/hospitalReviewContent";
	}
	
	@RequestMapping(value = "/hospitalReviewInsert", method = RequestMethod.GET)
	public String hospitalReviwInsertGet(Model model, int placeIdx) {
		HospitalVO hospitalVO = hospitalService.getHospitalInfo(placeIdx);
		
		model.addAttribute("cafeVO", hospitalVO);
		return "hospital/hospitalReviewInsert";
	}
	
	@RequestMapping(value = "/hospitalReviewInsert", method = RequestMethod.POST)
	public String hospitalReviwInsertPost(HospitalReviewVO vo, int placeIdx) {
		// 1. 만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 board폴더에 따로 보관시켜준다. ('/data/ckeditor'폴더에서 '/data/cafeReview'폴더로 복사처리) 
		if(vo.getContent().indexOf("src=\"/") != -1) hospitalService.imgCheck(vo.getContent());
		
		// 2. 이미지 작업(복사작업)을 모두 마치면, ckeditor 폴더 경로를 cafeReview 폴더 경로로 변경처리한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/hospital/"));
		
		// 3. content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은 후 DB에 저장한다.
		int res = hospitalService.setHospitalReviewInsert(vo);
		
		if(res != 0) return "redirect:/message/hospitalReviewInsertOK?idx="+placeIdx;
		else return "redirect:/message/hospitalReviewInsertNO?idx="+placeIdx;
	}
	
	@RequestMapping(value = "/hospitalReviewUpdate", method = RequestMethod.GET)
	public String petCafeReviewUpdateGet(Model model, int idx,  int placeIdx) {
		HospitalReviewVO vo = hospitalService.getHospitalReviewContent(idx);
		HospitalVO hospitalVO = hospitalService.getHospitalInfo(placeIdx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("cafeVO", hospitalVO);
		return "hospital/hospitalReviewUpdate";
	}
	
	@RequestMapping(value = "/hospitalReviewUpdate", method = RequestMethod.POST)
	public String hospitalReviewUpdatePost(Model model, HospitalReviewVO vo) {
		// 수정된 자료가 원본자료와 완전히 동일하다면 고치지않은거니까 수정할 필요가 없다. 즉, DB에 저장된 원본자료를 불러와서 현재 vo에 담긴 내용(content)과 비교해본다.
		HospitalReviewVO origVo = hospitalService.getHospitalReviewContent(vo.getIdx());
		
		// content의 내용이 조금이라도 변경이 되었다면 내용을 수정한 것이기에, 그림파일 처리 유무를 결정한다.
		if(!origVo.getContent().equals(vo.getContent())) {
			// 1.기존 cafeReview폴더에 그림이 존재했다면 원본그림을 모두 삭제처리한다.(원본그림은 수정창에 들어오기 전에 ckeditor폴더에 저장시켜두었다)
			if(origVo.getContent().indexOf("src=\"/") != -1) hospitalService.imgDelete(origVo.getContent());
			
			// 2.앞의 삭제 작업이 끝나면 'cafeReview'폴더를 'ckeditor'로 변경한다.
			vo.setContent(vo.getContent().replace("/data/hospital/", "/data/ckeditor/"));
			
			// 1,2 작업을 마치면 파일을 처음 업로드한것과 같은 작업처리를 해준다.
			// 즉, content에 이미지가 저장되어있다면, 저장된 이미지만 골라서 '/data/cafeReview/'폴더에 복사 저장처리한다.
			if(vo.getContent().indexOf("src=\"/") != -1) hospitalService.imgCheck(vo.getContent());
			
			//이미지들의 모든 복사작업을 마치면, 폴더명을 ckeditor에서 cafeReview폴더로 변경처리한다.
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/hospital/"));
			
			// content안의 내용과 그림파일까지, 잘 정비된 vo를 DB에 Update시켜준다.
		}
		int res = hospitalService.setHospitalReviewUpdate(vo);
		
		model.addAttribute("idx", vo.getIdx());
		
		if(res != 0) return "redirect:/message/hospitalReviewUpdateOk?updateIdx="+vo.getIdx()+"&placeIdx="+vo.getPlaceIdx();
		else return "redirect:/message/hospitalReviewUpdateNo?updateIdx="+vo.getIdx()+"&placeIdx="+vo.getPlaceIdx();
	}
	
	@RequestMapping(value = "/hospitalReviewDelete", method = RequestMethod.GET)
	public String hospitalReviewDeleteGet(int idx,  int placeIdx) {
		// 게시글에 사진이 존재한다면 서버에 저장된 사진을 삭제처리한다.
		HospitalReviewVO vo = hospitalService.getHospitalReviewContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) hospitalService.imgDelete(vo.getContent());
		
		// 사진작업이 끝나면 DB에 저장된 실제 정보레코드를 삭제처리한다.
		int res = hospitalService.setHospitalReviewDelete(idx);
		
		if(res != 0) return "redirect:/message/hospitalReviewDeleteOK?idx="+placeIdx;
		else return "redirect:/message/hospitalReviewDeleteNO?idx="+placeIdx;
	}
	
	@ResponseBody
	@RequestMapping(value = "/wishPlaceSave", method = RequestMethod.POST)
	public String wishPlaceSavePost(int placeIdx, String part, String mid, String nickName, String placeName, HttpSession session, WishPlaceVO wishVO, HttpServletRequest request) {
		
		mid = (String) session.getAttribute("sMid");
		nickName = (String) session.getAttribute("sNickName");
		
		HospitalVO vo = hospitalService.getPlaceName(placeIdx);
		placeName = vo.getPlaceName();
		String sido = vo.getSido();
		String sigungu = vo.getSigungu();
		String dong = vo.getDong();
		
		// 찜 목록 증가처리 (중복 불허)
		int res = 0;
		session = request.getSession(); //게시글을 보는순간 세션이 생긴다.
		ArrayList<String> wishPlace = (ArrayList<String>)session.getAttribute("sWishPlace");
		
		if(wishPlace == null) wishPlace = new ArrayList<String>();
		String imsiWishPlace = "wishPlaceCheck" + placeIdx;
		
		if(!wishPlace.contains(imsiWishPlace)) {  //"contains"= 포함하고있냐는 명령 / (imsiContentReadNum를 포함하고있니?)
			hospitalService.setWishPlace(mid, nickName, part, placeIdx, placeName, sido, sigungu, dong);
			wishPlace.add(imsiWishPlace);
			res = 1;
		}
		session.setAttribute("sWishPlace", wishPlace);
		
		return res + "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/wishPlaceDelete", method = RequestMethod.POST)
	public String wishPlaceDeletePost(HttpSession session, int placeIdx, String part) {
		session.removeAttribute("sWishPlace");
		
		String mid = (String) session.getAttribute("sMid");
		
		int res = hospitalService.setWishPlaceDelete(mid, part, placeIdx);
		return res + "";
	}
	
}
