package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.JwtService;
import com.ssafy.happyhouse.model.service.MemberService;
@CrossOrigin(origins = {"*"}, maxAge = 6000)
@RestController
@RequestMapping("/member")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Autowired
	private MemberService memberService;
	@Autowired
	private JwtService jwtService;

//	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	private String login(@RequestBody MemberDto member) throws ServletException, IOException {
//		System.out.println(member.toString());
//		String msg = "fail";
//		try {
//			member = memberService.login(member);
//			msg = "success";
//		} catch (SQLException e) {
//			e.printStackTrace();
//			msg = "fail";
//		}
//		return msg;
//	}
	public static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	private ResponseEntity<Map<String, Object>> login(@RequestBody MemberDto member) throws ServletException, IOException {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		try {
			MemberDto loginUser = memberService.login(member);
			if(loginUser != null) {
				String token = jwtService.create(loginUser);
				logger.trace("로그인 토근정보: {}", token);
				resultMap.put("auth-token", token);
				resultMap.put("id", loginUser.getId());
				status = HttpStatus.ACCEPTED;
			}else {
				resultMap.put("message", "로그인 실패");
				status = HttpStatus.ACCEPTED;
			}
		}catch(Exception e) {
			logger.error("로그인 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
//	@RequestMapping(value = "/logout", method = RequestMethod.GET)
//	private String logout(HttpSession session) throws IOException, ServletException {
//		session.invalidate();
//		return "index";
//	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	private String signup(@RequestBody MemberDto member) throws ServletException, IOException{
		String msg = "fail";
		try {
			memberService.signup(member);
			msg = "success";
			
		}catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		return msg;
	}
	@RequestMapping(value = "/info", method = RequestMethod.GET)
	private ResponseEntity<Map<String, Object>> getInfo(HttpServletRequest req){
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		System.out.print(">>>>> " + jwtService.get(req.getHeader("auth-token")));
		try {
			resultMap.putAll(jwtService.get(req.getHeader("auth-token")));
			status = HttpStatus.ACCEPTED;
		}catch(RuntimeException e) {
			logger.error("정보조회 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.PUT)
	private String update(@RequestBody MemberDto member) throws ServletException, IOException {
		String msg = "fail";
		try {
			memberService.update(member);
			msg = "success";
		}catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		return msg;
	}
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE)
	private String delete(@PathVariable("id") String id) throws ServletException, IOException {
		String msg = "fail";
		try {
			memberService.delete(id);	
			msg = "success";
		}catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		return msg;
	}
//	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
//	private String delete(@PathVariable("id") String id, Model model, HttpSession session, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println(id + "삭제");
//		try {
//			memberService.delete(id);	
//			session.setAttribute("msg", "회원탈퇴 성공");
//		}catch (Exception e) {
//			e.printStackTrace();
//			return "index";
//		}
//		session.invalidate();
//		return "index";
//	}
////	@RequestMapping(value = "/mypage")
////	private String mypage(Model model) throws ServletException, IOException{
////		return "/project/settings";
////	}
////	@RequestMapping(value = "/dong")
////	private String dong(Model model) throws ServletException, IOException{
////		return "/project/dongDeal";
////	}
////	@RequestMapping(value = "/apt")
////	private String apt(Model model) throws ServletException, IOException{
////		return "/project/aptDeal";
//	}
//	@RequestMapping(value = "/board")
//	private String board(Model model) throws ServletException, IOException{
//		return "/project/board";
//	}
}