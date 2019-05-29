package com.nonobank.bi.util;

import java.util.Map;

import org.springframework.core.env.CompositePropertySource;
import org.springframework.core.env.MapPropertySource;
import org.springframework.core.env.PropertySource;

public class PropertiesUtils {
	public static void getPropertiesFromSource(String prefix, PropertySource<?> propertySource,
			Map<String, Object> map) {
		if (propertySource instanceof MapPropertySource) {
			for (String key : ((MapPropertySource) propertySource).getPropertyNames()) {
				// LOGGER.info("{}:{}",key,propertySource.getProperty(key));
				if (key.startsWith(prefix)) {
					map.put(key.replaceFirst(prefix, ""), propertySource.getProperty(key));
				}
			}
		}
		if (propertySource instanceof CompositePropertySource) {
			for (PropertySource<?> s : ((CompositePropertySource) propertySource).getPropertySources()) {
				getPropertiesFromSource(prefix, s, map);
			}
		}
	}
}
