package com.nono.dq.model.dto.metadata;

import java.util.Date;

import javax.jdo.annotations.Transactional;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 
 *
 */
@Entity
public class DqDatasourceResult {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false, unique = true)
	private Integer id;

	private String statDate;
	private Integer tableId;
	private String batchId;
	private String level;
	private String notes;
	private Date warningSuccessTime;
	
	@Transactional
	private Date createTime;
	@Transactional
	private Date updateTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getStatDate() {
		return statDate;
	}
	public void setStatDate(String statDate) {
		this.statDate = statDate;
	}
	public Integer getTableId() {
		return tableId;
	}
	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}
	public String getBatchId() {
		return batchId;
	}
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
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
	@Override
	public String toString() {
		return "DqDataSourceResult [id=" + id + ", statDate=" + statDate + ", tableId=" + tableId + ", batchId="
				+ batchId + ", level=" + level + ", warningSuccessTime=" + warningSuccessTime + ", createTime="
				+ createTime + ", updateTime=" + updateTime + "]";
	}
}