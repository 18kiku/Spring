<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/cart/cartList.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>



<main>
<div class="wrapper">
	<div class="wrap">
		<div class="content_area">
			
			<div class="content_subject"><span>장바구니</span></div>
			<!-- 장바구니 리스트 -->
			<div class="content_middle_section"></div>
			<!-- 장바구니 가격 합계 -->
			<!-- cartList -->
			<div class="content_totalCount_section">
				
				<!-- 체크박스 전체 여부 -->
				<div class="all_check_input_div">
					<input type="checkbox" class="all_check_input input_size_20" checked="checked"><span class="all_chcek_span">전체선택</span>
				</div>				
				
				<table class="subject_table">
					<caption>표 제목 부분</caption>
					<tbody>

						<tr>
							<th class="td_width_1"></th>
							<th class="td_width_2"></th>
							<th class="td_width_3">상품명</th>
							<th class="td_width_4">가격</th>
							<th class="td_width_4">수량</th>
							<th class="td_width_4">합계</th>
							<th class="td_width_4">삭제</th>
						</tr>
					</tbody>
				</table>
				<table class="cart_table">
					<caption>표 내용 부분</caption>
					<tbody>
						<c:forEach items="${cartList}" var="cart">
							<tr>
								<td class="td_width_1 cart_list_td">
									<input type="checkbox" class="individual_cart_checkbox input_size_20" checked="checked">
									<input type="hidden" class="individual_product_price_input" value="${cart.product_price}">
									<input type="hidden" class="individual_salePrice_input" value="${product.product_price - (product.product_price*product.discount_rate/100)}">
									<input type="hidden" class="individual_order_quantity_input" value="${cart.order_quantity}">
									<input type="hidden" class="individual_totalPrice_input" value="${(product.product_price - (product.product_price*product.discount_rate/100)) * cart.order_quantity}">
									<input type="hidden" class="individual_product_id_input" value="${cart.product_id}">								
								</td>
								<td class="td_width_2">
									<div>
										<img>
									</div>								
								</td>
								<td class="td_width_3">${cart.product_name}</td>
								<td class="td_width_4 price_td">
									<div class="list_price">정가 : <fmt:formatNumber value="${cart.product_price}" pattern="#,### 원" /></div><br>
									판매가 : <span class="red_color"><fmt:formatNumber value="${product.product_price - (product.product_price*product.discount_rate/100)}" pattern="#,### 원" /></span>
								</td>
								<td class="td_width_4 table_text_align_center">
									<div class="table_text_align_center quantity_div">
										<input type="text" value="${cart.order_quantity}" class="quantity_input">	
										<button class="quantity_btn plus_btn">+</button>
										<button class="quantity_btn minus_btn">-</button>
									</div>
									<a class="quantity_modify_btn" data-cart_id="${cart.cart_id}">변경</a>
								</td>
								<td class="td_width_4 table_text_align_center">
									<fmt:formatNumber value="${product.product_price - (product.product_price*product.discount_rate/100) * cart.order_quantity}" pattern="#,### 원" />
								</td>
								<td class="td_width_4 table_text_align_center">
									<button class="delete_btn" data-cart_id="${cart.cart_id}">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<table class="list_table">
				</table>
			</div>
			<!-- 가격 종합 -->
			<div class="content_total_section">
				<div class="total_wrap">
					<table>
						<tr>
							<td>
								<table>
									<tr>
										<td>총 상품 가격</td>
										<td>
											<span class="totalPrice_span">70000</span> 원
										</td>
									</tr>
									<tr>
										<td>배송비</td>
										<td>
											<span class="delivery_price">3000</span>원
										</td>
									</tr>									
									<tr>
										<td>총 주문 상품수</td>
										<td><span class="totalKind_span"></span>종 <span class="totalCount_span"></span>개</td>
									</tr>
								</table>
							</td>
							<td>
								<table>
									<tr>
										<td></td>
										<td></td>
									</tr>
								</table>							
							</td>
						</tr>
					</table>
					<div class="boundary_div">구분선</div>
					<table>
						<tr>
							<td>
								<table>
									<tbody>
										<tr>
											<td>
												<strong>총 결제 예상 금액</strong>
											</td>
											<td>
												<span class="finalTotalPrice_span">70000</span> 원
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 구매 버튼 영역 -->
			<div class="content_btn_section">
				<a class="order_btn">주문하기</a>
			</div>
			
			<!-- 수량 조정 form -->
			<form action="/cartUpdate.do" method="post" class="quantity_update_form">
				<input type="hidden" name="cart_id" class="update_cart_id">
				<input type="hidden" name="order_quantity" class="update_order_quantity">
				<input type="hidden" name="id" value="${member.id}">
			</form>	
			
			<!-- 삭제 form -->
			<form action="/cartDelete.do" method="post" class="quantity_delete_form">
				<input type="hidden" name="cart_id" class="delete_cart_id">
				<input type="hidden" name="id" value="${member.id}">
			</form>		
			<!-- 주문 form -->
			<form action="/order.do?id=${member.id}" method="get" class="order_form">

			</form>
		</div>
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->
</main>
<script>
    $(document).ready(function () { /* 종합 정보 섹션 정보 삽입 */
        setTotalInfo();
        /* 이미지 삽입 */
        $(".image_wrap").each(function (i, obj) {
            const bobj = $(obj);
            if (bobj.data("product_id")) {
                const uploadPath = bobj.data("path");
                const uuid = bobj.data("uuid");
                const fileName = bobj.data("filename");
                const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
                $(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
            } else {
                $(this).find("img").attr('src', '/resources/img/goodsNoImage.png');
            }
        });
    });
    /* 체크여부에따른 종합 정보 변화 */
    $(".individual_cart_checkbox").on("change", function () { /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
        setTotalInfo($(".cart_list_td"));
    });
    /* 체크박스 전체 선택 */
    $(".all_check_input").on("click", function () { /* 체크박스 체크/해제 */
        if ($(".all_check_input").prop("checked")) {
            $(".individual_cart_checkbox").attr("checked", true);
        } else {
            $(".individual_cart_checkbox").attr("checked", false);
        }
        /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
        setTotalInfo($(".cart_list_td"));
    });
    /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
    function setTotalInfo() {
        let totalPrice = 0; // 총 가격
        let totalCount = 0; // 총 갯수
        let totalKind = 0; // 총 종류
        let totalPoint = 0; // 총 마일리지
        let deliveryPrice = 0; // 배송비
        let finalTotalPrice = 0; // 최종 가격(총 가격 + 배송비)
        $(".cart_list_td").each(function (index, element) {
            if ($(element).find(".individual_cart_checkbox").is(":checked") === true) {
                // 체크여부
                // 총 가격
                totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
                // 총 갯수
                totalCount += parseInt($(element).find(".individual_order_quantity_input").val());
                console.log(totalPrice);
                // 총 종류
                totalKind += 1;
                // 총 마일리지
                totalPoint += parseInt($(element).find(".individual_totalPoint_input").val());
            }
        });
        /* 배송비 결정 */
        if (totalPrice >= 30000) {
            deliveryPrice = 0;
        } else if (totalPrice == 0) {
            deliveryPrice = 0;
        } else {
            deliveryPrice = 3000;
        } finalTotalPrice = totalPrice + deliveryPrice;
        /* ※ 세자리 컴마 Javscript Number 객체의 toLocaleString() */
        // 총 가격
        $(".totalPrice_span").text(totalPrice.toLocaleString());
        // 총 갯수
        $(".totalCount_span").text(totalCount);
        // 총 종류
        $(".totalKind_span").text(totalKind);
        // 총 마일리지
        $(".totalPoint_span").text(totalPoint.toLocaleString());
        // 배송비
        $(".delivery_price").text(deliveryPrice);
        // 최종 가격(총 가격 + 배송비)
        $(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());
    }
    /* 수량버튼 */
    $(".plus_btn").on("click", function () {
        let quantity = $(this)
            .parent("div")
            .find("input")
            .val();
        $(this)
            .parent("div")
            .find("input")
            .val(++ quantity);
    });
    $(".minus_btn").on("click", function () {
        let quantity = $(this)
            .parent("div")
            .find("input")
            .val();
        if (quantity > 1) {
            $(this)
                .parent("div")
                .find("input")
                .val(-- quantity);
        }
    });
    /* 수량 수정 버튼 */
    $(".quantity_modify_btn").on("click", function () {
        let cart_id = $(this).data("cart_id");
        let order_quantity = $(this)
            .parent("td")
            .find("input")
            .val();
        $(".update_cart_id").val(cart_id);
        $(".update_order_quantity").val(order_quantity);
        $(".quantity_update_form").submit();
    });
    /* 장바구니 삭제 버튼 */
    $(".delete_btn").on("click", function (e) {
        e.preventDefault();
        const cart_id = $(this).data("cart_id");
        $(".delete_cart_id").val(cart_id);
        $(".quantity_delete_form").submit();
    });
    /* 주문 페이지 이동 */
    $(".order_btn").on("click", function () {
        let form_contents = '';
        let orderNumber = 0;
        $(".cart_list_td").each(function (index, element) {
            if ($(element).find(".individual_cart_checkbox").is(":checked") === true) { // 체크여부
                let product_id = $(element).find(".individual_product_id_input").val();
                let order_quantity = $(element).find(".individual_order_quantity_input").val();
                let product_id_input = "<input name='orders[" + orderNumber + "].product_id' type='hidden' value='" + product_id + "'>";
                form_contents += product_id_input;
                let order_quantity_input = "<input name='orders[" + orderNumber + "].order_quantity' type='hidden' value='" + order_quantity + "'>";
                form_contents += order_quantity_input;
                orderNumber += 1;
            }
        });
        $(".order_form").html(form_contents);
        $(".order_form").submit();
    });
</script>