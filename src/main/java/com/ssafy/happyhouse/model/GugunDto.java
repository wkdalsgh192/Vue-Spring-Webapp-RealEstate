package com.ssafy.happyhouse.model;

import org.apache.ibatis.type.Alias;

@Alias("gugun")
public class GugunDto {

	private String gugunCode;
	private String gugunName;
	
	public String getGugunCode() {
		return gugunCode;
	}
	protected void setGugunCode(String gugunCode) {
		this.gugunCode = gugunCode;
	}
	public String getGugunName() {
		return gugunName;
	}
	protected void setGugunName(String gugunName) {
		this.gugunName = gugunName;
	}
	public GugunDto(String gugunCode, String gugunName) {
		super();
		this.gugunCode = gugunCode;
		this.gugunName = gugunName;
	}
}
