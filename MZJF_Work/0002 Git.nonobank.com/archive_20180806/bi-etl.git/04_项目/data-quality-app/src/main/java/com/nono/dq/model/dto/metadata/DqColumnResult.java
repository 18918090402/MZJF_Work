package com.nono.dq.model.dto.metadata;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 
 *
 */
@Entity
@Table(name = "DQ_COLUMN_RESULT")
public class DqColumnResult {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false, unique = true)
	private Long id;
	
	private Integer tableId;
	private Integer columnId;
	private String statDate;
	private String columnValue;
	private String columnName;
	private String batchId;
	private Integer isLast;

	public String getBatchId() {
		return batchId;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	public Integer getIsLast() {
		return isLast;
	}

	public void setIsLast(Integer isLast) {
		this.isLast = isLast;
	}

	@Transient
	private Date createTime;
	@Transient
	private Date updateTime;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Integer getTableId() {
		return tableId;
	}
	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}
	public Integer getColumnId() {
		return columnId;
	}
	public void setColumnId(Integer columnId) {
		this.columnId = columnId;
	}
	public String getStatDate() {
		return statDate;
	}
	public void setStatDate(String statDate) {
		this.statDate = statDate;
	}
 
	public String getColumnValue() {
		return columnValue;
	}
	public void setColumnValue(String columnValue) {
		this.columnValue = columnValue;
	}
	
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	
	
	@Override
	public String toString() {
		return "DqCompareResult [id=" + id + ", tableId=" + tableId + ", columnId=" + columnId + ", statDate="
				+ statDate + ", columnValue=" + columnValue +  ", createTime=" + createTime
				+ ", updateTime=" + updateTime + "]";
	}
	
	
}
