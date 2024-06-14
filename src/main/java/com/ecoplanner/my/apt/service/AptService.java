package com.ecoplanner.my.apt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecoplanner.my.apt.dao.IAptDAO;
import com.ecoplanner.my.apt.vo.AptVO;

@Service
public class AptService {

	@Autowired
	IAptDAO dao;

	public List<AptVO> getAptNeighborhood(AptVO vo) {
		List<AptVO> result = dao.getAptNeighborhood(vo);
		System.out.println(result);
		return result;
	}

	// 셀렉트 박스 첫번째
	public List<AptVO> onechoice() {
		return dao.onechoice();
	}

	// 셀렉트 박스 두번째
	public List<AptVO> twochoice(AptVO vo) {
		return dao.twochoice(vo);
	}
	// 셀렉트 박스 세번째
		public List<AptVO> threechoice(AptVO vo) {
			return dao.threechoice(vo);
		}
	public List<AptVO> getAptSumElecUsage(){
		List<AptVO> result = dao.getAptSumElecUsage();
		System.out.println(result);
		return result;
	}
	
	// 목표치 계산 결과 조회
	public List<AptVO> getBill(AptVO vo){
		List<AptVO> result = dao.getBill(vo);
		System.out.println(result);
		return result;
	}
	
	// 목표치[여름] 계산 결과 조회
	public List<AptVO> getSummerBill(AptVO vo){
		List<AptVO> result = dao.getSummerBill(vo);
		System.out.println(result);
		return result;
	}

	// 아파트 비교 차트
	public List<AptVO> compareApt(AptVO vo) {
		List<AptVO> result = dao.compareApt(vo);
		System.out.println(result);
		return result;
	}

	
	// 고지서 통한 사용량 업데이트
	public void updateElecUsage(AptVO vo) throws Exception{
		int result = dao.updateElecUsage(vo);
		
		if(result == 0) {
			throw new Exception();
		}
	}
	
	// 아파트 평균 전력량 조회
	public AptVO getAptElecUsage(AptVO vo) {
		AptVO result = dao.getAptElecUsage(vo);
		System.out.println("avgelec: " + result);
		return result;
	}
	
	//내아파트 전력조회
	public List<AptVO> myapt(AptVO vo)	{
		List<AptVO> result = dao.myapt(vo);
		System.out.println(result);
		return result;
	}

}
