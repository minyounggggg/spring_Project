package com.spring.javaclassS15.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.dao.MemberDAO;
import com.spring.javaclassS15.vo.MemberPetVO;
import com.spring.javaclassS15.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getmemberNickCheck(String nickName) {
		return memberDAO.getmemberNickCheck(nickName);
	}

	@Override
	public String fileUpload(MultipartFile fName, String mid) {
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = mid + "_" + uid.toString().substring(0,8) + "_" + oFileName;
		
		try {
			javaclassProvide.writeFile(fName, sFileName, "member");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sFileName;
	}
	
	@Override
	public String fileUploadPet(MultipartFile fName, String mid) {
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = mid + "_" + uid.toString().substring(0,8) + "_" + oFileName;
		
		try {
			javaclassProvide.writeFile(fName, sFileName, "memberPet");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sFileName;
	}

	@Override
	public int setMemberJoinOK(MemberVO vo) {
		return memberDAO.setMemberJoinOK(vo);
	}

	@Override
	public MemberVO getMemberNickNameEmailCheck(String nickName, String email) {
		return memberDAO.getMemberNickNameEmailCheck(nickName, email);
	}

	@Override
	public void setKakaoMemberInput(String mid, String pwd, String nickName, String email) {
		memberDAO.setKakaoMemberInput(mid, pwd, nickName, email);
	}

	@Override
	public List<MemberPetVO> getMemberPetList(String mid) {
		return memberDAO.getMemberPetList(mid);
	}

	@Override
	public int setMemberPetInsertOK(MemberPetVO petVO, String mid) {
		return memberDAO.setMemberPetInsertOK(petVO, mid);
	}

	@Override
	public int setMemberMypagePetUpdateOK(MemberPetVO petVO, int idx) {
		return memberDAO.setMemberMypagePetUpdateOK(petVO, idx);
	}

	@Override
	public MemberPetVO getMemberPetPhoto(int idx) {
		return memberDAO.getMemberPetPhoto(idx);
	}

	@Override
	public int setMemberPetDeleteOK(int idx) {
		return memberDAO.setMemberPetDeleteOK(idx);
	}

	@Override
	public int setMemberUpdateOK(MemberVO vo, String mid) {
		return memberDAO.setMemberUpdateOK(vo, mid);
	}

	@Override
	public void setMemberLastDate(String mid) {
		memberDAO.setMemberLastDate(mid);
	}

	@Override
	public void setLoginUpdate(MemberVO vo) {
		memberDAO.setLoginUpdate(vo);
	}
	
}
