package com.spring.javaclassS15.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.PetCafeReviewVO;
import com.spring.javaclassS15.vo.PetCafeVO;

public interface PetPlaceDAO {

	public void setPetCafe(@Param("vo") PetCafeVO vo);

	public List<PetCafeVO> getPetCafeMap();

	public MemberVO getMemberinfo(@Param("mid") String mid);

	public List<PetCafeReviewVO> getPetCafeReviewList(@Param("idx") int idx);

	public PetCafeVO getCafeInfo(@Param("idx") int idx);

	public PetCafeReviewVO getPetCafeReviewContent(@Param("idx") int idx);

	public PetCafeVO getCafeInfoContent();

	public int setPetCafeReviewInsert(@Param("vo") PetCafeReviewVO vo);


	
}
