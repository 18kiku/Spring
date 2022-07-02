package com.kiku.springmall.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.OrderDTO;

@Repository
public class OrderDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int insertOrder(OrderDTO dto) {
		System.out.println("===> OrderDAO insertOrder");
		return sqlSession.insert("OrderDAO.insertOrder", dto);
	}

	public OrderDTO getOrder(OrderDTO dto) {
		System.out.println("===> OrderDAO getOrder");
		return sqlSession.selectOne("OrderDAO.getOrder", dto);
	}

	public List<OrderDTO> getOrderList(OrderDTO dto) {
		System.out.println("===> OrderDAO getOrderList");
		return sqlSession.selectList("OrderDAO.getOrderList", dto);
	}

}
