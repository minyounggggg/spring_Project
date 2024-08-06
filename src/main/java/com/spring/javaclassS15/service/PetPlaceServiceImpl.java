package com.spring.javaclassS15.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.dao.PetPlaceDAO;
import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PetCafeReviewVO;
import com.spring.javaclassS15.vo.PetCafeVO;
import com.spring.javaclassS15.vo.WishPlaceVO;

@Service
public class PetPlaceServiceImpl implements PetPlaceService {
	@Autowired
	PetPlaceDAO petPlaceDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public String fileCsvToMysql(MultipartFile fName) {
		String str = "";
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/petCafe/");
		
		// 작업할 원본 csv파일 업로드(원본파일이 utf-8파일이 아니라면 메모장에서 utf-8로 다시 저장해서 업로드시켜준다.
		try {
			FileOutputStream fos;
			fos = new FileOutputStream(realPath + fName.getOriginalFilename());
			if(fName.getBytes().length != -1) {
				fos.write(fName.getBytes());
			}
			fos.flush();
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 업로드된 파일을 Line단위로 읽어와서 ','로 분리후 DB에 저장하기
		realPath = request.getSession().getServletContext().getRealPath("/resources/data/petCafe/"+fName.getOriginalFilename());
		try {
			BufferedReader br = new BufferedReader(new FileReader(realPath));
			String line;
			int cnt = 0;
			while ((line = br.readLine()) != null) {
				//System.out.println(line);
				cnt++;
				str += cnt + " : " + line + "<br>";
				String[] pet_cafe = line.split(",");
				PetCafeVO vo = new PetCafeVO();
				int k = 0;
				vo.setPlaceName(pet_cafe[k]); k++;
				vo.setCategory(pet_cafe[k]); k++;
				vo.setSido(pet_cafe[k]); k++;
				vo.setSigungu(pet_cafe[k]); k++;
				vo.setDong(pet_cafe[k]); k++;
				vo.setLatitude(Double.parseDouble(pet_cafe[k])); k++;
				vo.setLongitude(Double.parseDouble(pet_cafe[k])); k++;
				vo.setZipNum(Integer.parseInt(pet_cafe[k])); k++;
				vo.setRdnmAddress(pet_cafe[k]); k++;
				vo.setLnmAddress(pet_cafe[k]); k++;
				vo.setHomePage(pet_cafe[k]); k++;
				vo.setClosedDay(pet_cafe[k]); k++;
				vo.setOpenTime(pet_cafe[k]); k++;
				vo.setParking(pet_cafe[k]); k++;
				vo.setPlayPrice(pet_cafe[k]); k++;
				vo.setPetOK(pet_cafe[k]); k++;
				vo.setPetSize(pet_cafe[k]); k++;
				vo.setPetLimit(pet_cafe[k]); k++;
				vo.setInPlaceOK(pet_cafe[k]); k++;
				vo.setOutPlaceOK(pet_cafe[k]); k++;
				vo.setPlaceInfo(pet_cafe[k]); k++;
				vo.setPetExtraFee(pet_cafe[k]); k=0;
				
				// DB에 저장하기
				petPlaceDAO.setPetCafe(vo);
			}
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}

	@Override
	public List<PetCafeVO> getPetCafeMap() {
		return petPlaceDAO.getPetCafeMap();
	}

	@Override
	public MemberVO getMemberinfo(String mid) {
		return petPlaceDAO.getMemberinfo(mid);
	}

	@Override
	public List<PetCafeReviewVO> getPetCafeReviewList(int idx, int startIndexNo, int pageSize) {
		return petPlaceDAO.getPetCafeReviewList(idx, startIndexNo, pageSize);
	}

	@Override
	public PetCafeVO getCafeInfo(int idx) {
		return petPlaceDAO.getCafeInfo(idx);
	}

	@Override
	public PetCafeReviewVO getPetCafeReviewContent(int idx) {
		return petPlaceDAO.getPetCafeReviewContent(idx);
	}

	@Override
	public PetCafeVO getCafeInfoContent() {
		return petPlaceDAO.getCafeInfoContent();
	}

	@Override
	public void imgCheck(String content) {
		//		  		  0   		1  		  2			3		  4			5
		// 				  01234567890123456789012345678901234567890123456789012345
		// <p><img alt="" src="/javaclassS15/data/ckeditor/240626093408_panchu1.jpg" style="height:200px; width:200px" /></p>
		// <p><img alt="" src="/javaclassS15/data/cafeReview/240626093408_panchu1.jpg" style="height:200px; width:200px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();	  //ServletRequestAttributes 로 형변환 후 사용
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 33;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;  //원본파일 경로명
			String copyFilePath = realPath + "cafeReview/" + imgFile; 
			
			fileCopyCheck(origFilePath, copyFilePath);	//ckeditor폴더의 그림파일을 board폴더 위치로 복사처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}	
	}

	// 파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048]; 	//2k
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {	// 있을때 2024바이트만큼 없을때까지 빙글빙글 반복 
				fos.write(b, 0, cnt);
			}
			fos.flush(); 	//찌꺼기 남은거 다 저장
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public int setPetCafeReviewInsert(PetCafeReviewVO vo) {
		return petPlaceDAO.setPetCafeReviewInsert(vo);
	}

	@Override
	public List<PetCafeReviewVO> getReviewMiniViewList(int idx) {
		return petPlaceDAO.getReviewMiniViewList(idx);
	}

	@Override
	public void imgDelete(String content) {
		//		  		  0   		1  		  2			3		  4			5
		// 				  01234567890123456789012345678901234567890123456789012345
		// <p><img alt="" src="/javaclassS15/data/cafeReview/240626093408_panchu1.jpg" style="height:200px; width:200px" /></p>
		// <p><img alt="" src="/javaclassS15/data/ckeditor/240626093408_panchu1.jpg" style="height:200px; width:200px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();	  //ServletRequestAttributes 로 형변환 후 사용
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 35;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "cafeReview/" + imgFile;  //원본파일 경로명
			
			fileDelete(origFilePath);	//board폴더의 그림파일을 삭제힌다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setCafeReviewUpdate(PetCafeReviewVO vo) {
		return petPlaceDAO.setCafeReviewUpdate(vo);
	}

	@Override
	public int setCafeReviewDelete(int idx) {
		return petPlaceDAO.setCafeReviewDelete(idx);
	}

	@Override
	public List<PetCafeReviewVO> getCafeReview() {
		return petPlaceDAO.getCafeReview();
	}
	
	@Override 
	public PetCafeVO getPlaceName(int placeIdx) { 
		return petPlaceDAO.getPlaceName(placeIdx); 
	}
	  
	@Override
	public int setWishPlace(String mid, String nickName, String part, int placeIdx, String placeName) {
		return petPlaceDAO.setWishPlace(mid, nickName, part, placeIdx, placeName);
	}

	@Override
	public int setWishPlaceDelete(String mid, String part, int placeIdx) {
		return petPlaceDAO.setWishPlaceDelete(mid, part, placeIdx);
	}
	  
	 

}
