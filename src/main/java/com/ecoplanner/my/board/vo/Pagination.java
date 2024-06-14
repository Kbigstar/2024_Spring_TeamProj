package com.ecoplanner.my.board.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Pagination<T> {
	private int totalPage;
    private int curPage;
    private int pageSize;
    private int startPage;
    private int endPage;
    private List<T> contents;
}
