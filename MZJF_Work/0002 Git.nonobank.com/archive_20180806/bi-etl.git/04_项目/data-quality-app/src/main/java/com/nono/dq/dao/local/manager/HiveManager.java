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

import java.sql.ResultSet;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.base.Strings;
import com.nono.dq.model.dto.metadata.DqDataSource;
import com.nono.dq.model.dto.metadata.DqDatasourceColumn;
import com.nono.dq.model.dto.metadata.DqJdbcMetadata;

/**
 * ConnManager implementation for generic SQL-compliant database. This is an
 * abstract class; it requires a database-specific ConnManager implementation to
 * actually create the connection.
 */
public class HiveManager extends BaseSqlManager {

	public static final Logger LOG = LoggerFactory.getLogger(HiveManager.class);

	public HiveManager(DqJdbcMetadata jdbcMetadata) {
		super(jdbcMetadata);
	}

	/**
	 * 查询结果
	 * 
	 */
	@Override
	public ResultSet validExpressionColumn(List<DqDatasourceColumn> ruleColumnList, DqDataSource dqDataSource)
			throws Exception {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT ");

		boolean first = true;
		for (DqDatasourceColumn column : ruleColumnList) {
			if (!first) {
				sb.append(", ");
			}
			sb.append(column.getColumnExpression());
			sb.append(" as ");
			sb.append("`" + column.getId() + "`");
			first = false;
		}
		sb.append(" FROM ");
		sb.append(dqDataSource.getTableName());
		if (!Strings.isNullOrEmpty(dqDataSource.getDataConstraints())) {
			sb.append(" WHERE ");
			sb.append(replaceConditions(dqDataSource.getDataConstraints()));
		}
		String sqlCmd = sb.toString();
		LOG.debug("Valid table data with command:{} ", sqlCmd);
		return execute(sqlCmd);
	}

	@Override
	public ResultSet validExpressionScript(DqDatasourceColumn column, DqDataSource dqDataSource) throws Exception {
		// TODO Auto-generated method stub
		if (Strings.isNullOrEmpty(column.getScriptText()))
			return null;
		return execute(column.getScriptText());
	}
}