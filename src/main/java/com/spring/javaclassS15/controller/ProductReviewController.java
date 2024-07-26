package com.spring.javaclassS15.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	// 제품리뷰 댓글달기
	@ResponseBody
	@RequestMapping(value = "/productReviewCommentInsert", method = RequestMethod.POST)
	public String productReviewCommentInsertPost(ReviewCommentVO commentVO) {
		// 부모댓글의 경우는 re_step=0, re_order=1로 처리. (단, 원본글의 첫번째 부모댓글은 re_order=1이지만, 2번 이상은 마지막 부모댓글의 re_order보다 +1처리 시켜준다.)
		ReviewCommentVO parentCommentVO = productReviewService.getPdReviewParentCommentCheck(commentVO.getPartIdx());
		
		System.out.println("commentVO : " + commentVO);
		System.out.println("parentCommentVO : " + parentCommentVO);
		
		if(parentCommentVO == null) {
			commentVO.setCommentCnt(1);
			System.out.println("parentCommentVO : 1111" );
		}
		else {
			commentVO.setCommentCnt(parentCommentVO.getCommentCnt() + 1);
			System.out.println("parentCommentVO : 2222" );
		}
		commentVO.setCommentLev(0);	//첫번쨰 댓글(부모댓글)이니까 re_step에 무조건 0을 set
		System.out.println("parentCommentVO : 333" );
		int res = productReviewService.setPdReviewCommentInputOK(commentVO);
		
		
		return res + "";
	}
	
}
