package com.nono.dq.model.dto.metadata;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 *
 */
@Entity
@Table(name = "DQ_COLUMN_COMPARE")
public class DqColumnCompare {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false, unique = true)
	private Integer id;
	private Integer columnId;
	private Integer ruleId;
	private String targetColumns;
	private Integer warningEnable;
	private Integer warningType;
	private Integer isValid;
	private Integer level;
	
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public Integer getIsValid() {
		return isValid;
	}
	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getColumnId() {
		return columnId;
	}
	public void setColumnId(Integer columnId) {
		this.columnId = columnId;
	}
	public Integer getRuleId() {
		return ruleId;
	}
	public void setRuleId(Integer ruleId) {
		this.ruleId = ruleId;
	}
	public String getTargetColumns() {
		return targetColumns;
	}
	public void setTargetColumns(String targetColumns) {
		this.targetColumns = targetColumns;
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
	@Override
	public String toString() {
		return "DqColumnCompare [id=" + id + ", columnId=" + columnId + ", ruleId=" + ruleId + ", targetColumns="
				+ targetColumns + ", warningEnable=" + warningEnable + ", warningType=" + warningType + ", isValid="
				+ isValid + ", level=" + level + "]";
	}
	
	
}
