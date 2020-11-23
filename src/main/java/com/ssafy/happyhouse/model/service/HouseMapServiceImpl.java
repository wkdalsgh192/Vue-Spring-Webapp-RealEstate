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
import com.ssafy.happyhouse.model.HouseLikeDto;
import com.ssafy.happyhouse.model.SidoDto;
import com.ssafy.happyhouse.model.mapper.HouseMapMapper;

@Service
public class HouseMapServiceImpl implements HouseMapService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<SidoDto> getSido() throws Exception {
		List<SidoDto> list = sqlSession.getMapper(HouseMapMapper.class).getSido();
		return list;
	}

	@Override
	public List<GugunDto> getGugunInSido(String sido) throws Exception {
		List<GugunDto> list = sqlSession.getMapper(HouseMapMapper.class).getGugunInSido(sido);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getDongInGugun(String gugun) throws Exception {
		List<HashMap<String, Object>> list = sqlSession.getMapper(HouseMapMapper.class).getDongInGugun(gugun);
		return list;
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dongcode) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getAptInDong(dongcode);
	}
	
	@Override
	public List<HouseDealDto> getDealInDong(String dongcode) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getDealInDong(dongcode);
	}

	@Override
	public List<HouseInfoDto> searchApt(String address) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).searchApt(address);
	}

	@Override
	public void addLike(HouseLikeDto houselike) throws Exception {
		sqlSession.getMapper(HouseMapMapper.class).addLike(houselike);		
	}
}
