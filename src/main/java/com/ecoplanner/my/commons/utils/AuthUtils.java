package com.ecoplanner.my.commons.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ecoplanner.my.member.vo.MemberVO;

public class AuthUtils {

	// 세션 로그인 정보 조회
	public static MemberVO getMemberInfo() {
		HttpServletRequest request =((ServletRequestAttributes)RequestContextHolder
				.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		
		return (MemberVO) session.getAttribute("login");
	}
}
