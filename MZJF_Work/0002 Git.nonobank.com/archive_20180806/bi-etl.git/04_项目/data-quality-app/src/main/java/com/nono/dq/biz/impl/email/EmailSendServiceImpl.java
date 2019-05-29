package com.nono.dq.biz.impl.email;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.nono.dq.biz.email.EmailSendService;
import com.nono.dq.model.Email;

@Service
public class EmailSendServiceImpl implements EmailSendService {
	private static final Logger LOGGER = LoggerFactory.getLogger(EmailSendServiceImpl.class);	
	private final static BlockingQueue<Email> emailCollection = new ArrayBlockingQueue<Email>(100);
	@Autowired
	private JavaMailSender javaMailSender;
	/**
	 * 启动邮箱发送服务
	 */
	@Override
	public void start() {
		new Thread(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				LOGGER.info("***************************************邮件发送服务启动******************************************************");
				while (true) {
					try {
						Thread.sleep(10000);
//						log.debug("************************************ Email task check******************************************************");
						Email email = emailCollection.poll();
						if (null != email) {
							LOGGER.info("************************************ Email  begin send******************************************************");
							realSendMailReal(email);
							LOGGER.info("************************************ Email  end send******************************************************");
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
	 * @param email
	 * @throws Exception 
	 */
	@Override
	public void sendMail(Email email) throws Exception{
		emailCollection.put(email);
	}
	
	
	/**
	 * 邮件发送执行方法
	 * @param email
	 * @throws MessagingException
	 */
	private void realSendMailReal(Email email) throws MessagingException {
		MimeMessage mailMessage = javaMailSender.createMimeMessage();
		// 设置utf-8或GBK编码，否则邮件会有乱码
		MimeMessageHelper messageHelper = new MimeMessageHelper(mailMessage,true, "utf-8");
		try {
			 messageHelper.setTo(email.getToArray());//接受者
			 String from ="it_data_dep@nonobank.com";
			 if(null != email.getFrom() ){
				 from = email.getFrom();
			 }
			 messageHelper.setFrom(new InternetAddress(from));
			 
			 messageHelper.setSubject(email.getSubject());// 主题
			 
			 if(email.getCcList().size()>0){
				 messageHelper.setCc(email.getCcArray());
			 }
			 if(email.getBccList().size()>0){
				 messageHelper.setBcc(email.getBccArray());
			 }
			 
			StringBuffer html =new StringBuffer();
			html.append("<html><head>");
			html.append("<style type=\"text/css\">");
			html.append("table.gridtable {font-family: verdana,arial,sans-serif;	font-size:12px;	color:#333333;	border-width: 1px;	border-color: #666666;	border-collapse: collapse;}");
			html.append("table.gridtable th {border-width: 1px;	padding: 8px;width:120px; font-size:13px;color:#FFFFFF;	border-style: solid;	border-color: #666666;	background-color: #FFB848;}");
			html.append("table.gridtable td {	border-width: 1px;	padding: 8px;width:120px;	border-style: solid;	border-color: #666666;	background-color: #ffffff;}");

			html.append("</style>");
			html.append("</head><body>");
			
			 html.append(email.getContent());
		
			 html.append("</body></html>");
			// 邮件内容，注意加参数true，表示启用html格式
			messageHelper.setText(html.toString(),true);//html邮件 第二个参数为true
				
			javaMailSender.send(mailMessage);
			LOGGER.info("发送邮件成功：from =  emailInfo : ", from,email);
		} catch (Exception e) {
			//如果发送失败，需重新发送
			try {
				this.sendMail(email);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			LOGGER.error(e.getMessage(), e);
		}
	}
}
