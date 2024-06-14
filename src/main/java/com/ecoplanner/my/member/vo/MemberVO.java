package com.ecoplanner.my.member.vo;

import lombok.Data;

@Data
public class MemberVO {
	
 private String memId;
 private String memPw;
 private String memNm;
 private String memRes;
 private String memPhone;
 private String newPw;
 private int elecUsage;
 private int targetUsage;
 
 
 private String apartProvince; 
 private String apartDistrict; 
 private String apartNeighborhood; 
 private String apartBuildingnm; 
 private String apartComplexcode;
 
 
 private int matchNum;
}
