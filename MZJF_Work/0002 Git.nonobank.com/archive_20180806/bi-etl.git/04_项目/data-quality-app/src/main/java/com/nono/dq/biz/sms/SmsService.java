package com.nono.dq.biz.sms;

import com.nono.dq.model.bo.SystemSms;

public interface SmsService {
	
	/**
	 * 启动邮箱发送服务
	 */
	void start();
	/**
	 * 添加邮件到邮件队列
	 * 
	 * @param email
	 */
	void sendMsm(SystemSms sms)  throws Exception;
	
	void realSendMsmReal(SystemSms sms);
	
	/**
	 * 统计待发送的短信
	 * @return
	 */
	Integer countWaitMsm();
}