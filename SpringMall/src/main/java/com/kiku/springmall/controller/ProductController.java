package com.kiku.springmall.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.ProductDTO;
import com.kiku.springmall.service.ProductService;
import com.kiku.springmall.util.Util;

@Controller
@SessionAttributes
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	private static final String UPLOAD_PATH = "C:\\spring_images\\mall\\";
	
	@GetMapping(value="/productInsert.do")
	public String insertProduct() {
		System.out.println("=> ProductController insertProduct()");
		return "management/product/productInsert";
	}
	@PostMapping(value="/productInsert.do")
	public String insertProduct(ProductDTO dto, MultipartHttpServletRequest request) {
		System.out.println("=> ProductController insertProduct(ProductDTO dto)");
		System.out.println("product_images -> " + request.getFiles("images").getClass().getName());
		System.out.println("product_details -> " + request.getFiles("images_detail").getClass().getName());
		
		if(request.getFiles("product_images")!= null) {
			File fileCheck = new File(UPLOAD_PATH);
			if(!fileCheck.exists()) fileCheck.mkdirs();
			
			List<MultipartFile> product_images = request.getFiles("product_images");
			dto.setProduct_image(String.join(",", Util.saveFile(product_images)));			
		} else {
			dto.setProduct_image(UPLOAD_PATH + "no-image.jpg");
		}
		if(request.getFiles("product_details") != null) {
			File fileCheck = new File(UPLOAD_PATH);
			if(!fileCheck.exists()) fileCheck.mkdirs();
			
			List<MultipartFile> product_details = request.getFiles("product_details");
			dto.setProduct_detail(String.join(",", Util.saveFile(product_details)));
		} else {
			dto.setProduct_detail(UPLOAD_PATH + "no-detail.jpg");
		}
		

		System.out.println("insert할것 : " + dto);
		productService.insertProduct(dto);
		
		return "redirect:productList.do";
	}
	
	
	
	@RequestMapping(value="/productUpdate.do")
	public String updateProduct(@ModelAttribute("product")ProductDTO dto, MultipartHttpServletRequest request) {
		System.out.println("=> ProductController updateProduct()");
		if(dto.getProduct_image()!= null) {
			File fileCheck = new File(UPLOAD_PATH);
			if(!fileCheck.exists()) fileCheck.mkdirs();
			
			List<MultipartFile> product_images = request.getFiles("product_images");
			dto.setProduct_image(String.join(",", Util.saveFile(product_images)));
		} else {
			dto.setProduct_image(request.getParameter("no_image"));
		}
		if(dto.getProduct_detail()!= null) {
			File fileCheck = new File(UPLOAD_PATH);
			if(!fileCheck.exists()) fileCheck.mkdirs();
			
			List<MultipartFile> product_details = request.getFiles("product_details");
			dto.setProduct_detail(String.join(",", Util.saveFile(product_details)));
		} else {
			dto.setProduct_detail(request.getParameter("no_detail"));
		}
		System.out.println("update할것" + dto);
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
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		System.out.println("member => " + member);
		
		model.addAttribute("product", productService.getProduct(dto));
		System.out.println(productService.getProduct(dto));
		return "management/product/productDetail";
	}
	
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap(){
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("Name", "PRODUCT_NAME");
		conditionMap.put("Category", "PRODUCT_CATEGORY");
		return conditionMap;
	}
	
	@RequestMapping(value="/productList.do")
	public String getProductList(ProductDTO dto, Model model){
		System.out.println("=> ProductController getProductList");
		
		if(dto.getSearchCondition() == null) dto.setSearchCondition("PRODUCT_NAME");
		if(dto.getSearchKeyword() == null) dto.setSearchKeyword("");
		
		int totalCount = productService.getProductCount(dto);
		
		model.addAttribute("productList", productService.getProductList(dto));
		return "management/product/productList";
	}
}
