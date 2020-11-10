package com.ssafy.happyhouse.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.GugunDto;
import com.ssafy.happyhouse.model.HouseDealDto;
import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoDto;
import com.ssafy.happyhouse.model.mapper.HouseMapMapper;

@Service
public class HouseMapServiceImpl implements HouseMapService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<SidoDto> getSido() throws Exception {
		List<SidoDto> list = sqlSession.getMapper(HouseMapMapper.class).getSido();
		System.out.println(list.size());
		System.out.println(list.get(0).getSidoCode());
		System.out.println("*************************");
		return list;
	}

	@Override
	public List<GugunDto> getGugunInSido(String sido) throws Exception {
		List<GugunDto> list = sqlSession.getMapper(HouseMapMapper.class).getGugunInSido(sido);
		System.out.println("*************************");
		System.out.println(sido);
		System.out.println(sqlSession.getMapper(HouseMapMapper.class).getGugunInSido(sido));
		System.out.println(list.size());
		System.out.println(list.get(0));
		System.out.println("*************************");
		return list;
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dong) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getAptInDong(dong);
	}

	@Override
	public List<HouseDealDto> getDealInDong(int code, String aptName) throws Exception {
		Map<String,Object> map = new HashMap<>();
        map.put("code", code);
        map.put("AptName", aptName);
		return sqlSession.getMapper(HouseMapMapper.class).getDealInDong(map);
	}

}
