package com.spring.javaclassS15.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS15.vo.MemberPetVO;
import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.WishPlaceVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getmemberNickCheck(@Param("nickName") String nickName);

	public int setMemberJoinOK(@Param("vo") MemberVO vo);

	public MemberVO getMemberNickNameEmailCheck(@Param("nickName") String nickName, @Param("email") String email);

	public void setKakaoMemberInput(@Param("mid") String mid, @Param("pwd") String pwd, @Param("nickName") String nickName, @Param("email") String email);

	public List<MemberPetVO> getMemberPetList(@Param("mid") String mid);

	public int setMemberPetInsertOK(@Param("petVO") MemberPetVO petVO, @Param("mid") String mid);

	public int setMemberMypagePetUpdateOK(@Param("petVO") MemberPetVO petVO, @Param("idx") int idx);

	public MemberPetVO getMemberPetPhoto(@Param("idx") int idx);

	public int setMemberPetDeleteOK(@Param("idx") int idx);

	public int setMemberUpdateOK(@Param("vo") MemberVO vo, @Param("mid") String mid);

	public void setMemberLastDate(@Param("mid") String mid);

	public void setLoginUpdate(@Param("vo") MemberVO vo);

	public List<WishPlaceVO> getCafeWishPlace(@Param("mid") String mid, @Param("cafePart") String cafePart, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public List<WishPlaceVO> getHospitalWishPlace(@Param("mid") String mid, @Param("hospitalPart") String hospitalPart, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCnt(@Param("part") String part, @Param("searchString") String searchString);

	public int hospitalTotRecCnt(@Param("part") String part, @Param("searchString") String searchString);

}
