package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS15.vo.MemberPetVO;
import com.spring.javaclassS15.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getmemberNickCheck(String nickName);

	public String fileUpload(MultipartFile fName, String mid);

	public int setMemberJoinOK(MemberVO vo);

	public MemberVO getMemberNickNameEmailCheck(String nickName, String email);

	public void setKakaoMemberInput(String mid, String pwd, String nickName, String email);

	public List<MemberPetVO> getMemberPetList(String mid);

}
