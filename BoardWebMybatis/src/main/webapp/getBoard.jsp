<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세보기</title>
<style>
.container { width: 500px; margin: 20px auto;}
h1, .d1 { text-align: center;}
.d1 { margin-bottom: 20px;}
a { text-decoration: none; color: #186ab3; font-weight: bold; font-size: 1.05em;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
tr { height: 40px;}
th, td { border: 1px solid black;}
th { background: #e9ecef;}
td { padding: 5px;}
table .seq { width: 100px; height: 20px; background: #f1f3f5;}
table .title { width: 380px; height: 20px; background: #186ab3;}
.btns { margin-top: 20px; text-align: center;}
.btns input { width: 100px; height: 35px; font-size: 1.05em; font-weight: bold; border-radius: 3px; cursor: pointer;}
.btns input[type=submit] { background: #000; color: #fff; border: 1px solid #000;}
.btns input[type=submit] { background: #868e96; color: #fff; border: 1px solid #868e96;}
#btn_delete { background: #c84557;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function(){
		let form = document.detailForm;
		// 글목록 버튼 처리
		let btn_board_list = document.getElementById("btn_board_list");
		btn_board_list.addEventListener("click", function(){
			form.action = "getBoardList.do";
			form.submit();
		})
		// 글삭제버튼처리
		let btn_delete = document.getElementById("btn_delete");
		btn_delete.addEventListener("click", function(){
			form.action = "deleteBoard.do";
			form.submit();
		})
	})
</script>
</head>
<body>
<div class="container">
	<h1>글상세</h1>
	<div class="d1"><a href="logout.do">로그아웃</a></div>
	<form action="updateBoard.do" method="post" name="detailForm">
	<table>
		<tr>
			<th width="20%">번호</th>
			<td width="80%"><input type="text" name="seq" value="${board.seq}" readonly></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" value="${board.title}" class="title"></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="writer" value="${board.writer}" class="writer" readonly></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name="content" rows="15" cols="52">${board.content}</textarea></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td>${board.regdate }</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${board.cnt }</td>
		</tr>
	</table>
	<div class="btns">
		<c:if test="${member.id == board.writer }">
			<input type="submit" value="글수정">&ensp;
			<input type="button" value="삭제" id="btn_delete">&ensp;
		</c:if>
		<input type="button" value="리스트" id="btn_board_list">
	</div>
	</form>
</div>
</body>
</html>