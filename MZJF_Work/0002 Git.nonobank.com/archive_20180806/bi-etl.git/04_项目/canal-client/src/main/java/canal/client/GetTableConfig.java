package canal.client;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import canal.client.util.DBConnector;

public class GetTableConfig {
	public static HashMap<String, String> getCanalData(String destinationName){
		HashMap<String, String> tableListMap =new HashMap<String,String>();
		String canalSQL = null;
		DBConnector db1 = null;
		ResultSet rs = null;
		//获取每个canal实例对应的订阅表
		canalSQL = "SELECT CANAL_DESTINATION_ID, CANAL_DESTINATION_NAME"
				+ ",group_concat(trim(TABLE_SCHEMA),'.',trim(TABLE_NAME)) as TABLE_SUBSCRIBE"
				+ ",group_concat(CANAL_DESTINATION_NAME,'.',trim(TABLE_SCHEMA),'.',trim(TABLE_NAME)) as TABLE_LIST"
				+ " FROM ETL.CANAL_SUBSCRIBE_TABLE AS A"
				+ " WHERE A.IS_VALID=1 ";// SQL语句
			
		if((!"".equals(destinationName))&&destinationName!=null){
			canalSQL+=" AND A.CANAL_DESTINATION_NAME='"+destinationName+"'";
		}
		canalSQL+=" GROUP BY CANAL_DESTINATION_ID, CANAL_DESTINATION_NAME";
		db1 = new DBConnector(canalSQL);// 创建DBHelper对象
		try {
			rs = db1.pst.executeQuery();// 执行语句，得到结果集
			while (rs.next()) {
				//HashMap<String, String> tableMap=new HashMap<String, String>();
				tableListMap.put("CANAL_DESTINATION_ID", rs.getString("CANAL_DESTINATION_ID"));
				tableListMap.put("CANAL_DESTINATION_NAME", rs.getString("CANAL_DESTINATION_NAME"));
				tableListMap.put("TABLE_SUBSCRIBE",rs.getString("TABLE_SUBSCRIBE").toLowerCase());
				tableListMap.put("TABLE_LIST",rs.getString("TABLE_LIST").toLowerCase());
			} // 显示数据
			rs.close();
			db1.close();// 关闭连接
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tableListMap;
	
	}
	
	public static HashMap<String, Map<String,String>> getTableInfo(String destinationName){
		HashMap<String, Map<String,String>> tableListMap = new HashMap<String, Map<String,String>>();
		DBConnector db1 = null;
		ResultSet rs = null;
		//获取每个canal实例对应的订阅表的详细信息
		String tableSQL="SELECT ID, CANAL_DESTINATION_ID, CANAL_DESTINATION_NAME"
				+ ",SERVER_NAME,TABLE_SCHEMA,TABLE_NAME,PRIMARY_KEY"
				+ ", FIELD_LIST,TOPIC_KEY,TOPIC_NAME, PARTITIONS_NUM"
				+ " FROM ETL.CANAL_SUBSCRIBE_TABLE AS A"
				+ " WHERE A.IS_VALID=1";// SQL语句
		
		if((!"".equals(destinationName))&&destinationName!=null){
			tableSQL+=" AND A.CANAL_DESTINATION_NAME='"+destinationName+"'";
		}
		db1 = new DBConnector(tableSQL);// 创建DBHelper对象
		try {
			rs = db1.pst.executeQuery();// 执行语句，得到结果集
			while (rs.next()) {
				HashMap<String, String> tableMap=new HashMap<String, String>();
				tableMap.put("ID", rs.getString("ID"));
				tableMap.put("CANAL_DESTINATION_ID", rs.getString("CANAL_DESTINATION_ID"));
				tableMap.put("CANAL_DESTINATION_NAME", rs.getString("CANAL_DESTINATION_NAME"));
				String fromServerName=rs.getString("SERVER_NAME");
				tableMap.put("SERVER_NAME", fromServerName);
				String fromTbSchema=rs.getString("TABLE_SCHEMA");
				tableMap.put("TABLE_SCHEMA", fromTbSchema);
				String fromTbName=rs.getString("TABLE_NAME");
				tableMap.put("TABLE_NAME", fromTbName);
				tableMap.put("PRIMARY_KEY", rs.getString("PRIMARY_KEY"));
				tableMap.put("FIELD_LIST", rs.getString("FIELD_LIST"));
				tableMap.put("TOPIC_NAME", rs.getString("TOPIC_NAME"));
				tableMap.put("PARTITIONS_NUM", rs.getString("PARTITIONS_NUM"));
				tableMap.put("TOPIC_KEY", rs.getString("TOPIC_KEY"));
				String TABLE_SUBSCRIBE="";
				if(fromTbSchema!=null&&fromTbName!=null&&!"".equals(fromTbSchema)&&!"".equals(fromTbName)){
					TABLE_SUBSCRIBE=(fromServerName.trim()+"."+fromTbSchema.trim()+"."+fromTbName.trim()).toLowerCase();
				}
				tableMap.put("TABLE_SUBSCRIBE", TABLE_SUBSCRIBE);
				//给每张表设置一个搜索主键canal实例id+表名
				//String tbp=rs.getString("SERVER_NAME")+"_"+TABLE_SUBSCRIBE;
				tableListMap.put(TABLE_SUBSCRIBE,tableMap);
			} // 显示数据
			rs.close();
			db1.close();// 关闭连接
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tableListMap;
	
	}
}
