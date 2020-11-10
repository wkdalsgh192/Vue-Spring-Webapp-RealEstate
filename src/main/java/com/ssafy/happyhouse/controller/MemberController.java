package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.MemberService;

@Controller
@RequestMapping("/member.do")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	private String login(MemberDto member, Model model, HttpSession session, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(member.toString());
		try {
			member = memberService.login(member);
			if(member != null) {//로그인 성공시 세션에 기록
				session.setAttribute("member", member);
			}else {//로그인 실패시 메세지를 화면에 전달
				model.addAttribute("msg", "아이디 비밀번호를 다시 확인해주세요.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			model.addAttribute("msg", "로그인 중 문제가 발생했습니다.");
			return "index";
		}
		return "index";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	private String logout(HttpSession session) throws IOException, ServletException {
		session.invalidate();
		return "index";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	private String signup(MemberDto member, Model model, HttpSession session, HttpServletResponse response) throws ServletException, IOException{
		System.out.println(member.toString());
		try {
			if(memberService.signup(member)) {
				session.setAttribute("msg", "회원가입 성공");
			}else {
				model.addAttribute("msg", "회원가입 실패");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "회원가입 중 문제가 발생했습니다.");
			return "index";
		}
		return "index";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	private String update(MemberDto member, Model model, HttpSession session, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(member.toString());
		try {
			memberService.update(member);
			session.setAttribute("msg", "회원 정보 수정 실패");
		}catch (Exception e) {
			e.printStackTrace();
			return "index";
		}
		session.invalidate();
		return "index";
	}
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	private String delete(@PathVariable("id") String id, Model model, HttpSession session, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(id + "삭제");
		try {
			memberService.delete(id);	
			session.setAttribute("msg", "회원탈퇴 성공");
		}catch (Exception e) {
			e.printStackTrace();
			return "index";
		}
		session.invalidate();
		return "index";
	}
	@RequestMapping(value = "/mypage")
	private String mypage(Model model) throws ServletException, IOException{
		return "/project/settings";
	}
	@RequestMapping(value = "/dong")
	private String dong(Model model) throws ServletException, IOException{
		return "/project/dongDeal";
	}
	@RequestMapping(value = "/apt")
	private String apt(Model model) throws ServletException, IOException{
		return "/project/aptDeal";
	}
	@RequestMapping(value = "/board")
	private String board(Model model) throws ServletException, IOException{
		return "/project/board";
	}
}