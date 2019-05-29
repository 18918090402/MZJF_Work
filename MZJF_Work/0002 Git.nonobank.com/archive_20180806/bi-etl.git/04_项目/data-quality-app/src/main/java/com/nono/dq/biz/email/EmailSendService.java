package com.nono.dq.biz.email;

import com.nono.dq.model.Email;

public interface EmailSendService {
	/**
	 * 启动邮箱发送服务
	 */
	void start();
	/**
	 * 添加邮件到邮件队列
	 * 
	 * @param email
	 */
	void sendMail(Email email)  throws Exception;
}
