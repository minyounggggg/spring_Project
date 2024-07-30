package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS15.vo.ProductReviewVO;
import com.spring.javaclassS15.vo.ReviewCommentVO;

public interface ProductReviewService {

	public List<ProductReviewVO> getProductReview();

	public int setproductReviewInsert(MultipartHttpServletRequest pdPhoto, ProductReviewVO vo);

	public ProductReviewVO getproductReviewContent(int idx);

	public List<ReviewCommentVO> getPdReviewComment(int idx);

	public ReviewCommentVO getPdReviewParentCommentCheck(int partIdx);

	public int setPdReviewCommentInputOK(ReviewCommentVO commentVO);

	public void setReadNumPlus(int idx);

	public void setpdReviewHeartUp(String idx);

}
