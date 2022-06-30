package com.kiku.springmall.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.CartDTO;

@Repository
public class CartDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public void insertCart(CartDTO dto) {
		System.out.println("===> CartDAO - insertCart()");
		sqlSession.insert("CartDAO.insertCart", dto);
	}
	
	public void updateCart(CartDTO dto) {
		System.out.println("===> CartDAO - updateCart()");
		sqlSession.insert("CartDAO.updateCart", dto);
	}
	
	public void deleteCart(CartDTO dto) {
		System.out.println("===> CartDAO - deleteCart()");
		sqlSession.insert("CartDAO.deleteCart", dto);
	}
	
	public CartDTO getCart(CartDTO dto) {
		System.out.println("===> CartDAO - getCart()");
		return sqlSession.selectOne("CartDAO.getCart", dto);
	}
	
	public List<CartDTO> getCartList(CartDTO dto) {
		System.out.println("===> CartDAO - getCartList()");
		return sqlSession.selectList("CartDAO.getCartList", dto);
	}

	public boolean checkCart(CartDTO dto) {
		System.out.println("===> CartDAO - getCartList()");
		boolean isEmpty = false;
		if(sqlSession.selectList("CartDAO.checkCart", dto).get(0) == null) {
			isEmpty = true;
		}
		return isEmpty;
	}
}
