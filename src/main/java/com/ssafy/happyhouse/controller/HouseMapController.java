package com.ssafy.happyhouse.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.GugunDto;
import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.HouseLikeDto;
import com.ssafy.happyhouse.model.SidoDto;
import com.ssafy.happyhouse.model.service.HouseMapService;
@RestController
@RequestMapping("/map")
public class HouseMapController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(HouseMapController.class);

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
	
	@PostMapping(value="/house/like", headers= {"Content-type=application/json"})
	public ResponseEntity<Map<String, Object>> addLike(@RequestBody HouseLikeDto like) throws Exception {
		System.out.println(like.toString());
		Map<String, Object> resultMap = new HashMap<>();
		String msg = "이미 추가된 매물입니다!";
		HttpStatus status = null;
		
		try {
			houseMapService.addLike(like);
			msg="관심 목록에 추가되었습니다!";
			resultMap.put("message", msg);
			status = HttpStatus.OK;
		} catch (Exception e) {
			logger.error("관심목록 추가 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}

}