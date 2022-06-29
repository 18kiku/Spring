package com.springbook.biz.board;

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
		
		int endPage2 = (int)(Math.ceil(total * 1.0)) / block.getAmount();
		if(endPage2 < this.endPage) this.endPage = endPage2;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < endPage2;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public BlockDTO getBlock() {
		return block;
	}

	public void setBlock(BlockDTO block) {
		this.block = block;
	}

	@Override
	public String toString() {
		return "PageDTO [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", total=" + total + ", block=" + block + "]";
	}
	
	
}
