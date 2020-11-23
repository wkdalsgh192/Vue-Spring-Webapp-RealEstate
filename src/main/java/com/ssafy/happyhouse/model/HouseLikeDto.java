package com.ssafy.happyhouse.model;

import org.apache.ibatis.type.Alias;

@Alias("houselike")
public class HouseLikeDto {
	
	private String id;
	private String aptName;
	private String price;
	private String area;
	private String lastUpdate;
	
	
	@Override
	public String toString() {
		return "HouseLikeDto [id=" + id + ", aptName=" + aptName + ", price=" + price + ", area=" + area
				+ ", lastUpdate=" + lastUpdate + "]";
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAptName() {
		return aptName;
	}
	public void setAptName(String aptName) {
		this.aptName = aptName;
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
	public String getLastUpdate() {
		return lastUpdate;
	}
	public void setLastUpdate(String lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	
}
