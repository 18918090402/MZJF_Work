package com.nono.dq.app.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class TaskSchedule {

	private static final Logger LOG = LoggerFactory.getLogger(TaskSchedule.class);


	private static final String patternCompare = "yyyy-MM-dd";
	private static final String patternAlert = "HH:mm:ss";
	private static final String alertTime = "06:00:00";//警报时间
	

	@Scheduled(cron = "0 0/15 2-22 * * ? ")
	public void punishTaskSchedule() {

	}
}