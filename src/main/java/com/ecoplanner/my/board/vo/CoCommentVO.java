package com.ecoplanner.my.board.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class CoCommentVO {
	private long commentId;
	private long parentCommentId;
	private String content;
	private String userId;
	private String createdAt;
}
