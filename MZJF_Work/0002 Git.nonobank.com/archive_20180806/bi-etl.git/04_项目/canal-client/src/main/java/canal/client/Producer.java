package canal.client;

import java.util.HashMap;
import java.util.Properties;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.security.JaasUtils;

import canal.client.util.PropertiesUtil;
import kafka.admin.AdminUtils;
import kafka.admin.RackAwareMode;
import kafka.utils.ZkUtils;

/**
 * 发送消息到kafka
 * 
 */
public class Producer {
	
	/**
	 * 创建kafka producer连接
	 **/
	public static KafkaProducer<String, String> connectKafka() {
		KafkaProducer<String, String> producer = null;
		Properties kafkaProp=PropertiesUtil.loadProperty("kafka.properties");
		try {
			Properties props = new Properties();
			props.put("bootstrap.servers", kafkaProp.getProperty("bootstrap.servers"));// 该地址是集群的子集，用来探测集群。
			props.put("key.serializer", kafkaProp.getProperty("key.serializer"));// 序列化的方式
			props.put("value.serializer", kafkaProp.getProperty("value.serializer"));// 序列化的方式
			props.put("acks", kafkaProp.getProperty("acks"));// 记录完整提交，最慢的但是最大可能的持久化
			props.put("retries", kafkaProp.getProperty("retries"));// 请求失败重试的次数
			props.put("batch.size", kafkaProp.getProperty("batch.size"));// batch的大小
			props.put("linger.ms", kafkaProp.getProperty("linger.ms"));// 默认情况即使缓冲区有剩余的空间，也会立即发送请求，设置一段时间用来等待从而将缓冲区填的更多，单位为毫秒，producer发送数据会延迟1ms，可以减少发送到kafka服务器的请求数据
			props.put("buffer.memory", kafkaProp.getProperty("buffer.memory"));// 提供给生产者缓冲内存总量
			props.put("partitioner.class", kafkaProp.getProperty("partitioner.class"));// 设置属性 自定义分区类

			producer = new KafkaProducer<String, String>(props);

		} catch (Exception e) {
			throw new RuntimeException("ERROR ## CREATE KafkaProducer FAILE:"+e);
		}
		return producer;

	}

	/**
	 * topic不存在时创建topic
	 **/
	public static boolean createTopic(String topic, int numPartitions) {
		Properties kafkaProp=PropertiesUtil.loadProperty("kafka.properties");
		ZkUtils zkUtils = ZkUtils.apply(kafkaProp.getProperty("zookeeper.servers"), 30000, 30000,
				JaasUtils.isZkSecurityEnabled());
		// 创建4个单分区单副本名为t1的topic
		if (!AdminUtils.topicExists(zkUtils, topic))
			AdminUtils.createTopic(zkUtils, topic, 4/* partitions */,
					2/* replication factor */, new Properties(), RackAwareMode.Enforced$.MODULE$);
		zkUtils.close();
		return true;
	}

	/**
	 * 把消息发送到kafka
	 * 
	 * @param topic
	 *            名称默认是serverName_schemaName_tablename
	 * @param content
	 *            发送的内容
	 * @return boolean
	 */
	public static boolean sendMessage(HashMap<String, String> canalMap,KafkaProducer<String, String> producer) {
		boolean flag=true;
		String topic = canalMap.get("KAFKA_TOPIC"); // kafka创建的topic
		String key = canalMap.get("KAFKA_TOPIC_KEY"); // key
		String content = canalMap.get("KAFKA_CONTENT"); // 要发送的内容
		//int numPartitions = Integer.parseInt(canalMap.get("PARTITIONS_NUM")); // topic分区数
		try {
			//Producer.createTopic(topic, numPartitions);
			// Send message.
			ProducerRecord<String, String> message = new ProducerRecord<String, String>(topic, key, content);
			producer.send(message);
		} catch (Exception e) {
			flag = false;
			throw new RuntimeException("ERROR ## send message to kafka fail, data:" + content, e);
		}
		return flag;
	}
	
	public static void main(String[] args) {
		Producer.connectKafka();
	}
}
