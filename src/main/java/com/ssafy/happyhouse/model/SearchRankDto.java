package com.ssafy.happyhouse.model;

public class SearchRankDto {
	int no;
	String dong;
	int cnt;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	@Override
	public String toString() {
		return "SearchRankDto [no=" + no + ", dong=" + dong + ", cnt=" + cnt + "]";
	}
}
