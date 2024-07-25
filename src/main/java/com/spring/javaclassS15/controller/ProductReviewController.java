package com.spring.javaclassS15.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.service.ProductReviewService;
import com.spring.javaclassS15.vo.ProductReviewVO;
import com.spring.javaclassS15.vo.ReviewCommentVO;

@Controller
@RequestMapping("/review")
public class ProductReviewController {
	
	@Autowired
	ProductReviewService productReviewService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	// 제품리뷰 view
	@RequestMapping(value = "/productReview", method = RequestMethod.GET)
	public String productReviewGet(Model model) {
		List<ProductReviewVO> reviewVos = productReviewService.getProductReview();
		model.addAttribute("reviewVos", reviewVos);
		//System.out.println("reviewVos : " + reviewVos);
		return "review/productReview";
	}
	
	// 제품리뷰 insert
	@RequestMapping(value = "/productReviewInsert", method = RequestMethod.POST)
	public String productReviewInsertPost(ProductReviewVO vo, MultipartHttpServletRequest pdPhoto) {
		System.out.println("pdPhoto : " + pdPhoto);
		
		int res = productReviewService.setproductReviewInsert(pdPhoto, vo);
		System.out.println("vo : " + vo);
		if(res != 0) return "redirect:/message/productReviewInsertOK";
		else return "redirect:/message/productReviewInsertNO";
	}
	
	// 제품리뷰 content view
	@RequestMapping(value = "/productReviewContent", method = RequestMethod.GET)
	public String productReviewContentGet(int idx, Model model) {
		ProductReviewVO vo = productReviewService.getproductReviewContent(idx);
		List<ReviewCommentVO> pdCommentVos = productReviewService.getPdReviewComment(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pdCommentVos", pdCommentVos);
		
		return "review/productReviewContent";
	}
	
}
