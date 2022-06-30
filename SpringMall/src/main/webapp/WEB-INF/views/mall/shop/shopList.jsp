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
</main>