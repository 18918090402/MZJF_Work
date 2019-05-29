package com.nonobank.bi.task;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.CollectionUtils;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.env.Environment;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.otter.canal.client.CanalConnector;
import com.alibaba.otter.canal.protocol.CanalEntry.Column;
import com.alibaba.otter.canal.protocol.CanalEntry.Entry;
import com.alibaba.otter.canal.protocol.CanalEntry.EntryType;
import com.alibaba.otter.canal.protocol.CanalEntry.EventType;
import com.alibaba.otter.canal.protocol.CanalEntry.RowChange;
import com.alibaba.otter.canal.protocol.CanalEntry.RowData;
import com.alibaba.otter.canal.protocol.Message;
import com.nonobank.bi.model.EventEntry;

import kafka.log.Log;

public class CanalClientTask extends CanalClientTaskBase {

	private static Logger LOGGER = LoggerFactory.getLogger(CanalClientTask.class);

	public CanalClientTask(CanalConnector connector, KafkaProducer<String, String> kafkaProducer, Environment env) {
		// TODO Auto-generated constructor stub
		super(connector, kafkaProducer, env);
	}

	/**
	 * Runnable
	 */
	@Override
	public void run() {
		long batchId = 0;
		long emptyCount = 0L;
		try {
			while (true) {
				Message message = consumeFromCanal(connector, batchSize);
				// 唯一标识
				batchId = message.getId();
				int size = message.getEntries().size();
				if (batchId == -1 || size == 0) {
					emptyCount++;
					try {
						LOGGER.debug(Thread.currentThread().toString() + ",EventEntry连续取空次数：{}", emptyCount);
						Thread.sleep(sleepTime);
					} catch (Exception e) {
						LOGGER.error(Thread.currentThread().toString() + ",{}", e);
					}
				} else {
					emptyCount = 0L;
					try {
						List<EventEntry> entryList = parseEntry(message);
						if (CollectionUtils.isNotEmpty(entryList)) {
							LOGGER.debug(Thread.currentThread().toString() + ",batchId ID:{},Parse Size:{}", batchId,
									entryList.size());
							producerToKafka(entryList, kafkaProducer);
							connector.ack(batchId); // 确认已经消费成功
						}
					} catch (Exception e) {
						LOGGER.error(Thread.currentThread().toString() + ",ERROR:{}", e);
						connector.rollback(batchId); // 回滚到上次的get请求，重新获取数据
					}
				}
			}
		} catch (Exception e) {
			LOGGER.error("{}", e);
			connector.rollback(batchId); // 处理失败, 回滚数据
		} finally {
			kafkaProducer.close();
			connector.unsubscribe();
			connector.disconnect();
		}
	}

	@Override
	public Message consumeFromCanal(CanalConnector connector, Integer batchSize) {
		return connector.getWithoutAck(batchSize);
	}

	/**
	 * 解析EventEntry entry
	 *
	 * @param List<Entry>
	 *            entrys
	 * @return boolean flag 当是true处理成功，false处理失败
	 */
	@Override
	protected List<EventEntry> parseEntry(Message message) throws Exception {
		List<EventEntry> eventEntryList = new ArrayList<EventEntry>();
		for (Entry entry : message.getEntries()) {
			if (entry.getEntryType() == EntryType.TRANSACTIONBEGIN
					|| entry.getEntryType() == EntryType.TRANSACTIONEND) {
				continue;
			}
			RowChange rowChage = RowChange.parseFrom(entry.getStoreValue());
			if (rowChage == null) {
				continue;
			}
			EventType eventType = rowChage.getEventType();
			if (eventType == null) {
				continue;
			}

			// JSONObject json = new JSONObject();
			// Gson gson = new
			// GsonBuilder().setPrettyPrinting().serializeNulls().create();

			for (RowData rowData : rowChage.getRowDatasList()) {
				EventEntry eventEntry = new EventEntry();
				eventEntry.setEventId(message.getId());// 批次ID
				eventEntry.setServerId(entry.getHeader().getServerId());// 服务器ID
				eventEntry.setEventType(eventType.name());// 事件类型
				eventEntry.setPosition(entry.getHeader().getLogfileOffset());// 文件位置
				eventEntry.setSchemaName(entry.getHeader().getSchemaName());// 数据库名
				eventEntry.setTableName(entry.getHeader().getTableName());// 表名
				// table/drop
				// table]
				eventEntry.setTimestamp(entry.getHeader().getExecuteTime());// [EventEntry里记录变更发生的时间戳,精确到秒]
				List<Column> beforeColumns = rowData.getBeforeColumnsList();
				List<Column> afterColumns = rowData.getAfterColumnsList();
				eventEntry.setBefore(MapColumn(beforeColumns, eventType, "before"));
				eventEntry.setAfter(MapColumn(afterColumns, eventType, "after"));
				eventEntryList.add(eventEntry);
				// String content = json.toJSONString(entry);
				// String content=gson.toJson(entry).toString();
				// System.out.println(content);
				// flag = producerToKafka(dbname + "_" + tbname, content);
			}
			// if (!(rowChage.getRowDatasList().size() > 0)) {
			// // String content = gson.toJson(entry).toString();
			// String content = json.toJSONString(entry);
			// System.out.println(content);
			// flag = producerToKafka(dbname + "_" + tbname, content);
			// }
		}
		return eventEntryList;
	}

	/**
	 * 把消息发送到kafka
	 * 
	 * @param topic
	 *            topic名称默认是tablename
	 * @param content
	 *            发送的内容
	 * @return void
	 */
	@Override
	protected void producerToKafka(List<EventEntry> entryList, KafkaProducer<String, String> kafkaProducer)
			throws Exception {
		Integer successCNT = 0;
		for (EventEntry entry : entryList) {
			String TOPIC = "canal." + entry.getSchemaName() + "." + entry.getTableName(); // kafka创建的topic

			String CONTENT = JSONObject.toJSONString(entry); // 要发送的内容
			ProducerRecord<String, String> message = new ProducerRecord<String, String>(TOPIC, null, CONTENT);
			kafkaProducer.send(message);

			LOGGER.info("topic:{},message:{}", TOPIC, entry);
			// ProducerRecord<String, EventEntry> message = new ProducerRecord<String,
			// EventEntry>(TOPIC, null, entry);
			// kafkaProducer.send(message);
			successCNT++;
		}
		LOGGER.debug(kafkaProducer.toString() + ",all size:{},success produce size:{}", entryList.size(), successCNT);
	}

	/**
	 * 处理表的字段和对应的值
	 *
	 * @param List<Column>
	 * @return Map<String,String>
	 */
	private static Map<String, String> MapColumn(List<Column> columns, EventType eventType, String type) {
		Map<String, String> map = new HashMap<>();
		try {
			for (Column column : columns) {
				if (column.getValue() == null) {
					map.put(column.getName(), "");
				}
				// 当Event是update时只取update的字段和主键key
				else if (eventType == EventType.UPDATE && (column.getUpdated() || column.getIsKey())
						&& "after".equals(type)) {
					map.put(column.getName(), column.getValue());
				} else if (eventType != EventType.UPDATE || "before".equals(type)) {
					map.put(column.getName(), column.getValue());
				}
			}
		} catch (Exception e) {
			throw new RuntimeException("ERROR ## parser of eromanga-event has an error , data:" + columns.toString(),
					e);
		}
		return map;
	}
}