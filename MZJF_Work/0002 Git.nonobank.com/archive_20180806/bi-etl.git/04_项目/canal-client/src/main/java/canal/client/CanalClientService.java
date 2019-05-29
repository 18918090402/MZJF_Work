package canal.client;

import java.net.InetSocketAddress;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.kafka.clients.producer.KafkaProducer;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.otter.canal.client.CanalConnector;
import com.alibaba.otter.canal.client.CanalConnectors;
import com.alibaba.otter.canal.protocol.CanalEntry.Column;
import com.alibaba.otter.canal.protocol.CanalEntry.Entry;
import com.alibaba.otter.canal.protocol.CanalEntry.EntryType;
import com.alibaba.otter.canal.protocol.CanalEntry.EventType;
import com.alibaba.otter.canal.protocol.CanalEntry.RowChange;
import com.alibaba.otter.canal.protocol.CanalEntry.RowData;
import com.alibaba.otter.canal.protocol.Message;

import canal.client.entry.EventEntry;
import canal.client.util.ConvertUtil;
import canal.client.util.PropertiesUtil;

public class CanalClientService{
	private String destinationName;
	private boolean running=true;
	private CanalConnector connector = null;
	
	//获取kafka生产者连接
	private KafkaProducer<String, String> producer=Producer.connectKafka();
	//获取订阅列表信息
	private HashMap<String, String> canalMap =null;
	//获取canal实例订阅的表信息
	HashMap<String, Map<String,String>> tableInfo=null;

	public CanalClientService(String destinationName) {
		this.destinationName=destinationName;
		StartCanal(destinationName);
	}

	public boolean StartCanal(String destinationName) {
		running=true;
		canalMap = GetTableConfig.getCanalData(destinationName);
		tableInfo=GetTableConfig.getTableInfo(destinationName);
		Properties prop=PropertiesUtil.loadProperty("canal.properties");
		refreshConfigInfo();
		String CANAL_SERVER_HOST = prop.getProperty("CANAL_SERVER_HOST");
		String CANAL_SERVER_PORT = prop.getProperty("CANAL_SERVER_PORT");
		String CANAL_ZOOKEEPER_QUORUM = prop.getProperty("CANAL_ZOOKEEPER_QUORUM");
		String CANAL_SERVER_MODEL = prop.getProperty("CANAL_SERVER_MODEL");
		String CANAL_SERVER_DESTINATION = destinationName;
		String CANAL_SLEEPTIME = prop.getProperty("CANAL_SLEEPTIME");
		String CANAL_BATCH_SIZE = prop.getProperty("CANAL_BATCH_SIZE");
		//订阅列表
		String TABLE_SUBSCRIBE = canalMap.get("TABLE_SUBSCRIBE");
		
		boolean flag = true;
		
		// 单机环境
		if ("stand-alone".equals(CANAL_SERVER_MODEL)) {
			connector = CanalConnectors.newSingleConnector(
					new InetSocketAddress(CANAL_SERVER_HOST, Integer.valueOf(CANAL_SERVER_PORT)),
					CANAL_SERVER_DESTINATION, "", "");
		
		// 基于zookeeper的集群环境
		} else if ("HA".equals(CANAL_SERVER_MODEL)) {
			connector = CanalConnectors.newClusterConnector(CANAL_ZOOKEEPER_QUORUM, CANAL_SERVER_DESTINATION, "", "");
		}
		if (connector != null) {
			long batchId = 0;
			try {
				connector.connect();
				connector.subscribe(TABLE_SUBSCRIBE);// 使用正则订阅需要解析表的binlog
//				connector.subscribe(".*\\..*");// 使用正则订阅需要解析表的binlog
				connector.rollback();// 回滚到未进行 ack 的地方，下次fetch的时候，可以从最后一个没有ack的地方开始拿				
				while (running) {
					/*
					 * 不指定 position 获取事件，该方法返回的条件: 尝试拿batchSize条记录，有多少取多少，不会阻塞等待
					 * canal 会记住此 client 最新的position。
					 */
					Message message = connector.getWithoutAck(Integer.valueOf(CANAL_BATCH_SIZE));
//					System.out.println(message);
					batchId = message.getId();
					int size = message.getEntries().size();
					if (batchId == -1 || size == 0) {
						try {
							canalMap = GetTableConfig.getCanalData(destinationName);
							tableInfo=GetTableConfig.getTableInfo(destinationName);
							Thread.sleep(Integer.valueOf(CANAL_SLEEPTIME));
						} catch (Exception e) {
							connector.rollback(batchId); // 处理失败, 回滚数据
						}
					} else {
						canalMap.put("BATCH_ID", String.valueOf(batchId));
						flag = parseEntry(message.getEntries(),batchId);
					}
					if (flag) {
						connector.ack(batchId); // 确认已经消费成功
					} else {
						connector.rollback(batchId); // 处理失败, 回滚数据
					}
				}
			} catch (Exception e) {
				connector.rollback(batchId); // 处理失败, 回滚数据
				e.printStackTrace();
			} finally {
				connector.disconnect();
			}
		}
		return flag;
	}

	/**
	 * 解析binlog entry
	 *
	 * @param List<Entry>
	 *            entrys
	 * @return boolean flag 当是true处理成功，false处理失败
	 */
	private boolean parseEntry(List<Entry> entrys,long batchId) {
		boolean flag = true;
		RowChange rowChage = null;
		for (Entry entry : entrys) {
			if (entry.getEntryType() == EntryType.TRANSACTIONBEGIN
					|| entry.getEntryType() == EntryType.TRANSACTIONEND) {
				continue;
			}
			try {
				rowChage = RowChange.parseFrom(entry.getStoreValue());
				flag = onEvents(rowChage, entry,batchId);
			} catch (Exception e) {
				flag = false;
				throw new RuntimeException("ERROR ## parser of eromanga-event has an error , data:" + entry.toString(),
						e);
			}
		}
		return flag;
	}

	/**
	 * 根据不同的EventType进行处理
	 *
	 * @param RowChange
	 *            rowChage
	 * @param Entry
	 *            entrys
	 * @return boolean flag 当是true处理成功，false处理失败
	 */
	public  boolean onEvents(RowChange rowChage, Entry entrys,long batchId) {
		String TABLE_PRIMARY_KEY = "";
		String TABLE_FIELD_LIST = "";
		String TABLE_TOPIC_KEY = "";
		String TABLE_TOPIC_NAME = "";
		
		boolean flag = true;
		try {
			JSONObject json = new JSONObject();
			if (rowChage == null) {
				System.out.println("binlog event is null");
				return flag;
			}

			EventType eventType = rowChage.getEventType();
			EventEntry entry = new EventEntry();
			entry.setEventId(batchId);// 批次ID
			entry.setServerId(entrys.getHeader().getServerId());// 服务器ID
			entry.setBinlogName(entrys.getHeader().getLogfileName());// 文件名
			entry.setEventType(eventType.name());// 事件类型
			entry.setPosition(entrys.getHeader().getLogfileOffset());// 文件位置
			entry.setServerName(destinationName);// 数据库名
			entry.setSchemaName(entrys.getHeader().getSchemaName());// 数据库名
			entry.setTableName(entrys.getHeader().getTableName());// 表名
			entry.setDdl(rowChage.getIsDdl());// [是否是ddl变更操作，比如create table/droptable]
			entry.setSql(rowChage.getSql());// [具体的ddl sql]
			entry.setTimestamp(entrys.getHeader().getExecuteTime());// [binlog里记录变更发生的时间戳,精确到秒]
			String TABLE_SUBSCRIBE = (entrys.getHeader().getSchemaName()+'.'+entrys.getHeader().getTableName()).toLowerCase();
			String tableList = destinationName+"."+TABLE_SUBSCRIBE;
//			
			String tables=canalMap.get("TABLE_LIST");
			if(tables != null&&(!"".equals(tables)) && (!tables.isEmpty())){
				Set<String> tableSubListSet=ConvertUtil.StringToSet(canalMap.get("TABLE_LIST"), ",");
				if(!tableSubListSet.contains(tableList.toLowerCase())){
					return flag;
				}
			}else{
				return flag;
			}
			
			//给每张表设置一个搜索主键canal实例id+表名
			String tbp=destinationName+"."+TABLE_SUBSCRIBE;
			HashMap<String,String> map=(HashMap<String, String>) tableInfo.get(tbp);
			TABLE_PRIMARY_KEY=map.get("PRIMARY_KEY");
			TABLE_FIELD_LIST=map.get("FIELD_LIST");
			TABLE_TOPIC_KEY=map.get("TOPIC_KEY");
			TABLE_TOPIC_NAME=map.get("TOPIC_NAME");
			
//			entry.setTableID(Integer.parseInt(map.get("ID")));//订阅表的ID
			if (eventType == null || "".equals(eventType)) {
				System.out.println("binlog event is null");
				return flag;
			}
			
			for (RowData rowData : rowChage.getRowDatasList()) {
				List<Column> beforeColumns = rowData.getBeforeColumnsList();
				List<Column> afterColumns = rowData.getAfterColumnsList();
				List<Column> columns=beforeColumns;
					if(beforeColumns==null||beforeColumns.size()==0){
						columns=afterColumns;
					}
				entry.setBefore(MapColumn(beforeColumns, eventType, "before",TABLE_PRIMARY_KEY,TABLE_FIELD_LIST,TABLE_TOPIC_KEY));
				entry.setAfter(MapColumn(afterColumns, eventType, "after",TABLE_PRIMARY_KEY,TABLE_FIELD_LIST,TABLE_TOPIC_KEY));
				entry.setPrimaryKey(MapColumn(columns, eventType, "primaryKey",TABLE_PRIMARY_KEY,TABLE_FIELD_LIST,TABLE_TOPIC_KEY));
				String content = json.toJSONString(entry);
				System.out.println(content);
				map.put("KAFKA_CONTENT", content);
				map.put("KAFKA_TOPIC", TABLE_TOPIC_NAME);
				String kafkaTopicKey=MapColumn(columns, eventType, "kafkaTopicKey",TABLE_PRIMARY_KEY,TABLE_FIELD_LIST,TABLE_TOPIC_KEY).get("KAFKA_TOPIC_KEY");
				map.put("KAFKA_TOPIC_KEY", kafkaTopicKey);
				if(producer==null){
					producer=Producer.connectKafka();
				}
				flag = Producer.sendMessage(map, producer);

			}
			if (!(rowChage.getRowDatasList().size() > 0)) {
				//String content = gson.toJson(entry).toString();
				String content = json.toJSONString(entry);
				System.out.println(content);
				map.put("KAFKA_CONTENT", content);
				map.put("KAFKA_TOPIC", TABLE_TOPIC_NAME);
				map.put("KAFKA_TOPIC_KEY", "");
				if(producer==null){
					producer=Producer.connectKafka();
				}
				flag = Producer.sendMessage(map, producer);
			}
		} catch (Exception e) {
			flag = false;
			throw new RuntimeException("ERROR ## parser of eromanga-event has an error , data:" + entrys.toString(), e);
		}
		return flag;
	}

	/**
	 * 处理表的字段和对应的值
	 *
	 * @param List<Column>
	 * @return Map<String,String>
	 */
	private Map<String, String> MapColumn(List<Column> columns, EventType eventType,String type,String primaryKey,String fieldList,String topicKey) {
		
		Set<String> primaryKeySet=null;
		if(primaryKey != null&&(!"".equals(primaryKey)) && (!primaryKey.isEmpty())){
			primaryKeySet=ConvertUtil.StringToSet(primaryKey, ",");
		}
		Set<String> fieldListSet=null;
		if(fieldList != null&&(!"".equals(fieldList)) && (!fieldList.isEmpty())){
			fieldListSet=ConvertUtil.StringToSet(fieldList, ",");
		}
		Map<String, String> map = new HashMap<String, String>();
		Map<String, String> primaryMap = new HashMap<String, String>();
		Map<String, String> kafkaTopicKey = new HashMap<String, String>();
		try {
			for (Column column : columns) {
				String columnName=column.getName().toLowerCase();
				if(fieldListSet==null){
					map.put(column.getName(), column.getValue());
					if (primaryKeySet.contains(columnName)) {
						primaryMap.put(column.getName(), column.getValue());
					}
					if(columnName.equals(topicKey)){
						kafkaTopicKey.put("KAFKA_TOPIC_KEY", column.getValue());
					}
				}
				else if (fieldListSet!=null&&fieldListSet.contains(columnName)&&column.getValue() == null) {
					map.put(column.getName(), column.getValue());
					if (primaryKeySet.contains(columnName)) {
						primaryMap.put(column.getName(), column.getValue());
					}
					if(columnName.equals(topicKey)){
						kafkaTopicKey.put("KAFKA_TOPIC_KEY", column.getValue());
					}
				}
			}

		} catch (Exception e) {
			throw new RuntimeException("ERROR ## parser of eromanga-event has an error , data:" + columns.toString(),e);
		}
		if("primaryKey".equals(type)){
			return primaryMap;
		}
		if("kafkaTopicKey".equals(type)){
			return kafkaTopicKey;
		}
		return map;
	}
	
	/*每隔10分钟刷新配置表信息*/
	public void refreshConfigInfo(){
		Timer timer = new Timer();
	    timer.schedule(new TimerTask() {
	      public void run() {
	    	System.out.println("------------开始刷新配置表信息-----------");
	    	canalMap = GetTableConfig.getCanalData(destinationName);
			tableInfo=GetTableConfig.getTableInfo(destinationName);
			System.out.println("------------完成刷新配置表信息-----------");
	      }
	    },0,100000);// 设定指定的时间time,此处为600000毫秒=10分钟
	}
}
