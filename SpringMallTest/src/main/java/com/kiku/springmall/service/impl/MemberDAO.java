package com.kiku.springmall.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.MemberDTO;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public MemberDTO login(MemberDTO dto) {
		System.out.println("===> MemberDAO login");
		return sqlSession.selectOne("MemberDAO.getMember", dto);
	}
	
	public void insertMember(MemberDTO dto) {
		System.out.println("===> MemberDAO insertMember");
		sqlSession.insert("MemberDAO.insertMember", dto);
	}
	
	public void updateMember(MemberDTO dto) {
		System.out.println("===> MemberDAO updateMember");
		sqlSession.update("MemberDAO.updateMember", dto);
	}
	
	public void deleteMember(MemberDTO dto) {
		System.out.println("===> MemberDAO deleteMember");
		sqlSession.delete("MemberDAO.deleteMember", dto);
	}
	
	public MemberDTO getMember(MemberDTO dto) {
		System.out.println("===> MemberDAO getMember");
		return sqlSession.selectOne("MemberDAO.getMember", dto);
	}
	
	public List<MemberDTO> getMemberList(MemberDTO dto) {
		System.out.println("===> MemberDAO getMemberList");
		//System.out.println(sqlSession.selectList("MemberDAO.getMemberList", dto));
		return sqlSession.selectList("MemberDAO.getMemberList", dto);
	}
}
