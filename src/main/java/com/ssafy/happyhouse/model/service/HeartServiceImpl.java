package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseLikeDto;
import com.ssafy.happyhouse.model.SearchRankDto;
import com.ssafy.happyhouse.model.mapper.HeartMapper;
@Service
public class HeartServiceImpl implements HeartService{
	@Autowired
	private SqlSession sqlSession;
	@Override
	public List<HouseLikeDto> list(String id) throws SQLException {
		return sqlSession.getMapper(HeartMapper.class).list(id);
	}
	@Override
	   public void delete(int no) throws SQLException{
	      sqlSession.getMapper(HeartMapper.class).delete(no);
	   }
	@Override
	public List<SearchRankDto> search() throws SQLException {
		return sqlSession.getMapper(HeartMapper.class).search();
	}

}
