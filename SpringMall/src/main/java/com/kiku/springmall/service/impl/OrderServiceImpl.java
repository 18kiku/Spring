package com.kiku.springmall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kiku.springmall.service.OrderDTO;
import com.kiku.springmall.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired
	private OrderDAO orderDAO;
	
	@Override
	public int insertOrder(OrderDTO dto) {
		System.out.println("==> OrderServiceImpl - insertOrder()");
		return orderDAO.insertOrder(dto);
	}

	@Override
	public OrderDTO getOrder(OrderDTO dto) {
		System.out.println("==> OrderServiceImpl - getOrder()");
		return orderDAO.getOrder(dto);
	}

	@Override
	public List<OrderDTO> getOrderList(OrderDTO dto) {
		System.out.println("==> OrderServiceImpl - getOrderList()");
		return orderDAO.getOrderList(dto);
	}

}
