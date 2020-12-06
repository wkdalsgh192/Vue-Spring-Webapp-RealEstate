package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.mapper.NoticeMapper;
@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private SqlSession sqlSession;
	@Override
	public List<NoticeDto> noticeList() throws SQLException {
		return sqlSession.getMapper(NoticeMapper.class).noticeList();
	}
	@Override
	public NoticeDto detail(String no) throws SQLException {
		return sqlSession.getMapper(NoticeMapper.class).detail(no);
	}
	@Override
	public void update(NoticeDto notice) throws SQLException {
		sqlSession.getMapper(NoticeMapper.class).update(notice);
	}
	@Override
	public void delete(int no) throws SQLException{
		sqlSession.getMapper(NoticeMapper.class).delete(no);
	}
	@Override
	public void create(NoticeDto notice) throws SQLException {
		sqlSession.getMapper(NoticeMapper.class).create(notice);
	}
}
