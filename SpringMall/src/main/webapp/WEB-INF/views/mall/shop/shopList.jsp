<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/shop/shopList.css">
<main>
<%-- 분류별 상품을 4개씩 3단으로 처리 --%>
<div class="d_category2">
	 분류 : <span>${productList[0].category_name }</span>
</div>
<div class="products">
	<c:forEach var="product" items="${productList }">
	<div class="d_category3">
		<div class="c_product">
			<div class="c_p1">
				<img src="<spring:url value='/images/${product.product_image }'/>"><br>
			</div>
			<div class="c_p2">
				<span title="${product.product_name }">${product.product_name }</span><br>
			</div>
			<div class="c_p3">
				<span title="${product.product_brand }">${product.product_brand }</span>
			</div>
			<div class="c_p4">
				<span>${product.product_price }</span>원
			</div>
		</div>
		<div class="c_product2">
			<div class="c_p5">
				<a href="#">구매</a>
			</div>
			<div class="c_p6">
				<a href="shopDetail.do?product_id=${product.product_id }">상세</a>
			</div>
		</div>
		<%-- </a>--%>
	</div>
	</c:forEach>
</div>
<div class="clearfix"></div>
<div class="paging">
	<!-- 첫 페이지 -->
	<c:if test="${pageDTO.prev }">
		<a href="shopMain.do?pageNum=1" class="p_box p_box_bold">prev</a>
	</c:if>
	<!-- 이전 페이지 -->
	<c:if test="${pageDTO.prev }">
		<c:set var="pageNum" value="${param.pageNum-10 }"/>	
		<a href="shopMain.do?pageNum=${pageNum }" class="p_box p_box_bold">next</a>
	</c:if>
	
	<!-- 페이지 번호 -->
	<c:forEach var="pageNum" varStatus="s" begin="${pageDTO.startPage }" end="${pageDTO.endPage }">
		<c:if test="${param.pageNum == pageNum }">
			<a href="shopMain.do?pageNum=${pageNum }" class="p_box_choice">${pageNum }</a>
		</c:if>
		<c:if test="${param.pageNum != pageNum }">
			<a href="shopMain.do?pageNum=${pageNum }" class="p_box">${pageNum }</a>
		</c:if>
	</c:forEach>
	
	<!-- 다음 페이지 -->
	<c:if test="${pageDTO.next }">
	<c:set var="pageNum" value="${param.pageNum+10 }"/>
		<c:if test="${pageNum > pageDTO.pageCount }">
			<c:set var="pageNum" value="${pageDTO.pageCount-1 }"/>
		</c:if>
		<a href="shopMain.do?pageNum=${pageNum }" class="p_box p_box_bold">next</a>
	</c:if>
	<!-- 마지막 페이지 -->
	<c:if test="${pageDTO.prev }">
	<c:set var="pageNum" value="${pageDTO.pageCount }"/>
		<a href="shopMain.do?pageNum=${pageNum-1 }" class="p_box p_box_bold">prev</a>
	</c:if>
</div>
</main>