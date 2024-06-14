package com.ecoplanner.my.member.web;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ecoplanner.my.apt.vo.AptVO;
import com.ecoplanner.my.member.service.MemberService;
import com.ecoplanner.my.member.vo.MemberVO;

@Controller
public class MemberController {
    
    @Autowired
    MemberService memberService;
    
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @RequestMapping("/login")
    public String login(HttpServletRequest request, Model model) {
        // 쿠키에서 rememberId를 읽어와 모델에 추가
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberId".equals(cookie.getName())) {
                    model.addAttribute("rememberId", cookie.getValue());                
                }
            }
        }
        return "member/login";
    }

    @RequestMapping("/loginDo")
    public String loginDo(MemberVO vo, HttpSession session, 
                          @RequestParam(value = "remember", required = false) Boolean remember, 
                          RedirectAttributes re, HttpServletResponse resp) {
        MemberVO login = memberService.loginMember(vo);
        if (login == null) {
            re.addFlashAttribute("msg", "아이디를 확인해 주세요.");
            return "redirect:/login";
        }
        boolean match = passwordEncoder.matches(vo.getMemPw(), login.getMemPw());
        if (!match) {
            re.addFlashAttribute("msg", "비번을 확인해 주세요.");
            return "redirect:/login";
        }
        session.setAttribute("login", login);
        
        // 아이디 기억하기 선택했을 때
        if (Boolean.TRUE.equals(remember)) {
            Cookie cookie = new Cookie("rememberId", vo.getMemId());
            cookie.setMaxAge(7 * 24 * 60 * 60); // 7일 동안 저장
            resp.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("rememberId", "");
            cookie.setMaxAge(0); // 유효시간이 0
            resp.addCookie(cookie);
        }

        re.addFlashAttribute("msg", "로그인이 정상적으로 처리되었습니다.");
        return "redirect:/";
    }

    @RequestMapping("/logoutDo")
    public String logoutDo(HttpSession session, RedirectAttributes re) {
        session.invalidate();
        re.addFlashAttribute("msg", "로그아웃 되셨습니다.");
        return "redirect:/";
    }

    @RequestMapping("/cbPoint")
    public String cbPoint() {
        return "member/cbPoint";
    }

    @RequestMapping("/regist")
    public String regist() {
        return "member/regist";
    }

    @RequestMapping("/registDo")
    public String registDo(HttpServletRequest request, MemberVO member, RedirectAttributes re) {
        member.setMemPw(passwordEncoder.encode(request.getParameter("memPw")));
        try {
            memberService.registMember(member);
        } catch (Exception e) {
            e.printStackTrace();
            return "errorView";
        }
        re.addFlashAttribute("msg", "회원가입이 정상적으로 처리 되었습니다.");
        return "redirect:/";
    }

    @PostMapping("/getAptList")
    @ResponseBody
    public ResponseEntity<List<AptVO>> getAptList(@RequestBody AptVO vo) {
        List<AptVO> result = memberService.getAptList(vo);
        return ResponseEntity.ok(result);
    }

    @RequestMapping("/mypage")
    public String mypageView(HttpSession session, Model model) {
        if (session.getAttribute("login") == null) {
            return "redirect:/login";
        }
        return "member/mypage";
    }

    @RequestMapping("/updateDo")
    public String updateDo(MemberVO vo, HttpSession session, RedirectAttributes redirectAttributes) {
        MemberVO sessionMember = (MemberVO) session.getAttribute("login");
        
        if (sessionMember != null && sessionMember.equals(vo)) {
            redirectAttributes.addFlashAttribute("msg", "수정할 내용이 없습니다.");
            return "redirect:/mypage";
        }

        try {
            memberService.updateMember(vo);
            session.setAttribute("login", vo);
            redirectAttributes.addFlashAttribute("msg", "회원 정보가 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("msg", "회원 정보 수정 중 오류가 발생했습니다.");
        }

        return "redirect:/mypage";
    }
    // 비밀번호 변경
    @RequestMapping(value = "/updatePw", method = RequestMethod.POST)
    public String updatePw(@RequestParam("currentPw") String currentPw,
                           @RequestParam("newPw") String newPw,
                           @RequestParam("confirmPw") String confirmPw,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        MemberVO sessionMember = (MemberVO) session.getAttribute("login");

        if (sessionMember == null) {
            // 로그인이 되어 있지 않은 경우
            return "redirect:/login";
        }
        
        boolean match = passwordEncoder.matches(newPw, sessionMember.getMemPw());
        
        	
        // 현재 비밀번호가 맞는지 확인
        if (!passwordEncoder.matches(currentPw, sessionMember.getMemPw())) {
            redirectAttributes.addFlashAttribute("msg", "현재 비밀번호가 일치하지 않습니다.");
            return "redirect:/mypage";
        }
        
        // 새로운 비밀번호와 새 비밀번호 확인이 일치하는지 확인
        if (!newPw.equals(confirmPw)) {
            redirectAttributes.addFlashAttribute("msg", "새 비밀번호가 일치하지 않습니다.");
            return "redirect:/mypage";
        }

        try {
            // 비밀번호 암호화하여 저장
            String encryptedNewPw = passwordEncoder.encode(newPw);
            sessionMember.setMemPw(encryptedNewPw);
            
            // 새로운 암호화된 비밀번호로 업데이트
            memberService.updatePw(sessionMember);

            // 세션 업데이트
            session.setAttribute("login", sessionMember);
            redirectAttributes.addFlashAttribute("msg", "회원 정보가 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("msg", "회원 정보 수정 중 오류가 발생했습니다.");
        }

        return "redirect:/mypage";
    }
    // 비밀번호 찾기 
    @RequestMapping("/updateSearchPw")
    public String updateSearchPw(@RequestBody MemberVO vo) throws Exception {
    	 String encryptedNewPw = vo.getMemPw();
    	 encryptedNewPw = passwordEncoder.encode(encryptedNewPw);
    	 vo.setMemPw(encryptedNewPw);
    	 memberService.updateSearchPw(vo);
    	 
    	return "redirect:login";
    }
    // 비밀번호 찾기  끝
    
    @RequestMapping("/idpw")
    public String idpw() {
        return "member/idpw";
    }

    @RequestMapping("/idpwDo")
    public String idpwDo(MemberVO vo, HttpSession session, RedirectAttributes re) {
    	
        MemberVO idpw = memberService.loginMember(vo);
        if (idpw == null) {
            re.addFlashAttribute("msg", "아이디를 확인해 주세요.");
            return "redirect:/idpw";
        }
        boolean match = passwordEncoder.matches(idpw.getMemPw(),vo.getMemPw());
        if (!match) {
            re.addFlashAttribute("msg", "비번을 확인해 주세요.");
            return "redirect:/idpw";
        }
        session.setAttribute("idpw", idpw);
        re.addFlashAttribute("msg", "로그인이 정상적으로 처리되었습니다.");
        return "redirect:/";
    }
    
    
    
    // 아이디 중복체크
    @ResponseBody
    @RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
    public String clippingDO(@RequestBody MemberVO vo, RedirectAttributes re) {
    	try {
    		MemberVO check = memberService.loginMember(vo);
    		System.out.println(check);
    		if (check !=null) {
    			return "notnull";
    	}
    	}catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "null";
    }
    // 아이디 중복체크 끝
    
 // 이메일 중복체크
    @ResponseBody
    @RequestMapping(value = "/emailCheck", method = RequestMethod.POST)
    public String emailDO(@RequestBody MemberVO vo, RedirectAttributes re) {
    	System.out.println(vo);
    	try {
    		MemberVO email = memberService.loginMember(vo);
    		System.out.println(email);
    		if (email != null) {
    			return "notnull";
    		}
    	}catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "null";
    }
    // 이메일 중복체크 끝
    
    
    // 전화번호 중복체크
    @ResponseBody
    @RequestMapping(value = "/phoneCheck", method = RequestMethod.POST)
    public String phoneCheckDo(@RequestBody MemberVO vo, RedirectAttributes re) {
    	try {
    		MemberVO check = memberService.phoneMember(vo);
    		System.out.println(check);
    		if (check !=null) {
    			return "notnull";
    	}
    	}catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "null";
    }
    // 전화번호 중복체크 끝
    
    
    @ResponseBody
    @RequestMapping("/checkCurrentPassword")
	public boolean pwCheck(MemberVO vo) {
    	System.out.println(vo);
    	MemberVO idpw = memberService.loginMember(vo);
    	//현재 비번이랑 같지 않음
    	System.out.println(idpw.getMemPw());
    	System.out.println( vo.getNewPw());
    	
		boolean match = passwordEncoder.matches(vo.getNewPw(),idpw.getMemPw());
		System.out.println(match);
		return match;
	}
    
	
	@PostMapping("/aptGetRes")
	public ResponseEntity<List<AptVO>> aptGetRes(@RequestBody AptVO vo){
	    System.out.println(vo);
	    List<AptVO> result = memberService.getAptList(vo);
	    return ResponseEntity.ok(result);
	}
	
	
	
	
	
	
	
}
