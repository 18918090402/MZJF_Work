package com.nono.dq.app.config;

import java.util.Map;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.env.CompositePropertySource;
import org.springframework.core.env.MapPropertySource;
import org.springframework.core.env.PropertySource;

import com.nono.dq.app.UserProfile;

@Configuration
public class DataSourceConfig {
	
	@Configuration
	@Profile(UserProfile.INTG)
	@org.springframework.context.annotation.PropertySource("classpath:/intg/jdbc.properties")
	class DataSourceIntgConfiguration {
	}

	@Configuration
	@Profile(UserProfile.PROD)
	@org.springframework.context.annotation.PropertySource("classpath:/prod/jdbc.properties")
	class DataSourceProdConfiguration {
	}
	
	public void getPropertiesFromSource(String mysqlPrefix,String druidPrefix,PropertySource<?> propertySource, Map<String, Object> map) {
		if (propertySource instanceof MapPropertySource) {
			for (String key : ((MapPropertySource) propertySource).getPropertyNames()) {
				//LOGGER.info("{}:{}",key,propertySource.getProperty(key));
				if (key.startsWith(mysqlPrefix)) {
					map.put(key.replaceFirst(mysqlPrefix, ""), propertySource.getProperty(key));
				} else if (key.startsWith(druidPrefix)) {
					map.put(key.replaceFirst(druidPrefix, ""), propertySource.getProperty(key));
				}
			}
		}

		if (propertySource instanceof CompositePropertySource) {
			for (PropertySource<?> s : ((CompositePropertySource) propertySource).getPropertySources()) {
				getPropertiesFromSource(mysqlPrefix,druidPrefix,s, map);
			}
		}
	}
}
