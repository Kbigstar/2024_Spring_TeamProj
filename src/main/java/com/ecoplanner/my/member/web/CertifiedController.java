package com.ecoplanner.my.member.web;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@RestController
	public class CertifiedController{

	    final DefaultMessageService messageService;

	    public CertifiedController() {
	        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
	        this.messageService = NurigoApp.INSTANCE.initialize("NCSDYXX8GMDKY4AW", "JRZVOYPHKWHPN4FELGVZWMOVTZWNTONC", "https://api.coolsms.co.kr");
	    }

	    /**
	     * 단일 메시지 발송 예제
	     */
	    @GetMapping("/sendSMS")
	    @ResponseBody
	    public int sendSMS(@RequestParam("memPhone") String userPhoneNumber, HttpSession session) {
	        int randomNumber = (int)((Math.random() * (9999 - 1000 + 1)) + 1000); // 난수 생성
	        session.setAttribute("smsCode", randomNumber);
	        System.out.println("Generated Code: " + randomNumber);
	        System.out.println("Stored in Session: " + session.getAttribute("smsCode")); // 이 라인 추가

	        Message message = new Message();
	        message.setFrom("01048748190");
	        message.setTo(userPhoneNumber);
	        message.setText("[Ecoplanner] 휴대폰 인증번호 \n 인증번호 [" + randomNumber + "]");

	        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
	        System.out.println(response);
	        return randomNumber;
	    }
	    


	    @RequestMapping("/verifyCode")
	    public String verifyCode(@RequestParam("userCode") int userCode, HttpSession session) {
	        Integer sessionCode = (Integer) session.getAttribute("smsCode");
	        System.out.println("Session Code: " + sessionCode);
	        System.out.println("User Code: " + userCode);

	        if (sessionCode != null && sessionCode.equals(userCode)) {
	            return "Y";
	        } else {
	            return "N";
	        }
	    }
	}
	


