package com.nono.dq.model.dto.metadata;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 *
 */
@Entity
@Table(name = "DQ_DATASOURCE_COLUMN")
public class DqDatasourceColumn {
	@Id
	private Integer id;
	private Integer tableId;
	private String columnName;
	private String columnExpression;
	private String scriptText;
	private String staticalMode;
	private Integer isValid;
	private String desc;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getTableId() {
		return tableId;
	}
	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getColumnExpression() {
		return columnExpression;
	}
	public void setColumnExpression(String columnExpression) {
		this.columnExpression = columnExpression;
	}
	public String getScriptText() {
		return scriptText;
	}
	public void setScriptText(String scriptText) {
		this.scriptText = scriptText;
	}
	public String getStaticalMode() {
		return staticalMode;
	}
	public void setStaticalMode(String staticalMode) {
		this.staticalMode = staticalMode;
	}
	public Integer getIsValid() {
		return isValid;
	}
	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((columnExpression == null) ? 0 : columnExpression.hashCode());
		result = prime * result + ((columnName == null) ? 0 : columnName.hashCode());
		result = prime * result + ((desc == null) ? 0 : desc.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((isValid == null) ? 0 : isValid.hashCode());
		result = prime * result + ((scriptText == null) ? 0 : scriptText.hashCode());
		result = prime * result + ((staticalMode == null) ? 0 : staticalMode.hashCode());
		result = prime * result + ((tableId == null) ? 0 : tableId.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DqDatasourceColumn other = (DqDatasourceColumn) obj;
		if (columnExpression == null) {
			if (other.columnExpression != null)
				return false;
		} else if (!columnExpression.equals(other.columnExpression))
			return false;
		if (columnName == null) {
			if (other.columnName != null)
				return false;
		} else if (!columnName.equals(other.columnName))
			return false;
		if (desc == null) {
			if (other.desc != null)
				return false;
		} else if (!desc.equals(other.desc))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (isValid == null) {
			if (other.isValid != null)
				return false;
		} else if (!isValid.equals(other.isValid))
			return false;
		if (scriptText == null) {
			if (other.scriptText != null)
				return false;
		} else if (!scriptText.equals(other.scriptText))
			return false;
		if (staticalMode == null) {
			if (other.staticalMode != null)
				return false;
		} else if (!staticalMode.equals(other.staticalMode))
			return false;
		if (tableId == null) {
			if (other.tableId != null)
				return false;
		} else if (!tableId.equals(other.tableId))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "DqDatasourceColumn [id=" + id + ", tableId=" + tableId + ", columnName=" + columnName
				+ ", columnExpression=" + columnExpression + ", scriptText=" + scriptText + ", staticalMode="
				+ staticalMode + ", isValid=" + isValid + ", desc=" + desc + "]";
	}
}
