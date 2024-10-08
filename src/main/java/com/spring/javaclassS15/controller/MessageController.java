package com.spring.javaclassS15.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "", required = false) String idx,
			@RequestParam(name="updateIdx", defaultValue = "", required = false) String updateIdx,
			@RequestParam(name="placeIdx", defaultValue = "", required = false) String placeIdx,
			@RequestParam(name="pag", defaultValue = "1", required = false) String pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) String pageSize
			) {
		
		if(msgFlag.equals("memberLoginOK")) {
			model.addAttribute("msg", mid + "님 로그인 되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNewOK")) {
			model.addAttribute("msg", mid+"님 로그인 되었습니다.\\n임시 비밀번호가 등록된 이메일로 발급되었습니다.\\n확인 후 회원정보를 변경해주세요.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNO")) {
			model.addAttribute("msg", "입력하신 아이디 또는 비밀번호가 다릅니다.\\n다시 입력해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinIdNO")) {
			model.addAttribute("msg", "이미 사용중인 아이디입니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberJoinNickNO")) {
			model.addAttribute("msg", "이미 사용중인 닉네임입니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberJoinOK")) {
			model.addAttribute("msg", "회원가입이 완료되었습니다. 다시 로그인해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNO")) {
			model.addAttribute("msg", "회원가입 오류! 다시 시도해주세요.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", "로그아웃이 정상적으로 완료되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "로그인 후 이용해주시기 바랍니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("petInsertOK")) {
			model.addAttribute("msg", "반려동물 등록이 완료되었습니다.");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("petInsertNO")) {
			model.addAttribute("msg", "반려동물 등록 오류! 다시 시도해주세요.");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("memberUpdateOK")) {
			model.addAttribute("msg", "회원 정보가 수정되었습니다.");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("memberUpdateNO")) {
			model.addAttribute("msg", "회원 정보 수정 오류! 다시 시도해주세요.");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("petUpdateOK")) {
			model.addAttribute("msg", "반려동물 정보수정이 완료되었습니다.");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("petUpdateNO")) {
			model.addAttribute("msg", "반려동물 정보수정 오류! 다시 시도해주세요.");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("petDeleteOK")) {
			model.addAttribute("msg", "반려동물의 정보가 삭제되었습니다.");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("petDeleteNO")) {
			model.addAttribute("msg", "반려동물 정보삭제 오류! 다시 시도해주세요.");
			model.addAttribute("url", "/member/memberMypage");
		}
		else if(msgFlag.equals("productReviewInsertOK")) {
			model.addAttribute("msg", "제품 후기가 등록 되었습니다.");
			model.addAttribute("url", "/review/productReview");
		}
		else if(msgFlag.equals("productReviewInsertNO")) {
			model.addAttribute("msg", "제품 후기 등록 실패! 다시 시도해주세요.");
			model.addAttribute("url", "/review/productReview");
		}
		else if(msgFlag.equals("productReviewUpdateOK")) {
			model.addAttribute("msg", "제품 후기 수정완료.");
			model.addAttribute("url", "/review/productReview");
		}
		else if(msgFlag.equals("productReviewUpdateNO")) {
			model.addAttribute("msg", "제품 후기 수정 실패! 다시 시도해주세요.");
			model.addAttribute("url", "/review/productReview");
		}
		else if(msgFlag.equals("petCafeReviewInsertOK")) {
			model.addAttribute("msg", "카페 리뷰가 등록 되었습니다.");
			model.addAttribute("url", "/petPlace/petCafeReviewList?idx="+idx);
		}
		else if(msgFlag.equals("petCafeReviewInsertNO")) {
			model.addAttribute("msg", "리뷰 등록 실패! 다시 시도해주세요.");
			model.addAttribute("url", "/petPlace/petCafeReviewList?idx="+idx);
		}
		else if(msgFlag.equals("cafeReviewUpdateOk")) {
			model.addAttribute("msg", "카페 리뷰가 수정되었습니다.");
			model.addAttribute("url", "/petPlace/petCafeReviewContent?idx="+updateIdx+"&placeIdx="+placeIdx);
		}
		else if(msgFlag.equals("cafeReviewUpdateNO")) {
			model.addAttribute("msg", "카페 리뷰 수정 실패! 다시 시도해주세요.");
			model.addAttribute("url", "/petPlace/petCafeReviewContent?idx="+updateIdx+"&placeIdx="+placeIdx);
		}
		else if(msgFlag.equals("cafeReviewDeleteOK")) {
			model.addAttribute("msg", "카페 리뷰가 정상적으로 삭제 되었습니다.");
			model.addAttribute("url", "/petPlace/petCafeReviewList?idx="+idx);
		}
		else if(msgFlag.equals("cafeReviewDeleteNO")) {
			model.addAttribute("msg", "카페 리뷰 삭제 실패! 다시 시도해주세요.");
			model.addAttribute("url", "/petPlace/petCafeReviewList?idx="+idx);
		}
		
		else if(msgFlag.equals("hospitalReviewInsertOK")) {
			model.addAttribute("msg", "병원 리뷰가 등록 되었습니다.");
			model.addAttribute("url", "/hospital/hospitalReviewList?idx="+idx);
		}
		else if(msgFlag.equals("hospitalReviewInsertNO")) {
			model.addAttribute("msg", "리뷰 등록 실패! 다시 시도해주세요.");
			model.addAttribute("url", "/hospital/hospitalReviewList?idx="+idx);
		}
		else if(msgFlag.equals("hospitalReviewUpdateOk")) {
			model.addAttribute("msg", "병원 리뷰가 수정되었습니다.");
			model.addAttribute("url", "/hospital/hospitalReviewContent?idx="+updateIdx+"&placeIdx="+placeIdx);
		}
		else if(msgFlag.equals("hospitalReviewUpdateNO")) {
			model.addAttribute("msg", "병원 리뷰 수정 실패! 다시 시도해주세요.");
			model.addAttribute("url", "/hospital/hospitalReviewContent?idx="+updateIdx+"&placeIdx="+placeIdx);
		}
		else if(msgFlag.equals("hospitalReviewDeleteOK")) {
			model.addAttribute("msg", "병원 리뷰가 정상적으로 삭제 되었습니다.");
			model.addAttribute("url", "/hospital/hospitalReviewList?idx="+idx);
		}
		else if(msgFlag.equals("hospitalReviewDeleteNO")) {
			model.addAttribute("msg", "병원 리뷰 삭제 실패! 다시 시도해주세요.");
			model.addAttribute("url", "/hospital/hospitalReviewList?idx="+idx);
		}
		else if(msgFlag.equals("reviewDeleteOK")) {
			model.addAttribute("msg", "신고 게시글이 삭제 처리되었습니다.");
			model.addAttribute("url", "/admin/complaintList");
		}
		else if(msgFlag.equals("reviewDeleteNO")) {
			model.addAttribute("msg", "신고 게시글 삭제 실패! 다시 시도해주세요.");
			model.addAttribute("url", "/admin/complaintList");
		}
		else if(msgFlag.equals("productReviewUpdateOK")) {
			model.addAttribute("msg", "해당 제품의 후기가 수정 되었습니다.");
			model.addAttribute("url", "/review/productReviewContent?idx="+idx);
		}
		else if(msgFlag.equals("productReviewUpdateNO")) {
			model.addAttribute("msg", "제품 후기 수정 실패! 다시 시도해주세요.");
			model.addAttribute("url", "/review/productReviewContent?idx="+idx);
		}
		else if(msgFlag.equals("memberPointCheck")) {
			model.addAttribute("msg", "출석 포인트(+10P)가 지급되었습니다!");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("mbti_E")) {
			model.addAttribute("msg", "당신의 MBTI는 E입니다.");
			model.addAttribute("url", "/mbti/mbti");
		}
		else if(msgFlag.equals("mbti_I")) {
			model.addAttribute("msg", "당신의 MBTI는 I입니다.");
			model.addAttribute("url", "/mbti/mbti");
		}
		
		
		
		return "include/message";
	}
	
}
