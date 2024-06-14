package com.ecoplanner.my.member.vo;


public class MailVO {
	
	private String title;
	private String content;
	private String email;
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "MailVO [title=" + title + ", content=" + content + ", email=" + email + "]";
	}
	
	
}
