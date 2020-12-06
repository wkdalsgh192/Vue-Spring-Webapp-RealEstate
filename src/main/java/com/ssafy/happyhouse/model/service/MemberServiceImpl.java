package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MemberDto login(MemberDto member) throws SQLException {
		return sqlSession.getMapper(MemberMapper.class).selectLogin(member);
	}
	@Override
	public boolean signup(MemberDto member) throws SQLException {		
		return sqlSession.getMapper(MemberMapper.class).insertsigup(member);
	}
	@Override
	public void update(MemberDto member) throws SQLException {
		sqlSession.getMapper(MemberMapper.class).update(member);		
	}
	@Override
	public void delete(String id) throws SQLException {
		sqlSession.getMapper(MemberMapper.class).delete(id);		
	}
}
