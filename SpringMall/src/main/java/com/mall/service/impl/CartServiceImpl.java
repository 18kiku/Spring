package com.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mall.service.CartDTO;
import com.mall.service.CartService;

@Service
public class CartServiceImpl implements CartService{

	@Autowired
	private CartDAO cartDAO;
	
	@Override
	public void insertCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - insertCart()");
		cartDAO.insertCart(dto);
	}

	@Override
	public void updateCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - updateCart()");
		cartDAO.updateCart(dto);
	}

	@Override
	public void deleteCart(CartDTO dto) {
		System.out.println("==> CartServiceImpl - deleteCart()");
		cartDAO.deleteCart(dto);
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

}
