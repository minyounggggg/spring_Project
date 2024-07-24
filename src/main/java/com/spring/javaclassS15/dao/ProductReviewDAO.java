package com.spring.javaclassS15.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS15.vo.ProductReviewVO;

public interface ProductReviewDAO {

	List<ProductReviewVO> getProductReview();

	int setproductReviewInsert(@Param("vo") ProductReviewVO vo);

	ProductReviewVO getproductReviewContent(@Param("idx") int idx);
	
}
