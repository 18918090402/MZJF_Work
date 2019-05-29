package com.nonobank.bi.config;

import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.env.Environment;

import com.alibaba.otter.canal.client.CanalConnector;
import com.alibaba.otter.canal.client.CanalConnectors;
import com.nonobank.bi.common.enums.CommonEnum;

/**
 * Canal相关的配置
 * 
 * @author zhaoyaoyuan
 *
 */
@Configuration
public class CanalConnectorConfig {

	private final static Logger LOGGER = LoggerFactory.getLogger(CanalConnectorConfig.class);

	@Configuration
	@Profile(UserProfile.INTG)
	@org.springframework.context.annotation.PropertySource("classpath:/intg/canal.properties")
	class CanalConfigIntgConfiguration {
	}

	@Configuration
	@Profile(UserProfile.PROD)
	@org.springframework.context.annotation.PropertySource("classpath:/prod/canal.properties")
	class CanalConfigProdConfiguration {
	}

	@Autowired
	private Environment env;

	/**
	 * 获得Canal客户端的Bean
	 * @return
	 */
	@Bean
	public List<CanalConnector> canalConnector() {
	List<CanalConnector> connectorList =new ArrayList<CanalConnector>();
	String serverModel=env.getProperty("canal.server.model");
	//一个connector处理一个instance
	for(String instancesAndRegex:env.getProperty("canal.instancesAndRegex").split(",")){
		String instance = instancesAndRegex.split(":")[0];
		String regex = instancesAndRegex.split(":")[1];
		LOGGER.debug("************Begin [{}] instance connector",instance);
		CanalConnector connector = null;
		//单机环境和HA position谁存储？？？
		if(CommonEnum.CanalServerModelEnum.STAND_ALONE.getValue().equals(serverModel)){
			connector=CanalConnectors.newSingleConnector(
				new InetSocketAddress(env.getProperty("canal.host"), Integer.valueOf(env.getProperty("canal.port"))),
				instance, "", "");
		}else if(CommonEnum.CanalServerModelEnum.CLUSTER.getValue().equals(serverModel)){//基于zookeeper的集群环境
			connector=CanalConnectors.newClusterConnector(env.getProperty("canal.zk-address"), instance, "", "");
		}
		
		if(connector !=null){
			connector.connect();
			//有问题：如果同时起了多个client订阅同一个canal instance，会一直卡这里
			connector.subscribe(regex);
			connector.rollback();// 回滚到未进行 ack 的地方，下次fetch的时候，可以从最后一个没有
			connectorList.add(connector);
		}
		LOGGER.debug("************End [{}] instance connector",instance);
	}
	return connectorList;
}}