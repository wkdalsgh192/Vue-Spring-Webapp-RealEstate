package com.ssafy.happyhouse.model.service;

import java.util.HashMap;
import java.util.List;

import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.HouseLikeDto;

public interface HouseMapService {
	
	List<HashMap<String, Object>> getDongInGugun(String gugun) throws Exception;
	List<HouseInfoDto> searchApt(String address) throws Exception;
	List<HouseDealDto> checkPrice(String apt_name) throws Exception;
	void addLike(HouseLikeDto houselike) throws Exception;
}
