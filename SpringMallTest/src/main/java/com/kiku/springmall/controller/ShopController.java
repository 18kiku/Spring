package com.kiku.springmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.ProductDTO;
import com.kiku.springmall.service.ProductService;

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
	public String shopList(ProductDTO dto, Model model) {
		int product_category = Integer.parseInt(productService.getProductList(dto, "category").get(0).getProduct_category());
		String product_categoryName = " ";
		
		switch(product_category){
		case 111: product_categoryName = "여자 물실크"; break;
		case 112: product_categoryName = "여자 본견모시"; break;
		case 121: product_categoryName = "남자 물실크"; break;
		case 122: product_categoryName = "남자 본견모시"; break;
		case 131: product_categoryName = "배자/쾌자"; break;
		case 211: product_categoryName = "민소매 여성 저고리"; break;
		case 212: product_categoryName = "반팔 여성 저고리"; break;
		case 213: product_categoryName = "긴팔 여성 저고리"; break;
		case 221: product_categoryName = "짧은 치마"; break;
		case 222: product_categoryName = "긴 치마"; break;
		case 223: product_categoryName = "겨울용 치마"; break;
		case 231: product_categoryName = "여성 원피스"; break;
		case 241: product_categoryName = "반팔 남성 생활한복"; break;
		case 242: product_categoryName = "긴팔 남성 생활한복"; break;
		case 300: product_categoryName = "궁중 한복"; break;
		case 411: product_categoryName = "여아 한복"; break;
		case 421: product_categoryName = "남아 한복"; break;
		case 500: product_categoryName = "장신구"; break;
		case 600: product_categoryName = "공예품"; break;
		default: product_categoryName = "error"; break;
		}
		model.addAttribute("product_category", product_categoryName);
		model.addAttribute("productList", productService.getProductList(dto, "category"));
		return "shop.list";
	}
	@RequestMapping(value="/shopDetail.do")
	public String shopDetail(ProductDTO dto, Model model) {
		ProductDTO product = productService.getProduct(dto);
		int product_category = Integer.parseInt(productService.getProduct(dto).getProduct_category());
		String product_categoryName = "";
		
		
		switch(product_category){
		case 111: product_categoryName = "여자 물실크"; break;
		case 112: product_categoryName = "여자 본견모시"; break;
		case 121: product_categoryName = "남자 물실크"; break;
		case 122: product_categoryName = "남자 본견모시"; break;
		case 131: product_categoryName = "배자/쾌자"; break;
		case 211: product_categoryName = "민소매 여성 저고리"; break;
		case 212: product_categoryName = "반팔 여성 저고리"; break;
		case 213: product_categoryName = "긴팔 여성 저고리"; break;
		case 221: product_categoryName = "짧은 치마"; break;
		case 222: product_categoryName = "긴 치마"; break;
		case 223: product_categoryName = "겨울용 치마"; break;
		case 231: product_categoryName = "여성 원피스"; break;
		case 241: product_categoryName = "반팔 남성 생활한복"; break;
		case 242: product_categoryName = "긴팔 남성 생활한복"; break;
		case 300: product_categoryName = "궁중 한복"; break;
		case 411: product_categoryName = "여아 한복"; break;
		case 421: product_categoryName = "남아 한복"; break;
		case 500: product_categoryName = "장신구"; break;
		case 600: product_categoryName = "공예품"; break;
		}
		product.setProduct_category(product_categoryName);
		model.addAttribute("product", product);
		return "shop.detail";
	}
}
