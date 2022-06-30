<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/management/product/productDetail.css" />
<script>
	document.addEventListener("DOMContentLoaded", function(){
		let btn_update = document.getElementById("btn_update");
		let btn_list = document.getElementById("btn_list");
		
		btn_update.addEventListener("click", function(){
			// 유효성 검사 후 submit();
		})
		
		btn_list.addEventListener("click", function(){
			location="productList.do";
		})
		
	})
</script>
</head>
<body>
<div class="container">
	<h1>ProductDetail</h1>
	<div class="d1">
		<form action="productUpdate.do" method="post" name="detailForm" enctype="multipart/form-data">
			<table>
			<tr>
				<th>
					product_id
				</th>
				<!-- product_id is read only-->
				<td>
					<input type="number" name="product_id" value="${product.product_id }" readonly>
				</td>
			</tr>
			<tr>
				<th>
					product_category
				</th>
				<!-- select로 고치기 -->
				<td>
					<input type="text" name="product_category" value="${product.product_category }">
				</td>
			</tr>
			<tr>
				<th>
					product_name
				</th>
				<td>
					<input type="text" name="product_name" value="${product.product_name }">
				</td>
			</tr>
			<tr>
				<th>
					product_brand
				</th>
				<td>
					<input type="text" name="product_brand" value="${product.product_brand }">
				</td>
			</tr>
			<tr>
				<th>
					product_size
				</th>
				<td>
					<input type="text" name="product_size" value="${product.product_size }">
				</td>
			</tr>
			<tr>
				<th>
					product_color
				</th>
				<td>
					<input type="text" name="product_color" value="${product.product_color }">
				</td>
			</tr>
			<tr>
				<th>
					product_price
				</th>
				<td>
					<input type="number" name="product_price" value="${product.product_price }">
				</td>
			</tr>
			<tr>
				<th>
					discount_rate
				</th>
				<td>
					<input type="number" name="discount_rate" value="${product.discount_rate }">
				</td>
			</tr>
			<tr>
				<th>
					product_stock
				</th>
				<td>
					<input type="number" name="product_stock" value="${product.product_stock }">
				</td>
			</tr>
			<tr>
				<th>
					product_image
				</th>
				<td>
					<input type="file" name="product_images">
					<input type="hidden" name="no_image" value="${product.product_image }" multiple>
				</td>
			</tr>
			<tr>
				<th>
					product_detail
				</th>
				<td>
					<input type="file" name="product_details">
					<input type="hidden" name="no_detail" value="${product.product_detail }" multiple>
				</td>
			</tr>
			</table>
			<div class="btns">
				<input type="submit" id="btn_update" value="update">
				<input type="button" id="btn_list" value="list">
			</div>
		</form>
	</div>
</div>
</body>
</html>