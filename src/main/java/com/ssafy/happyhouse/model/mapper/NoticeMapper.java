package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.NoticeDto;

public interface NoticeMapper {
	public List<NoticeDto> noticeList() throws SQLException;
}
