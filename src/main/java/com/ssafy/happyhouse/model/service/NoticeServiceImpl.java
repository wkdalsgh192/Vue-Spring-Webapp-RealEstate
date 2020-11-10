package com.ssafy.happyhouse.model.service;

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
	public List<NoticeDto> noticeList() throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).noticeList();
	}
}
