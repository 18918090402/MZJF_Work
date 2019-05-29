package com.nonobank.bi.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import com.alibaba.otter.canal.client.CanalConnector;

@Configuration
public class ThreadPoolConfig {
	
	@Autowired
	List<CanalConnector> connectorList;
	@Bean
	public ThreadPoolTaskExecutor getThreadPoolTaskExecutor(){
		ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();
		taskExecutor.setCorePoolSize(connectorList.size());
		taskExecutor.setQueueCapacity(1000);
		taskExecutor.setKeepAliveSeconds(3000);
		taskExecutor.setMaxPoolSize(50);
		return taskExecutor;
	}
}