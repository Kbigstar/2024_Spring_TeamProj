package com.ecoplanner.my.board.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ecoplanner.my.board.vo.BoardVO;
import com.ecoplanner.my.board.vo.CommentVO;
import com.ecoplanner.my.member.vo.MemberVO;

@Mapper
public interface BoardDAO {

	// 게시글 리스트 조회
	public List<BoardVO> selectBoardList(Map<String, Object> param);

	// 게시글 리스트 조회
	public int insertBoardPost(BoardVO boardVO);

	// 게시글 상세 조회
	public BoardVO selectBoardDetail(int boardId);

	// 게시글 조회수 업데이트
	public void updateBoardViewCount(int boardId);
	
	// 게시글 좋아요 조회 by userId
	public int selectBoardLike(Map<String, Object> param);
	
	// 게시글 좋아요 추가
	public int insertBoardLike(Map<String, Object> param);
	
	// 게시글 좋아요 조회
	public int selectBoardLikeCount(int boardId);
	
	// 인기 게시글 조회
	public List<BoardVO> selectPopularBoardList(BoardVO boardVO);
	
	// 전체 게시글 조회
	public int selectBoardTotalCount(Integer boardMasterId);
	
	// 댓글 목록 조회
	public List<CommentVO> selectCommentList(int boardId);
	
	public void insertComment(CommentVO commentVO);
	
	int updateBoard(BoardVO boardVo);

	int deleteBoard(int boardId);


}
