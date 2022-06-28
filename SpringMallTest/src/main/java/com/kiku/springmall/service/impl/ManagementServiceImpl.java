package com.kiku.springmall.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kiku.springmall.service.ManagementDTO;
import com.kiku.springmall.service.ManagementService;

@Service
public class ManagementServiceImpl implements ManagementService{

	@Autowired
	private ManagementDAO managementDAO;
	
	@Override
	public ManagementDTO login(ManagementDTO dto) {
		System.out.println("==> ManagementServiceImpl - login()");
		return managementDAO.login(dto);
	}

}
