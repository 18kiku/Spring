package com.mall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mall.service.MemberDTO;
import com.mall.service.MemberService;

@Controller
@SessionAttributes
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	
	@GetMapping(value="/memberLogin.do")
	public String login() {
		System.out.println("=> MemberController - login(get)");
		return "login";
	}
	// int로 고치고 반환값에따라 아이디가 존재하지 않습니다, 등 경고창 띄우기
	@PostMapping(value="/memberLogin.do")
	public String login(MemberDTO dto, HttpSession session) {
		System.out.println("=> MemberController - login(post)");
		
		MemberDTO member = memberService.login(dto);
		if(member != null) {
			session.setAttribute("member", member);
			return "shop.main";// 원래 있던 페이지로 돌아가도록 수정하기
		} else return "login";
	}
	@RequestMapping(value="/memberLogout.do")
	public String logout(HttpSession session){
		System.out.println("=> MemberController - 로그아웃 처리");
		session.invalidate();
		return "shop.main";
	}
	
	// ######################
	// 회원가입, 수정, 삭제, 상세확인
		@GetMapping("/memberJoin.do")
		public String insertMember() {
			System.out.println("=> MemberController - insertMember");
			return "memberJoin";
		}
		@RequestMapping("/memberCheck.do")
		@ResponseBody
		public int checkMember(@RequestParam("id") String id){
			int cnt = 0;
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			if(memberService.getMember(dto) == null) {
				cnt = 0;
			} else if(memberService.getMember(dto).getId() != null) {
				cnt = 1;
			}
			return cnt;
		}
		@PostMapping("/memberJoin.do")
		public String insertMember(MemberDTO dto) {
			System.out.println("=> MemberController - 회원등록 처리(DB)");
			memberService.insertMember(dto);
			return "login";
		}
		@RequestMapping("/memberUpdate.do")
		public String updateMember(@ModelAttribute("member") MemberDTO dto, HttpSession session){
			System.out.println("=> MemberController - 회원정보 업데이트"); 
			memberService.updateMember(dto); // 업데이트가 완료됐다고 띄우기
			return "memberInfo";
		}
		@RequestMapping("/memberDelete.do")
		public String deleteMember(MemberDTO dto) {
			System.out.println("=> MemberController - 회원탈퇴");
			memberService.deleteMember(dto);
			return "login";
		}
		@RequestMapping("/memberInfo.do")
		public String getMember(MemberDTO dto, Model model, HttpSession session) {
			System.out.println("=> MemberController - 회원정보확인");
			MemberDTO member = (MemberDTO)session.getAttribute("member");
			if(member != null) {
				model.addAttribute("member", memberService.getMember(dto));
			} else return "login";
			
			return "memberInfo";
		}
	
}
