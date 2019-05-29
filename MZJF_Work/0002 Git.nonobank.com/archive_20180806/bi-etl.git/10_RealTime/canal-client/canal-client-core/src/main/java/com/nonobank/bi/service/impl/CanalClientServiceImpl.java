package com.nonobank.bi.service.impl;

import java.util.List;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import com.alibaba.otter.canal.client.CanalConnector;
import com.nonobank.bi.service.CanalClientService;
import com.nonobank.bi.task.CanalClientTask;
import com.nonobank.bi.task.CanalClientTaskBase;

@Service
public class CanalClientServiceImpl implements CanalClientService {
	private static Logger LOGGER = LoggerFactory.getLogger(CanalClientServiceImpl.class);
 
	@Autowired
	private ThreadPoolTaskExecutor threadPool;
	
	@Autowired
	private List<KafkaProducer<String, String>> kafkaProducerList;
	
	@Autowired
	private List<CanalConnector> connectorList;
	
	@Autowired
	private Environment env;
	
	public void canalMain() {
		for(int i=0;i<=connectorList.size()-1;i++){
			LOGGER.info("begin :{}",i);
			CanalClientTaskBase task =new CanalClientTask(connectorList.get(i), kafkaProducerList.get(i),env);
			threadPool.execute(task);
		}
	}
}