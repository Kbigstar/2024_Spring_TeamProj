package com.ecoplanner.my.board.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ecoplanner.my.board.service.BoardService;
import com.ecoplanner.my.board.vo.BoardVO;
import com.ecoplanner.my.board.vo.CommentVO;
import com.ecoplanner.my.board.vo.Pagination;
import com.ecoplanner.my.commons.utils.AuthUtils;
import com.ecoplanner.my.member.service.MemberService;
import com.ecoplanner.my.member.vo.MemberVO;

import lombok.RequiredArgsConstructor;
import oracle.net.aso.b;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {

	private final BoardService boardService;

	// 공통 게시글 리스트 조회
	@GetMapping
	public String board(Model model,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "5") int size,
			@ModelAttribute("boardVo") BoardVO boardVO,
			HttpSession session
			) {
		MemberVO login = (MemberVO) session.getAttribute("login");
		boardVO.setApartCode(login.getApartComplexcode());
		Pagination<BoardVO> boardList = boardService.getBoardList(boardVO, page, size);
		List<BoardVO> popularBoardList = boardService.getPopularBoardList(boardVO);
		popularBoardList.stream().forEach(it -> it.switchCreatedAt());
		
		model.addAttribute("boardData", boardList);
		model.addAttribute("popularBoardList", popularBoardList);
		model.addAttribute("boardMasterId", null);
		
		return "board/board";
	}
	
	// 게시글 리스트 조회
	@GetMapping("/{boardMasterId}")
	public String board(@PathVariable int boardMasterId,
			Model model,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "5") int size,
			BoardVO boardVO,
			HttpSession session) {
		boardVO.setBoardMasterId(boardMasterId);
		
		MemberVO login = (MemberVO) session.getAttribute("login");
		boardVO.setApartCode(login.getApartComplexcode());
		
		Pagination<BoardVO> boardList = boardService.getBoardList(boardVO, page, size);
		List<BoardVO> popularBoardList = boardService.getPopularBoardList(boardVO);
		popularBoardList.stream().forEach(it -> it.switchCreatedAt());
		
		model.addAttribute("boardData", boardList);
		model.addAttribute("popularBoardList", popularBoardList);
		model.addAttribute("boardId", boardMasterId);
		model.addAttribute("boardMasterId", boardMasterId);
		
		return "/board/board";
	}
	
	// 게시글 작성 View
	@GetMapping("/write")
	public String boardWrite(@RequestParam(required = false) Integer boardId, Model model) {
		if (boardId != null) {
			model.addAttribute("boardId", boardId);
		}
		
		return "board/boardWrite";
	}
	
	// 게시글 작성
	@PostMapping
	public String postBoard(BoardVO boardVO) {
		MemberVO loginInfo = AuthUtils.getMemberInfo();
		boardVO.setUserId(loginInfo.getMemId());
		boardVO.setBoardMasterId(boardVO.getCategoryId());
		boardService.addBoardPost(boardVO);
		
		Map<String, String> result = new HashMap<String, String>();
		result.put("result", "success");
		
		return "redirect:/board/" + boardVO.getCategoryId();
	}
	
	// 게시글 상세 조회
	@RequestMapping("/detail/{boardId}")
	public String boardDetail(HttpSession session, @PathVariable int boardId, Model model) {
		BoardVO boardDetail = boardService.getBoardDetail(boardId);
		boardDetail.switchCreatedAt();
		List<CommentVO> commentList =boardService.getCommetList(boardId);
		
		model.addAttribute("boardDetail", boardDetail);
		model.addAttribute("commentList", commentList);

		return "board/boardDetail";
	}
	
	@PostMapping("/detail/{boardId}/like")
	public Map<String, String> putBoardLike(@PathVariable int boardId) {
		boolean resultLike = boardService.addBoardLike(boardId);
		
		Map<String, String> result = new HashMap<String, String>();
		
		if(resultLike == true) {
			result.put("result", "success");
		} else {
			result.put("result", "faile");
		}
		
		return result;
	}
	
	@GetMapping("/update/{boardId}")
	public String boardUpdate(@PathVariable int boardId, Model model) {
		BoardVO boardDetail = boardService.getBoardDetail(boardId);
		model.addAttribute("board", boardDetail);

		return "board/boardEdit";
	}
	@RequestMapping("/update")
	public String procBoardUpdate(@RequestBody BoardVO boardVo) {
		boardService.updateBoard(boardVo);

		return "redirect:/board/detail/" + boardVo.getBoardId();
	}
	@RequestMapping("/delete/{boardId}")
	public String procDeleteBoard(@PathVariable int boardId) {
		boardService.deleteBoard(boardId);

		return "redirect:/board";
	}
	
	@PostMapping("/detail/{boardId}/comment")
	public void postBoardComment(@PathVariable int boardId, @RequestBody CommentVO commentVO) {
		Map<String, String> map = new HashMap<String, String>();
		commentVO.setBoardId(boardId);
		boardService.addBoardComment(commentVO);
	}
}