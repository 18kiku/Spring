<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/cart/cartList.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<main>
<div class="container">
	<div class="cart_list">
		<div class="d1">
		</div>
		<div class="d2">
			<a href="shopMain.do">홈</a> > <span>장바구니</span>
		</div>
		<hr class="d_line">
		<div class="d3">
			<input type="checkbox" name="ck_cart_all" id="ck_cart_all"><label for="ck_cart_all">전체 선택</label>
			<input type="button" value="주문" id="btn_order_select">
			<input type="button" value="삭제" id="btn_delete_select">
		</div>
		<table class="t_cart_list">
		<tr>
			<th colspan="3">
				상품정보
			</th>
			<th>
				수량
			</th>
			<th>
				상품금액
			</th>
			<th>
				배송정보
			</th>
			<th>
				주문
			</th>
		</tr>
		<c:if test="${cartList[0]==null }">
		<tr>
			<td colspan="7" class="td0">
				장바구니에 상품이 없습니다.
			</td>
		</tr>
		</c:if>
		<c:if test="${cartList[0] !=null }">
		<c:forEach var="cart" items="${cartList }">
		<form action="cartUpdate.do" method="post" name="cartForm">
			<input type="hidden" name="cart_id" value="">
			<input type="hidden" name="product_id" value="">
			<tr>
				<td class="center td1" width="3%">
					<span><input type="checkbox" name="ck_cart_one" class="ck_cart_one"></span>
				</td>
				<td class="center td2" width="8%">
					<a href="shopDetail?product_id=${cart.product_id }"><img src="/spring_images/${cart.product_image }" width="60" height="60"></a>
				</td>
				<td class="left td3" width="48%">
					<span class="s1">
					<a href="shopDetail.do?product_id=${cart.product_id}">${cart.product_name }</a>
					</span><br>
					<span class="s2">
					${cart.product_size} | ${product.product_color } </span><br>
					<span class="s3">${cart.product_price }원</span> | <span class="s4"><fmt:formatNumber pattern="#,###,###" value="${cart.product_price * cart.discount_rate / 100}"/>원</span> (<span class="s5">${cart.discount_rate }%할인</span>)
				</td>
				<td class="center td4" width="8%">
					<input type="number" name="order_quantity" value="${cart.order_quantity }" class="order_quantity" min=1 max=99><br>
					<input type="submit" name="btn_count" value="변경" class="btn_update">
				</td>
				<td class="right td5" width="9%">
					<fmt:formatNumber pattern="#,###,###" value="${cart.product_price * cart.discount_rate / 100}"/>원
				</td>
				<td class="center td6" width="12%">
					${d_day }<br>
					도착예정
				</td>
				<td class="center td7" width="12%">
					<input type="button" name="btn_order_one" value="주문하기" class="btn_order_one"><br>
					<input type="button" name="btn_delete_one" value="삭제" class="btn_delete_one">
				</td>
			</tr>
		</form>
		</c:forEach>
		</c:if>
		<tr>
			<th colspan="7">
				배송 상품 총 금액 : <b class="c1_s1">0원</b>
			</th>
		</tr>
		</table>
		<div class="d4">
			<span>선택한 상품</span>
			<input type="button" value="주문" id="btn_order_select2">
			<input type="button" value="삭제" id="btn_delete_select2">
		</div>
		<table class="t_cart_tot">
		<tr>
			<th>
				총 상품 금액<br>
				<span class="s1 c2_s1">0원</span>
			</th>
			<th>
				<img src="resources/img/plus.PNG" width="30">
			</th>
			<th>
				총 추가금액<br>
				<span class="s2"><%=0 %></span>원
			</th>
			<th>
				<img src="resources/img/minus.PNG" width="30">
			</th>
			<th>
				총 할인금액<br>
				<span class="s3"><%=0 %></span>원
			</th>
			<th>
				<img src="resources/img/equal.PNG" width="30">
			</th>
			<th>
				최종 결제금액<br>
				<span class="s4 c3_s1">0원</span>
			</th>
		</tr>
		<tr>
			<th colspan="7">
				<span>정가 <b class="c1_s2">0원</b>에서 <b class="c1_s3">0원</b> 할인</span><br>
				<span>총 주문수량 : <b class="c1_s4">0종</b> (<b class="c1_s5">0개</b>)</span>
			</th>
		</tr>
		</table>
		<table class="t_cart_address">
		<tr>
			<th>
				배송일 안내<br>
				<input type="button" value="배송안내">
			</th>
			<td>
				배송지 : <span id="address">${member.address }&ensp;${member.address_detail }</span><input type="button" value="배송지 변경" id="btn_address">
			</td>
		</tr>
		</table>
		<div class="d5">
			<input type="submit" value="주문하기" id="btn_order_select3">
			<input type="button" value="돌아가기" id="btn_shopping">
		</div>
	</div>
</div>
</main>