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
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.nono.dq.model.dto.metadata.DqDataSource;
import com.nono.dq.model.dto.metadata.DqDatasourceColumn;
import com.nono.dq.model.dto.metadata.DqJdbcMetadata;

/**
 * ConnManager implementation for generic SQL-compliant database. This is an
 * abstract class; it requires a database-specific ConnManager implementation to
 * actually create the connection.
 */
public class MysqlManager extends BaseSqlManager {

	public static final Log LOG = LogFactory.getLog(MysqlManager.class.getName());

	public MysqlManager(DqJdbcMetadata jdbcMetadata) {
		super(jdbcMetadata);
	}


	/**
	 * 根据索引位置获取数据
	 * ResultSet数据会被多次查询
	 * @param rs
	 * @param index
	 * @return
	 * @throws Exception
	 */
	@Override 
	public List<Object> getColumnValues(ResultSet rs,Integer index) throws Exception {
		List<Object> record = new ArrayList<Object>();
		//游标移到第一个位置，便于再次查询
		while(!rs.previous());
		
		while (rs.next()) {
			record.add(rs.getObject(index));
		}
		return record;
	}
	/**
	 * 根据字段名获取数据
	 * ResultSet数据会被多次查询
	 * @param rs
	 * @param columnName
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Object> getColumnValues(ResultSet rs,String columnName) throws Exception {
		List<Object> record = new ArrayList<Object>();
		//游标移到第一个位置，便于再次查询
		while(!rs.previous());
		
		while (rs.next()) {
			record.add(rs.getObject(columnName));
		}
		return record;
	}


	@Override
	public ResultSet validExpressionColumn(List<DqDatasourceColumn> ruleColumnList, DqDataSource dqDataSource)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public ResultSet validExpressionScript(DqDatasourceColumn ruleColumnList, DqDataSource dqDataSource)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}
