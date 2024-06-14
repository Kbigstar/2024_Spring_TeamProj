package com.ecoplanner.my.news.vo;

public class NewsSearchVO extends PagingVO {
	
	private String searchWord; /* 검색어 */
	private String sort;       /* 검색조건*/
	private String searchScrap; /* 스크랩검색 */
	private boolean checkbtn; //체크박스 

	public String getSearchScrap() {
		return searchScrap;
	}

	public void setSearchScrap(String searchScrap) {
		this.searchScrap = searchScrap;
	}

	public String getSort() {
		return sort;
	}

	public boolean isCheckbtn() {
		return checkbtn;
	}

	public void setCheckbtn(boolean checkbtn) {
		this.checkbtn = checkbtn;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	@Override
	public String toString() {
		return "NewsSearchVO [searchWord=" + searchWord + ", sort=" + sort + ", searchScrap=" + searchScrap
				+ ", checkbtn=" + checkbtn + "]";
	}

	



}
