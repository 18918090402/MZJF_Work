/*! ******************************************************************************
 *
 * Pentaho Data Integration
 *
 * Copyright (C) 2002-2015 by Pentaho : http://www.pentaho.com
 *
 *******************************************************************************
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 ******************************************************************************/

package com.nono.dq.dao.local.manager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.locks.ReentrantLock;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.nono.dq.biz.impl.MetaDataServiceImpl;
import com.nono.dq.model.dto.metadata.DqJdbcMetadata;

public class ConnectionPoolUtil {
	private static ConcurrentMap<Integer, Connection> dataSources = new ConcurrentHashMap<Integer, Connection>();
	private static final Logger LOGGER = LoggerFactory.getLogger(MetaDataServiceImpl.class);
	// PDI-12947
	private static final ReentrantLock lock = new ReentrantLock();
	
	private ConnectionPoolUtil(){
		super();
	}
	private static boolean isDataSourceRegistered(DqJdbcMetadata jdbcMetadata) throws Exception {
		try {
			return dataSources.containsKey(jdbcMetadata.getId());
		} catch (Exception e) {
			throw new Exception("Database.UnableToCheckIfConnectionPoolExists.Exception");
		}
	}

	/**
	 * Create a connection to the database; usually used only from within
	 * getConnection(), which enforces a singleton guarantee around the
	 * Connection object.
	 */
	protected static Connection makeConnection(DqJdbcMetadata jdbcMetadata) throws SQLException {
		
		Connection connection;
		String driverClass = getDriverClass(jdbcMetadata);
		try {
			Class.forName(driverClass);
		} catch (ClassNotFoundException cnfe) {
			throw new RuntimeException("Could not load db driver class: " + driverClass);
		}
		String username = jdbcMetadata.getUserName();
		String password = jdbcMetadata.getPassword();
		String connectString = getConnectionUrl(jdbcMetadata);
		Properties connectionParams = jdbcMetadata.getConnectionParams();
		if (connectionParams != null && connectionParams.size() > 0) {
			LOGGER.debug("User specified connection params. " + "Using properties specific API for making connection.");

			Properties props = new Properties();
			if (username != null) {
				props.put("user", username);
			}

			if (password != null) {
				props.put("password", password);
			}

			props.putAll(connectionParams);
			connection = DriverManager.getConnection(connectString, props);
		} else {
			LOGGER.info("No connection paramenters specified. " + "Using regular API for making connection.");
			if (username == null) {
				connection = DriverManager.getConnection(connectString);
			} else {
				connection = DriverManager.getConnection(connectString, username, password);
			}
		}
		return connection;
	}

	protected static int getMetadataIsolationLevel() {
		return Connection.TRANSACTION_READ_COMMITTED;
	}

	/**
	 * 会出现连接失效的情况
	 * @param jdbcMetadata
	 * @return
	 * @throws Exception
	 */
	@Deprecated
	public static Connection getConnection(DqJdbcMetadata jdbcMetadata) throws Exception {
		if (!isDataSourceRegistered(jdbcMetadata)) {
			// lock.lock();
			synchronized (jdbcMetadata.getId()) {
				if (!isDataSourceRegistered(jdbcMetadata)) {
					addPoolableDataSource(jdbcMetadata);
				}
			}
			// lock.unlock();
		}
		return dataSources.get(jdbcMetadata.getId());
	}

	private static String getConnectionUrl(DqJdbcMetadata jdbcMetadata) {
		switch (jdbcMetadata.getJdbcType()) {
		case 1:
			return "jdbc:hive2://" + jdbcMetadata.getHost() + ":" + jdbcMetadata.getPort() + "/"
					+ jdbcMetadata.getDbName();
		default:
			return "jdbc:mysql://" + jdbcMetadata.getHost() + ":" + jdbcMetadata.getPort() + "/"
					+ jdbcMetadata.getDbName();
		}
	}

	private static String getDriverClass(DqJdbcMetadata jdbcMetadata) {
		switch (jdbcMetadata.getJdbcType()) {
		case 1:
			return "org.apache.hive.jdbc.HiveDriver";
		case 2:
			return "com.mysql.jdbc.Driver";
		default:
			return "com.mysql.jdbc.Driver";
		}
	}

	/**
	 * This methods adds a new data source to cache
	 *
	 * @param log
	 * @param databaseMeta
	 * @param partitionId
	 * @param initialSize
	 * @param maximumSize
	 * @throws Exception
	 * @throws KettleDatabaseException
	 */
	private static void addPoolableDataSource(DqJdbcMetadata jdbcMetadata) throws Exception {
		dataSources.put(jdbcMetadata.getId(), makeConnection(jdbcMetadata));
	}
}
