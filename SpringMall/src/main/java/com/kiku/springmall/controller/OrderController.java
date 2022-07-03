package com.kiku.springmall.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.OrderDTO;
import com.kiku.springmall.service.OrderService;
import com.kiku.springmall.service.PageDTO;
import com.kiku.springmall.service.ProductDTO;
import com.kiku.springmall.service.ProductService;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ProductService productService;
	
	@GetMapping("/orderCheck.do")
	public String checkOrder(OrderDTO dto, Model model, HttpSession session){
		System.out.println("=> OrderController orderCheck");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member == null) {
			return "redirect:memberLogin.do";
		}
		List<OrderDTO> orderList = new ArrayList<OrderDTO>();
		ProductDTO product = null;
		for(OrderDTO order : dto.getOrderList()) {
			product = new ProductDTO();
			product.setProduct_id(order.getProduct_id());
			order.setProduct_image(productService.getProduct(product).getProduct_image());
			order.setProduct_name(productService.getProduct(product).getProduct_name());
			order.setProduct_price(productService.getProduct(product).getProduct_price());
			order.setDiscount_rate(productService.getProduct(product).getDiscount_rate());
			System.out.println(order);
			orderList.add(order);
		}
		model.addAttribute("orderList", orderList);
		model.addAttribute("member", member); // 이게 제대로 가는게 맞나?
		System.out.println(member);
		
		return "order.check";
	}
	// 트랜잭션처리 결제가실패하면 롤백
	@RequestMapping("/orderInsert.do")
	public String insertOrder(OrderDTO dto, Model model, HttpSession session) {
		System.out.println("=> OrderController insertOrder");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member == null) {
			return "redirect:memberLogin.do";
		}
		
		for(OrderDTO order : dto.getOrderList()) {
			orderService.insertOrder(order);
		}
		List<OrderDTO> orderList = orderService.getOrder(dto);
		model.addAttribute("orderList", orderList);
		model.addAttribute("member", member);
		return "order.list";
	}
	
	@RequestMapping("/orderList.do")
	public String orderList(OrderDTO dto, BlockDTO block, Model model, HttpSession session) {
		System.out.println("=> OrderController orderList");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member == null) {
			return "redirect:memberLogin.do";
		}
		dto.setOrderer_id(member.getId());
		int totalCount = orderService.getOrderCount(dto);
		System.out.println(totalCount);
		model.addAttribute("pageDTO", new PageDTO(block, totalCount));
		model.addAttribute("orderList", orderService.getOrderList(dto, block));
		return "order.list";
	}
	
}
