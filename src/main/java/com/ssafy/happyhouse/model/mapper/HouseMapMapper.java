package com.ssafy.happyhouse.model.mapper;

import java.util.HashMap;
import java.util.List;

import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.HouseLikeDto;

public interface HouseMapMapper {
	List<HashMap<String, Object>> getDongInGugun(String gugun) throws Exception;
	List<HouseInfoDto> searchApt(String address) throws Exception;
	void addLike(HouseLikeDto houselike) throws Exception;
	List<HouseDealDto> checkPrice(String apt_name) throws Exception;
}
