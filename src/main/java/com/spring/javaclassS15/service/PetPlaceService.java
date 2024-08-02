package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PetCafeReviewVO;
import com.spring.javaclassS15.vo.PetCafeVO;

public interface PetPlaceService {

	public String fileCsvToMysql(MultipartFile fName);

	public List<PetCafeVO> getPetCafeMap();

	public MemberVO getMemberinfo(String mid);

	public List<PetCafeReviewVO> getPetCafeReviewList(int idx);

	public PetCafeVO getCafeInfo(int idx);

	public PetCafeReviewVO getPetCafeReviewContent(int idx);

	public PetCafeVO getCafeInfoContent(int placeIdx);


}
