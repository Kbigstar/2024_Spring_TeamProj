package com.ecoplanner.my.apt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ecoplanner.my.apt.service.AptService;
import com.ecoplanner.my.apt.vo.AptVO;

@RestController
public class CompareController {

	@Autowired
	AptService aptservice;
	
	@GetMapping("/onechoice")
	public List<AptVO> onechoice() {
		List<AptVO> comList = aptservice.onechoice();
		return comList;
	}

	@GetMapping("/twochoice")
	public List<AptVO> twochoice(@RequestParam String apartDistrict) {
		System.out.println(apartDistrict);
		AptVO vo = new AptVO();
		vo.setApartDistrict(apartDistrict);
		List<AptVO> codList = aptservice.twochoice(vo);
		return codList;
	
	}
	@GetMapping("/threechoice")
	public List<AptVO> threechoice(@RequestParam String apartNeighborhood) {
		AptVO vo = new AptVO();
		vo.setApartNeighborhood(apartNeighborhood);
		List<AptVO> coList = aptservice.threechoice(vo);
		return coList;
	
	}
	@PostMapping("/compareApt")
	public  ResponseEntity<List<AptVO>> compareApt(@RequestBody AptVO vo) {
		
		// 1.화면 선택 단지코드로 해당 단지의 정보 조회 
		// 2.비동기로 json 데이터 형태로 전달 
	
		List<AptVO> compare = aptservice.compareApt(vo);
		 System.out.println(compare);
		return ResponseEntity.ok(compare);
		
	}
}
