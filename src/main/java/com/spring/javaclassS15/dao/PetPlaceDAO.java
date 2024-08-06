package com.spring.javaclassS15.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PetCafeReviewVO;
import com.spring.javaclassS15.vo.PetCafeVO;
import com.spring.javaclassS15.vo.WishPlaceVO;

public interface PetPlaceDAO {

	public void setPetCafe(@Param("vo") PetCafeVO vo);

	public List<PetCafeVO> getPetCafeMap();

	public MemberVO getMemberinfo(@Param("mid") String mid);

	public List<PetCafeReviewVO> getPetCafeReviewList(@Param("idx") int idx, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public PetCafeVO getCafeInfo(@Param("idx") int idx);

	public PetCafeReviewVO getPetCafeReviewContent(@Param("idx") int idx);

	public PetCafeVO getCafeInfoContent();

	public int setPetCafeReviewInsert(@Param("vo") PetCafeReviewVO vo);

	public List<PetCafeReviewVO> getReviewMiniViewList(@Param("idx") int idx);

	public int totRecCnt(@Param("contentNum") int contentNum);

	public int setCafeReviewUpdate(@Param("vo") PetCafeReviewVO vo);

	public int setCafeReviewDelete(@Param("idx") int idx);

	public List<PetCafeReviewVO> getCafeReview();

	public PetCafeVO getPlaceName(@Param("placeIdx") int placeIdx);

	public int setWishPlace(@Param("mid") String mid, @Param("nickName") String nickName, @Param("part") String part, @Param("placeIdx") int placeIdx, @Param("placeName") String placeName, @Param("sido") String sido, @Param("sigungu") String sigungu, @Param("dong") String dong);

	public int setWishPlaceDelete(@Param("mid") String mid, @Param("part") String part, @Param("placeIdx") int placeIdx);



	
}
