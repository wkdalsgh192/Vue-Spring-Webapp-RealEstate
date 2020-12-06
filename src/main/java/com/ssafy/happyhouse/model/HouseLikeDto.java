package com.ssafy.happyhouse.model;

import org.apache.ibatis.type.Alias;

@Alias("houselike")
public class HouseLikeDto {
	private int no;
	private String id;
	private String apt_name;
	private String price;
	private String area;
	private String last_update;
	public String getId() {
		return id;
	}
	
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getApt_name() {
		return apt_name;
	}
	public void setApt_name(String apt_name) {
		this.apt_name = apt_name;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getLast_update() {
		return last_update;
	}
	public void setLast_update(String last_update) {
		this.last_update = last_update;
	}
	@Override
	public String toString() {
		return "HouseLikeDto [id=" + id + ", apt_name=" + apt_name + ", price=" + price + ", area=" + area
				+ ", last_update=" + last_update + "]";
	}
}
