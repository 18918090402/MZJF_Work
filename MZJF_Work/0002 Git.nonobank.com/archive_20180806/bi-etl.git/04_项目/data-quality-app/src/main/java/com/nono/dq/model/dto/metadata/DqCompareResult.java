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
@Table(name = "DQ_COMPARE_RESULT")
public class DqCompareResult {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false, unique = true)
	private Long id;
	private Integer compareId;
	
	private String statDate;
	private String columnValue;
	private String targetValue;
	private Integer warningEnable;
	private Integer warningType;
	private Integer warningStatus;
	private Integer tableId;
	private Integer columnId;
	
	private Date warningSuccessTime;
	private Integer compareResult;

	private String batchId;

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

	private Integer level;
	
	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getBatchId() {
		return batchId;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
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

	public Integer getCompareId() {
		return compareId;
	}

	public void setCompareId(Integer compareId) {
		this.compareId = compareId;
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

	public String getTargetValue() {
		return targetValue;
	}

	public void setTargetValue(String targetValue) {
		this.targetValue = targetValue;
	}

	public Integer getWarningEnable() {
		return warningEnable;
	}

	public void setWarningEnable(Integer warningEnable) {
		this.warningEnable = warningEnable;
	}

	public Integer getWarningType() {
		return warningType;
	}

	public void setWarningType(Integer warningType) {
		this.warningType = warningType;
	}

	public Integer getWarningStatus() {
		return warningStatus;
	}

	public void setWarningStatus(Integer warningStatus) {
		this.warningStatus = warningStatus;
	}

	public Date getWarningSuccessTime() {
		return warningSuccessTime;
	}

	public void setWarningSuccessTime(Date warningSuccessTime) {
		this.warningSuccessTime = warningSuccessTime;
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

	public Integer getCompareResult() {
		return compareResult;
	}

	public void setCompareResult(Integer compareResult) {
		this.compareResult = compareResult;
	}

	@Override
	public String toString() {
		return "DqCompareResult [id=" + id + ", statDate=" + statDate + ",compareId="+compareId+", columnValue=" + columnValue
				+ ", targetValue=" + targetValue + ",compareResult=" + compareResult + ", warningEnable="
				+ warningEnable + ", warningType=" + warningType + ", warningStatus=" + warningStatus
				+ ", warningSuccessTime=" + warningSuccessTime + ", createTime=" + createTime + ", updateTime="
				+ updateTime + "]";
	}

}
