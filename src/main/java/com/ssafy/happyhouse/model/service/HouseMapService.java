package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.GugunDto;
import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoDto;

public interface HouseMapService {
	
	List<SidoDto> getSido() throws Exception;
	List<GugunDto> getGugunInSido(String sido) throws Exception;
	List<HouseInfoDto> getDongInGugun(String gugun) throws Exception;
	List<HouseInfoDto> getAptInDong(String dong) throws Exception;
	List<HouseDealDto> getDealInDong(int code, String aptName) throws Exception;
	
}
