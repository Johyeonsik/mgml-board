package com.spring.board.vo;

public class PageVo {
	
	private int pageNo = 0;
	private String[] sort;
	
	
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public String[] getSort() {
		return sort;
	}
	public void setSort(String[] sort) {
		this.sort = sort;
	}
	@Override
	public String toString() {
		return "PageVo [pageNo=" + pageNo + ", sort=" + sort + "]";
	}
	

}
