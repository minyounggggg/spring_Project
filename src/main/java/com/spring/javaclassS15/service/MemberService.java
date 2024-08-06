package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS15.vo.MemberPetVO;
import com.spring.javaclassS15.vo.MemberVO;
import com.spring.javaclassS15.vo.WishPlaceVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getmemberNickCheck(String nickName);

	public String fileUpload(MultipartFile fName, String mid);
	
	public String fileUploadPet(MultipartFile fName, String mid);

	public int setMemberJoinOK(MemberVO vo);

	public MemberVO getMemberNickNameEmailCheck(String nickName, String email);

	public void setKakaoMemberInput(String mid, String pwd, String nickName, String email);

	public List<MemberPetVO> getMemberPetList(String mid);

	public int setMemberPetInsertOK(MemberPetVO petVO, String mid);

	public int setMemberMypagePetUpdateOK(MemberPetVO petVO, int idx);

	public MemberPetVO getMemberPetPhoto(int idx);

	public int setMemberPetDeleteOK(int idx);

	public int setMemberUpdateOK(MemberVO vo, String mid);

	public void setMemberLastDate(String mid);

	public void setLoginUpdate(MemberVO vo);

	public List<WishPlaceVO> getCafeWishPlace(String mid, String cafePart, int startIndexNo, int pageSize);

	public List<WishPlaceVO> getHospitalWishPlace(String mid, String hospitalPart);



}
