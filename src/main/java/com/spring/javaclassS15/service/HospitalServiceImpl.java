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
import com.spring.javaclassS15.dao.HospitalDAO;
import com.spring.javaclassS15.vo.HospitalReviewVO;
import com.spring.javaclassS15.vo.HospitalVO;
import com.spring.javaclassS15.vo.MemberVO;

@Service
public class HospitalServiceImpl implements HospitalService {
	@Autowired
	HospitalDAO hospitalDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public String fileCsvToMysql(MultipartFile fName) {
		String str = "";
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/hospital/");
		
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
		realPath = request.getSession().getServletContext().getRealPath("/resources/data/hospital/"+fName.getOriginalFilename());
		try {
			BufferedReader br = new BufferedReader(new FileReader(realPath));
			String line;
			int cnt = 0;
			while ((line = br.readLine()) != null) {
				//System.out.println(line);
				cnt++;
				str += cnt + " : " + line + "<br>";
				String[] hospital = line.split(",");
				HospitalVO vo = new HospitalVO();
				int k = 0;
				vo.setPlaceName(hospital[k]); k++;
				vo.setCategory(hospital[k]); k++;
				vo.setSido(hospital[k]); k++;
				vo.setSigungu(hospital[k]); k++;
				vo.setDong(hospital[k]); k++;
				vo.setLatitude(Double.parseDouble(hospital[k])); k++;
				vo.setLongitude(Double.parseDouble(hospital[k])); k++;
				vo.setZipNum(Integer.parseInt(hospital[k])); k++;
				vo.setRdnmAddress(hospital[k]); k++;
				vo.setLnmAddress(hospital[k]); k++;
				vo.setHomePage(hospital[k]); k++;
				vo.setClosedDay(hospital[k]); k++;
				vo.setOpenTime(hospital[k]); k++;
				vo.setParking(hospital[k]); k++;
				vo.setPlayPrice(hospital[k]); k++;
				vo.setPetOK(hospital[k]); k++;
				vo.setPetSize(hospital[k]); k++;
				vo.setPetLimit(hospital[k]); k++;
				vo.setInPlaceOK(hospital[k]); k++;
				vo.setOutPlaceOK(hospital[k]); k++;
				vo.setPlaceInfo(hospital[k]); k++;
				vo.setPetExtraFee(hospital[k]); k=0;
				
				// DB에 저장하기
				hospitalDAO.setHospital(vo);
			}
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}

	@Override
	public List<HospitalVO> getHospitalMap() {
		return hospitalDAO.getHospitalMap();
	}

	@Override
	public MemberVO getMemberinfo(String mid) {
		return hospitalDAO.getMemberinfo(mid);
	}

	@Override
	public List<HospitalReviewVO> getHospitalReviewList(int idx, int startIndexNo, int pageSize) {
		return hospitalDAO.getHospitalReviewList(idx, startIndexNo, pageSize);
	}

	@Override
	public HospitalVO getHospitalInfo(int idx) {
		return hospitalDAO.getHospitalInfo(idx);
	}

	@Override
	public HospitalReviewVO getHospitalReviewContent(int idx) {
		return hospitalDAO.getHospitalReviewContent(idx);
	}

	@Override
	public HospitalVO getHospitalInfoContent() {
		return hospitalDAO.getHospitalInfoContent();
	}

	@Override
	public void imgCheck(String content) {
		//		  		  0   		1  		  2			3		  4			5
		// 				  01234567890123456789012345678901234567890123456789012345
		// <p><img alt="" src="/javaclassS15/data/ckeditor/240626093408_panchu1.jpg" style="height:200px; width:200px" /></p>
		// <p><img alt="" src="/javaclassS15/data/hospital/240626093408_panchu1.jpg" style="height:200px; width:200px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();	  //ServletRequestAttributes 로 형변환 후 사용
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 33;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;  //원본파일 경로명
			String copyFilePath = realPath + "hospital/" + imgFile; 
			
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
	public int setHospitalReviewInsert(HospitalReviewVO vo) {
		return hospitalDAO.setHospitalReviewInsert(vo);
	}

	@Override
	public List<HospitalReviewVO> getReviewMiniViewList(int idx) {
		return hospitalDAO.getReviewMiniViewList(idx);
	}

	@Override
	public void imgDelete(String content) {
		//		  		  0   		1  		  2			3		  4			5
		// 				  01234567890123456789012345678901234567890123456789012345
		// <p><img alt="" src="/javaclassS15/data/hospital/240626093408_panchu1.jpg" style="height:200px; width:200px" /></p>
		// <p><img alt="" src="/javaclassS15/data/ckeditor/240626093408_panchu1.jpg" style="height:200px; width:200px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();	  //ServletRequestAttributes 로 형변환 후 사용
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 33;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "hospital/" + imgFile;  //원본파일 경로명
			
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
	public int setHospitalReviewUpdate(HospitalReviewVO vo) {
		return hospitalDAO.setHospitalReviewUpdate(vo);
	}

	@Override
	public int setHospitalReviewDelete(int idx) {
		return hospitalDAO.setHospitalReviewDelete(idx);
	}

	

}
