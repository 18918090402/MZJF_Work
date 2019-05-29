package com.nonobank.bi.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.env.AbstractEnvironment;
import org.springframework.core.env.Environment;
import org.springframework.core.env.PropertySource;

import com.alibaba.otter.canal.client.CanalConnector;
import com.nonobank.bi.util.PropertiesUtils;

@Configuration
public class KafkaProducerConfig {

	private final static Logger LOGGER = LoggerFactory.getLogger(KafkaProducerConfig.class);
	@Autowired
	private List<CanalConnector> connectorList;
	
	private static String prefix="kafka.";
	@Configuration
	@Profile(UserProfile.INTG)
	@org.springframework.context.annotation.PropertySource("classpath:/intg/kafka.properties")
	class KafkaConfigIntgConfiguration {
	}

	@Configuration
	@Profile(UserProfile.PROD)
	@org.springframework.context.annotation.PropertySource("classpath:/prod/kafka.properties")
	class KafkaConfigProdConfiguration {
	}

	@Autowired
	private Environment env;

	@Bean
	public List<KafkaProducer<String, String>> kafkaProducerList() {
		List<KafkaProducer<String, String>> kafkaProducerList =new ArrayList<KafkaProducer<String, String>>();
		
		Properties properties = new Properties();
		Map<String, Object> map = new HashMap<String, Object>();
		for (Iterator<PropertySource<?>> it = ((AbstractEnvironment) env).getPropertySources().iterator(); it
				.hasNext();) {
			PropertySource<?> propertySource = it.next();
			PropertiesUtils.getPropertiesFromSource(prefix, propertySource, map);
		}
		properties.putAll(map);
		//一个producer处理一个canalconnector
		for(int i=0;i<=connectorList.size()-1;i++){
			properties.setProperty("client.id", env.getProperty("kafka.client.id.prefix")+"_"+i);
			kafkaProducerList.add(new KafkaProducer<String, String>(properties));
			LOGGER.debug("kafkaProducer配置:{}",properties);
		}
		return kafkaProducerList;
	}
}