package com.spring.javaclassS15.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.dao.ProductReviewDAO;
import com.spring.javaclassS15.vo.ProductReviewVO;

@Service
public class ProductReviewServiceImpl implements ProductReviewService {
	@Autowired
	ProductReviewDAO productReviewDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public List<ProductReviewVO> getProductReview() {
		return productReviewDAO.getProductReview();
	}

	@Override
	public void setproductReviewPhoto(MultipartHttpServletRequest pdPhoto) {
		try {
			List<MultipartFile> fileList = pdPhoto.getFiles("fName");
			String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			
			for(MultipartFile file : fileList) {
				//System.out.println("원본파일 : " + file.getOriginalFilename());
				String oFileName = file.getOriginalFilename();
				String sFileName = javaclassProvide.saveFileName(oFileName);
				
				javaclassProvide.writeFile(file, sFileName, "productReview");	//오버라이드니까 예외더처리 throw말고  try catch
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				fileSizes += file.getSize();
			}
			oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			System.out.println("원본파일 : " + oFileNames);
			System.out.println("저장파일 : " + sFileNames);
			System.out.println("총사이즈 : " + fileSizes);
			
			} catch (IOException e) {e.printStackTrace();}
		//return sFileName;
	}

	@Override
	public int setproductReviewInsert(ProductReviewVO vo) {
		return productReviewDAO.setproductReviewInsert(vo);
	}
}
