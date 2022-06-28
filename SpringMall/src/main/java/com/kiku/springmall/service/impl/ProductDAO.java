package com.kiku.springmall.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.ProductDTO;

@Repository
public class ProductDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public void insertProduct(ProductDTO dto) {
		System.out.println("===> ProductDAO insertProduct");
		sqlSession.insert("ProductDAO.insertProduct", dto);
	}
	
	public void updateProduct(ProductDTO dto) {
		System.out.println("===> ProductDAO updateProduct");
		sqlSession.update("ProductDAO.updateProduct", dto);
	}
	
	public void deleteProduct(ProductDTO dto) {
		System.out.println("===> ProductDAO deleteProduct");
		sqlSession.delete("ProductDAO.deleteProduct", dto);
	}
	
	public ProductDTO getProduct(ProductDTO dto) {
		System.out.println("===> ProductDAO getProduct");
		return sqlSession.selectOne("ProductDAO.getProduct", dto);
	}
	
	public List<ProductDTO> getProductList(ProductDTO dto) {
		System.out.println("===> ProductDAO getProductList");
		return sqlSession.selectList("ProductDAO.getProductList", dto);
	}
	
	public List<ProductDTO> getProductList_category(ProductDTO dto) {
		System.out.println("===> ProductDAO getProductList_category");
		return sqlSession.selectList("ProductDAO.getProductList_category", dto);
	}
	
}
