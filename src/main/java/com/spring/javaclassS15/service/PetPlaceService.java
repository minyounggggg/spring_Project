package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PetCafeReviewVO;
import com.spring.javaclassS15.vo.PetCafeVO;
import com.spring.javaclassS15.vo.WishPlaceVO;

public interface PetPlaceService {

	public String fileCsvToMysql(MultipartFile fName);

	public List<PetCafeVO> getPetCafeMap();

	public MemberVO getMemberinfo(String mid);

	public List<PetCafeReviewVO> getPetCafeReviewList(int idx, int startIndexNo, int pageSize);

	public PetCafeVO getCafeInfo(int idx);

	public PetCafeReviewVO getPetCafeReviewContent(int idx);

	public PetCafeVO getCafeInfoContent();

	public void imgCheck(String content);

	public int setPetCafeReviewInsert(PetCafeReviewVO vo);

	public List<PetCafeReviewVO> getReviewMiniViewList(int idx);

	public void imgDelete(String content);

	public int setCafeReviewUpdate(PetCafeReviewVO vo);

	public int setCafeReviewDelete(int idx);

	public List<PetCafeReviewVO> getCafeReview();

	public PetCafeVO getPlaceName(int placeIdx);

	public int setWishPlace(String mid, String nickName, String part, int placeIdx, String placeName, String sido, String sigungu, String dong);

	public int setWishPlaceDelete(String mid, String part, int placeIdx);

	public WishPlaceVO getWishcheck(String mid, int placeIdx);

	public int getWishPlace(String mid, int placeIdx);




}
