package com.kiku.springmall.controller;

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
		dto.setOrderer_id(member.getId());
		model.addAttribute("cartList", cartService.getCartList(dto));
		return "cart.list";
	}
	
	@RequestMapping(value="/cartInsert.do")
	public String insertCart(CartDTO dto, Model model, HttpSession session) {
		System.out.println("=> CartController - insertCart");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member != null) {
			cartService.insertCart(dto);
		} else {
			return "login";
		}
		
		return "redirect:cartList.do";
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
