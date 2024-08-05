package com.spring.javaclassS15.dao;

import java.util.List;

import com.spring.javaclassS15.vo.ProductReviewVO;

public interface AdminDAO {

	int getCafeReviewCount();

	int getHospitalReviewCount();

	int getProductReviewCount();

	List<ProductReviewVO> getComplaintList();

	int setReviewDelete(int idx);

	
	
}
