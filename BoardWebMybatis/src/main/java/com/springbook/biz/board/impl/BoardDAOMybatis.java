package com.springbook.biz.board.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.springbook.biz.board.BoardDTO;

//@Repository("boardDAO")
public class BoardDAOMybatis extends SqlSessionDaoSupport{
	
	@Autowired
	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		super.setSqlSessionFactory(sqlSessionFactory);
	}
	
	// 글등록
	public void insertBoard(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - insertBoard() start");
		this.getSqlSession().insert("BoardDAO.insertBoard", dto);
		
	}
	// 글수정
	public void updateBoard(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - updateBoard() start");
		this.getSqlSession().commit();
	}
	// 조회수 증가 -> 글상세보기에서 동작
	public void updateBoardCnt(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - updateBoardCnt() start");
		this.getSqlSession().commit();
	}
	// 글삭제
	public void deleteBoard(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - deleteBoard() start");
		this.getSqlSession().commit();
	}
	// 글 전체 보기 -> 검색 기능 추가
	public List<BoardDTO> getBoardList(BoardDTO dto){
		System.out.println("===> BoardDAOMybatis - getBoardList() start");
		return this.getSqlSession().selectList("BoardDAO.getBoardList", dto);
		
	}
	// 글 상세 보기(1건)
	public BoardDTO getBoard(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - getBoard() start");
		return this.getSqlSession().selectOne("BoardDAO.getBoard", dto);
	}
}
