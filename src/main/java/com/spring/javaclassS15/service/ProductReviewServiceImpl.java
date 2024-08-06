package com.spring.javaclassS15.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.dao.ProductReviewDAO;
import com.spring.javaclassS15.vo.ProductReviewVO;
import com.spring.javaclassS15.vo.ReviewCommentVO;

@Service
public class ProductReviewServiceImpl implements ProductReviewService {
	@Autowired
	ProductReviewDAO productReviewDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	

	@Override
	public List<ProductReviewVO> getProductReview(int startIndexNo, int pageSize, String part) {
		return productReviewDAO.getProductReview(startIndexNo, pageSize, part);
	}

	@Override
	public int setproductReviewInsert(MultipartHttpServletRequest pdPhoto, ProductReviewVO vo) {
		try {
			List<MultipartFile> fileList = pdPhoto.getFiles("fName");
			//String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			
			for(MultipartFile file : fileList) {
				//System.out.println("원본파일 : " + file.getOriginalFilename());
				String oFileName = file.getOriginalFilename();
				String sFileName = javaclassProvide.saveFileName(oFileName);
				
				javaclassProvide.writeFile(file, sFileName, "productReview");	//오버라이드니까 예외더처리 throw말고  try catch
				
				//oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				fileSizes += file.getSize();
			}
			//oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			//System.out.println("원본파일 : " + oFileNames);
			//System.out.println("저장파일 : " + sFileNames);
			//System.out.println("총사이즈 : " + fileSizes);
			
			vo.setProductPhoto(sFileNames);
			//System.out.println("vo : " + vo);
			
			} catch (IOException e) {e.printStackTrace();}
		return productReviewDAO.setproductReviewInsert(vo);
	}

	@Override
	public ProductReviewVO getproductReviewContent(int idx) {
		return productReviewDAO.getproductReviewContent(idx);
	}

	@Override
	public List<ReviewCommentVO> getPdReviewComment(int idx) {
		return productReviewDAO.getPdReviewComment(idx);
	}

	@Override
	public ReviewCommentVO getPdReviewParentCommentCheck(int partIdx) {
		return productReviewDAO.getPdReviewParentCommentCheck(partIdx);
	}

	@Override
	public int setPdReviewCommentInputOK(ReviewCommentVO commentVO) {
		return productReviewDAO.setPdReviewCommentInputOK(commentVO);
	}

	@Override
	public void setReadNumPlus(int idx) {
		productReviewDAO.setReadNumPlus(idx);
	}

	@Override
	public void setpdReviewHeartUp(String idx) {
		productReviewDAO.setpdReviewHeartUp(idx);
	}

	@Override
	public int getPetCategoryCheck(String petCategorySelect) {
		return productReviewDAO.getPetCategoryCheck(petCategorySelect);
	}

	@Override
	public void setpdReviewComplaint(int idx) {
		productReviewDAO.setpdReviewComplaint(idx);
	}

	@Override
	public void imgDelete(String productPhoto) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/productReview/");
		
		String[] imgs = productPhoto.split("/");
		//System.out.println("imgs : " + imgs);
		
		for(int i=0; i < imgs.length; i++) {
			File file = new File(realPath + imgs[i]);
			if(file.exists()) file.delete();
		}
	}

	@Override
	public int setReviewDelete(int idx) {
		return productReviewDAO.setReviewDelete(idx);
	}

	@Override
	public int setproductReviewUpdate(MultipartHttpServletRequest pdPhoto, ProductReviewVO vo) {
		try {
			List<MultipartFile> fileList = pdPhoto.getFiles("fName");
			//String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			
			for(MultipartFile file : fileList) {
				//System.out.println("원본파일 : " + file.getOriginalFilename());
				String oFileName = file.getOriginalFilename();
				String sFileName = javaclassProvide.saveFileName(oFileName);
				
				javaclassProvide.writeFile(file, sFileName, "productReview");	//오버라이드니까 예외더처리 throw말고  try catch
				
				//oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				fileSizes += file.getSize();
			}
			//oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			//System.out.println("원본파일 : " + oFileNames);
			System.out.println("저장파일 : " + sFileNames);
			System.out.println("총사이즈 : " + fileSizes);
			
			vo.setProductPhoto(sFileNames);
			System.out.println("vo : " + vo);
			
			} catch (IOException e) {e.printStackTrace();}
		return productReviewDAO.setproductReviewUpdate(vo);
	}

	@Override
	public void imgUpdateDelete(String productPhoto) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/productReview/");
		System.out.println("productPhoto U : " + productPhoto);
		
		String[] imgs = productPhoto.split("/");
		System.out.println("imgs U : " + imgs);
		
		for(int i=0; i < imgs.length; i++) {
			File file = new File(realPath + imgs[i]);
			if(file.exists()) file.delete();
		}
	}

	@Override
	public ProductReviewVO getOrgReviewVO(int idx) {
		return productReviewDAO.getOrgReviewVO(idx);
	}

	@Override
	public int setReviewHeartDelete(int idx) {
		return productReviewDAO.setReviewHeartDelete(idx);
	}
}
