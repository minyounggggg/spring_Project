package com.spring.javaclassS15.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.service.AdminService;

@Controller
@RequestMapping("/mbti")
public class MbtiController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	
	// mbti 메인
	@RequestMapping(value = "/mbti", method = RequestMethod.GET)
	public String mbtiGet(Model model) {
		
		return "mbti/mbti";
	}
	
	// mbti 결과
	@ResponseBody
	@RequestMapping(value = "/mbtiResultOK", method = RequestMethod.POST)
	public String mbtiResultOKPost(int eORi) {
		if(eORi > 1) return "E";
		else return "I";
	}
	
	
	
	
	
}
