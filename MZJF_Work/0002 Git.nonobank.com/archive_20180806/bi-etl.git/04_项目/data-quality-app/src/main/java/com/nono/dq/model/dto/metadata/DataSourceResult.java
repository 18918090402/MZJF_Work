package com.nono.dq.model.dto.metadata;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * 
 *
 */
@Entity(name="DQ_DATASOURCE_RESULT")
public class DataSourceResult {
	@Id
	private Integer tableId;
	private String statDate;
	private String level;
	private String notes;
	
	public Integer getTableId() {
		return tableId;
	}
	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}
	public String getStatDate() {
		return statDate;
	}
	public void setStatDate(String statDate) {
		this.statDate = statDate;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
}