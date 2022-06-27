package com.kiku.springmall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kiku.springmall.service.MemberDTO;
import com.kiku.springmall.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO memberDAO;

	@Override
	public MemberDTO login(MemberDTO dto) {
		// TODO Auto-generated method stub
		return memberDAO.login(dto);
	}
	
	@Override
	public void insertMember(MemberDTO dto) {
		// TODO Auto-generated method stub
		memberDAO.insertMember(dto);
	}

	@Override
	public void updateMember(MemberDTO dto) {
		// TODO Auto-generated method stub
		memberDAO.updateMember(dto);
	}

	@Override
	public void deleteMember(MemberDTO dto) {
		// TODO Auto-generated method stub
		memberDAO.deleteMember(dto);
	}

	@Override
	public MemberDTO getMember(MemberDTO dto) {
		// TODO Auto-generated method stub
		return memberDAO.getMember(dto);
	}

	@Override
	public List<MemberDTO> getMemberList(MemberDTO dto) {
		// TODO Auto-generated method stub
		return memberDAO.getMemberList(dto);
	}



}
