package com.springbook.biz.board;

public class BlockDTO {
	private int pageNum;
	private int amount;
	private int startNum;
	
	public BlockDTO() {
		this(1, 10);
	}
	
	public BlockDTO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	@Override
	public String toString() {
		return "BlockDTO [pageNum=" + pageNum + ", amount=" + amount + ", startNum=" + startNum + "]";
	}
	
	
}
