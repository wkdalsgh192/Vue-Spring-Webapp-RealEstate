package com.ssafy.happyhouse.model;

public class NoticeDto {
	private String no;
	private String title;
	private String date;
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
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
	@Override
	public String toString() {
		return "NoticeDto [no=" + no + ", title=" + title + ", date=" + date + "]";
	}
}
