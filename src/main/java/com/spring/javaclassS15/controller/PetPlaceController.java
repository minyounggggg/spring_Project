package com.spring.javaclassS15.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS15.common.JavaclassProvide;
import com.spring.javaclassS15.service.PetPlaceService;
import com.spring.javaclassS15.vo.PetCafeVO;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/petPlace")
public class PetPlaceController {
	
	@Autowired
	PetPlaceService petPlaceService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	
	@RequestMapping(value = "/petCafeForm", method = RequestMethod.GET)
	public String petCafeFormGet() {
		return "petPlace/petCafeForm";
	}
	
	// CSV파일을 MySQL파일로 변환하기
	@ResponseBody
	@RequestMapping(value = "/petCafeForm", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String csvFormPost(MultipartFile fName, HttpServletRequest request) throws IOException {
		return petPlaceService.fileCsvToMysql(fName);
	}

	@RequestMapping(value = "/petCafe", method = RequestMethod.GET)
	public String petCafeGet(Model model) {
		PetCafeVO vo = new PetCafeVO();
		List<PetCafeVO> vos = petPlaceService.getPetCafeMap();
		
		model.addAttribute("vo", vo);
		model.addAttribute("jsonVos", JSONArray.fromObject(vos));
		return "petPlace/petCafe";
	}
}
