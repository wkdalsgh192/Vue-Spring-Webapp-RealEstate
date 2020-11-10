package com.ssafy.happyhouse.model;

import org.apache.ibatis.type.Alias;

@Alias("sido")
public class SidoDto {

	private String sidoCode;
	private String sidoName;
	
	public String getSidoCode() {
		return sidoCode;
	}
	public void setSidoCode(String sidoCode) {
		this.sidoCode = sidoCode;
	}
	public String getSidoName() {
		return sidoName;
	}
	public void setSidoName(String sidoName) {
		this.sidoName = sidoName;
	}
	
	public SidoDto(String sidoCode, String sidoName) {
		super();
		this.sidoCode = sidoCode;
		this.sidoName = sidoName;
	}
	
}
