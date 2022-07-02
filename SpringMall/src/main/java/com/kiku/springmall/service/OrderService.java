package com.kiku.springmall.service;

import java.util.List;

public interface OrderService {
	int insertOrder(OrderDTO dto);
	OrderDTO getOrder(OrderDTO dto);
	List<OrderDTO> getOrderList(OrderDTO dto);
}