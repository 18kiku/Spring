package com.kiku.springmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.MemberService;
import com.kiku.springmall.service.PageDTO;
import com.kiku.springmall.service.ProductDTO;
import com.kiku.springmall.service.ProductService;
import com.kiku.springmall.util.Util;

@Controller
@SessionAttributes
public class ShopController {
	
	@Autowired
	private ProductService productService;
	
	
	@RequestMapping(value="/shopMain.do")
	public String shopMain(ProductDTO productDTO, MemberDTO memberDTO, HttpSession session) {
		
		return "shop.main";
	}
	@RequestMapping(value="/shopList.do")
	public String shopList(ProductDTO dto, Model model, BlockDTO block) {
		
		int totalCount = productService.getProductCount(dto);
		model.addAttribute("pageDTO", new PageDTO(block, totalCount));
		model.addAttribute("productList", productService.getProductList(dto, block));
		return "shop.list";
	}
	@RequestMapping(value="/shopDetail.do")
	public String shopDetail(ProductDTO dto, Model model, HttpSession session) {
		model.addAttribute("product", productService.getProduct(dto));
		return "shop.detail";
	}
}
