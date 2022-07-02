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

import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.OrderDTO;
import com.kiku.springmall.service.OrderService;
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
		System.out.println("=> OrderController orderInsert");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		List<OrderDTO> orderList = new ArrayList<OrderDTO>();
		ProductDTO product = new ProductDTO();
		
		for(OrderDTO order : dto.getOrderList()) {
			product.setProduct_id(order.getProduct_id());
			order.setProduct_image(productService.getProduct(product).getProduct_image());
			order.setProduct_name(productService.getProduct(product).getProduct_name());
			order.setProduct_price(productService.getProduct(product).getProduct_price());
			order.setDiscount_rate(productService.getProduct(product).getDiscount_rate());
			System.out.println(order);
			orderList.add(order);
		}
		model.addAttribute("orderList", orderList);
		model.addAttribute("member", member);
		
		return "order.check";
	}
	
	@RequestMapping("/orderDetail.do")
	public String orderDetail(OrderDTO dto, Model model, HttpSession session) {
		System.out.println("=> OrderController orderDetail");
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		List<OrderDTO> orderList = null;
		for(OrderDTO order : dto.getOrderList()) {
			
		}
		model.addAttribute("orderList", orderService.getOrderList(dto));
		model.addAttribute("member", member);
		System.out.println(dto);
		return "";
	}
	
}
