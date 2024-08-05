package com.spring.javaclassS15.vo;

import lombok.Data;

@Data
public class MemberVO {
	
	private int idx;
	private String mid;
	private String pwd;
	private String nickName;
	private String address;
	private String email;
	private String photo;
	private String userDel;
	private int point;
	private int visitCnt;
	private String startDate;
	private String lastDate;
	private int level;
	
	private int todayCnt;
}
