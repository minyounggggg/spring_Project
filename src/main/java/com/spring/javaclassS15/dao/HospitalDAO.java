package com.spring.javaclassS15.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS15.vo.HospitalReviewVO;
import com.spring.javaclassS15.vo.HospitalVO;
import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PetCafeReviewVO;
import com.spring.javaclassS15.vo.PetCafeVO;

public interface HospitalDAO {

	public void setHospital(@Param("vo") HospitalVO vo);

	public List<HospitalVO> getHospitalMap();

	public MemberVO getMemberinfo(@Param("mid") String mid);

	public List<HospitalReviewVO> getHospitalReviewList(@Param("idx") int idx, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public HospitalVO getHospitalInfo(@Param("idx") int idx);

	public HospitalReviewVO getHospitalReviewContent(@Param("idx") int idx);

	public HospitalVO getHospitalInfoContent();

	public int setHospitalReviewInsert(@Param("vo") HospitalReviewVO vo);

	public List<HospitalReviewVO> getReviewMiniViewList(@Param("idx") int idx);

	public int totRecCnt(@Param("contentNum") int contentNum);

	public int setHospitalReviewUpdate(@Param("vo") HospitalReviewVO vo);

	public int setHospitalReviewDelete(@Param("idx") int idx);

	public List<HospitalReviewVO> gethospitalReview();

	public PetCafeVO getPlaceName(@Param("placeIdx") int placeIdx);

	public void setWishPlace(@Param("mid") String mid, @Param("nickName") String nickName, @Param("part") String part, @Param("placeIdx") int placeIdx, @Param("placeName") String placeName);

	public int setWishPlaceDelete(@Param("mid") String mid, @Param("part") String part, @Param("placeIdx") int placeIdx);



	
}
