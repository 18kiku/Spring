package com.kiku.springmall.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.ManagementDTO;

@Repository
public class ManagementDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public ManagementDTO login(ManagementDTO dto) {
		System.out.println("===> ManagementDAO getAdmin");
		System.out.println("DAO " + sqlSession.selectOne("ManagementDAO.getAdmin", dto));
		return null;
	}
}
