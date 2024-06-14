package com.ecoplanner.my.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecoplanner.my.apt.vo.AptVO;
import com.ecoplanner.my.member.dao.IMemberDAO;
import com.ecoplanner.my.member.vo.MemberVO;

@Service
public class MemberService {

	@Autowired
	IMemberDAO dao;

	public void registMember(MemberVO vo) throws Exception {
		int result = dao.registMember(vo);
		if (result == 0) {
			throw new Exception();
		}
	}

	// 회원조회
	public MemberVO loginMember(MemberVO vo) {
		return dao.loginMember(vo);
	}
	
	// 아파트명
	public List<AptVO> getAptList(AptVO vo){
		List<AptVO> result = dao.getAptList(vo);
		System.out.println(result);
		return result;
	}
	
	//수정하기
	   public void updateMember(MemberVO vo) throws Exception {
	      int result = dao.updateMember(vo);
	      if(result == 0) {
	         throw new Exception();
	      }
	   }

	   // 비밀번호만 수정하기
	   public void updatePw(MemberVO vo) throws Exception {
		   int result = dao.updatePw(vo);
		   if(result == 0) {
			   throw new Exception();
		   }
	   }	
	   
	   // 전화번호 인증
	   public MemberVO certifiedMember (MemberVO vo) {
		   return dao.certifiedMember(vo);
	   }
	   
	   // 아이디 찾기
	   public MemberVO findMember(MemberVO vo) {
		   return dao.findMember(vo);
		}
	   
	   
	   // 비밀번호 중복
	   public MemberVO phoneMember(MemberVO vo) {
		   return dao.phoneMember(vo);
		}
	   

	   // 비밀번호만 수정하기
	   public void updateSearchPw(MemberVO vo) throws Exception {
		   int result = dao.updatePw(vo);
		   if(result == 0) {
			   throw new Exception();
		   }
	   }	
	   
	   
}
