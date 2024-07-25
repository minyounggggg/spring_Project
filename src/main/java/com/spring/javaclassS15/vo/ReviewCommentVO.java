package com.spring.javaclassS15.vo;

import lombok.Data;

@Data
public class ReviewCommentVO {
	private int idx;
	private int commentLev;
	private int commentCnt;
	private String part;
	private int partIdx;
	private String mid;
	private String nickName;
	private String photo;
	private String content;
	private String uploadDate;
	
}
