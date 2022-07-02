<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/cart/cartList.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
    $(document).ready(function () { /* 종합 정보 섹션 정보 삽입 */
        setTotalInfo();
        /* 체크여부에따른 종합 정보 변화 */
        $(".individual_cart_checkbox").on("change", function () { /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
            setTotalInfo($(".cart_list_td"));
        });
        /* 체크박스 전체 선택 */
        $(".input_all_check").on("click", function () { /* 체크박스 체크/해제 */
            if ($(".input_all_check").prop("checked")) {
                $(".individual_cart_checkbox").attr("checked", true);
            } else {
                $(".individual_cart_checkbox").attr("checked", false);
            }
            /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
            setTotalInfo($(".cart_list_td"));
        });
        /* 수량버튼 */
        $(".btn_plus").on("click", function () {
            let quantity = $(this)
                .parent("div")
                .find("input")
                .val();
            $(this)
                .parent("div")
                .find("input")
                .val(++ quantity);
        });
        $(".btn_minus").on("click", function () {
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
        let updateForm = {
        		orderer_id: '${member.id}',
        		product_id: '',
        		order_quantity: ''
        }
        /* 수량 수정 버튼 */
        $(".btn_quantity_modify").on("click", function () {
            updateForm.product_id = $(this).data("product_id");
            updateForm.order_quantity = $(this)
                .parent("td")
                .find("input")
                .val();
            $.ajax({
                url: 'cartUpdate.do',
                type: 'POST',
                data: updateForm,
                success: function(message) {
                	if (message == 0) {
                        alert("장바구니에 추가하지 못하였습니다.");
                    } else if (message == 1) {
                        alert("장바구니에 추가되었습니다.");
                    } else if (message == 2) {
                        alert("장바구니에 추가되었습니다.(상품개수를 업데이트했습니다.)");
                    } else if (message == 10917) {
                        alert("로그인을 해주세요.");
                        location = "memberLogin.do";
                    }
                },
                error: function(message){
                	alert('오류');
                }
            })
        });
        let deleteForm = {
        		cart_id: ''
        }
        /* 장바구니 개별 삭제 버튼 */
        $(".btn_delete").on("click", function (e) {
            deleteForm.cart_id = $(this).data("cart_id");
            $.ajax({
            	url: 'cartDelete.do',
            	type: 'POST',
            	data: deleteForm,
            	success: function(message){
            		if (message == 0) {
                        alert("삭제에 실패했습니다.");
                    } else if (message > 0 && message < 10917) {
                        alert("삭제되었습니다.");
                        location = 'cartList.do';
                    } else if (message == 10917) {
                        alert("로그인을 해주세요.");
                        location = "memberLogin.do";
                    }
            	},
            	error: function(message){
            		alert('오류');
            	}
            })
        });
        /* 장바구니 전체 삭제 버튼 */
        $(".input_all_delete").on("click", function (e) {
            $.ajax({
            	url: 'cartDeleteAll.do',
            	type: 'POST',
            	data: {
            		orderer_id: $(this).data("orderer_id")
            	},
            	success: function(message){
            		if (message == 0) {
                        alert("삭제에 실패했습니다.");
                    } else if (message > 0 && message < 10917) {
                        alert("모두 삭제되었습니다.");
                        location = 'cartList.do';
                    } else if (message == 10917) {
                        alert("로그인을 해주세요.");
                        location = "memberLogin.do";
                    }
            	},
            	error: function(message){
            		alert('오류');
            	}
            })
        });
        /* 주문 페이지 이동 */
        $(".btn_order").on("click", function () {
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
    
</script>
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
				<div class="all_input_div">
					<input type="checkbox" class="input_all_check input_size_20" checked="checked"><span class="all_chcek_span">전체선택</span>
					<input type="button" class="input_all_delete input_size_4020" data-orderer_id="${member.id }" value="전체 삭제">
				</div>			
				<div class="clearfix"></div>
				
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
									<input type="hidden" class="individual_salePrice_input" value="${cart.product_price - (cart.product_price*cart.discount_rate/100)}">
									<input type="hidden" class="individual_order_quantity_input" value="${cart.order_quantity}">
									<input type="hidden" class="individual_totalPrice_input" value="${(cart.product_price - (cart.product_price*cart.discount_rate/100)) * cart.order_quantity}">
									<input type="hidden" class="individual_product_id_input" value="${cart.product_id}">								
								</td>
								<td class="td_width_2">
									<div>
										<img src="${pageContext.request.contextPath}/resources/img/${product.product_image }" width="60" height="60">
									</div>								
								</td>
								<td class="td_width_3">${cart.product_name}</td>
								<td class="td_width_4 price_td">
									<div class="list_price">정가 : <fmt:formatNumber value="${cart.product_price}" pattern="#,### 원" /></div><br>
									판매가 : <span class="red_color"><fmt:formatNumber value="${cart.product_price - (cart.product_price*product.discount_rate/100)}" pattern="#,### 원" /></span>
								</td>
								<td class="td_width_4 table_text_align_center">
									<div class="table_text_align_center quantity_div">
										<input type="text" value="${cart.order_quantity}" class="quantity_input">	
										<button class="btn_quantity btn_plus">+</button>
										<button class="btn_quantity btn_minus">-</button>
									</div>
									<input type="button" class="btn_quantity_modify" data-product_id="${cart.product_id}" value="변경">
								</td>
								<td class="td_width_4 table_text_align_center">
									<fmt:formatNumber value="${cart.product_price - (cart.product_price*cart.discount_rate/100) * cart.order_quantity}" pattern="#,### 원" />
								</td>
								<td class="td_width_4 table_text_align_center">
									<input type="button" class="btn_delete" data-cart_id="${cart.cart_id}" value="삭제">
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
				<a class="btn_order">주문하기</a>
			</div>
			
			<!-- 수량 조정 form -->
			<form action="/cartUpdate.do" method="post" class="quantity_update_form">
				<input type="hidden" name="product_id" class="update_product_id">
				<input type="hidden" name="order_quantity" class="update_order_quantity">
				<input type="hidden" name="orderer_id" value="${member.id}">
			</form>	
			
			<!-- 삭제 form -->
			<form action="/cartDelete.do" method="post" class="quantity_delete_form">
				<input type="hidden" name="cart_id" class="delete_cart_id">
				<input type="hidden" name="orderer_id" value="${member.id}">
			</form>
			
			<!-- 전체 삭제 form -->
			<form action="/cartDeleteAll.do" method="post" class="quantity_delete_all_form">
				<input type="hidden" name="cart_id" class="delete_all_cart_id">
				<input type="hidden" name="orderer_id" value="${member.id}">
			</form>	
			
			<!-- 주문 form -->
			<form action="/order.do?id=${member.id}" method="get" class="order_form">

			</form>
		</div>
	</div>	<!-- class="wrap" -->
</div>	<!-- class="wrapper" -->
</main>