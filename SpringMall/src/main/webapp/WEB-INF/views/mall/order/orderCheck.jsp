<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mall/order/orderCheck.css?v">

<script>
    $(document).ready(function () { /* 주문 조합정보란 최신화 */
        setTotalInfo();
        IMP.init("imp90878890");
    });
    /* 주소입력란 버튼 동작(숨김, 등장) */
    function showAdress(className) {
        /* 컨텐츠 동작 */
        /* 모두 숨기기 */
        $(".div_addressInfo_input").css('display', 'none');
        /* 컨텐츠 보이기 */
        $(".div_addressInfo_input_" + className).css('display', 'block');
        /* 버튼 색상 변경 */
        /* 모든 색상 동일 */
        $(".btn_address").css('backgroundColor', '#555');
        /* 지정 색상 변경 */
        $(".btn_address_" + className).css('backgroundColor', '#3c3838');
        /* selectAddress T/F */
        /* 모든 selectAddress F만들기 */
        $(".div_addressInfo_input").each(function (i, obj) {
            $(obj).find(".selectAddress").val("F");
        });
        /* 선택한 selectAdress T만들기 */
        $(".div_addressInfo_input_" + className).find(".selectAddress").val("T");
    }
    /* 다음 주소 연동 */
    function execution_daum_address() {
        console.log("동작");
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = '';
                // 참고항목 변수
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (
                            extraAddr !== ''
                                ? ', ' + data.buildingName
                                : data.buildingName
                        );
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 추가해야할 코드
                    // 주소변수 문자열과 참고항목 문자열 합치기
                    addr += extraAddr;
                } else {
                    addr += ' ';
                }
                // 제거해야할 코드
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $(".input_delivery_postcode").val(data.zonecode);
                $(".input_delivery_address").val(addr);
                // 커서를 상세주소 필드로 이동한다.
                $(".input_delivery_address_detail").attr("readonly", false);
                $(".input_delivery_address_detail").focus();
            }
        }).open();
    }
    /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
    function setTotalInfo() {
        let totalPrice = 0; // 총 가격
        let totalCount = 0; // 총 갯수
        let totalKind = 0; // 총 종류
        let deliveryPrice = 0; // 배송비
        let finalTotalPrice = 0; // 최종 가격(총 가격 + 배송비)
        $(".td_table_products_price").each(function (index, element) { // 총 가격
            totalPrice += parseInt($(element).find(".input_individual_order_amount").val());
            // 총 갯수
            totalCount += parseInt($(element).find(".input_individual_order_quantity").val());
            // 총 종류
            totalKind += 1;
        });
        /* 배송비 결정 */
        if (totalPrice >= 30000) {
            deliveryPrice = 0;
        } else if (totalPrice == 0) {
            deliveryPrice = 0;
        } else {
            deliveryPrice = 3000;
        } finalTotalPrice = totalPrice + deliveryPrice;
        /* 값 삽입 */
        // 총 가격
        $(".span_totalPrice").text(totalPrice.toLocaleString());
        // 총 갯수
        $(".div_products_kind_count").text(totalCount);
        // 총 종류
        $(".div_products_kind_kind").text(totalKind);
        // 배송비
        $(".span_delivery_price").text(deliveryPrice.toLocaleString());
        // 최종 가격(총 가격 + 배송비)
        $(".span_finalTotalPrice").text(finalTotalPrice.toLocaleString());
    };
    /* 결제 요청 */
    $(".btn_payment").on("click", function () {
        
    });
    function requestPay() { // IMP.request_pay(param, callback) 결제창 호출
        IMP.request_pay({
            // param
            pg: "카카오페이",
            pay_method: "card",
            merchant_uid: uuidv4(),
            name: "상품",
            amount: 1,
            buyer_email: "18kiku@gmil.com",
            buyer_name: "키쿠",
            buyer_tel: "010-9362-9589",
            buyer_addr: "서울특별시 강남구 신사동",
            buyer_postcode: "01181"
        }, function (rsp) { // callback
            if (rsp.success) {
                var msg = '결제가 완료되었습니다.';
                msg += '고유ID : ' + rsp.imp_uid;
                msg += '상점 거래ID : ' + rsp.merchant_uid;
                msg += '결제 금액 : ' + rsp.paid_amount;
                msg += '카드 승인번호 : ' + rsp.apply_num;
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
            }
            alert(msg);
        });
    };
    function uuidv4() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = Math.random() * 16 | 0,
                v = c == 'x'
                    ? r
                    : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    }
    /* 주문 요청 */
    $(".btn_order").on("click", function () { /* 주소 정보 & 받는이*/
        $(".div_addressInfo_input").each(function (i, obj) {
            if ($(obj).find(".selectAddress").val() === 'T') {
                $("input[name='delivery_name']").val($(obj).find(".input_delivery_name").val());
                $("input[name='delivery_postcode']").val($(obj).find(".input_postcode").val());
                $("input[name='delivery_address']").val($(obj).find(".input_address").val());
                $("input[name='delivery_address_detail']").val($(obj).find(".input_address_detail").val());
            }
        });
        /* 상품정보 */
        let form_contents = '';
        $(".td_table_products_price").each(function (index, element) {
            let product_id = $(element).find(".input_individual_product_id").val();
            let order_quantity = $(element).find(".input_individual_order_quantity").val();
            let product_id_input = "<input name='orders[" + index + "].product_id' type='hidden' value='" + product_id + "'>";
            form_contents += product_id_input;
            let order_quantity_input = "<input name='orders[" + index + "].order_quantity' type='hidden' value='" + order_quantity + "'>";
            form_contents += order_quantity_input;
        });
        $(".order_form").append(form_contents);
        /* 서버 전송 */
        $(".order_form").submit();
    });
</script>

<main>
<div class="wrapper">
	<div class="wrap">
		<div class="content_area">
			<div class="content_subject">
				<span>주문확인</span>
			</div>
			<div class="content_main">
				<!-- 회원 정보 -->
				<div class="div_member_info">
					<table class="table_text_align_center table_member">
					<tbody>
					<tr>
						<th style="width: 25%;">
							주문자
						</th>
						<td style="width: *">
							${member.name} | ${member.email}
						</td>
					</tr>
					</tbody>
					</table>
				</div>
				<!-- 배송지 정보 -->
				<div class="div_addressInfo">
					<div class="div_addressInfo_button">
						<input type="button" class="btn_address btn_address_1" onclick="showAdress('1')" style="background-color: #3c3838;" value="배송지">
						<input type="button" class="btn_address btn_address_2" onclick="showAdress('2')" value="직접 입력">
					</div>
					<div class="div_addressInfo_input_wrap">
						<div class="div_addressInfo_input div_addressInfo_input_1" style="display: block">
							<table>
							<colgroup>
							<col width="25%">
							<col width="*">
							</colgroup>
							<tbody>
							<tr>
								<th>
									이름
								</th>
								<td>
									 ${member.name}
								</td>
							</tr>
							<tr>
								<th>
									주소
								</th>
								<td>
									 ${member.address} ${member.address_detail}<br>
									${member.postcode} <input class="selectAddress" value="T" type="hidden">
									<input class="input_delivery_name" value="${member.name}" type="hidden">
									<input class="input_postcode" type="hidden" value="${member.postcode}">
									<input class="input_address" type="hidden" value="${member.address}">
									<input class="input_address_detail" type="hidden" value="${member.address_detail}">
								</td>
							</tr>
							</tbody>
							</table>
						</div>
						<div class="div_addressInfo_input div_addressInfo_input_2">
							<table>
							<colgroup>
							<col width="25%">
							<col width="*">
							</colgroup>
							<tbody>
							<tr>
								<th>
									이름
								</th>
								<td>
									<input class="input_delivery_name">
								</td>
							</tr>
							<tr>
								<th>
									주소
								</th>
								<td>
									<input class="selectAddress" value="F" type="hidden">
									<input class="input_delivery_postcode" readonly="readonly"><a class="btn_addres_search" onclick="execution_daum_address()">주소 찾기</a><br>
									<input class="input_delivery_address" readonly="readonly"><br>
									<input class="input_delivery_address_detail" readonly="readonly">
								</td>
							</tr>
							</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- 상품 정보 -->
				<div class="div_products">
					<!-- 상품 종류 -->
					<div class="div_products_kind">
						 주문상품 <span class="div_products_kind_kind"></span>종 <span class="div_products_kind_count"></span>개
					</div>
					<!-- 상품 테이블 -->
					<table class="table_products_subject">
					<colgroup>
					<col width="15%">
					<col width="45%">
					<col width="40%">
					</colgroup>
					<tbody>
					<tr>
						<th>
							이미지
						</th>
						<th>
							상품 정보
						</th>
						<th>
							판매가
						</th>
					</tr>
					</tbody>
					</table>
					<table class="table_products">
					<colgroup>
					<col width="15%">
					<col width="45%">
					<col width="40%">
					</colgroup>
					<tbody>
					<c:forEach items="${orderList}" var="order">
					<tr>
						<td>
							<div class="image_wrap">
								<img>
							</div>
						</td>
						<td>
							${order.product_name}
						</td>
						<td class="td_table_products_price">
							<fmt:formatNumber value="${order.salePrice}" pattern="#,### 원"/> | 수량 ${order.order_quantity}개 <br>
							<fmt:formatNumber value="${order.order_amount}" pattern="#,### 원"/>
							<br>
							<input type="hidden" class="input_individual_product_price" value="${order.product_price}">
							<input type="hidden" class="input_individual_salePrice" value="${order.salePrice}">
							<input type="hidden" class="input_individual_order_quantity" value="${order.order_quantity}">
							<input type="hidden" class="input_individual_order_amount" value="${order.order_amount}">
							<input type="hidden" class="input_individual_product_id" value="${order.product_id}">
						</td>
					</tr>
					</c:forEach>
					</tbody>
					</table>
				</div>
				<!-- 주문 종합 정보 -->
				<div class="div_total_info">
					<!-- 가격 종합 정보 -->
					<div class="div_total_info_price">
						<ul>
							<li>
							<span class="span_price_label">상품 금액</span>
							<span class="span_totalPrice">100000</span>원 </li>
							<li>
							<span class="span_price_label">배송비</span>
							<span class="span_delivery_price">100000</span>원 </li>
							<li>
							<span class="span_price_label">할인금액</span>
							<li class="li_price_total">
							<strong class="span_price_label total_price_label">최종 결제 금액</strong>
							<strong class="strong_red">
							<span class="total_price_red span_finalTotalPrice">
							1500000 </span>원 </strong>
							</li>
						</ul>
					</div>
					<!-- 버튼 영역 -->
					<div class="div_total_info_btn">
						<input type="button" class="btn_payment" onclick="requestPay()" value="결제하기">
						<!-- <input type="button" class="btn_order" value="결제하기"> -->
					</div>
				</div>
			</div>
			<!-- 주문 요청 form -->
			<form class="order_form" action="orderList.do" method="post">
				<!-- 주문자 회원번호 -->
				<input name="orderer_id" value="${member.id}" type="hidden">
				<!-- 주소록 & 받는이-->
				<input name="delivery_name" type="hidden">
				<input name="delivery_postcode" type="hidden">
				<input name="delivery_address" type="hidden">
				<input name="delivery_address_detail" type="hidden">
				<!-- 상품 정보 -->
			</form>
		</div>
	</div>
	<!-- class="wrap" -->
</div>
<!-- class="wrapper" -->
</main>