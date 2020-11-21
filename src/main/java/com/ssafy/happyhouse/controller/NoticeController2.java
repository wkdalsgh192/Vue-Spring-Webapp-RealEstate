package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.service.NoticeService;
@CrossOrigin(origins = {"*"}, maxAge = 6000)
@RestController
@RequestMapping("/notice")
public class NoticeController2 {
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public List<NoticeDto> list() throws ServletException, IOException {
		try {
			List<NoticeDto> list = noticeService.noticeList();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	@RequestMapping(value = "/detail/{no}", method = RequestMethod.GET)
	private NoticeDto detail(@PathVariable("no") String no)throws ServletException, IOException {
		try {
			NoticeDto notice = noticeService.detail(no);
			return notice;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	@RequestMapping(value = "/update", method = RequestMethod.PUT)
	private String update(@RequestBody NoticeDto notice)throws ServletException, IOException {
		String msg = "fail";
		try {
			noticeService.update(notice);
			msg = "success";
		}catch(Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		return msg;
	}
	@RequestMapping(value = "/delete/{no}", method = RequestMethod.DELETE)
	private String delete(@PathVariable("no") int no) throws ServletException, IOException {
		String msg = "fail";
		try {
			noticeService.delete(no);
			msg = "success";
		}catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		return msg;
	}
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	private String create(@RequestBody NoticeDto notice) throws ServletException, IOException {
		String msg = "fail";
		try {
			noticeService.create(notice);
			msg = "success";
		}catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		return msg;
	}
}
