package com.ecoplanner.my.apt.vo;

import lombok.Data;

@Data
public class AptVO {
	
	
	private int apartNo; 				// 아파트 번호
	private String apartProvince;		 // 시
	private String apartDistrict; 		// 구
	private String apartNeighborhood; 	// 동
	private String apartBuildingnm; 	// 아파트 이름
	private int apartLegalcode; 		// 법정동 코드
	private String apartComplexcode; 	// 단지코드
	private int totalElecUsage; 		// 전기 사용량 합계
	
	private String enerDt; // 그래프용 아파트 날짜
	private int elecUsage; // 그래프용 전력사용량
	
	private int elecUseage; // 목표치 계산용 전력사용량
	private int totalBillAmount; // 목표치 계산용 전기세
	
	private String memId; // 고지서 사용량 업데이트용 아이디 
	
}
