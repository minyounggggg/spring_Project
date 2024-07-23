package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS15.vo.ProductReviewVO;

public interface ProductReviewService {

	List<ProductReviewVO> getProductReview();

	void setproductReviewPhoto(MultipartHttpServletRequest pdPhoto);

	int setproductReviewInsert(ProductReviewVO vo);

}
