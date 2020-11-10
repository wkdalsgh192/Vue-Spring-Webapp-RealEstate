package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;

import com.ssafy.happyhouse.model.MemberDto;

public interface MemberMapper {
	MemberDto selectLogin(MemberDto member) throws SQLException;
	boolean insertsigup(MemberDto member) throws SQLException;
	void update(MemberDto member) throws SQLException;
	void delete(String id) throws SQLException;
}
