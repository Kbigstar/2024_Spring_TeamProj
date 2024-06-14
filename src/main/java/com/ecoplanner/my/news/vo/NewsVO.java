package com.ecoplanner.my.news.vo;

import lombok.Data;

@Data
public class NewsVO {
	 private int newsNo;
	 private String newsTitle;
	 private String newsLink;
	 private int newsViews;
	 private String newsDt;
	 
	 private String memId;
	 private int scrapNumber;
	 private String createDt;
	 private String scrapYn;
}
