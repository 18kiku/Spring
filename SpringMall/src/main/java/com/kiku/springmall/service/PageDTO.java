package com.kiku.springmall.service;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private BlockDTO block;
	
	public PageDTO(BlockDTO block, int total) {
		this.block = block;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(block.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		int realEnd = (int)(Math.ceil(total * 1.0)) / block.getAmount();
		if(realEnd < this.endPage) this.endPage = realEnd;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
