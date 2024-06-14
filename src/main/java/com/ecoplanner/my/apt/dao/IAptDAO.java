package com.ecoplanner.my.apt.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ecoplanner.my.apt.vo.AptVO;

@Mapper
public interface IAptDAO {
	// [OO동] 조회 _ main treemap 기능
	public List<AptVO> getAptNeighborhood(AptVO vo);

	// 셀렉트 박스 첫번째
	public List<AptVO> onechoice();

	// 셀렉트 박스 두번째
	public List<AptVO> twochoice(AptVO vo);

	// 셀렉트 박스 세번째
	public List<AptVO> threechoice(AptVO vo);
	
	// 1년치 모든아파트 elec_usage 그래프 202301 ~ 202312
	public List<AptVO> getAptSumElecUsage();
	
	// 목표치 계산 결과 조회
	public List<AptVO> getBill(AptVO vo);
	// 목표치[여름] 계산 결과 조회
	public List<AptVO> getSummerBill(AptVO vo);
	// 아파트 비교 차트
	public List<AptVO> compareApt(AptVO vo);

	// 고지서 통한 사용량 업데이트
	public int updateElecUsage(AptVO vo);
	
	// 아파트 평균 전력량 조회
	public AptVO getAptElecUsage(AptVO vo);
	
	//내아파트 전력조회
	public List<AptVO> myapt(AptVO vo);
}
