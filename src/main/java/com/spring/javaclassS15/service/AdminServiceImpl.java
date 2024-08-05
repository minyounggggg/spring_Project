package com.spring.javaclassS15.service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

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

	@Override
	public void imgDelete(String productPhoto) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/productReview/");
		
		String[] imgs = productPhoto.split("/");
		System.out.println("imgs : " + imgs);
		
		for(int i=0; i < imgs.length; i++) {
			File file = new File(realPath + imgs[i]);
			if(file.exists()) file.delete();
		}
	}

	@Override
	public int setReviewDelete(int idx) {
		return adminDAO.setReviewDelete(idx);
	}
		

	

	

}
