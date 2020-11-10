package com.ssafy.happyhouse.controller;


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
		System.out.println(sido);
		return houseMapService.getGugunInSido(sido);
	}
	
	@GetMapping(value="/address/gugun/{gugun}", headers= {"Content-type=application/json"})
	public List<HouseInfoDto> searchDong(@PathVariable("gugun") String gugun) throws Exception {
		return houseMapService.getDongInGugun(gugun);
	}
	
	@GetMapping(value="/house/info/{dong}", headers= {"Content-type=application/json"})
	public List<HouseInfoDto> searchApt(@PathVariable("dong") String dong) throws Exception {
		return houseMapService.getAptInDong(dong);
	}
	
//	@GetMapping(value="/house/deal", headers={"Content-type=application/json"})
//	public List<HouseDealDto> searchDeal(HouseDealDto dealDto) throws Exception {
//		String code = dealDto.getCode();
//		String aptName = dealDto.getAptName();
//		return houseMapService.getDealInDong(code, aptName);
//	}
}