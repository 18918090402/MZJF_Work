package com.nonobank.bi.config;

import java.util.Map;

import org.apache.kafka.clients.producer.Partitioner;
import org.apache.kafka.common.Cluster;

public class SimplePartitioner implements Partitioner {

	@Override
	public void configure(Map<String, ?> configs) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int partition(String topic, Object key, byte[] keyBytes, Object value, byte[] valueBytes, Cluster cluster) {
		// TODO Auto-generated method stub
		return Integer.valueOf((Integer)key);
	}

	@Override
	public void close() {
		// TODO Auto-generated method stub
		
	}
  
}