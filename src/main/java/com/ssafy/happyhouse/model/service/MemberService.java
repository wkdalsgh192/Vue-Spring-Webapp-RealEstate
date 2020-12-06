package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;

import com.ssafy.happyhouse.model.MemberDto;

public interface MemberService {
	MemberDto login(MemberDto member) throws SQLException;
	boolean signup(MemberDto member) throws SQLException;
	void update(MemberDto member) throws SQLException;
	void delete(String id) throws SQLException;
}
