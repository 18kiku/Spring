package com.kiku.springmall.service;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class OrderDTO {
	
	private List<OrderDTO> orderList;
	
	private String order_id;
	private String orderer_id;
	private int product_id;
	private int order_amount;
	private int order_quantity;
	private Timestamp order_date;
	private String delivery_name;
	private String delivery_tel;
	private String delivery_postcode;
	private String delivery_address;
	private String delivery_address_detail;
	private String delivery_state;
	
	private int salePrice;
	
	// join
	private String product_name;
	private int product_price;
	private int discount_rate;
	private String product_image;
	
	private String searchCondition;
	private String searchKeyword;
	
	public int getSalePrice() {
		return product_price - (product_price*discount_rate/100);
	}
}
