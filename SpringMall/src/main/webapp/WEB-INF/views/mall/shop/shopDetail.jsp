<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/shop/shopDetail.css">
<script>
	document.addEventListener("DOMContentLoaded", function(){
		// 이미지 변화 효과
		let big_img = document.querySelector(".big_img");
		let thumb_imgs = document.querySelectorAll(".thumb");
		for(let thumb of thumb_imgs){
			thumb.addEventListener("mouseover", function(){
				big_img.src = thumb.src;
			})	
		}
		// 상품 수량을 100 미만으로 제한하는 효과
		let order_quantity = document.getElementById("order_quantity");
		order_quantity.addEventListener("keyup", function(event){
			if(order_quantity.value < 1) order_quantity.value = 1;
			else if(order_quantity.value > 99){
				order_quantity.value = 99;
			}
		})
		
		// 장바구니 주문하기 버튼
		let form = document.detailForm;
		let btn_cart = document.getElementById("btn_cart");
		let btn_buy = document.getElementById("btn_buy");
		btn_cart.addEventListener("click", function(){
			if(!confirm('상품을 장바구니에 담으시겠습니까?')) {
				return;
			} else {
				form.submit();
			}
		})
		btn_buy.addEventListener("click", function(){
			if(!confirm('주문하시겠습니까?')) {
				return;
			} else {
				form.action = '../buy/buyForm.jsp';
				form.submit();
			}
		})
	})
</script>
<main>
	<div class="d_category">
		<a href="shopMain.do">홈</a>&ensp;>&ensp;
		<a href="shopList.do?product_category=${product.product_category }">${product.product_category }</a>&ensp;>&ensp;
		<span class="p_name">${product.product_name }</span>
	
	</div>
	<div class="c_detail">
		<%-- 구역 1: 왼쪽 상단 - 상품이미지 --%>
		<div class="s1">
			<div class="big_imgs"><img src="/spring_images/${product.product_image }" width="450" height="600" class="big_img"></div>
			<div class="small_imgs">
				<img src="/spring_images/${product.product_image }" width="60" height="80" class="thumb">
				<img src="/spring_images/${product.product_image }" width="60" height="80" class="thumb">
				<img src="/spring_images/${product.product_image }" width="60" height="80" class="thumb">
			</div>
		</div>
		<%-- 구역 2: 오른쪽 상단 - 상품 기본 정보 --%>
		<div class="s2">
			<form action="cartInsert.do" method="post" name="detailForm">
				<%-- cart_id, order_quantity를 제외한 5가지 필드 정보--%>
				<input type="hidden" name="orderer_id" value="${member.id }">
				<input type="hidden" name="product_id" value="${product.product_id }">
				
				<div class="s2_d1">${product.product_name }</div>
				<div class="s2_d2"><span class="ss">브랜드</span><span>${product.product_brand }</span></div>
				<div class="s2_d8"><span class="ss">사이즈</span><span>${product.product_size }</span></div>
				<div class="s2_d9"><span class="ss">색상</span><span>${product.product_color }</span></div>
				<div class="s2_d3"><span class="ss">정가</span><span>${product.product_price }원</span></div>
				<div class="s2_d4"><span class="ss">판매가</span><span><b><fmt:formatNumber pattern="#,###,###" value="${product.product_price * product.discount_rate / 100}"/></b>원</span></div>
				<div class="s2_d5"><span class="ss">할인율</span><span><b>${product.discount_rate }%</b></span></div>
				<div class="s2_d6"><span class="ss">구매수량</span><input type="number" name="order_quantity" id="order_quantity" value="1" min="1" max="99"></div>
				<div class="s2_d7"><span class="ss">배송안내</span><br><br>
					<c:if test="${member == null }">
						<span>
							배송일은 서울은 익일, 경기는 2일, 지방은 3일, 제주 및 도서지역은 평균 5일이 소요됩니다.<br><br>
							단, 토요일, 일요일은 쉽니다.
						</span>
					</c:if>
					<c:if test="${member != null }"> <!-- controller에서 넘길때 model에 d_day를 계산해서 넘기기 -->
						<span><b>${member.name }</b>님의 주소로 <b>${d_day }</b>까지 배송됩니다.</span><br><br>
						<span>주소 : <b>${member.address }</b></span>
					</c:if>
					
				</div>
				<div class="s2_d8"><span class="ss">배송비</span><span>무료</span></div>
				<div class="btns">
					<input type="button" value="장바구니" id="btn_cart">
					<input type="button" value="주문하기" id="btn_buy">
				</div>
			</form>
		</div>
		<hr class="t_line">
		<%-- 구역 3: 하단 - 상품 내용, 리뷰 --%>
		<div class="s3">
			<div class="s3_c1">
				<span class="ss1"><a href="#s2">상세설명</a></span>
				<span class="ss2"><a href="#s3">리뷰</a></span>
				<span class="ss3">상품문의</span>
				<span class="ss4">교환/반품</span>
			</div>
			<h3>상세정보</h3>
			<hr>
			<div class="s3_c2" id="s2"><img src="/spring_images/${product.product_detail }"></div>
			<%-- <h3>리뷰</h3>
			<hr>
			<div class="s3_c3" id="s3">
				<c:forEach var="review" items="reviewList">
					<div class="s3_review">
						<div class="s3_r1">
							<div class="s3_title">${review.title }</div>
							<div class="s3_content">${review.content } %></div>
							<div class="s3_content_toggle">내용 전체 보기 ∨</div>
						</div>
						<div class="s3_r2">
							<div>작성자 : ${review.writer }</div>
							<div>등록일자 : ${review.reg_date }</div>
							<div>조회수 : ${review.cnt }</div>
						</div>
					</div>
				</c:forEach>
			</div> --%>
		</div>
	</div>
	<hr class="t_line">
</main>