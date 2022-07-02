package com.kiku.springmall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kiku.springmall.service.CartDTO;
import com.kiku.springmall.service.CartService;

@Service
public class CartServiceImpl implements CartService{

	@Autowired
	private CartDAO cartDAO;
	
	@Override
	public int insertCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - insertCart()");
		return cartDAO.insertCart(dto);
	}

	@Override
	public int updateCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - updateCart()");
		return cartDAO.updateCart(dto);
	}
	
	@Override
	public int deleteCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - deleteCart()");
		return cartDAO.deleteCart(dto);
	}
	
	@Override
	public int deleteCartAll(CartDTO dto) {
		System.out.println("==> CartServiceImpl - deleteCartAll()");
		return cartDAO.deleteCartAll(dto);
	}

	@Override
	public CartDTO getCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - getCart()");
		return cartDAO.getCart(dto);
	}

	@Override
	public List<CartDTO> getCartList(CartDTO dto) {
		System.out.println("==> CartServiceImpl - getCartList()");
		return cartDAO.getCartList(dto);
	}

	@Override
	public int checkCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - checkCart()");
		return cartDAO.checkCart(dto);
	}


}
