package com.ecoplanner.my.board.vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import java.util.Date;

import com.ecoplanner.my.commons.utils.ShaUtils;

@Data
public class BoardVO {
	// 게시글 ID
	private long boardId;
	
	private String apartCode;
	
	private String apartName;
	
	// 게시글 마스터 ID
	private Integer boardMasterId = null;
	
	private int categoryId;
	
	private long boardContentId;
	
	// 카테고리 명
	private String categoryName;
	
	// 유저 ID
	private String userId;
	
	// 게시글 제목
	private String title;
	
	// 게시글 내용
	private String content;
	
	// 조회수 카운트
	private int viewCount;
	
	// 좋아요 카운트
	private int boardLikeCount;
	
	// 게시글 생성시간
	private LocalDateTime createdAt;
	
	private String formattedCreatedAt;
	
	// 게시글 업데이트 시간
	private LocalDateTime updatedAt;
	
	private String searchWord;
	private String sort;
	private Integer rowNum;
	private Integer dataId;
	
	
	public void switchUserId() {
		this.userId = ShaUtils.generateHash(this.userId);
	}
	
	public void switchCreatedAt() {
		// yyyyMMdd 형식의 DateTimeFormatter 생성
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        // LocalDateTime을 yyyyMMdd 형식의 문자열로 변환
        String formattedDate = this.createdAt.format(formatter);
		this.formattedCreatedAt = formattedDate;
	}
	
	public void updateLikeCount(int likeCount) {
		this.boardLikeCount = likeCount;
	}
}
