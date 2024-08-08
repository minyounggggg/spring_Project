package com.spring.javaclassS15.pagenation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS15.dao.HospitalDAO;
import com.spring.javaclassS15.dao.MemberDAO;
import com.spring.javaclassS15.dao.PetPlaceDAO;
import com.spring.javaclassS15.dao.ProductReviewDAO;
import com.spring.javaclassS15.vo.PageVO;

@Service
public class PageProcess {
	
	@Autowired
	ProductReviewDAO productReviewDAO;
	
	@Autowired
	PetPlaceDAO petPlaceDAO;
	
	@Autowired
	HospitalDAO hospitalDAO;
	
	@Autowired
	MemberDAO memberDAO;
	

	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString, int contentNum) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("productReview")) totRecCnt = productReviewDAO.totRecCnt(part);
		else if(section.equals("cafeReview")) totRecCnt = petPlaceDAO.totRecCnt(contentNum);
		else if(section.equals("hospitalReview")) totRecCnt = hospitalDAO.totRecCnt(contentNum);
		else if(section.equals("wishCafe")) totRecCnt = memberDAO.totRecCnt(part, searchString);
		else if(section.equals("wishHospital")) totRecCnt = memberDAO.hospitalTotRecCnt(part, searchString);
			
		//else if(section.equals("pds")) totRecCnt = pdsDAO.totRecCnt(part);
		
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) +1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;		// 1페이지는 0이니까 pag에 -1을 해준다?
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		pageVO.setPart(part);
		
		return pageVO;
	}
}
