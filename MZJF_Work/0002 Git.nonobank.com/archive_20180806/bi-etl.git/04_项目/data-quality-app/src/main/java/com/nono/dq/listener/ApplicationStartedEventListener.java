package com.nono.dq.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import com.nono.dq.biz.email.EmailSendService;
import com.nono.dq.biz.sms.SmsService;
/**
 * spring boot容器启动并加载完成后
 * @author zhaoyaoyuan
 */
@Component
public class ApplicationStartedEventListener implements ApplicationListener<ContextRefreshedEvent> {

    private Logger logger = LoggerFactory.getLogger(ContextRefreshedEvent.class);
    
    @Autowired
    private EmailSendService emailService; 
    
    @Autowired
    private SmsService smsService;
    
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		// TODO Auto-generated method stub
		//event.getApplicationContext().getBean(EmailSendService.class);
		logger.info("==MyApplicationStartedEventListener==");
		emailService.start();
		smsService.start();
	}
}