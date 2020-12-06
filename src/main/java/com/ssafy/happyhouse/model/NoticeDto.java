package com.ssafy.happyhouse.model;

public class NoticeDto {
	private int no;
	private String title;
	private String date;
	private String content;
	private String member_id;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	@Override
	public String toString() {
		return "NoticeDto [no=" + no + ", title=" + title + ", date=" + date + ", content=" + content + ", member_id="
				+ member_id + "]";
	}
	
}
