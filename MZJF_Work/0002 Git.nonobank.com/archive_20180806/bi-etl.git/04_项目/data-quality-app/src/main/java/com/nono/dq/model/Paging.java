package com.nono.dq.model;

public class Paging {
	private Integer start = 0; // 分页
	private Integer limit = 20; //

	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

}