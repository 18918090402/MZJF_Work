package com.nono.dq.biz.impl.sms;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

import javax.mail.MessagingException;

import org.apache.directory.api.util.Strings;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.nono.dq.biz.sms.SmsService;
import com.nono.dq.dao.local.metadata.DqConfSmsRepo;
import com.nono.dq.model.bo.SystemSms;

@Service
public class SmsServiceImpl implements SmsService {
	private static final Logger LOGGER = LoggerFactory.getLogger(SmsServiceImpl.class);
	private final static BlockingQueue<SystemSms> emailCollection = new ArrayBlockingQueue<SystemSms>(100);
	
	@Autowired
	private DqConfSmsRepo systemSmsRepo;
	
	@Autowired
	private SmsService smsService;
	/**
	 * 启动邮箱发送服务
	 */
	@Override
	public void start() {
		new Thread(new Runnable() {
			@Override
			public void run() {
				while (true) {
					try {
						Thread.sleep(1000);
						SystemSms sms = emailCollection.poll();
						if (null != sms) {
							smsService.realSendMsmReal(sms);
						}
					} catch (Exception e) {
						LOGGER.error("{}", e);
					}
				}
			}
		}).start();
	}

	/**
	 * 添加邮件到邮件队列
	 * 
	 * @param email
	 * @throws Exception
	 */
	@Override
	public void sendMsm(SystemSms sms) throws Exception {
		if(Strings.isNotEmpty(sms.getContent())) {
			emailCollection.put(sms);
		}
	}

	/**
	 * 短信发送执行方法
	 * @param email
	 * @throws MessagingException
	 */
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public  void realSendMsmReal(SystemSms sms){
		try {
			//TransactionAspectSupport.currentTransactionStatus().isNewTransaction()
			systemSmsRepo.saveSms(sms);
		} catch (Exception e) {
			// 如果发送失败，需重新发送
			try {
				this.sendMsm(sms);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				LOGGER.error(e.getMessage(), e);
			}
			LOGGER.error(e.getMessage(), e);
		}
	}

	@Override
	public Integer countWaitMsm() {
		// TODO Auto-generated method stub
		return emailCollection.size();
	}
}
