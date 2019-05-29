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

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.sql.Types;

/**
 * Contains a set of methods which can read db columns from a ResultSet into
 * Java types, and do serialization of these types to/from DataInput/DataOutput
 * for use with Hadoop's Writable implementation. This supports null values for
 * all types.
 */
public final class JdbcWritableBridge {

	// Currently, cap BLOB/CLOB objects at 16 MB until we can use external
	// storage.
	public static final long MAX_BLOB_LENGTH = 16 * 1024 * 1024;
	public static final long MAX_CLOB_LENGTH = 16 * 1024 * 1024;

	private JdbcWritableBridge() {
	}

	public static Integer readInteger(String col, ResultSet r) throws SQLException {
		int val;
		val = r.getInt(col);
		if (r.wasNull()) {
			return null;
		} else {
			return Integer.valueOf(val);
		}
	}

	public static Integer readInteger(int colNum, ResultSet r) throws SQLException {
		int val;
		val = r.getInt(colNum);
		if (r.wasNull()) {
			return null;
		} else {
			return Integer.valueOf(val);
		}
	}

	public static Long readLong(int colNum, ResultSet r) throws SQLException {
		long val;
		val = r.getLong(colNum);
		if (r.wasNull()) {
			return null;
		} else {
			return Long.valueOf(val);
		}
	}

	public static String readString(int colNum, ResultSet r) throws SQLException {
		return r.getString(colNum);
	}

	public static Float readFloat(int colNum, ResultSet r) throws SQLException {
		float val;
		val = r.getFloat(colNum);
		if (r.wasNull()) {
			return null;
		} else {
			return Float.valueOf(val);
		}
	}

	public static Double readDouble(int colNum, ResultSet r) throws SQLException {
		double val;
		val = r.getDouble(colNum);
		if (r.wasNull()) {
			return null;
		} else {
			return Double.valueOf(val);
		}
	}

	public static Boolean readBoolean(int colNum, ResultSet r) throws SQLException {
		boolean val;
		val = r.getBoolean(colNum);
		if (r.wasNull()) {
			return null;
		} else {
			return Boolean.valueOf(val);
		}
	}

	public static Time readTime(int colNum, ResultSet r) throws SQLException {
		return r.getTime(colNum);
	}

	public static Timestamp readTimestamp(int colNum, ResultSet r) throws SQLException {
		return r.getTimestamp(colNum);
	}

	public static Date readDate(int colNum, ResultSet r) throws SQLException {
		return r.getDate(colNum);
	}

	public static BigDecimal readBigDecimal(int colNum, ResultSet r) throws SQLException {
		return r.getBigDecimal(colNum);
	}

	public static void writeInteger(Integer val, int paramIdx, int sqlType, PreparedStatement s) throws SQLException {
		if (null == val) {
			s.setNull(paramIdx, sqlType);
		} else {
			s.setInt(paramIdx, val);
		}
	}

	public static void writeLong(Long val, int paramIdx, int sqlType, PreparedStatement s) throws SQLException {
		if (null == val) {
			s.setNull(paramIdx, sqlType);
		} else {
			s.setLong(paramIdx, val);
		}
	}

	public static void writeDouble(Double val, int paramIdx, int sqlType, PreparedStatement s) throws SQLException {
		if (null == val) {
			s.setNull(paramIdx, sqlType);
		} else {
			s.setDouble(paramIdx, val);
		}
	}

	public static void writeBoolean(Boolean val, int paramIdx, int sqlType, PreparedStatement s) throws SQLException {
		if (null == val) {
			s.setNull(paramIdx, sqlType);
		} else {
			s.setBoolean(paramIdx, val);
		}
	}

	public static void writeFloat(Float val, int paramIdx, int sqlType, PreparedStatement s) throws SQLException {
		if (null == val) {
			s.setNull(paramIdx, sqlType);
		} else {
			s.setFloat(paramIdx, val);
		}
	}

	public static void writeString(String val, int paramIdx, int sqlType, PreparedStatement s) throws SQLException {
		if (null == val) {
			s.setNull(paramIdx, sqlType);
		} else {
			s.setString(paramIdx, val);
		}
	}

	public static void writeTimestamp(Timestamp val, int paramIdx, int sqlType, PreparedStatement s)
			throws SQLException {
		if (null == val) {
			s.setNull(paramIdx, sqlType);
		} else {
			s.setTimestamp(paramIdx, val);
		}
	}

	public static void writeTime(Time val, int paramIdx, int sqlType, PreparedStatement s) throws SQLException {
		if (null == val) {
			s.setNull(paramIdx, sqlType);
		} else {
			s.setTime(paramIdx, val);
		}
	}

	public static void writeDate(Date val, int paramIdx, int sqlType, PreparedStatement s) throws SQLException {
		if (null == val) {
			s.setNull(paramIdx, sqlType);
		} else {
			s.setDate(paramIdx, val);
		}
	}

	public static void writeBigDecimal(BigDecimal val, int paramIdx, int sqlType, PreparedStatement s)
			throws SQLException {
		if (null == val) {
			s.setNull(paramIdx, sqlType);
		} else {
			s.setBigDecimal(paramIdx, val);
		}
	}
	
	 public static String getJDBCMethod(int sqlType) {
		    // Mappings taken from:
		    // http://java.sun.com/j2se/1.3/docs/guide/jdbc/getstart/mapping.html
		    if (sqlType == Types.INTEGER || sqlType == Types.SMALLINT || sqlType == Types.TINYINT
		    		) {
		      return "getInt";
		    } else if (sqlType == Types.VARCHAR || sqlType == Types.CHAR ||sqlType == Types.LONGVARCHAR
		    		||sqlType == Types.NVARCHAR ||sqlType == Types.NCHAR ||sqlType == Types.LONGNVARCHAR) {
		      return "String";
		    }  else if (sqlType == Types.NUMERIC || sqlType == Types.DECIMAL) {
		      return "getBigDecimal";
		    } else if (sqlType == Types.BIT || sqlType == Types.BOOLEAN) {
		      return "getBoolean";
		    } else if (sqlType == Types.BIGINT) {
		      return "getLong";
		    } else if (sqlType == Types.REAL) {
		      return "Float";
		    } else if (sqlType == Types.FLOAT) {
		      return "getFloat";
		    } else if (sqlType == Types.DOUBLE) {
		      return "getDouble";
		    } else if (sqlType == Types.DATE) {
		      return "getDate";
		    } else if (sqlType == Types.TIME) {
		      return "getTime";
		    } else if (sqlType == Types.TIMESTAMP) {
		      return "getTimestamp";
		    }  else if (sqlType == Types.BINARY
			        || sqlType == Types.VARBINARY||sqlType == Types.CLOB||sqlType == Types.BLOB
		        || sqlType == Types.LONGVARBINARY) {
		      return"String";
		    } else {
		      // TODO(aaron): Support DISTINCT, ARRAY, STRUCT, REF, JAVA_OBJECT.
		      // Return null indicating database-specific manager should return a
		      // java data type if it can find one for any nonstandard type.
		      return null;
		    }
		  }
	 
	 public static String toJavaType(int sqlType) {
		    // Mappings taken from:
		    // http://java.sun.com/j2se/1.3/docs/guide/jdbc/getstart/mapping.html
		    if (sqlType == Types.INTEGER) {
		      return "Integer";
		    } else if (sqlType == Types.VARCHAR) {
		      return "String";
		    } else if (sqlType == Types.CHAR) {
		      return "String";
		    } else if (sqlType == Types.LONGVARCHAR) {
		      return "String";
		    } else if (sqlType == Types.NVARCHAR) {
		      return "String";
		    } else if (sqlType == Types.NCHAR) {
		      return "String";
		    } else if (sqlType == Types.LONGNVARCHAR) {
		      return "String";
		    } else if (sqlType == Types.NUMERIC) {
		      return "java.math.BigDecimal";
		    } else if (sqlType == Types.DECIMAL) {
		      return "java.math.BigDecimal";
		    } else if (sqlType == Types.BIT) {
		      return "Boolean";
		    } else if (sqlType == Types.BOOLEAN) {
		      return "Boolean";
		    } else if (sqlType == Types.TINYINT) {
		      return "Integer";
		    } else if (sqlType == Types.SMALLINT) {
		      return "Integer";
		    } else if (sqlType == Types.BIGINT) {
		      return "Long";
		    } else if (sqlType == Types.REAL) {
		      return "Float";
		    } else if (sqlType == Types.FLOAT) {
		      return "Double";
		    } else if (sqlType == Types.DOUBLE) {
		      return "Double";
		    } else if (sqlType == Types.DATE) {
		      return "java.sql.Date";
		    } else if (sqlType == Types.TIME) {
		      return "java.sql.Time";
		    } else if (sqlType == Types.TIMESTAMP) {
		      return "java.sql.Timestamp";
		    }  else if (sqlType == Types.BINARY
			        || sqlType == Types.VARBINARY||sqlType == Types.CLOB||sqlType == Types.BLOB
		        || sqlType == Types.LONGVARBINARY) {
		      return"String";
		    } else {
		      // TODO(aaron): Support DISTINCT, ARRAY, STRUCT, REF, JAVA_OBJECT.
		      // Return null indicating database-specific manager should return a
		      // java data type if it can find one for any nonstandard type.
		      return null;
		    }
		  }
}
