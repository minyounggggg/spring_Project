package com.spring.javaclassS15.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.pagenation.PageProcess;
import com.spring.javaclassS15.service.ProductReviewService;
import com.spring.javaclassS15.vo.PageVO;
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
	
	@Autowired
	PageProcess pageProcess;
	
	// 제품리뷰 view
	@RequestMapping(value = "/productReview", method = RequestMethod.GET)
	public String productReviewGet(Model model,
		@RequestParam(name="part", defaultValue = "모든제품", required = false) String part,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "6", required = false) int pageSize
		) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "productReview", part, "");
		List<ProductReviewVO> reviewVos = productReviewService.getProductReview(pageVO.getStartIndexNo(), pageSize, part);
		
		model.addAttribute("reviewVos", reviewVos);
		model.addAttribute("pageVO", pageVO);
		//System.out.println("reviewVos : " + reviewVos);
		return "review/productReview";
	}
	
	// 제품리뷰 카테고리선택
	@ResponseBody
	@RequestMapping(value = "/petCategoryCheck", method = RequestMethod.POST)
	public String petCategoryCheckPost(String petCategorySelect) {
		int res = productReviewService.getPetCategoryCheck(petCategorySelect);
		return res + "";
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
	public String productReviewContentGet(int idx, Model model, HttpServletRequest request) {
		ProductReviewVO vo = productReviewService.getproductReviewContent(idx);
		List<ReviewCommentVO> pdCommentVos = productReviewService.getPdReviewComment(idx);
		
		HttpSession session = request.getSession(); //게시글을 보는순간 세션이 생긴다.
		ArrayList<String> contentReadNum = (ArrayList<String>)session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "productReview" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {  //"contains"= 포함하고있냐는 명령 / (imsiContentReadNum를 포함하고있니?)
			productReviewService.setReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
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
		}
		else {
			commentVO.setCommentCnt(parentCommentVO.getCommentCnt() + 1);
		}
		commentVO.setCommentLev(0);	//첫번쨰 댓글(부모댓글)이니까 re_step에 무조건 0을 set
		int res = productReviewService.setPdReviewCommentInputOK(commentVO);
		
		return res + "";
	}
	
	// 제품리뷰 좋아요버튼 처리
	@ResponseBody
	@RequestMapping(value = "/productReviewCommentHeartUp", method = RequestMethod.POST)
	public String productReviewCommentHeartUpPost(String idx, HttpServletRequest request) {

		// 좋아요 수 증가처리 (중복 불허)
		int res = 0;
		HttpSession session = request.getSession(); //게시글을 보는순간 세션이 생긴다.
		ArrayList<String> contentGood = (ArrayList<String>)session.getAttribute("sContentGood");
		if(contentGood == null) contentGood = new ArrayList<String>();
		String imsiContentGood = "pdReviewHeart" + idx;
		if(!contentGood.contains(imsiContentGood)) {  //"contains"= 포함하고있냐는 명령 / (imsiContentReadNum를 포함하고있니?)
			productReviewService.setpdReviewHeartUp(idx);
			contentGood.add(imsiContentGood);
			res = 1;
		}
		session.setAttribute("sContentGood", contentGood);
		
		//response.getWriter().write(sw);
		
		return res + "";
	}
	
}
