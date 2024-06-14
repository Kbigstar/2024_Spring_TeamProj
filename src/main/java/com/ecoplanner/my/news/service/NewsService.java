package com.ecoplanner.my.news.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecoplanner.my.news.dao.INewsDAO;
import com.ecoplanner.my.news.vo.NewsSearchVO;
import com.ecoplanner.my.news.vo.NewsVO;

@Service
public class NewsService {

	@Autowired
	INewsDAO dao;

	// 뉴스 조회하기
	public List<NewsVO> getnews(NewsSearchVO searchVO) {
		// 검색조건에 따른 전체 건수 조회
		int total = dao.getTotalRowCount(searchVO);
		// 전체건수로 paging 건수 세팅
		searchVO.setTotalRowCount(total);
		searchVO.pageSetting();

		List<NewsVO> result = dao.getnews(searchVO);
		System.out.println(result);
		return result;
	}

	// 조회수 증가
	public void updateNewsViews(NewsVO vo) throws Exception {
		int result = dao.updateNewsViews(vo);

		if (result == 0) {
			throw new Exception();
		}
	}

	// 스크랩
	public void scrapNews(NewsVO vo) throws Exception {
		int result = dao.scrapNews(vo);

		if (result == 0) {
			throw new Exception();
		}
	}

	// 스크랩 삭제
	public void deleteScrap(NewsVO vo) throws Exception {
		int result = dao.deleteScrap(vo);

		if (result == 0) {
			throw new Exception();
		}
	}
	// 스크랩 조회
	public List<NewsVO> scrapSelect(NewsVO vo){
		List<NewsVO> result = dao.scrapSelect(vo);
		System.out.println(result);
		return result;
	}
}
