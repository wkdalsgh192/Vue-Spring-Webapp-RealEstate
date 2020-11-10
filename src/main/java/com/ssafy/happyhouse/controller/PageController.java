package com.ssafy.happyhouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/page")
public class PageController {
	
	@RequestMapping(value="/search/{param}", method=RequestMethod.GET)
	public String toAptSearchPage(@PathVariable("param") String param) {
		if ("dong".equals(param)) return "/project/dongDeal";
		else return "/project/aptDeal";
	}
	
	@RequestMapping(value="/announce", method=RequestMethod.GET)
	public String toAnnouncementPage() {
		return "project/board";
	}
	
	@RequestMapping(value="/settings", method=RequestMethod.GET)
	public String toSettingsPage() {
		return "project/settings";
	}

}
