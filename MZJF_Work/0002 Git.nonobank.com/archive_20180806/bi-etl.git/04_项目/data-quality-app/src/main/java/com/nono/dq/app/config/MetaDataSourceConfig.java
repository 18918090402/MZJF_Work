package com.nono.dq.app.config;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.orm.jpa.JpaProperties;
import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.AbstractEnvironment;
import org.springframework.core.env.Environment;
import org.springframework.core.env.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;

@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(basePackages = {"com.nono.dq.dao.local.metadata"})
public class MetaDataSourceConfig {

	private final static Logger LOGGER = LoggerFactory.getLogger(MetaDataSourceConfig.class);

	private static final String MYSQL_PREFIX = "db.mysql.";
	private static final String DRUID_PREFIX = "db.druid.";

	@Autowired
	private Environment env;
	@Autowired
	private DataSourceConfig dataSourceConfig;
	
	@Bean
	public DataSource dataSource() {
		LOGGER.info("----begin init analyzeDataSource----");
		Properties dbProperties = new Properties();
		Map<String, Object> map = new HashMap<String, Object>();
		for (Iterator<PropertySource<?>> it = ((AbstractEnvironment) env).getPropertySources().iterator(); it
				.hasNext();) {
			PropertySource<?> propertySource = it.next();
			dataSourceConfig.getPropertiesFromSource(MYSQL_PREFIX, DRUID_PREFIX, propertySource, map);
		}
		dbProperties.putAll(map);
		LOGGER.info("********properties:{}", dbProperties.toString());
		DruidDataSource dataSource = null;
		try {
			dataSource = (DruidDataSource) DruidDataSourceFactory.createDataSource(dbProperties);
			if (null != dataSource) {
				//dataSource.setFilters("wall,stat");
				dataSource.init();
			}
		} catch (Exception e) {
			throw new RuntimeException("load datasource error, dbProperties is :" + dbProperties, e);
		}
		LOGGER.info("----end init analyzeDataSource----");
		return dataSource;
	}
	
    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory (EntityManagerFactoryBuilder builder,@Qualifier("dataSource")DataSource dataSource) {
        return builder
                .dataSource(dataSource)
                .properties(getVendorProperties(dataSource))
                .packages("com.nono.dq.model.dto.metadata","com.nono.dq.model.dto.schedule") //设置实体类所在位置
                .build();
    }
    
//	@Primary
//    @Bean(name = "entityManager")
//    public EntityManager entityManager(@Qualifier("entityManagerFactory") LocalContainerEntityManagerFactoryBean entityManagerFactory) {
//        return entityManagerFactory.getObject().createEntityManager();
//    }
	
    @Autowired
    private JpaProperties jpaProperties;
    private Map<String, String> getVendorProperties(DataSource dataSource) {
        return jpaProperties.getHibernateProperties(dataSource);
    }
    
    @Bean
    public PlatformTransactionManager transactionManager(@Qualifier("entityManagerFactory") LocalContainerEntityManagerFactoryBean entityManagerFactory) {
    	 JpaTransactionManager transactionManager
         = new JpaTransactionManager();
    	 transactionManager.setDataSource( entityManagerFactory.getDataSource());
       transactionManager.setEntityManagerFactory(
    		   entityManagerFactory.getObject() );
        return transactionManager;
    }
}