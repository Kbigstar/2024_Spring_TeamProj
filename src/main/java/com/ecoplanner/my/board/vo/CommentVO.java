package com.ecoplanner.my.board.vo;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CommentVO {
    private int boardId;
    private long commentId;
    private Long parentCommentId = null;
    private String content;
    private String userId;
    private String createdAt;
    private List<CoCommentVO> cocomentList;
}