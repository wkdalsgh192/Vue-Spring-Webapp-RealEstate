package com.ssafy.happyhouse.controller;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.GugunDto;
import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoDto;
import com.ssafy.happyhouse.model.service.HouseMapService;
@RestController
@RequestMapping("/map")
public class HouseMapController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Autowired
	private HouseMapService houseMapService; 
	
	@GetMapping(value= "/address", headers= {"Content-type=application/json"})
	public List<SidoDto> searchSido() throws Exception {
		return houseMapService.getSido();
	}
	
	@GetMapping(value="/address/sido/{sido}", headers= {"Content-type=application/json"})
	public List<GugunDto> searchGugun(@PathVariable("sido") String sido) throws Exception {
		return houseMapService.getGugunInSido(sido);
	}
	
	@GetMapping(value="/address/gugun/{gugun}", headers= {"Content-type=application/json"})
	public List<HashMap<String, Object>> searchDong(@PathVariable("gugun") String gugun) throws Exception {
		return houseMapService.getDongInGugun(gugun);
	}
	
	@GetMapping(value="/house/deal/{dongcode}", headers= {"Content-type=application/json"})
	public List<HouseDealDto> searchDongName(@PathVariable("dongcode") String dongcode) throws Exception {
		return houseMapService.getDealInDong(dongcode);
	}
	
//	@GetMapping(value="/house/info/{dongcode}", headers= {"Content-type=application/json"})
//	public List<HouseInfoDto> searchApt(@PathVariable("dongcode") String dongcode) throws Exception {
//		return houseMapService.getAptInDong(dongcode);
//	}
	
	@GetMapping(value="/house/info/{address}", headers= {"Content-type=application/json"})
	public List<HouseInfoDto> searchApt(@PathVariable("address") String address) throws Exception {
		System.out.println(address);
		return houseMapService.searchApt('%'+address+'%');
	}
	
//	@GetMapping(value="/house/deal", headers={"Content-type=application/json"})
//	public List<HouseDealDto> searchDeal(HouseDealDto dealDto) throws Exception {
//		String code = dealDto.getCode();
//		String aptName = dealDto.getAptName();
//		return houseMapService.getDealInDong(code, aptName);
//	}
}