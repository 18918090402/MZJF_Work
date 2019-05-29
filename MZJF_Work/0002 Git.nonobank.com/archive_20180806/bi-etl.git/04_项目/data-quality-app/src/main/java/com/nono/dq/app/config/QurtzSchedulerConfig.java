package com.nono.dq.app.config;
import java.io.IOException;
import java.util.Properties;

import javax.sql.DataSource;

import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.spi.JobFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

import com.nono.dq.dao.local.metadata.QrtzJobLogRepo;
import com.nono.dq.listener.QurtzJobListener;

@Configuration
public class QurtzSchedulerConfig {

	@Autowired
	private QrtzJobLogRepo qrtzJobLogRepo;
	
	@Bean
	public JobFactory jobFactory(ApplicationContext applicationContext) {
		AutowiringSpringBeanJobFactory jobFactory = new AutowiringSpringBeanJobFactory();
		jobFactory.setApplicationContext(applicationContext);
		return jobFactory;
	}

	@Bean
	public SchedulerFactoryBean schedulerFactoryBean(DataSource dataSource, JobFactory jobFactory) throws IOException {
		SchedulerFactoryBean factory = new SchedulerFactoryBean();
		factory.setOverwriteExistingJobs(true);
		factory.setDataSource(dataSource);
		factory.setJobFactory(jobFactory);
		
		factory.setQuartzProperties(quartzProperties());
		return factory;
	}

	@Bean
	public Properties quartzProperties() throws IOException {
		PropertiesFactoryBean propertiesFactoryBean = new PropertiesFactoryBean();
		propertiesFactoryBean.setLocation(new ClassPathResource("/quartz.properties"));
		propertiesFactoryBean.afterPropertiesSet();
		return propertiesFactoryBean.getObject();
	}
	
	@Bean
	public Scheduler scheduler(SchedulerFactoryBean factory) throws IOException {
		Scheduler  scheduler =factory.getObject();
		try {
			//对所有job都增加监听器
			scheduler.getListenerManager().addJobListener(new QurtzJobListener("QuartzJobListener",qrtzJobLogRepo));
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return scheduler;
	}
	
}