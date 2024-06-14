package com.ecoplanner.my.board.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecoplanner.my.board.dao.BoardDAO;
import com.ecoplanner.my.board.vo.BoardVO;
import com.ecoplanner.my.board.vo.CommentVO;
import com.ecoplanner.my.board.vo.Pagination;
import com.ecoplanner.my.commons.utils.AuthUtils;
import com.ecoplanner.my.member.dao.IMemberDAO;
import com.ecoplanner.my.member.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardService {
	
	@Autowired
	BoardDAO dao;

	private final BoardDAO boardDao;
	
	public Pagination<BoardVO> getBoardList(BoardVO boardVO, int page, int size) {
		int pagePerSize = 5;
		
		Map<String, Object> param = new HashMap<>();
        param.put("boardMasterId", boardVO.getBoardMasterId());
        param.put("offset", (page-1) * size);
        param.put("size", size);
        param.put("searchWord", boardVO.getSearchWord());
        param.put("sort", boardVO.getSort());
        param.put("apartCode", boardVO.getApartCode());
		List<BoardVO> boardList = boardDao.selectBoardList(param);
		boardList.stream().forEach(it -> it.switchCreatedAt());
		
		int boardTotalCount = boardDao.selectBoardTotalCount(boardVO.getBoardMasterId());
		
        int totalPage = (int)Math.ceil((double)boardTotalCount / size);
		
		int startPage = (page - 1) / pagePerSize * pagePerSize + 1;
        int endPage = ((page - 1) / pagePerSize + 1) * pagePerSize;
        if(endPage > totalPage) endPage = totalPage;
        
		return Pagination.<BoardVO>builder()
			.curPage(page)
			.contents(boardList)
			.totalPage(totalPage)
			.startPage(startPage)
			.endPage(endPage)
			.pageSize(size)
			.build();
	}
	
	public int addBoardPost(BoardVO boardVO) {
		return boardDao.insertBoardPost(boardVO);
	}
	
	public BoardVO getBoardDetail(int boardId) {
		boardDao.updateBoardViewCount(boardId);
		
		BoardVO resultBoardVo = boardDao.selectBoardDetail(boardId);
		resultBoardVo.updateLikeCount(boardDao.selectBoardLikeCount(boardId));
		
		return resultBoardVo;
	}
	
	public boolean addBoardLike(int boardId) {
		MemberVO memberInfo = AuthUtils.getMemberInfo();
		
		Map<String, Object> param = new HashMap<String,Object>();
		param.put("boardId", boardId);
		param.put("userId", memberInfo.getMemId());
		
		int result = boardDao.selectBoardLike(param);
		
		if(result != 0) { return false; }
		
		boardDao.insertBoardLike(param);
		
		return true;
	}
	
	public List<BoardVO> getPopularBoardList(BoardVO boardVO) {
		return boardDao.selectPopularBoardList(boardVO);
	}
	
	public List<CommentVO> getCommetList(int boardId) {
		List<CommentVO> commentList = boardDao.selectCommentList(boardId);
		return commentList.stream().filter(it -> it.getParentCommentId() == null).collect(Collectors.toList());
	}
	
	public boolean updateBoard(BoardVO boardVO) {
		int result = boardDao.updateBoard(boardVO);

		return result > 0 ? true : false;
	}
	
	public boolean deleteBoard(int boardId) {
		int result = boardDao.deleteBoard(boardId);
		return result > 0 ? true : false;
	}
	public void addBoardComment(CommentVO commentVO) {
		MemberVO memberVO = AuthUtils.getMemberInfo();
		commentVO.setUserId(memberVO.getMemId());
		boardDao.insertComment(commentVO);
	}
}
