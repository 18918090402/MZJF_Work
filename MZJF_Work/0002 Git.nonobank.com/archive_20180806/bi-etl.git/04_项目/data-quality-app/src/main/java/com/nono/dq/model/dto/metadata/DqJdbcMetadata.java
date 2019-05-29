package com.nono.dq.model.dto.metadata;

import java.util.Properties;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;


 
@Entity
@Table(name = "DQ_JDBC")
public class DqJdbcMetadata {
	@Id
	private Integer id;

	private String jndiName;

	private String host;
	private String port;
	private String dbName;
	private String userName;
	private String password;

	@Transient
	private Properties connectionParams;
	
	private Integer jdbcType;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getJndiName() {
		return jndiName;
	}

	public void setJndiName(String jndiName) {
		this.jndiName = jndiName;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getDbName() {
		return dbName;
	}

	public void setDbName(String dbName) {
		this.dbName = dbName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Properties getConnectionParams() {
		return connectionParams;
	}

	public void setConnectionParams(Properties connectionParams) {
		this.connectionParams = connectionParams;
	}

	public Integer getJdbcType() {
		return jdbcType;
	}

	public void setJdbcType(Integer jdbcType) {
		this.jdbcType = jdbcType;
	}

	@Override
	public String toString() {
		return "JdbcMetadata [id=" + id + ", jndiName=" + jndiName + ", host=" + host + ", port=" + port + ", dbName="
				+ dbName + ", userName=" + userName + ", password=" + password + ",jdbcType="+jdbcType+"]";
	}

}
