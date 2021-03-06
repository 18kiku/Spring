package com.springbook.biz.board.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.springbook.biz.board.BlockDTO;
import com.springbook.biz.board.BoardDTO;

@Repository("boardDAO")
public class BoardDAOMybatis2{
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 글등록
	public void insertBoard(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - insertBoard() start");
		mybatis.insert("BoardDAO.insertBoard", dto);
		
	}
	// 글수정
	public void updateBoard(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - updateBoard() start");
		mybatis.update("BoardDAO.updateBoard", dto);
	}
	// 조회수 증가 -> 글상세보기에서 동작
	public void updateBoardCnt(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - updateBoardCnt() start");
		mybatis.update("BoardDAO.updateBoardCnt", dto);
	}
	// 글삭제
	public void deleteBoard(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - deleteBoard() start");
		mybatis.delete("BoardDAO.deleteBoard", dto);
	}
	// 글삭제
	public void deleteBoardById(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - deleteBoardById() start");
		
		mybatis.delete("BoardDAO.deleteBoardById", dto);
	}
	
	// 글 상세 보기(1건)
	public BoardDTO getBoard(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - getBoard() start");
		return mybatis.selectOne("BoardDAO.getBoard", dto);
	}
	
	// 페이징에서 사용할 전체 페이지수를 구함
	public int getBoardListCount(BoardDTO dto) {
		System.out.println("===> BoardDAOMybatis - getBoardListCount() start");
		return mybatis.selectOne("BoardDAO.getBoardListCount", dto);
	}
	
	// 글 전체 보기 -> 검색 기능 추가
	public List<BoardDTO> getBoardList(BoardDTO dto, BlockDTO block){
		System.out.println("===> BoardDAOMybatis - getBoardList() start");
		
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		pagingMap.put("board", dto);
		block.setStartNum((block.getPageNum() - 1) * block.getAmount());
		pagingMap.put("block", block);
		
		return mybatis.selectList("BoardDAO.getBoardList", pagingMap);
	}
}
