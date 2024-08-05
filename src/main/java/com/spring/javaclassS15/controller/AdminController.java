package com.spring.javaclassS15.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.service.AdminService;
import com.spring.javaclassS15.vo.ChartVO;
import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.ProductReviewVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	
	// 일주일간 항목별 리뷰 업로드 수 차트로 보기
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet(Model model) {
		
		int cafeReviewCnt = adminService.getCafeReviewCount();
		int hospitalReviewCnt = adminService.getHospitalReviewCount();
		int productReviewCnt = adminService.getProductReviewCount();
		
		model.addAttribute("cafeReviewCnt", cafeReviewCnt);
		model.addAttribute("hospitalReviewCnt", hospitalReviewCnt);
		model.addAttribute("productReviewCnt", productReviewCnt);
		return "admin/adminMain";
	}
	
	// 신고리스트 보기
	@RequestMapping(value = "/complaintList", method = RequestMethod.GET)
	public String complaintListGet(Model model) {
		
		List<ProductReviewVO> vos = adminService.getComplaintList();
		model.addAttribute("vos", vos);
		
		return "admin/complaintList";
	}
	
	// 신고리스트 삭제
	@RequestMapping(value = "/reviewDeleteOk", method = RequestMethod.POST)
	public String reviewDeleteOkPost(int idx, String productPhoto) {
		
		javaclassProvide.deleteFile(productPhoto, "productReview");
		
		return "admin/complaintList";
	}
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String indexGet() {
		
		return "admin/index";
	}
	
	@RequestMapping(value = "/layoutSidenavLight", method = RequestMethod.GET)
	public String layoutSidenavLightGet() {
		
		return "admin/layout-sidenav-light";
	}
	
	@RequestMapping(value = "/layoutStatic", method = RequestMethod.GET)
	public String layoutStaticGet() {
		
		return "admin/layout-static";
	}
	
	@RequestMapping(value = "/charts", method = RequestMethod.GET)
	public String chartsGet() {
		
		return "admin/charts";
	}
	
	@RequestMapping(value = "/tables", method = RequestMethod.GET)
	public String tablesGet() {
		
		return "admin/tables";
	}
	
	
	
}
