package com.ecoplanner.my.member.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ecoplanner.my.member.service.MemberService;
import com.ecoplanner.my.member.vo.MemberVO;

@RestController
public class findController {

    @Autowired
    private MemberService memberService;

    @PostMapping("/idfindDo")
    public MemberVO idfindDo(MemberVO login) {
    	System.out.println(login);
        MemberVO vo = memberService.findMember(login);
        System.out.println("out:");
        System.out.println(vo);
        return vo;
    }
}
