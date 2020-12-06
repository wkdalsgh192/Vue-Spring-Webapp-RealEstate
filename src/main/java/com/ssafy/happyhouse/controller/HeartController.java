package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.HouseLikeDto;
import com.ssafy.happyhouse.model.SearchRankDto;
import com.ssafy.happyhouse.model.service.HeartService;

@CrossOrigin(origins = {"*"}, maxAge = 6000)
@RestController
@RequestMapping("/heart")
public class HeartController {
	@Autowired
	private HeartService heartService;
	
	@RequestMapping(value = "/list/{id}", method = RequestMethod.GET)
	public List<HouseLikeDto> list(@PathVariable("id") String id) throws ServletException, IOException {
		try {
			List<HouseLikeDto> list = heartService.list(id);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	@RequestMapping(value = "delete/{no}", method = RequestMethod.DELETE)
	   public String delete(@PathVariable("no") int no) throws ServletException, IOException{
	      String msg = "fail"; 
	      try {
	         heartService.delete(no);
	         msg = "success";
	      }catch(Exception e) {
	         e.printStackTrace();
	         msg="fail";
	      }
	      return msg;
	   }
	@RequestMapping(value = "search", method = RequestMethod.GET)
	public List<SearchRankDto> search() throws ServletException, IOException{
		try {
			List<SearchRankDto> list = heartService.search();
			return list;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
