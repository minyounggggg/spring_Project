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
	public MemberPetVO getPetPhoto(int idx) {
		return memberDAO.getPetPhoto(idx);
	}
/*
	@Override
	public void imgDelete(String petPhoto) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();	  //ServletRequestAttributes 로 형변환 후 사용
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");	//이거 맑 펫 사진 경로 
		
		int position = 28;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile;  //원본파일 경로명
			
			fileDelete(origFilePath);	//board폴더의 그림파일을 삭제힌다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		
	}
	*/
}
