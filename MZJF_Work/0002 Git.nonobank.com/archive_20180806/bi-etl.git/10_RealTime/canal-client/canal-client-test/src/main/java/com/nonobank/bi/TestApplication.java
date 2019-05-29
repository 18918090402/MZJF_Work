package com.nonobank.bi;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.TopicPartition;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.core.env.Environment;

import com.nonobank.bi.config.UserProfile;
import com.nonobank.bi.model.Binlog;

import kafka.consumer.ConsumerIterator;
import kafka.consumer.KafkaStream;
import kafka.javaapi.consumer.ConsumerConnector;


@SpringBootApplication
@EnableAutoConfiguration(exclude = { DataSourceAutoConfiguration.class, HibernateJpaAutoConfiguration.class })
public class TestApplication implements CommandLineRunner {

	private Logger LOGGER = LoggerFactory.getLogger(TestApplication.class);
	
	@Autowired
	private Environment env;
	@Autowired
	private KafkaConsumer<String,Binlog> kafkaConsumer;
	@Autowired
	private ConsumerConnector connector;
	
	public static void main(String[] args) throws Exception {
		if (System.getProperty("spring.profiles.active") == null) {
			System.setProperty("spring.profiles.active", UserProfile.INTG);
		}
		SpringApplication.run(TestApplication.class, args);
	}
	
	private void path1(){
		ExecutorService executor = Executors.newFixedThreadPool(4);
		//每个topic的分区数
		Map<String, Integer> topicCountMap = new HashMap<String, Integer>();
		// We always have just one topic being read by one thread
		for(String topic:env.getProperty("consumer.topics").split(",")){
			topicCountMap.put(topic, 1);
		}
		Map<String, List<KafkaStream<byte[], byte[]>>> streamsMap = connector.createMessageStreams(topicCountMap);
		
		for(String topic:streamsMap.keySet()){
			//每个topic的分区数
			List<KafkaStream<byte[], byte[]>> streams = streamsMap.get(topic);
			for(KafkaStream<byte[], byte[]> stream:streams){
				while(true){
					ConsumerIterator<byte[], byte[]> it =stream.iterator();
					//一条条取数据，会阻塞
					while(it.hasNext()){
						LOGGER.info("message:{}",it.next().message());
					}
				}
			}
		}
	}

	@Override
	public void run(String... args) throws Exception {
			for(TopicPartition p:kafkaConsumer.assignment()){
				LOGGER.info("topic:{},partition:{}",p.topic(),p.partition());
			}
			while(true){
				ConsumerRecords<String, Binlog> records = kafkaConsumer.poll(1);
				for (ConsumerRecord<String, Binlog> record : records){
					System.out.printf("offset = %d, key = %s, value = %s%n", record.offset(), record.key(), record.value());
				}
			}
	}
}