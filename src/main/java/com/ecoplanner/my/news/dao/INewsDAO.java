package com.ecoplanner.my.news.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ecoplanner.my.news.vo.NewsSearchVO;
import com.ecoplanner.my.news.vo.NewsVO;



	@Mapper
	public interface INewsDAO{
		// 뉴스 조회
		public List<NewsVO> getnews(NewsSearchVO searchVO);
		// 조회수 증가
		public int updateNewsViews(NewsVO vo);
		// 게시글 전체 건수
		public int getTotalRowCount(NewsSearchVO searchVO);
		//스크랩
		public int scrapNews(NewsVO vo);
		//스크랩 삭제
		public int deleteScrap(NewsVO vo);
		// 스크랩 조회
		public List<NewsVO> scrapSelect(NewsVO vo);
}
