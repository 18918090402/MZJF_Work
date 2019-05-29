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
@Table(name = "DQ_RULE_AE")
public class DqRuleAe {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false, unique = true)
	private Integer id;
	
	private String aeValue;
	private Integer isValid;
	private String aeDesc;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAeValue() {
		return aeValue;
	}
	public void setAeValue(String aeValue) {
		this.aeValue = aeValue;
	}
	public Integer getIsValid() {
		return isValid;
	}
	public void setIsValid(Integer isValid) {
		this.isValid = isValid;
	}
	public String getAeDesc() {
		return aeDesc;
	}
	public void setAeDesc(String aeDesc) {
		this.aeDesc = aeDesc;
	}
	
}
