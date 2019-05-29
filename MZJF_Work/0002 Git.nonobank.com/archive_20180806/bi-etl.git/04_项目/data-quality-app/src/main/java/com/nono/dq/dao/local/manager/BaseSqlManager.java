/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.nono.dq.dao.local.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.base.Strings;
import com.nono.dq.model.dto.metadata.DqDataSource;
import com.nono.dq.model.dto.metadata.DqDatasourceColumn;
import com.nono.dq.model.dto.metadata.DqJdbcMetadata;
import com.nono.dq.util.DateUtil;
import com.nono.dq.util.LoggingUtils;
import com.nono.dq.util.ReflectUtil;

/**
 * ConnManager implementation for generic SQL-compliant database. This is an
 * abstract class; it requires a database-specific ConnManager implementation to
 * actually create the connection.
 */
public abstract class BaseSqlManager {

	private final Logger LOG = LoggerFactory.getLogger(BaseSqlManager.class);

	private static final int DEFAULT_FETCH_SIZE = 1000;
	protected static final String TOTAL_COLUMN = "total_count_";
	private Statement lastStatement;
	public DqJdbcMetadata jdbcMetadata;
	public Connection connection;

	public void init() {
		try {
			this.connection = ConnectionPoolUtil.makeConnection(this.jdbcMetadata);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			LOG.error("{}",e);
		}
	}

	public BaseSqlManager(DqJdbcMetadata jdbcMetadata) {
		this.jdbcMetadata = jdbcMetadata;
		init();
	}

	/**
	 * where
	 * 
	 * @param conditions
	 * @return
	 */
	protected String replaceConditions(String conditions) {
		String query = conditions.replaceAll("\\$\\{T_SUB_1\\}", DateUtil.getStringLastDate());
		return query;
	}

	protected ResultSet execute(String stmt, Object... args) throws SQLException {
		return execute(stmt, DEFAULT_FETCH_SIZE, args);
	}

	public ResultSet execute(String stmt) throws SQLException {
		return execute(stmt, DEFAULT_FETCH_SIZE, null);
	}

	/**
	 * Executes an arbitrary SQL statement.
	 * 
	 * @param stmt
	 *            The SQL statement to execute
	 * @param fetchSize
	 *            Overrides default or parameterized fetch size
	 * @return A ResultSet encapsulating the results or null on error
	 */
	protected ResultSet execute(String stmt, Integer fetchSize, Object... args) throws SQLException {
		// Release any previously-open statement.
		PreparedStatement statement = null;
		statement = connection.prepareStatement(stmt, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
		if (fetchSize != null) {
			LOG.debug("Using fetchSize for next query: " + fetchSize);
			statement.setFetchSize(fetchSize);
		}
		this.lastStatement = statement;
		if (null != args) {
			for (int i = 0; i < args.length; i++) {
				statement.setObject(i + 1, args[i]);
			}
		}
		LOG.info("Executing SQL statement: " + stmt);
		return statement.executeQuery();
	}

	public void close() throws SQLException {
		release();
	}

	/**
	 * @return the transaction isolation level to use for metadata queries
	 *         (queries executed by the ConnManager itself).
	 */
	protected int getMetadataIsolationLevel() {
		return Connection.TRANSACTION_READ_COMMITTED;
	}

	protected void release() {
		if (null != this.lastStatement) {
			try {
				this.lastStatement.close();
				this.connection.close();
			} catch (SQLException e) {
				LOG.error("Exception closing executed Statement: " + e, e);
			}
			this.lastStatement = null;
		}
	}

	/**
	 * @return a SQL query to retrieve the current timestamp from the db.
	 */
	protected String getCurTimestampQuery() {
		return "SELECT CURRENT_TIMESTAMP()";
	}

	/**
	 * {@inheritDoc}
	 */
	public Timestamp getCurrentDbTimestamp() {
		release(); // Release any previous ResultSet.

		Statement s = null;
		ResultSet rs = null;
		try {
			s = connection.createStatement();
			rs = s.executeQuery(getCurTimestampQuery());
			if (rs == null || !rs.next()) {
				return null; // empty ResultSet.
			}
			return rs.getTimestamp(1);
		} catch (SQLException sqlE) {
			LoggingUtils.logAll(LOG, "SQL exception accessing current timestamp: " + sqlE, sqlE);
			return null;
		} finally {
			try {
				if (null != rs) {
					rs.close();
				}
			} catch (SQLException sqlE) {
				LoggingUtils.logAll(LOG, "SQL Exception closing resultset: " + sqlE, sqlE);
			}

			try {
				if (null != s) {
					s.close();
				}
			} catch (SQLException sqlE) {
				LoggingUtils.logAll(LOG, "SQL Exception closing statement: " + sqlE, sqlE);
			}
		}
	}

	/**
	 * 
	 * @param rs
	 *            key:columnName value:计算的column值
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, Object> getColumnValues(ResultSet rs) throws Exception {
		HashMap<String, Object> record = new HashMap<>();
		int cols = rs.getMetaData().getColumnCount();
		ResultSetMetaData metadata = rs.getMetaData();
		while (rs.next()) {
			for (int i = 1; i < cols + 1; i++) {
				// String colTypeName = metadata.getColumnTypeName(i);
				String colName = metadata.getColumnLabel(i);
				// 字段类型，怎么动态取？
				if (colName == null || colName.equals("")) {
					colName = metadata.getColumnName(i);
				}
				Object value = ReflectUtil.getValueByMethod(rs,
						JdbcWritableBridge.getJDBCMethod(metadata.getColumnType(i)), new Class[] { String.class },
						new String[] { colName });
				record.put(colName, value);
			}
		}
		return record;
	}

	/**
	 * 根据索引位置获取数据 ResultSet数据会被多次查询
	 * 
	 * @param rs
	 * @param index
	 * @return
	 * @throws Exception
	 */
	public List<Object> getColumnValues(ResultSet rs, Integer index) throws Exception {
		throw new UnsupportedOperationException("Method not support for this database");
	}

	/**
	 * 根据字段名获取数据 ResultSet数据会被多次查询
	 * 
	 * @param rs
	 * @param columnName
	 * @return
	 * @throws Exception
	 */
	public List<Object> getColumnValues(ResultSet rs, String columnName) throws Exception {
		throw new UnsupportedOperationException("Method not support for this database");
	}

	protected Map<String, String> getColumnTypeNamesForQuery(String stmt) {
		ResultSet results;
		try {
			results = execute(stmt);
		} catch (SQLException sqlE) {
			LoggingUtils.logAll(LOG, "Error executing statement: " + sqlE.toString(), sqlE);
			release();
			return null;
		}
		try {
			Map<String, String> colTypeNames = new HashMap<String, String>();
			int cols = results.getMetaData().getColumnCount();
			ResultSetMetaData metadata = results.getMetaData();
			for (int i = 1; i < cols + 1; i++) {
				String colTypeName = metadata.getColumnTypeName(i);
				String colName = metadata.getColumnLabel(i);
				if (colName == null || colName.equals("")) {
					colName = metadata.getColumnName(i);
				}

				colTypeNames.put(colName, colTypeName);
				LOG.info("Found column {} of type {}", colName, colTypeName);
			}

			return colTypeNames;
		} catch (SQLException sqlException) {
			LoggingUtils.logAll(LOG, "Error reading from database: " + sqlException.toString(), sqlException);
			return null;
		} finally {
			try {
				results.close();
			} catch (SQLException sqlE) {
				LoggingUtils.logAll(LOG, "SQLException closing ResultSet: " + sqlE.toString(), sqlE);
			}
			release();
		}
	}

	/**
	 * @param tableName
	 * @return
	 * @throws SQLException
	 */
	public long getTableRowCount(DqDataSource dqDataSource) throws SQLException {
		release(); // Release any previous ResultSet
		long result = -1;
		StringBuilder countQuery = new StringBuilder("SELECT COUNT(1) FROM ");
		countQuery.append(dqDataSource.getTableName());
		if (Strings.isNullOrEmpty(dqDataSource.getDataConstraints())) {
			countQuery.append(" WHERE");
			countQuery.append(dqDataSource.getDataConstraints());
		}
		Statement stmt = null;
		ResultSet rset = null;
		try {
			stmt = connection.createStatement();
			rset = stmt.executeQuery(countQuery.toString());
			rset.next();
			result = rset.getLong(1);
		} catch (SQLException ex) {
			LoggingUtils.logAll(LOG, "Unable to get count from table {}" + dqDataSource.getTableName(), ex);
			throw ex;
		} finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException ex) {
					LoggingUtils.logAll(LOG, "Unable to close result set", ex);
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException ex) {
					LoggingUtils.logAll(LOG, "Unable to close statement", ex);
				}
			}
		}
		return result;
	}

	protected String escapeTableName(String tableName) {
		if (null == tableName) {
			return null;
		}
		return tableName;
	}

	public abstract ResultSet validExpressionColumn(List<DqDatasourceColumn> ruleColumnList, DqDataSource dqDataSource)
			throws Exception;
	
	public abstract ResultSet validExpressionScript(DqDatasourceColumn ruleColumn, DqDataSource dqDataSource)
			throws Exception;
}
