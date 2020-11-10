package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.NoticeDto;

public interface NoticeService {
	public List<NoticeDto> noticeList() throws Exception;
}
