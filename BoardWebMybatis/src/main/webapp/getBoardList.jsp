<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 전체 보기</title>
<style>
.container { width: 1000px; margin: 20px auto;}
h1 { text-align: center;}
.a_tags { text-align: center;}
.a_tags a { text-decoration: none; text-align: center; color: #000;}
a { text-decoration: none; color: #196ab3; font-weight: bold; font-size: 0.95em;}
.d1 { width: 100%; padding-bottom: 40px;}
.d1 div { display: inline-block;}
.d1 .d1_1 { float: left;}
.d1 .d1_2 { float: right; width: 68px; border: 1px solid #196ab3; padding: 3px 10px; border-radius: 3px; margin-right: 5px; text-align: center;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
tr { height: 30px;}
th, td { border: 1px solid black;}
th { background: #e9ecef;}
.t1 tr td:nth-of-type(1) { text-align: right; padding-right: 5px;}
.t1 tr td:nth-of-type(2), .t1 tr td:nth-of-type(3) { padding: 0 5px;}
.t1 select { width: 100px; height: 25px;}
.t1 input[type=text] { width: 280px; height: 18px; padding-left: 3px;}
.t1 input[type=submit] { width: 88px; height: 25px; cursor: pointer;}
.t2 .center { text-align: center;}
.t2 .left { padding-left: 5px;}
/* 하단 - 페이징 영역*/
.paging { text-align: center; margin-top: 20px;}
.p_box { display: inline-block; width: 22px; height: 22px; padding: 5px;}
.p_box:hover { background: #868e96; color: white; font-weight: bold; border-radius: 50%;}
.p_box_c { background: #1e94be; color: white; font-weight: bold; border-radius: 10px;}
.p_box_b { font-weight: bold;}
</style>
</head>
<body>
<div class="container">
	<h1>글목록</h1>
	<div class="d1">
		<div class="d1_1"><a href="getMember.do?id=${member.id}">${member.id }</a> 님 환영합니다&emsp;<a href="logout.do">LOGOUT</a></div>
		<div class="d1_2"><a href="insertBoard.do">글등록</a></div>
	</div>
	<form action="getBoardList.do" method="post">
	<table class="t1">
		<tr>
			<td width="60%">
				<select name="searchCondition">
					<c:forEach var="option" items="${conditionMap }">
						<option value="${option.value }">${option.key }</option>
					</c:forEach>
				</select>
			</td>
			<td width="30%"><input type="text" name="searchKeyword"></td>
			<td width="10%"><input type="submit" value="검색"></td>
		</tr>
	</table>	
	</form>
	<table class="t2">
		<tr>
			<th width="10%">번호</th>
			<th width="50%">제목</th>
			<th width="15%">작성자</th>
			<th width="15%">등록일</th>
			<th width="10%">조회수</th>
		</tr>
		<c:forEach var="board" items="${boardList }">
		<tr>
			<td class="center">${board.seq }</td>
			<td class="left"><a href="getBoard.do?seq=${board.seq }">${board.title }</a></td>
			<td class="center">${board.writer }</td>
			<td class="center">${board.regdate }</td>
			<td class="center">${board.cnt }</td>
		</tr>
		</c:forEach>
	</table>
	<div class="paging">
		<!-- 이전 페이지 -->
		<c:if test="${pageDTO.prev }">
			<a href="#" class="p_box">prev</a>
		</c:if>
		
		<!-- 페이지 번호 -->
		<c:forEach var="num" begin="${pageDTO.startPage }" end="${pageDTO.endPage }">
			<a href="#" class="p_box">${num }</a>
		</c:forEach>
		
		<!-- 이전 페이지 -->
		<c:if test="${pageDTO.next }">
			<a href="#" class="p_box">next</a>
		</c:if>
	</div>
</div>

</body>
</html>