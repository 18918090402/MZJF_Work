package com.nono.dq.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class QualityQuery implements Cloneable{

	private String statDate;
	private List<Integer> items;
	//是否计算依赖 1:计算 0：不计算
	private Boolean depends;
	private String batchId; 
	private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	public String getBatchId() {
		return batchId;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	public Boolean getDepends() {
		return depends;
	}

	public void setDepends(Boolean depends) {
		this.depends = depends;
	}

	public String getStatDate() {
		return statDate;
	}

	public void setStatDate(String statDate) {
		this.statDate = statDate;
	}

	public Date getStatDT() throws ParseException {
		return df.parse(this.getStatDate());
	}

	public void setItems(List<Integer> items) {
		this.items = items;
	}

	public List<Integer> getItems() {
		return items;
	}
	public void setItems(Integer...items) {
		this.items = Arrays.asList(items);
	}
	

	@Override
	public QualityQuery clone() throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		return (QualityQuery)super.clone();
	}
}
