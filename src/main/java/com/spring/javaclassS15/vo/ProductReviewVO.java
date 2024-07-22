package com.spring.javaclassS15.vo;

import lombok.Data;

@Data
public class ProductReviewVO {
	private int idx;
	private String mid;
	private String nickName;
	private String photo;
	private String petCategory;
	private String productCategory;
	private String brand;
	private String productName;
	private int memberHeart;
	private int petHeart;
	private String goodPoint;
	private String badPoint;
	private String productPhoto;
	private String repurchase;
	private int readNum;
	private String uploadDate;
	private int complaint;
	private int goodHeart;
	private String hostIp;
	
	private int commentCnt;
	
}
