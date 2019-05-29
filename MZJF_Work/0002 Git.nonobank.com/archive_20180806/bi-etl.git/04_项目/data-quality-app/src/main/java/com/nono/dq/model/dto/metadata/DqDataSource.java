package com.nono.dq.model.dto.metadata;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 *
 */
@Entity
@Table(name = "DQ_DATASOURCE")
public class DqDataSource {
	@Id
	private Integer id;
	private String jdbcId;
	private Integer jdbcType;
	private String tableName;

	private String dataConstraints;
	private Integer isValid;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getJdbcId() {
		return jdbcId;
	}

	public void setJdbcId(String jdbcId) {
		this.jdbcId = jdbcId;
	}

	public Integer getJdbcType() {
		return jdbcType;
	}

	public void setJdbcType(Integer jdbcType) {
		this.jdbcType = jdbcType;
	}

	public String getDataConstraints() {
		return dataConstraints;
	}

	public void setDataConstraints(String dataConstraints) {
		this.dataConstraints = dataConstraints;
	}

	public Integer getIsValid() {
		return isValid;
	}

	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((dataConstraints == null) ? 0 : dataConstraints.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((isValid == null) ? 0 : isValid.hashCode());
		result = prime * result + ((jdbcId == null) ? 0 : jdbcId.hashCode());
		result = prime * result + ((jdbcType == null) ? 0 : jdbcType.hashCode());
		result = prime * result + ((tableName == null) ? 0 : tableName.hashCode());
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
		DqDataSource other = (DqDataSource) obj;
		if (dataConstraints == null) {
			if (other.dataConstraints != null)
				return false;
		} else if (!dataConstraints.equals(other.dataConstraints))
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
		if (jdbcId == null) {
			if (other.jdbcId != null)
				return false;
		} else if (!jdbcId.equals(other.jdbcId))
			return false;
		if (jdbcType == null) {
			if (other.jdbcType != null)
				return false;
		} else if (!jdbcType.equals(other.jdbcType))
			return false;
		if (tableName == null) {
			if (other.tableName != null)
				return false;
		} else if (!tableName.equals(other.tableName))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "DqDataSource [id=" + id + ", jdbcId=" + jdbcId + ", jdbcType=" + jdbcType
				+ ", tableName=" + tableName + ", dataConstraints=" + dataConstraints + ", isValid=" + isValid + "]";
	}
}
