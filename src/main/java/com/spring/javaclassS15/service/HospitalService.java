package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS15.vo.HospitalReviewVO;
import com.spring.javaclassS15.vo.HospitalVO;
import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PetCafeReviewVO;
import com.spring.javaclassS15.vo.PetCafeVO;

public interface HospitalService {

	public String fileCsvToMysql(MultipartFile fName);

	public List<HospitalVO> getHospitalMap();

	public MemberVO getMemberinfo(String mid);

	public List<HospitalReviewVO> getHospitalReviewList(int idx, int startIndexNo, int pageSize);

	public HospitalVO getHospitalInfo(int idx);

	public HospitalReviewVO getHospitalReviewContent(int idx);

	public HospitalVO getHospitalInfoContent();

	public void imgCheck(String content);

	public int setHospitalReviewInsert(HospitalReviewVO vo);

	public List<HospitalReviewVO> getReviewMiniViewList(int idx);

	public void imgDelete(String content);

	public int setHospitalReviewUpdate(HospitalReviewVO vo);

	public int setHospitalReviewDelete(int idx);

	public List<HospitalReviewVO> gethospitalReview();

	public PetCafeVO getPlaceName(int placeIdx);

	public void setWishPlace(String mid, String nickName, String part, int placeIdx, String placeName);

	public int setWishPlaceDelete(String mid, String part, int placeIdx);



}
