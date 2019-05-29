package com.nonobank.bi.task;

import java.util.List;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.env.Environment;

import com.alibaba.otter.canal.client.CanalConnector;
import com.alibaba.otter.canal.protocol.Message;
import com.nonobank.bi.model.EventEntry;

public abstract class CanalClientTaskBase implements Runnable  {
	
		private static Logger LOGGER = LoggerFactory.getLogger(CanalClientTaskBase.class);
		protected CanalConnector connector;
		protected KafkaProducer<String, String> kafkaProducer;
		protected Environment env;
		protected int batchSize;
		protected Long sleepTime;
		
		public CanalClientTaskBase(CanalConnector connector, KafkaProducer<String, String> kafkaProducer, Environment env){
			this.connector=connector;
			this.kafkaProducer=kafkaProducer;
			this.env=env;
			init();
		}
		/**
		 * 初始化操作
		 */
		public void init(){
			batchSize = Integer.valueOf(env.getProperty("canal.fetch.batchsize"));// 每批次拿取的数量
			sleepTime = Long.valueOf(env.getProperty("canal.sleeptime"));
			LOGGER.info("canal.fetch.batchsize:{},canal.sleeptime:{}",batchSize,sleepTime);
		}
		
		/**
		 * 从canal消费数据，每次取batchSize数量的消息
		 * @param batchSize
		 * @return
		 */
		protected abstract Message consumeFromCanal(CanalConnector connector,Integer batchSize);
		
		/**
		 * 解析binlog entry
		 *
		 * @param List<Entry>
		 *            entrys
		 * @return boolean flag 当是true处理成功，false处理失败
		 */
		protected abstract List<EventEntry> parseEntry(Message message) throws Exception;
		
		/**
		 * 把消息发送到kafka
		 * 
		 * @param topic
		 *            topic名称默认是tablename
		 * @param content
		 *            发送的内容
		 * @return void
		 */
		protected abstract void producerToKafka(List<EventEntry> entryBOList,KafkaProducer<String, String> kafkaProducer) throws Exception;
		
		
}