package com.spring.javaclassS15.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS15.vo.MemberPetVO;
import com.spring.javaclassS15.vo.MemberVO;

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

}
