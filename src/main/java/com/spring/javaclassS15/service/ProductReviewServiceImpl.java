package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS15.dao.ProductReviewDAO;
import com.spring.javaclassS15.vo.ProductReviewVO;

@Service
public class ProductReviewServiceImpl implements ProductReviewService {
	@Autowired
	ProductReviewDAO productReviewDAO;

	@Override
	public List<ProductReviewVO> getProductReview() {
		return productReviewDAO.getProductReview();
	}
}
