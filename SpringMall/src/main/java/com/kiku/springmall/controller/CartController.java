package com.kiku.springmall.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kiku.springmall.service.CartDTO;
import com.kiku.springmall.service.CartService;
import com.kiku.springmall.service.MemberDTO;

@Controller
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	@RequestMapping(value="/cartList.do")
	public String cartList(CartDTO dto, Model model, HttpSession session) {
		System.out.println("=> CartController - cartList");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member != null) {
			dto.setOrderer_id(member.getId());
			model.addAttribute("cartList", cartService.getCartList(dto));
			return "cart.list";
		}
		return "login";
	}
	
	@RequestMapping(value="/cartInsert.do")
	public String insertCart(CartDTO dto, Model model, HttpSession session, HttpServletRequest request) {
		System.out.println("=> CartController - insertCart");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member != null) {
			if(cartService.checkCart(dto)) {
				cartService.insertCart(dto);
			} else {
				cartService.updateCart(dto);
			}
		} else {
			return "/memberLogin.do";
		}
		
		return "redirect:cartList.do";
	}
	
	@RequestMapping(value="/cartUpdate.do")
	public String updateCart(CartDTO dto) {
		return "";
	}
	
	@RequestMapping(value="/cartDelete.do")
	public String deleteCart(CartDTO dto) {
		return "";
	}
	
	@RequestMapping(value="/cartDeleteList.do")
	public String deleteCartList(CartDTO dto) {
		return "";
	}
}
