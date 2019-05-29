package com.nonobank.bi.config;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.env.AbstractEnvironment;
import org.springframework.core.env.Environment;
import org.springframework.core.env.PropertySource;

import com.nonobank.bi.model.Binlog;

import kafka.consumer.Consumer;
import kafka.consumer.ConsumerConfig;
import kafka.javaapi.consumer.ConsumerConnector;

@Configuration
public class KafkaConfig {

	private final static Logger LOGGER = LoggerFactory.getLogger(KafkaConfig.class);
	
	private static String prefix="kafka.";
	@Configuration
	@Profile(UserProfile.INTG)
	@org.springframework.context.annotation.PropertySource("classpath:/intg/kafka.properties")
	class AppConfigIntgConfiguration {
	}

	@Configuration
	@Profile(UserProfile.PROD)
	@org.springframework.context.annotation.PropertySource("classpath:/prod/kafka.properties")
	class AppConfigProdConfiguration {
	}

	@Autowired
	private Environment env;
	
	@Bean
	public ConsumerConnector getKafkaConsumerConnector() {
		Properties properties = new Properties();
		Map<String, Object> map = new HashMap<String, Object>();
		for (Iterator<PropertySource<?>> it = ((AbstractEnvironment) env).getPropertySources().iterator(); it
				.hasNext();) {
			PropertySource<?> propertySource = it.next();
		}
		properties.putAll(map);
		ConsumerConfig consumerConfig = new ConsumerConfig(properties);
		ConsumerConnector consumer = Consumer.createJavaConsumerConnector(consumerConfig);
		return consumer;
	}
	
	@Bean
	public KafkaConsumer<String,Binlog> getKafkaConsumer() {
		Properties properties = new Properties();
		Map<String, Object> map = new HashMap<String, Object>();
		for (Iterator<PropertySource<?>> it = ((AbstractEnvironment) env).getPropertySources().iterator(); it
				.hasNext();) {
			PropertySource<?> propertySource = it.next();
		}
		properties.putAll(map);
		LOGGER.info("kafkaConsumer配置:{}",properties);
		KafkaConsumer<String, Binlog> consumer = new KafkaConsumer<String, Binlog>(properties);
		
		consumer.subscribe(Arrays.asList(env.getProperty("consumer.topics").split(",")));
		return consumer;
	}
	
}