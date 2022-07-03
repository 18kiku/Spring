package com.kiku.springmall.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.OrderDTO;

@Repository
public class OrderDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int insertOrder(OrderDTO dto) {
		System.out.println("===> OrderDAO insertOrder");
		System.out.println("인서트오더에들어가는dto는 " + dto);
		return sqlSession.insert("OrderDAO.insertOrder", dto);
	}

	public List<OrderDTO> getOrder(OrderDTO dto) {
		System.out.println("===> OrderDAO getOrder");
		return sqlSession.selectList("OrderDAO.getOrder", dto);
	}

	public List<OrderDTO> getOrderList(OrderDTO dto, BlockDTO block) {
		System.out.println("===> OrderDAO getOrderList");
		
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		pagingMap.put("order", dto);
		pagingMap.put("block", block);
		System.out.println(pagingMap);
		return sqlSession.selectList("OrderDAO.getOrderList", pagingMap);
	}

	public int getOrderCount(OrderDTO dto) {
		System.out.println("===> OrderDAO getOrderCount");
		return sqlSession.selectOne("OrderDAO.getOrderCount", dto);
	}

}
