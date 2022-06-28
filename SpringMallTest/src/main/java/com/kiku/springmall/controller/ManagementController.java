package com.kiku.springmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kiku.springmall.service.ManagementDTO;
import com.kiku.springmall.service.ManagementService;

@Controller
public class ManagementController {
	
	@Autowired
	private ManagementService managementService;
	
	@GetMapping(value="/managementLogin.do")
	public String login() {
		System.out.println("=> ManagementController - login(get)");
		return "management/managementLogin";
	}
	
	@PostMapping(value="/managementLogin.do")
	public String login(ManagementDTO dto, HttpSession session) {
		System.out.println("=> ManagementController - login(post)");
		ManagementDTO admin = managementService.login(dto);
		if(admin != null) {
			session.setAttribute("admin", admin);
			return "managementMain.do";
		} else return "management/managementLogin";
	}
	
	@RequestMapping(value="/managementLogout.do")
	public String logout(HttpSession session){
		System.out.println("=> ManagementController - 로그아웃 처리");
		session.invalidate();
		return "management/managementLogin";
	}
	
	@RequestMapping(value="/managementMain.do")
	public String managementMain() {
		return "management/managementMain";
	}
}
