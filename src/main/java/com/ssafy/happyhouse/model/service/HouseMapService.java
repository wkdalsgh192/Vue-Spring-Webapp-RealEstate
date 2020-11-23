package com.ssafy.happyhouse.model.service;

import java.util.HashMap;
import java.util.List;

import com.ssafy.happyhouse.model.GugunDto;
import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.HouseLikeDto;
import com.ssafy.happyhouse.model.SidoDto;

public interface HouseMapService {
	
	List<SidoDto> getSido() throws Exception;
	List<GugunDto> getGugunInSido(String sido) throws Exception;
	List<HashMap<String, Object>> getDongInGugun(String gugun) throws Exception;
	List<HouseInfoDto> getAptInDong(String dongcode) throws Exception;
	List<HouseDealDto> getDealInDong(String dongcode) throws Exception;
	List<HouseInfoDto> searchApt(String address) throws Exception;
	void addLike(HouseLikeDto houselike) throws Exception;
}
