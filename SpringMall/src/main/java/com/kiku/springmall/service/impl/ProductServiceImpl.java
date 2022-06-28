package com.kiku.springmall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kiku.springmall.service.ProductDTO;
import com.kiku.springmall.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductDAO productDAO;

	@Override
	public void insertProduct(ProductDTO dto) {
		System.out.println("==> ProductServiceImpl - insertProduct()");
		productDAO.insertProduct(dto);
	}

	@Override
	public void updateProduct(ProductDTO dto) {
		System.out.println("==> ProductServiceImpl - updateProduct()");
		productDAO.updateProduct(dto);
	}

	@Override
	public void deleteProduct(ProductDTO dto) {
		System.out.println("==> ProductServiceImpl - deleteProduct()");
		productDAO.deleteProduct(dto);
	}

	@Override
	public ProductDTO getProduct(ProductDTO dto) {
		System.out.println("==> ProductServiceImpl - getProduct()");
		return productDAO.getProduct(dto);
	}

	@Override
	public List<ProductDTO> getProductList(ProductDTO dto, String mode) {
		System.out.println("==> ProductServiceImpl getProductList()");
		if(mode.equals("all")) {
			return productDAO.getProductList(dto);
		} else if(mode.equals("category")) {
			return productDAO.getProductList_category(dto);
		}
		return null;
		
	}
}
