package com.spring.javaclassS15.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS15.vo.ProductReviewVO;
import com.spring.javaclassS15.vo.ReviewCommentVO;

public interface ProductReviewDAO {

	public List<ProductReviewVO> getProductReview();

	public int setproductReviewInsert(@Param("vo") ProductReviewVO vo);

	public ProductReviewVO getproductReviewContent(@Param("idx") int idx);

	public List<ReviewCommentVO> getPdReviewComment(@Param("idx") int idx);

	public ReviewCommentVO getPdReviewParentCommentCheck(@Param("partIdx") int partIdx);

	public int setPdReviewCommentInputOK(@Param("commentVO") ReviewCommentVO commentVO);

	public void setReadNumPlus(@Param("idx") int idx);

	public void setpdReviewHeartUp(@Param("idx") String idx);
	
}
