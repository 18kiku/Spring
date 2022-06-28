<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
@import url('https://fonts.googleapis.com/css2?family=Dongle&family=Hi+Melody&family=Jua&family=Zen+Loop&display=swap');
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/common/shopHeader.css">
<header>
<%-- 상단 --%>
<div class="t_box1">
	<%-- 구역1 (상단좌측): 로그인, 회원가입, 고객센터 --%>
	<c:if test="${member==null }">
	<a href="memberLogin.do"><span>로그인</span></a>&ensp;|&ensp; <a href="memberJoin.do"><span>회원가입</span></a> &ensp;|&ensp; </c:if>
	<c:if test="${member !=null }">
	<a href="memberInfo.do?id=${member.id }">${member.name }님</a>&ensp;|&ensp;<a href="memberLogout.do">로그아웃</a>&ensp;|&ensp; </c:if>
	<a href="#"><span>고객센터</span></a>
</div>
<div class="t_box2">
	<%-- 구역2 (상단우측): 회원정보, 구매정보, 장바구니정보 --%>
	<c:if test="${member !=null }">
	<a href="memberInfo.do">
	<img src="<spring:url value='/images/icons/user-white.png'/>" width="35" title="회원정보" class="t_box2_img1"> </a>
	<a href="purchaseDetail.do">
	<img src="<spring:url value='/images/icons/buy-white.png'/>" width="35" title="구매정보" class="t_box2_img2"> </a>
	<a href="cartList.do">
	<img src="<spring:url value='/images/icons/cart-white.png'/>" width="35" title="장바구니정보" class="t_box2_img3"> </a>
	</c:if>
	<c:if test="${member==null }">
	<a href="memberLogin.do?id=${member.id }">
	<img src="<spring:url value='/images/icons/user-white.png'/>" width="35" title="회원정보" class="t_box2_img1"> </a>
	<a href="memberLogin.do">
	<img src="<spring:url value='/images/icons/buy-white.png'/>" width="35" title="구매정보" class="t_box2_img2"> </a>
	<a href="memberLogin.do">
	<img src="<spring:url value='/images/icons/cart-white.png'/>" width="35" title="장바구니정보" class="t_box2_img3"> </a>
	</c:if>
</div>
<div class="t_box3">
	<%-- 구역3 (중단): 타이틀, 검색 --%>
	<div class="m_title">
		<a href="shopMain.do">KoreaHanbok</a>
	</div>
	<div class="s_title">
		한복은 한국의 전통 의복
	</div>
</div>
<%-- 하단 --%>
<div class="t_box4">
	<%-- 구역4 (하단): 메인메뉴(하위메뉴) --%>
	<div class="hover">
		<div class="m_menu1 main">
			<a href="#">전통한복</a>
		</div>
		<div class="s_menu1 sub">
			<div>
				<a href="shopList.do?product_category=111">여성한복</a>
			</div>
			<div>
				<a href="shopList.do?product_category=121">남성한복</a>
			</div>
			<div>
				<a href="shopList.do?product_category=131">배자/쾌자</a>
			</div>
		</div>
	</div>
	<div class="hover">
		<div class="m_menu2 main">
			<a href="#">개량한복</a>
		</div>
		<div class="s_menu2 sub">
			<div>
				<a href="shopList.do?product_category=211">여성 저고리</a>
			</div>
			<div>
				<a href="shopList.do?product_category=221">여성 치마</a>
			</div>
			<div>
				<a href="shopList.do?product_category=231">여성 원피스</a>
			</div>
			<div>
				<a href="shopList.do?product_category=241">남성 생활한복</a>
			</div>
		</div>
	</div>
	<div class="hover">
		<div class="m_menu3 main">
			<a href="#">궁중한복</a>
		</div>
		<div class="s_menu3 sub">
			<div>
				<a href="shopList.do?product_category=300">궁중한복</a>
			</div>
		</div>
	</div>
	<div class="hover">
		<div class="m_menu4 main">
			<a href="#">아동한복</a>
		</div>
		<div class="s_menu4 sub">
			<div>
				<a href="shopList.do?product_category=411">여아 한복</a>
			</div>
			<div>
				<a href="shopList.do?product_category=421">남아 한복</a>
			</div>
		</div>
	</div>
	<div class="hover">
		<div class="m_menu5 main">
			<a href="shopList.do?product_category=500">장신구</a>
		</div>
		<div class="s_menu5 sub">
			<div>
				<a href="shopList.do?product_category=500">장신구</a>
			</div>
		</div>
	</div>
	<div class="hover">
		<div class="m_menu6 main">
			<a href="shopList.do?product_category=600">공예품</a>
		</div>
		<div class="s_menu6 sub">
			<div>
				<a href="shopList.do?product_category=600">공예품</a>
			</div>
		</div>
	</div>
</div>
<div class="top_end"></div>
<hr class="end_line">
</header>