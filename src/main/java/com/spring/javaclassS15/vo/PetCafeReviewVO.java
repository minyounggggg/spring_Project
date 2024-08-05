package com.spring.javaclassS15.vo;

import lombok.Data;

@Data
public class PetCafeReviewVO {
	private int idx;
	private int placeIdx;
	private String mid;
	private String nickName;
	private String photo;
	private String title;
	private String content;
	private String returnVisit;
	private int readNum;
	private String uploadDate;
	private int complaint;
	private int goodHeart;
	private String hostIp;
	
	private int reviewCnt;
}
