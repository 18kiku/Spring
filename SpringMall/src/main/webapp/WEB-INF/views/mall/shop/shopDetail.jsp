<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>          

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/shop/shopDetail.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<main>
<div class="wrapper">
	<div class="wrap">
		<div class="content_area">
			<div class="content_top">
				<div class="dt_left_area">
					<div class="image_wrap">
						<img>
					</div>				
				</div>
				<div class="dt_right_area">
					<div class="title">
						<h1>
							${product.product_name}
						</h1>
					</div>
					<div class="line"></div>
					<div class="brand">
						 <span>
						 	브랜드 | ${product.product_brand} 
						 </span>
					</div>
					<div class="line"></div>
					<div class="color">
						 <span>
						 	색상 | &emsp;${product.product_color} 
						 </span>
					</div>
					<div class="line"></div>
					<div class="size">
						 <span>
						 	사이즈 | ${product.product_size} 
						 </span>
					</div>
					<div class="line"></div>
					<div class="price">
						<div class="list_price">정가 : <fmt:formatNumber value="${product.product_price}" pattern="#,### 원" /></div>
						<div class="discount_price">
							판매가 : <span class="discount_price_number"><fmt:formatNumber value="${product.product_price - (product.product_price*product.discount_rate/100)}" pattern="#,### 원" /></span> 
							[<fmt:formatNumber value="${product.discount_rate}" pattern="###" />% 
							<fmt:formatNumber value="${product.product_price*product.discount_rate}" pattern="#,### 원" /> 할인]
						</div>
						<div>
							적립 포인트 : <span class="point_span"></span>원
						</div>							
					</div>			
					<div class="line">
					</div>	
					<div class="button">						
						<div class="button_quantity">
							주문수량 | 
							<input type="text" class="quantity_input" value="1">
							<span>
								<button class="plus_btn">+</button>
								<button class="minus_btn">-</button>
							</span>
						</div>
						<div class="space_vertical"></div>
						<div class="button_set">
							<a class="btn_cart">장바구니 담기</a>
							<a class="btn_order">바로구매</a>
						</div>
					</div>
				</div>
			</div>
			<div class="line">
			</div>				
			<div class="content_middle">
				<div class="product_intro">
					intro
				</div>
				<div class="product_detail">
					detail

				</div>
			</div>
			<!-- 주문 form -->
			<form action="/order/${member.id}" method="get" class="order_form">
				<input type="hidden" name="orders[0].productId" value="${product.product_id}">
				<input type="hidden" name="orders[0].productCount" value="">
			</form>	
		</div>
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->
</main>
<script>
    $(document).ready(function () { /* 이미지 삽입 */
        const bobj = $(".image_wrap");
        if (bobj.data("productId")) {
            const uploadPath = bobj.data("path");
            const uuid = bobj.data("uuid");
            const fileName = bobj.data("filename");
            const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
            bobj.find("img").attr('src', '/display?fileName=' + fileCallPath);
        } else {
            bobj.find("img").attr('src', '/resources/img/goodsNoImage.png');
        }
    });
    // $(document).ready(function(){
    // 수량 버튼 조작
    let quantity = $(".quantity_input").val();
    $(".plus_btn").on("click", function () {
        $(".quantity_input").val(++ quantity);
    });
    $(".minus_btn").on("click", function () {
        if (quantity > 1) {
            $(".quantity_input").val(-- quantity);
        }
    });
    // 서버로 전송할 데이터
    const form = {
        id: '${member.id}',
        productId: '${product.product_id}',
        productCount: ''
    }
    // 장바구니 추가 버튼
    $(".btn_cart").on("click", function (e) {
        form.productCount = $(".quantity_input").val();
        $.ajax({
            url: '/cart/add',
            type: 'POST',
            data: form,
            success: function (result) {
                cartAlert(result);
            }
        })
    });
    function cartAlert(result) {
        if (result == '0') {
            alert("장바구니에 추가를 하지 못하였습니다.");
        } else if (result == '1') {
            alert("장바구니에 추가되었습니다.");
        } else if (result == '2') {
            alert("장바구니에 이미 추가되어져 있습니다.");
        } else if (result == '5') {
            alert("로그인이 필요합니다.");
        }
    }
    /* 바로구매 버튼 */
    $(".btn_order").on("click", function () {
        let productCount = $(".quantity_input").val();
        $(".order_form").find("input[name='orders[0].productCount']").val(productCount);
        $(".order_form").submit();
    });
</script>