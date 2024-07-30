package com.spring.javaclassS15.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS15.vo.PetCafeVO;

public interface PetPlaceService {

	public String fileCsvToMysql(MultipartFile fName);

	public List<PetCafeVO> getPetCafeMap();


}
