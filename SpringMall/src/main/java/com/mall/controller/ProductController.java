package com.mall.controller;

import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mall.service.MemberDTO;
import com.mall.service.ProductDTO;
import com.mall.service.ProductService;
import com.mall.util.Delivery;

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
	
	
	@RequestMapping(value="/productList.do")
	public String getProductList(ProductDTO dto, Model model){
		System.out.println("=> ProductController getProductList");
		model.addAttribute("productList", productService.getProductList(dto, "all"));
		return "management/product/productList";
	}
}
