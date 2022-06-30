<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ProductList</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/management/product/productList.css" />
<script>
	document.addEventListener("DOMContentLoaded", function(){
		let btn_insert = document.getElementById("btn_insert");
		btn_insert.addEventListener("click", function(){
			location = "productInsert.do";
		})
	})
</script>
</head>
<body>
<body>
<div class="container">
	<h1>Product List</h1>
	<input type="button" id="btn_insert" value="Register">
		<form action="productList.do" method="post">
	<table class="search">
		<tr>
			<td>
				<select name="searchCondition">
					<c:forEach var="option" items="${conditionMap }">
						<option value="${option.value }">${option.key }</option>
					</c:forEach>
				</select>
				<input type="text" name="searchKeyword">
				<input type="submit" value="search">
			</td>
		</tr>
	</table>	
	</form>
	<table class="product">
	<tr>
		<th width="4%">
			product_id
		</th>
		<th width="13%">
			product_category
		</th>
		<th width="7%">
			product_image
		</th>
		<th width="23%">
			product_name
		</th>
		<th width="5%">
			product_brand
		</th>
		<th width="5%">
			product_size
		</th>
		<th width="5%">
			product_color
		</th>
		<th width="7%">
			product_price
		</th>
		<th width="7%">
			discount_rate
		</th>
		<th width="5%">
			product_stock
		</th>
		<th width="8%">
			reg_date
		</th>
		<th width="11%">
			delete
		</th>
	</tr>
	<c:if test="${productList[0] !=null }">
	<c:forEach var="product" items="${productList }">
	<tr>
		<td class="center">
			<a href="productDetail.do?product_id=${product.product_id }">${product.product_id }</a>
		</td>
		<td class="center">
			${product.product_category }
		</td>
		<td class="center">
			<a href="productDetail.do?product_id=${product.product_id }"><img src="file:\\\${product.product_image }" width="60" height="60"></a>
		</td>
		<td class="center">
			<a href="productDetail.do?product_id=${product.product_id }">${product.product_name }</a>
		</td>
		<td class="center">
			${product.product_brand }
		</td>
		<td class="center">
			${product.product_size }
		</td>
		<td class="center">
			${product.product_color }
		</td>
		<td class="right">
			${product.product_price }
		</td>
		<td class="right">
			${product.discount_rate }
		</td>
		<td class="right">
			${product.product_stock }
		</td>
		<fmt:formatDate var="reg_date" value="${product.reg_date }" pattern="yyyy/MM/dd"/>
		<td class="center">
			${reg_date }
		</td>
		<td class="center">
			<a href="productDelete.do?product_id=${product.product_id }">delete</a>
		</td>
	</tr>
	</c:forEach>
	</c:if>
	<c:if test="${productList[0]==null }">
	<tr>
		<td colspan="11" class="center">
			nothing
		</td>
	</tr>
	</c:if>
	</table>
	<div>
		<ul class="paging">
			<c:if test="${paging.prev }">
				<li class="paging_button">
					<a href="#">Previous</a>
				</li>
			</c:if>
			
			<c:forEach var="num" begin="${paging.startPage }" end="${paging.endPage }">
				<li class="paging_button">
					<a href="#">${num }</a>
				</li>
			</c:forEach>
			<c:if test="${paging.next }">
				<li class="paging_button">
					<a href="#">Next</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
</body>
</html>