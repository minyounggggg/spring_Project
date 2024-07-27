package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS15.vo.ProductReviewVO;
import com.spring.javaclassS15.vo.ReviewCommentVO;

public interface ProductReviewService {

	List<ProductReviewVO> getProductReview();

	int setproductReviewInsert(MultipartHttpServletRequest pdPhoto, ProductReviewVO vo);

	ProductReviewVO getproductReviewContent(int idx);

	List<ReviewCommentVO> getPdReviewComment(int idx);

	ReviewCommentVO getPdReviewParentCommentCheck(int partIdx);

	int setPdReviewCommentInputOK(ReviewCommentVO commentVO);

}
