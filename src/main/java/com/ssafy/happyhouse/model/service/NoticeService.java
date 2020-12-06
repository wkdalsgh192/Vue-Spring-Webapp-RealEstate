package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.NoticeDto;

public interface NoticeService {
	public List<NoticeDto> noticeList() throws SQLException;
	public NoticeDto detail(String no) throws SQLException;
	void update(NoticeDto notice) throws SQLException;
	void delete(int no) throws SQLException;
	void create(NoticeDto notice) throws SQLException;
}
