package com.kiku.springmall.service;

import java.util.List;

public interface OrderService {
	int insertOrder(OrderDTO dto);
	List<OrderDTO> getOrder(OrderDTO dto);
	List<OrderDTO> getOrderList(OrderDTO dto, BlockDTO block);
	int getOrderCount(OrderDTO dto);
}
