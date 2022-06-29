package com.springbook.biz.member.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.springbook.biz.member.MemberDTO;

@Repository("memberDAO")
public class MemberDAOMybatis2 {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 회원 아이디 중복 체크
	public MemberDTO checkIdMember(MemberDTO dto) {
		System.out.println("===> MemberDAOMybatis2 - checkIdMember() start");
		return mybatis.selectOne("MemberDAO.checkIdMember", dto);
	}
	// 회원 등록
	public void insertMember(MemberDTO dto) {
		System.out.println("===> MemberDAOMybatis2 - insertMember() start");
		mybatis.insert("MemberDAO.insertMember", dto);
	}
	// 회원 수정
	public void updateMember(MemberDTO dto) {
		System.out.println("===> MemberDAOMybatis2 - updateMember() start");
		mybatis.update("MemberDAO.updateMember", dto);
	}
	// 회원 삭제
	public void deleteMember(MemberDTO dto) {
		System.out.println("===> MemberDAOMybatis2 - deleteMember() start");
		mybatis.delete("MemberDAO.deleteMember", dto);
	}
	// 회원정보(1건) (id만 확인)
	public MemberDTO getMember(MemberDTO dto) {
		System.out.println("===> MemberDAOMybatis2 - getMember() start");
		return mybatis.selectOne("MemberDAO.getMember", dto);
	}
	// 로그인 확인 (id와 password 둘다 확인)
	public MemberDTO loginMember(MemberDTO dto) {
		System.out.println("===> MemberDAOMybatis2 - loginMember() start");
		return mybatis.selectOne("MemberDAO.loginMember", dto);
	}
}
