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

	/*
	 * // 제품리뷰수정 content update
	 * 
	 * @RequestMapping(value = "/productReviewUpdateOK", method =
	 * RequestMethod.POST) public String productReviewUpdateOKPost(ProductReviewVO
	 * vo, Model model) { // 수정된 자료가 원본자료와 완전히 동일하다면 고치지않은거니까 수정할 필요가 없다. 즉, DB에 저장된
	 * 원본자료를 불러와서 현재 vo에 담긴 내용(content)과 비교해본다. ProductReviewVO origVo =
	 * productReviewService.getproductReviewContent(vo.getIdx());
	 * 
	 * // content의 내용이 조금이라도 변경이 되었다면 내용을 수정한 것이기에, 그림파일 처리 유무를 결정한다.
	 * if(!origVo.getProductPhoto().equals(vo.getProductPhoto())) { // 1.기존 board폴더에
	 * 그림이 존재했다면 원본그림을 모두 삭제처리한다.(원본그림은 수정창에 들어오기 전에 updateCopy폴더에 저장시켜두었다)
	 * productReviewService.imgDelete(origVo.getProductPhoto());
	 * 
	 * // 2.앞의 삭제 작업이 끝나면 'board'폴더를 'updateCopy'로 변경한다.
	 * vo.setProductPhoto(vo.getProductPhoto().replace("/data/board/",
	 * "/data/updateCopy/"));
	 * 
	 * // 1,2 작업을 마치면 파일을 처음 업로드한것과 같은 작업처리를 해준다. // 즉, content에 이미지가 저장되어있다면, 저장된
	 * 이미지만 골라서 '/data/board/'폴더에 복사 저장처리한다.
	 * if(vo.getProductPhoto().indexOf("src=\"/") != -1)
	 * productReviewService.imgCheck(vo.getProductPhoto());
	 * 
	 * //이미지들의 모든 복사작업을 마치면, 폴더명을 updateCopy에서 board폴더로 변경처리한다.
	 * vo.setProductPhoto(vo.getProductPhoto().replace("/data/updateCopy/",
	 * "/data/board/"));
	 * 
	 * // content안의 내용과 그림파일까지, 잘 정비된 vo를 DB에 Update시켜준다. } int res =
	 * productReviewService.setProductReviewUpdateOK(vo);
	 * 
	 * model.addAttribute("idx", vo.getIdx());
	 * 
	 * if(res != 0) return "redirect:/message/productReviewUpdateOk"; else return
	 * "redirect:/message/productReviewUpdateNo"; }
	 */
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
	
}
