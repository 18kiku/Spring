package com.kiku.springmall.controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.PageDTO;
import com.kiku.springmall.service.ProductDTO;
import com.kiku.springmall.service.ProductService;

@Controller
@SessionAttributes
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@GetMapping(value="/productInsert.do")
	public String insertProduct() {
		System.out.println("=> ProductController insertProduct()");
		return "management/product/productInsert";
	}
	@PostMapping(value="/productInsert.do")
	public String insertProduct(ProductDTO dto) {
		System.out.println("=> ProductController insertProduct(ProductDTO dto)");
		productService.insertProduct(dto);
		return "redirect:productList.do";
	}
	
	@RequestMapping(value="/productUpdate.do")
	public String updateProduct(@ModelAttribute("product")ProductDTO dto) {
		System.out.println("=> ProductController updateProduct()");
		productService.updateProduct(dto);
		return "management/product/productDetail";
	}
	
	@RequestMapping(value="/productDelete.do")
	public String deleteProduct(ProductDTO dto) {
		System.out.println("=> ProductController deleteProduct()");
		productService.deleteProduct(dto);
		return "redirect:productList.do";
	}
	
	@RequestMapping(value="/productDetail.do")
	public String getProduct(ProductDTO dto, Model model, HttpSession session) {
		System.out.println("=> ProductController getProduct");
		model.addAttribute("product", productService.getProduct(dto));
		return "management/product/productDetail";
	}
	
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap(){
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("상품명", "PRODUCT_NAME");
		conditionMap.put("카테고리", "PRODUCT_CATEGORY");
		return conditionMap;
	}
	
	@RequestMapping(value="/productList.do")
	public String getProductList(ProductDTO dto, Model model){
		System.out.println("=> ProductController getProductList");
		
		if(dto.getSearchCondition() == null) dto.setSearchCondition("PRODUCT_NAME");
		if(dto.getSearchKeyword() == null) dto.setSearchKeyword("");
		
		int totalCount = productService.getProductCount(dto);
		System.out.println(totalCount);
		model.addAttribute("productList", productService.getProductList(dto));
		return "management/product/productList";
	}
}
