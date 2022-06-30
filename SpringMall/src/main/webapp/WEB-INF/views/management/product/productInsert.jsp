<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/management/product/productInsert.css" />
<script>
	document.addEventListener("DOMContentLoaded", function(){
		let btn_insert = document.getElementById("btn_insert");
		let btn_list = document.getElementById("btn_list");
		
		btn_insert.addEventListener("click", function(){
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
	<h1>Product Insert</h1>
	<div class="d1">
		<form action="productInsert.do" method="post" name="detailForm" enctype="multipart/form-data">
			<table>
			<tr>
				<th>
					product_category
				</th>
				<!-- select로 고치기 -->
				<td>
					<input type="text" name="product_category">
				</td>
			</tr>
			<tr>
				<th>
					product_name
				</th>
				<td>
					<input type="text" name="product_name">
				</td>
			</tr>
			<tr>
				<th>
					product_brand
				</th>
				<td>
					<input type="text" name="product_brand">
				</td>
			</tr>
			<tr>
				<th>
					product_size
				</th>
				<td>
					<input type="text" name="product_size">
				</td>
			</tr>
			<tr>
				<th>
					product_color
				</th>
				<td>
					<input type="text" name="product_color">
				</td>
			</tr>
			<tr>
				<th>
					product_price
				</th>
				<td>
					<input type="number" name="product_price">
				</td>
			</tr>
			<tr>
				<th>
					discount_rate
				</th>
				<td>
					<input type="number" name="discount_rate">
				</td>
			</tr>
			<tr>
				<th>
					product_stock
				</th>
				<td>
					<input type="number" name="product_stock">
				</td>
			</tr>
			<tr>
				<th>
					product_image
				</th>
				<td>
					<input type="file" name="product_images" multiple>
				</td>
			</tr>
			<tr>
				<th>
					product_detail
				</th>
				<td>
					<input type="file" name="product_details" multiple>
				</td>
			</tr>
			</table>
			<div class="btns">
				<input type="submit" id="btn_insert" value="Insert">
				<input type="reset" value="reset">
				<input type="button" id="btn_list" value="list">
			</div>
		</form>
	</div>
</div>
</body>
</html>