package canal.client.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

public class DBConnector {

	public Connection conn = null;
	public PreparedStatement pst = null;

	Properties prop = PropertiesUtil.loadProperty("system.properties");
	String name = prop.getProperty("MYSQL_DRIVER");
	String url = prop.getProperty("MYSQL_JDBC_URL");
	String user = prop.getProperty("MYSQL_USER");
	String password = prop.getProperty("MYSQL_PWD");

	public DBConnector(String sql) {
		try {
			Class.forName(name);// 指定连接类型
			conn = DriverManager.getConnection(url, user, password);// 获取连接
			pst = conn.prepareStatement(sql);// 准备执行语句
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			this.conn.close();
			this.pst.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		String sql = null;
		DBConnector db1 = null;
		ResultSet rs = null;
		sql = "SELECT ID, CANAL_DESTINATION_ID, CANAL_DESTINATION_NAME"
				+ ",SERVER_NAME,TABLE_SCHEMA,TABLE_NAME,PRIMARY_KEY"
				+ ", FIELD_LIST, PARTITIONS_NUM"
				+ " FROM ETL.CANAL_SUBSCRIBE_TABLE AS A"
				+ " WHERE A.IS_VALID=1;";// SQL语句
		
		db1 = new DBConnector(sql);// 创建DBHelper对象
		List<HashMap<String, String>> tableListMap = new ArrayList<HashMap<String, String>>();
		try {
			rs = db1.pst.executeQuery();// 执行语句，得到结果集
			while (rs.next()) {
				HashMap<String, String> tableMap=new HashMap<String, String>();
				tableMap.put("ID", rs.getString("ID"));
				tableMap.put("CANAL_DESTINATION_ID", rs.getString("CANAL_DESTINATION_ID"));
				tableMap.put("CANAL_DESTINATION_NAME", rs.getString("CANAL_DESTINATION_NAME"));
				tableMap.put("SERVER_NAME", rs.getString("SERVER_NAME"));
				tableMap.put("TABLE_SCHEMA", rs.getString("TABLE_SCHEMA"));
				tableMap.put("TABLE_NAME", rs.getString("TABLE_NAME"));
				tableMap.put("PRIMARY_KEY", rs.getString("PRIMARY_KEY"));
				tableMap.put("FIELD_LIST", rs.getString("FIELD_LIST"));
				tableMap.put("PARTITIONS_NUM", rs.getString("PARTITIONS_NUM"));
				tableListMap.add(tableMap);
			} // 显示数据
			rs.close();
			db1.close();// 关闭连接
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(tableListMap.size());
	}
}
