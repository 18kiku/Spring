package com.kiku.springmall.service;

import java.util.List;

public interface CartService {
	int insertCart(CartDTO dto);
	int updateCart(CartDTO dto);
	int deleteCart(CartDTO dto);
	int deleteCartAll(CartDTO dto);
	CartDTO getCart(CartDTO dto);
	List<CartDTO> getCartList(CartDTO dto);
	int checkCart(CartDTO dto);
}
