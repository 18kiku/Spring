package com.kiku.springmall.service;

import java.util.List;

public interface CartService {
	void insertCart(CartDTO dto);
	void updateCart(CartDTO dto);
	void deleteCart(CartDTO dto);
	CartDTO getCart(CartDTO dto);
	List<CartDTO> getCartList(CartDTO dto);
	boolean checkCart(CartDTO dto);
}
