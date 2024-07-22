package com.spring.javaclassS15.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.service.ProductReviewService;
import com.spring.javaclassS15.vo.ProductReviewVO;

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
		System.out.println("reviewVos : " + reviewVos);
		return "review/productReview";
	}
	
	
}
