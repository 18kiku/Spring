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
	
	public int insertCart(CartDTO dto) {
		System.out.println("===> CartDAO - insertCart()");
		return sqlSession.insert("CartDAO.insertCart", dto);
	}
	
	public int updateCart(CartDTO dto) {
		System.out.println("===> CartDAO - updateCart()");
		return sqlSession.update("CartDAO.updateCart", dto);
	}
	
	public int deleteCart(CartDTO dto) {
		System.out.println("===> CartDAO - deleteCart()");
		return sqlSession.delete("CartDAO.deleteCart", dto);
	}
	
	public int deleteCartAll(CartDTO dto) {
		System.out.println("===> CartDAO - deleteCartAll()");
		return sqlSession.delete("CartDAO.deleteCartAll", dto);
	}
	
	public CartDTO getCart(CartDTO dto) {
		System.out.println("===> CartDAO - getCart()");
		return sqlSession.selectOne("CartDAO.getCart", dto);
	}
	
	public List<CartDTO> getCartList(CartDTO dto) {
		System.out.println("===> CartDAO - getCartList()");
		return sqlSession.selectList("CartDAO.getCartList", dto);
	}

	public int checkCart(CartDTO dto) {
		System.out.println("===> CartDAO - getCartList()");
		return sqlSession.selectOne("CartDAO.checkCart", dto);
	}
}
