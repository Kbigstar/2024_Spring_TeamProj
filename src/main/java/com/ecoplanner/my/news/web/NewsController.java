package com.ecoplanner.my.news.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecoplanner.my.member.vo.MemberVO;
import com.ecoplanner.my.news.service.NewsService;
import com.ecoplanner.my.news.vo.NewsSearchVO;
import com.ecoplanner.my.news.vo.NewsVO;

@Controller
public class NewsController {

	@Autowired
	NewsService newsService;

	@RequestMapping("/news")
	public String news(Model model, @ModelAttribute("searchVO") NewsSearchVO searchVO) {
		System.out.println(searchVO);
		List<NewsVO> newsList = newsService.getnews(searchVO);
		model.addAttribute("newsList", newsList);
		return "news/news";
	}

	@ResponseBody
	@RequestMapping("/updateNewsViews")
	public void updateNewsViews(@RequestBody NewsVO vo) {
		try {
			newsService.updateNewsViews(vo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("업데이트");
		System.out.println(vo);

	}

	// 스크랩
	@RequestMapping("/scrapDo")
	public ResponseEntity<?> scrapDo(NewsVO vo,HttpSession session) throws Exception {
	
		MemberVO login = (MemberVO) session.getAttribute("login");
		vo.setMemId(login.getMemId());
		System.out.println(vo);
		newsService.scrapNews(vo);
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("message","success");
		return new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);
		
	}
	//스크랩 삭제
	@RequestMapping(value="/scrapDel",method=RequestMethod.POST)
	public String scrapDel(NewsVO vo,HttpSession session) throws Exception {
		
		MemberVO login = (MemberVO) session.getAttribute("login");
		vo.setMemId(login.getMemId());
		System.out.println(vo);
		newsService.deleteScrap(vo);		
		return "redirect:/news";
	}
	//스크랩 조회
	@RequestMapping("/scrapList")
	public ResponseEntity<List<NewsVO>> scrapList(@RequestBody NewsVO vo) {
		System.out.println(vo);
		List<NewsVO> scrapList = newsService.scrapSelect(vo);
		return ResponseEntity.ok(scrapList);
	}
	
}
