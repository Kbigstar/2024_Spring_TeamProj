package com.ecoplanner.my.apt.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecoplanner.my.apt.service.AptService;
import com.ecoplanner.my.apt.vo.AptVO;
import com.ecoplanner.my.member.vo.MemberVO;

@Controller
public class AptController {

	@Autowired
	AptService aptService;
	
	@RequestMapping("/aptBill")
	public String aptBill() {

		return "apt/aptBill";
	}
	
	@RequestMapping("/aptPlan")
	public String aptPlan() {

		return "apt/aptPlan";
	}

	@RequestMapping("/apt")
	public String apt() {

		return "apt/apt";

	}

	@RequestMapping("/aptCompare")
	public String aptCompare(HttpSession session,Model model ) {
		session.getAttribute("login");
		// 1. 고객정보 
		// 2. 고객정보로 해당년도 값 가져오기 (db)
		// 3. 화면 으로 전달(model) 
		
		return "apt/aptCompare";
	}
	
	
	
	@PostMapping("/aptGetDistrict")
	public ResponseEntity<List<AptVO>> getDistrict(@RequestBody AptVO vo){
	    System.out.println(vo);
	    List<AptVO> result = aptService.getAptNeighborhood(vo);
	    return ResponseEntity.ok(result);
	}
	
	@PostMapping("/aptGetSum")
	public ResponseEntity<List<AptVO>> getSumElecUsage(){
	    List<AptVO> result = aptService.getAptSumElecUsage();
	    System.out.println(result);
	    return ResponseEntity.ok(result);
	}
	
	@PostMapping("/calculateBill")
	public ResponseEntity<List<AptVO>> getBill(@RequestBody AptVO vo){
	    System.out.println(vo);
	    List<AptVO> result = aptService.getBill(vo);
	    return ResponseEntity.ok(result);
	}
	
	@PostMapping("/calculateSummerBill")
	public ResponseEntity<List<AptVO>> getSummerBill(@RequestBody AptVO vo){
	    System.out.println(vo);
	    List<AptVO> result = aptService.getSummerBill(vo);
	    return ResponseEntity.ok(result);
	}
	
	@RequestMapping("/updateElecUsage")
	public ResponseEntity<String> updateElecUsage(@RequestBody AptVO vo, HttpSession session){
		try {
			aptService.updateElecUsage(vo);
			System.out.println("업데이트");
        	System.out.println(vo);
            // 세션에서 기존 login 객체 가져오기
            Object loginObj = session.getAttribute("login");
            if (loginObj != null && loginObj instanceof MemberVO) {
                MemberVO login = (MemberVO) loginObj;
                login.setElecUsage(vo.getElecUsage()); // elecUsage 값 설정
                session.setAttribute("login", login); // 세션에 업데이트된 login 객체 저장
                System.out.println("gdgd"+login.getElecUsage());
            }
        	
        	return ResponseEntity.ok().body("[not error]Event update successfully");
		} catch (Exception e) {
			System.out.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update event");
		}
	}
	
	@ResponseBody
	@RequestMapping("/aptAvgElecUsage")
	public AptVO getAptElecUsage(@RequestBody AptVO vo) {
		AptVO result = aptService.getAptElecUsage(vo);
		System.out.println("aptelecusageVO: " + vo);
		System.out.println("aptelecusage: " + result);
		return result;
	}
		@PostMapping("/myapt")
		public  ResponseEntity<List<AptVO>> myapt(@RequestBody AptVO vo) {
			
			List<AptVO> myapt = aptService.myapt(vo);
			 System.out.println(myapt);
			return ResponseEntity.ok(myapt);
	}

}