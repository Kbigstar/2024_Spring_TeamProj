package com.ecoplanner.my.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ecoplanner.my.apt.vo.AptVO;
import com.ecoplanner.my.member.vo.MemberVO;

@Mapper
public interface IMemberDAO {

	// 회원조회
	public MemberVO loginMember(MemberVO vo);

	// 회원가입
	public int registMember(MemberVO vo);

	// 아파트 리스트 조회
	public List<AptVO> getAptList(AptVO vo);

	// 수정하기
	public int updateMember(MemberVO vo);

	// 비밀번호만 수정
	public int updatePw(MemberVO vo);

	// 전화번호 인증
	public MemberVO certifiedMember(MemberVO vo);

	// 아이디 찾기
	public MemberVO findMember(MemberVO vo);

	// 비밀번호 찾기
	public List<MemberVO> getMemberList(String email);

	// 전화번호 중복
	public MemberVO phoneMember(MemberVO vo);
	
	// 비밀번호 찾기 이후 변경
	public int updateSearchPw(MemberVO vo);

}
