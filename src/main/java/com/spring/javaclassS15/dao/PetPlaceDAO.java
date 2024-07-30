package com.spring.javaclassS15.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS15.vo.PetCafeVO;

public interface PetPlaceDAO {

	public void setPetCafe(@Param("vo") PetCafeVO vo);

	public List<PetCafeVO> getPetCafeMap();

	
}
