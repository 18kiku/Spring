package com.springbook.view.board;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.springbook.biz.board.BlockDTO;
import com.springbook.biz.board.BoardDTO;
import com.springbook.biz.board.BoardService;
import com.springbook.biz.board.PageDTO;

/*
RequestMapping - 클라이언트의 요청경로를 컨트롤러에서 찾도록 하는 역할
ModelAttribute - RequestMapping 이전에 동작하며, 해당 내용을 모델(객체)로 만들어주느 ㄴ역할
SessionAttributes - 객체를 세션으로 등록하여 사용하도록 하는 역할 

@Autowired
		1. 타입 매칭
		2. 타입 매칭 결과가 2개 이상 있다면 필드명, 파라미터 명으로 빈 이름 매칭
@Qualifier("빈 이름")
		1. Qualifier끼리
		2. 빈 이름 
*/

@Controller
@SessionAttributes("board")
public class BoardController {
	
	// 컨트롤러 다음 서비스가 시작되기때문에 아직 보드서비스가 생성되지않음
	@Autowired 
	private BoardService boardService;
	
	// 화면을 보여줄때는 get방식으로
	@RequestMapping(value="/insertBoard.do", method=RequestMethod.GET)
	public String insertBoard() {
		System.out.println("=> BoardController - 글등록 화면 이동");
		return "insertBoard.jsp";
	}
	// 처리할때는 post방식으로 나눠주자
	@PostMapping(value="/insertBoard.do")
	public String insertBoard(BoardDTO dto) throws IOException{
		System.out.println("=> BoardController - 글등록 처리(처리)");
		boardService.insertBoard(dto);
		
		if(dto.getTitle().equals("")) return "insertBoard.jsp";
		if(dto.getWriter().equals("")) return "insertBoard.jsp";
		if(dto.getContent().equals("")) return "insertBoard.jsp";
		
		return "redirect:getBoardList.do";
	}
	// SessionAttributes의 ModelAttribute 어노테이션을 사용하여 update할때 발생하는 null 업데이트를 방지
	@RequestMapping(value="/updateBoard.do")
	public String updateBoard(@ModelAttribute("board") BoardDTO dto){
		System.out.println("=> BoardController - 글수정 처리");
		/* System.out.println("작성자 : " + dto.getWriter()); */
		boardService.updateBoard(dto);
		return "redirect:getBoardList.do";
	}
	@RequestMapping(value="/deleteBoard.do")
	public String deleteBoard(BoardDTO dto) {
		System.out.println("=> BoardController - 글삭제 처리");
		boardService.deleteBoard(dto);
		return "redirect:getBoardList.do";
	}
	
	
	@RequestMapping(value="/getBoard.do")
	public String getBoard(BoardDTO dto, Model model) {
		System.out.println("=> BoardController - 글상세 조회");
		model.addAttribute("board", boardService.getBoard(dto));
		return "getBoard.jsp";
	}
	// 검색 목록 설정
	@ModelAttribute("conditionMap") // RequestMapping 이전에 실행
	public Map<String, String> searchConditionMap(){
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("내용", "CONTENT");
		conditionMap.put("작성자", "WRITER");
		conditionMap.put("제목", "TITLE");
		return conditionMap;
	}
		
	@RequestMapping(value="/getBoardList.do")
	public String getBoardList(BoardDTO dto, Model model, BlockDTO block) {
		System.out.println("=> BoardController - 글목록 조회");
		// 검색 확인 - searchCondition, searchKeyword가 null일때의 처리
		if(dto.getSearchCondition() == null) dto.setSearchCondition("TITLE");
		if(dto.getSearchKeyword() == null) dto.setSearchKeyword("");
		
		model.addAttribute("boardList", boardService.getBoardList(dto, block));
		model.addAttribute("pageDTO", new PageDTO(block, 155));
		return "getBoardList.jsp";
	}
}
