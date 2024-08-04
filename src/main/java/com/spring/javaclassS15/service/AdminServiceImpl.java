package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.dao.AdminDAO;
import com.spring.javaclassS15.vo.ProductReviewVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public int getCafeReviewCount() {
		return adminDAO.getCafeReviewCount();
	}

	@Override
	public int getHospitalReviewCount() {
		return adminDAO.getHospitalReviewCount();
	}

	@Override
	public int getProductReviewCount() {
		return adminDAO.getProductReviewCount();
	}

	@Override
	public List<ProductReviewVO> getComplaintList() {
		return adminDAO.getComplaintList();
	}

	

	

}
