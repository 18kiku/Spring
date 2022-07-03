package com.kiku.springmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

	@ResponseBody
	@RequestMapping(value="/cartInsert.do")
	public int insertCart(CartDTO dto, Model model, HttpSession session) {
		System.out.println("=> CartController - insertCart");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		System.out.println(dto);
		System.out.println(member);
		int message = 10917;
		if(member != null) {
			System.out.println(cartService.checkCart(dto));
			if(cartService.checkCart(dto) == 0) {
				int result = cartService.insertCart(dto);
				System.out.println("카트가 비어있을때 result = " + result);
				if(result == 0) {
					message = 0;
				} else {
					message = 1;
				}
			} else {
				int result = cartService.updateCart(dto);
				System.out.println("카드에 해당상품이 있을때 result = " + result);
				
				if(result == 0) {
					message = 0;
				} else {
					message = 2;
				}
			}
		}
		return message;
	}

	@ResponseBody
	@RequestMapping(value="/cartUpdate.do")
	public int updateCart(CartDTO dto, HttpSession session) {
		System.out.println("=> CartController - updateCart");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		System.out.println(member);
		System.out.println(dto);
		if(member == null) {
			return 10917;
		}
		return cartService.updateCart(dto);
	}

	@ResponseBody
	@RequestMapping(value="/cartDelete.do")
	public int deleteCart(CartDTO dto, HttpSession session) {
		System.out.println("=> CartController - deleteCart");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member == null) {
			return 10917;
		}
		return cartService.deleteCart(dto);
	}

	@ResponseBody
	@RequestMapping(value="/cartDeleteAll.do")
	public int deleteCartAll(CartDTO dto, HttpSession session) {
		System.out.println("=> CartController - deleteCartList");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member == null) {
			return 10917;
		}
		return cartService.deleteCartAll(dto);
	}
	
	
}
