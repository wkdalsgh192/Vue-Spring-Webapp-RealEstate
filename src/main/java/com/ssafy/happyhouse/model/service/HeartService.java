package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.HouseLikeDto;
import com.ssafy.happyhouse.model.SearchRankDto;

public interface HeartService {
	public List<HouseLikeDto> list(String id) throws SQLException;
	void delete(int no) throws SQLException;
	public List<SearchRankDto> search() throws SQLException;
}
