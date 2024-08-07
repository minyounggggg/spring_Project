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
import com.spring.javaclassS15.service.PetPlaceService;
import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PageVO;
import com.spring.javaclassS15.vo.PetCafeReviewVO;
import com.spring.javaclassS15.vo.PetCafeVO;
import com.spring.javaclassS15.vo.WishPlaceVO;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/petPlace")
public class PetPlaceController {
	
	@Autowired
	PetPlaceService petPlaceService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	@Autowired
	PageProcess pageProcess;
	
	
	@RequestMapping(value = "/petCafeForm", method = RequestMethod.GET)
	public String petCafeFormGet() {
		return "petPlace/petCafeForm";
	}
	
	// CSV파일을 MySQL파일로 변환하기
	@ResponseBody
	@RequestMapping(value = "/petCafeForm", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String csvFormPost(MultipartFile fName, HttpServletRequest request) throws IOException {
		return petPlaceService.fileCsvToMysql(fName);
	}

	@RequestMapping(value = "/petCafe", method = RequestMethod.GET)
	public String petCafeGet(Model model, HttpSession session, HttpServletRequest request) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO memberVO = petPlaceService.getMemberinfo(mid);
		PetCafeVO vo = new PetCafeVO();
		List<PetCafeVO> vos = petPlaceService.getPetCafeMap();
		List<PetCafeReviewVO> cafeReviewVos = petPlaceService.getCafeReview();
		request.setAttribute("cafeReviewVos2", cafeReviewVos);
		
	
		
		List<Integer> res = new ArrayList<Integer>(); 
		for(PetCafeVO vo1 :vos ) {
			
			int r =petPlaceService.getWishPlace(mid, vo1.getIdx());
			res.add(r);
		}
		
		model.addAttribute("cafeReviewVos", cafeReviewVos);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("vo", vo);
		model.addAttribute("res", res);
		model.addAttribute("jsonVos", JSONArray.fromObject(vos));
		return "petPlace/petCafe";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reviewMiniView", method = RequestMethod.POST)
	public List<PetCafeReviewVO> reviewMiniViewGet(Model model, int idx) {
		List<PetCafeReviewVO> vos = petPlaceService.getReviewMiniViewList(idx);
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
	
	@RequestMapping(value = "/petCafeReviewList", method = RequestMethod.GET)
	public String petCafeReviewListGet(int idx, Model model,HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "cafeReview", "", "", idx);
		
		List<PetCafeReviewVO> vos = petPlaceService.getPetCafeReviewList(idx, pageVO.getStartIndexNo(), pageSize);
		PetCafeVO cafeVO = petPlaceService.getCafeInfo(idx);
		
		String mid = (String) session.getAttribute("sMid");
		int res = petPlaceService.getWishPlace(mid, idx);
		
		model.addAttribute("vos", vos);
		model.addAttribute("res", res);
		model.addAttribute("cafeVO", cafeVO);
		model.addAttribute("pageVO", pageVO);
		return "petPlace/petCafeReviewList";
	}
	
	@RequestMapping(value = "/petCafeReviewContent", method = RequestMethod.GET)
	public String petCafeReviwContentGet(int idx, int placeIdx, Model model, HttpSession session) {
		PetCafeReviewVO vo = petPlaceService.getPetCafeReviewContent(idx);
		//PetCafeVO cafeVO = petPlaceService.getCafeInfoContent();
		PetCafeVO cafeVO = petPlaceService.getCafeInfo(placeIdx);
		String mid = (String) session.getAttribute("sMid");
		int res = petPlaceService.getWishPlace(mid, placeIdx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("res", res);
		model.addAttribute("cafeVO", cafeVO);
		return "petPlace/petCafeReviewContent";
	}
	
	@RequestMapping(value = "/petCafeReviewInsert", method = RequestMethod.GET)
	public String petCafeReviwInsertGet(Model model, int placeIdx) {
		PetCafeVO cafeVO = petPlaceService.getCafeInfo(placeIdx);
		
		model.addAttribute("cafeVO", cafeVO);
		return "petPlace/petCafeReviewInsert";
	}
	
	@RequestMapping(value = "/petCafeReviewInsert", method = RequestMethod.POST)
	public String petCafeReviwInsertPost(PetCafeReviewVO vo, int placeIdx) {
		// 1. 만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 board폴더에 따로 보관시켜준다. ('/data/ckeditor'폴더에서 '/data/cafeReview'폴더로 복사처리) 
		if(vo.getContent().indexOf("src=\"/") != -1) petPlaceService.imgCheck(vo.getContent());
		
		// 2. 이미지 작업(복사작업)을 모두 마치면, ckeditor 폴더 경로를 cafeReview 폴더 경로로 변경처리한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/cafeReview/"));
		
		// 3. content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은 후 DB에 저장한다.
		int res = petPlaceService.setPetCafeReviewInsert(vo);
		
		if(res != 0) return "redirect:/message/petCafeReviewInsertOK?idx="+placeIdx;
		else return "redirect:/message/petCafeReviewInsertNO?idx="+placeIdx;
	}
	
	@RequestMapping(value = "/petCafeReviewUpdate", method = RequestMethod.GET)
	public String petCafeReviewUpdateGet(Model model, int idx,  int placeIdx) {
		PetCafeReviewVO vo = petPlaceService.getPetCafeReviewContent(idx);
		PetCafeVO cafeVO = petPlaceService.getCafeInfo(placeIdx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("cafeVO", cafeVO);
		return "petPlace/petCafeReviewUpdate";
	}
	
	@RequestMapping(value = "/petCafeReviewUpdate", method = RequestMethod.POST)
	public String petCafeReviewUpdatePost(Model model, PetCafeReviewVO vo) {
		// 수정된 자료가 원본자료와 완전히 동일하다면 고치지않은거니까 수정할 필요가 없다. 즉, DB에 저장된 원본자료를 불러와서 현재 vo에 담긴 내용(content)과 비교해본다.
		PetCafeReviewVO origVo = petPlaceService.getPetCafeReviewContent(vo.getIdx());
		
		// content의 내용이 조금이라도 변경이 되었다면 내용을 수정한 것이기에, 그림파일 처리 유무를 결정한다.
		if(!origVo.getContent().equals(vo.getContent())) {
			// 1.기존 cafeReview폴더에 그림이 존재했다면 원본그림을 모두 삭제처리한다.(원본그림은 수정창에 들어오기 전에 ckeditor폴더에 저장시켜두었다)
			if(origVo.getContent().indexOf("src=\"/") != -1) petPlaceService.imgDelete(origVo.getContent());
			
			// 2.앞의 삭제 작업이 끝나면 'cafeReview'폴더를 'ckeditor'로 변경한다.
			vo.setContent(vo.getContent().replace("/data/cafeReview/", "/data/ckeditor/"));
			
			// 1,2 작업을 마치면 파일을 처음 업로드한것과 같은 작업처리를 해준다.
			// 즉, content에 이미지가 저장되어있다면, 저장된 이미지만 골라서 '/data/cafeReview/'폴더에 복사 저장처리한다.
			if(vo.getContent().indexOf("src=\"/") != -1) petPlaceService.imgCheck(vo.getContent());
			
			//이미지들의 모든 복사작업을 마치면, 폴더명을 ckeditor에서 cafeReview폴더로 변경처리한다.
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/cafeReview/"));
			
			// content안의 내용과 그림파일까지, 잘 정비된 vo를 DB에 Update시켜준다.
		}
		int res = petPlaceService.setCafeReviewUpdate(vo);
		
		model.addAttribute("idx", vo.getIdx());
		
		if(res != 0) return "redirect:/message/cafeReviewUpdateOk?updateIdx="+vo.getIdx()+"&placeIdx="+vo.getPlaceIdx();
		else return "redirect:/message/cafeReviewUpdateNo?updateIdx="+vo.getIdx()+"&placeIdx="+vo.getPlaceIdx();
	}
	
	@RequestMapping(value = "/cafeReviewDelete", method = RequestMethod.GET)
	public String cafeReviewDeleteGet(int idx,  int placeIdx) {
		// 게시글에 사진이 존재한다면 서버에 저장된 사진을 삭제처리한다.
		PetCafeReviewVO vo = petPlaceService.getPetCafeReviewContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) petPlaceService.imgDelete(vo.getContent());
		
		// 사진작업이 끝나면 DB에 저장된 실제 정보레코드를 삭제처리한다.
		int res = petPlaceService.setCafeReviewDelete(idx);
		
		if(res != 0) return "redirect:/message/cafeReviewDeleteOK?idx="+placeIdx;
		else return "redirect:/message/cafeReviewDeleteNO?idx="+placeIdx;
	}
	
	@ResponseBody
	@RequestMapping(value = "/wishPlaceSave", method = RequestMethod.POST)
	public String wishPlaceSavePost(Model model, int placeIdx, String part, String mid, String nickName, String placeName, HttpSession session, WishPlaceVO wishVO, HttpServletRequest request) {
		
		mid = (String) session.getAttribute("sMid");
		nickName = (String) session.getAttribute("sNickName");
		
		PetCafeVO vo = petPlaceService.getPlaceName(placeIdx);
		placeName = vo.getPlaceName();
		String sido = vo.getSido();
		String sigungu = vo.getSigungu();
		String dong = vo.getDong();
		
		WishPlaceVO wishVos = petPlaceService.getWishcheck(mid, placeIdx); 
		model.addAttribute("wishVos", wishVos);
		
		int res = petPlaceService.setWishPlace(mid, nickName, part, placeIdx, placeName, sido, sigungu, dong);
		return res + "";
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/wishPlaceDelete", method = RequestMethod.POST)
	public String wishPlaceDeletePost(HttpSession session, int placeIdx, String part) {
		//session.removeAttribute("sWishPlace");
		
		String mid = (String) session.getAttribute("sMid");
		
		int res = petPlaceService.setWishPlaceDelete(mid, part, placeIdx);
		return res + "";
	}
	
	
}
