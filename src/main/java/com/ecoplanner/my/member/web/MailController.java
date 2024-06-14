package com.ecoplanner.my.member.web;

import java.io.UnsupportedEncodingException;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ecoplanner.my.member.service.MailService;
import com.ecoplanner.my.member.vo.MailVO;
import com.ecoplanner.my.member.vo.MemberVO;


@Controller
public class MailController {
	
	@Autowired
	private MailService mailService;
	
	private int matchNumber = 0;
	
	@RequestMapping("/test")
    public String test() throws UnsupportedEncodingException {
        // 난수 생성
        Random random = new Random();
        int randomNumber = random.nextInt(999999); // 0부터 999999까지의 난수 생성
        
        // 난수를 포함한 메일 본문
        String subject = "테스트";
        String content = "반갑다, 인증번호는 " + randomNumber + "입니다.";
        matchNumber = randomNumber;
        System.out.println("메일 전송 완료: " + randomNumber+ " gdgdgd " + matchNumber);
        
        // 메일 전송
        mailService.sendMail("asder0705@naver.com", subject, content);
        System.out.println("메일 전송 완료: " + content);
        
        return "main";
    }
    
	
	@ResponseBody
	@RequestMapping("/sendMailDo")
	public String sendMailDo(@RequestBody MailVO vo) throws UnsupportedEncodingException {
	    if (vo.getEmail() == null || vo.getEmail().isEmpty()) {
	        throw new IllegalArgumentException("To address must not be null");
	    }

	    // 난수 생성
	    Random random = new Random();
	    int randomNumber = random.nextInt(999999); // 0부터 999999까지의 난수 생성
	    
	    
	    // 난수를 포함한 메일 본문
	    String subject = "EcoPlanner";
	    String content = "인증번호는 " + randomNumber + "입니다.";
	    matchNumber = randomNumber;
	    System.out.println("메일 전송 준비 중: " + randomNumber);

	    // 메일 전송
	    mailService.sendMail(vo.getEmail(), subject, content);
	    System.out.println("메일 전송 완료: " + content);

	    
	    
	    return Integer.toString(randomNumber);
	}
	
	
}
