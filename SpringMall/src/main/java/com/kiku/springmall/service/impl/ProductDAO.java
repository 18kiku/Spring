package com.kiku.springmall.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.BlockDTO;
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
	
	public int getProductCount(ProductDTO dto) {
		System.out.println("===> ProductDAO getProductCount");
		return sqlSession.selectOne("ProductDAO.getProductCount", dto);
	}
	
	public ProductDTO getProduct(ProductDTO dto) {
		System.out.println("===> ProductDAO getProduct");
		return sqlSession.selectOne("ProductDAO.getProduct", dto);
	}
	
	public List<ProductDTO> getProductList(ProductDTO dto, BlockDTO block) {
		System.out.println("===> ProductDAO getProductList");
		
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		pagingMap.put("product", dto);
		pagingMap.put("block", block);
		System.out.println("페이징" + pagingMap);
		System.out.println("결과 : " + sqlSession.selectList("ProductDAO.getProductList", pagingMap));
		return sqlSession.selectList("ProductDAO.getProductList", pagingMap);
	}
	
}
