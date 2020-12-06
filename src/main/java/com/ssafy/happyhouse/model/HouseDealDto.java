package com.ssafy.happyhouse.model;

import org.apache.ibatis.type.Alias;

@Alias("housedeal")
public class HouseDealDto {
	String no;
	String dong;
	String apt_name;
	String deal_amount;
	String deal_date;
	
	@Override
	public String toString() {
		return "HouseDealDto [no=" + no + ", dong=" + dong + ", apt_name=" + apt_name + ", deal_amount=" + deal_amount
				+ ", deal_date=" + deal_date + "]";
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getApt_name() {
		return apt_name;
	}
	public void setApt_name(String apt_name) {
		this.apt_name = apt_name;
	}
	public String getDeal_amount() {
		return deal_amount;
	}
	public void setDeal_amount(String deal_amount) {
		this.deal_amount = deal_amount;
	}
	public String getDeal_date() {
		return deal_date;
	}
	public void setDeal_date(String deal_date) {
		this.deal_date = deal_date;
	}
	
}
