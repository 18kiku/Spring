package com.kiku.springmall.service;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CartDTO {
	// column
	private int cart_id;
	private String orderer_id;
	private int product_id;
	private int order_quantity;
	
	// join
	private String product_category;
	private String product_name;
	private String product_brand;
	private String product_size;
	private String product_color;
	private int product_price;
	private int discount_rate;
	private int product_stock;
	private String product_image;
	private String product_detail;
	private Timestamp reg_date;
}
