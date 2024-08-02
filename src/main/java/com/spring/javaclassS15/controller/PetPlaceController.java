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
import com.spring.javaclassS15.service.PetPlaceService;
import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PetCafeReviewVO;
import com.spring.javaclassS15.vo.PetCafeVO;

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
	public String petCafeGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO memberVO = petPlaceService.getMemberinfo(mid);
		PetCafeVO vo = new PetCafeVO();
		List<PetCafeVO> vos = petPlaceService.getPetCafeMap();
		
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("vo", vo);
		model.addAttribute("jsonVos", JSONArray.fromObject(vos));
		return "petPlace/petCafe";
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
	public String petCafeReviewListGet(int idx, Model model) {
		List<PetCafeReviewVO> vos = petPlaceService.getPetCafeReviewList(idx);
		PetCafeVO cafeVO = petPlaceService.getCafeInfo(idx);
		
		model.addAttribute("vos", vos);
		model.addAttribute("cafeVO", cafeVO);
		return "petPlace/petCafeReviewList";
	}
	
	@RequestMapping(value = "/petCafeReviewContent", method = RequestMethod.GET)
	public String petCafeReviwContentGet(int idx, int placeIdx, Model model) {
		PetCafeReviewVO vo = petPlaceService.getPetCafeReviewContent(idx);
		//PetCafeVO cafeVO = petPlaceService.getCafeInfoContent();
		PetCafeVO cafeVO = petPlaceService.getCafeInfo(placeIdx);
		
		model.addAttribute("vo", vo);
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
}
