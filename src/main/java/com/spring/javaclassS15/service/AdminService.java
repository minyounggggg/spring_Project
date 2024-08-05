package com.spring.javaclassS15.service;

import java.util.List;

import com.spring.javaclassS15.vo.ProductReviewVO;

public interface AdminService {

	int getCafeReviewCount();

	int getHospitalReviewCount();

	int getProductReviewCount();

	List<ProductReviewVO> getComplaintList();

	void imgDelete(String productPhoto);

	int setReviewDelete(int idx);

	

}
