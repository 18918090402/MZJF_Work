--原始
createtab_stmt	
CREATE VIEW odsopr.infra_sms_sms_message_log AS SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.mobile_num,a.biz_template_id,a.content_params,a.current_channel,a.used_channel,a.task_id,a.serial_num,a.status,a.timeout,a.report_time,a.create_time,a.update_time,a.version,a.attribute,a.extension,a.channel_code	
FROM ODSOPR.INFRA_SMS_SMS_MESSAGE_LOG_HIST A	
LEFT JOIN ODSOPR.INFRA_SMS_SMS_MESSAGE_LOG_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.mobile_num,a.biz_template_id,a.content_params,a.current_channel,a.used_channel,a.task_id,a.serial_num,a.status,a.timeout,a.report_time,a.create_time,a.update_time,a.version,a.attribute,a.extension,a.channel_code	
FROM ODSOPR.INFRA_SMS_SMS_MESSAGE_LOG_CUR A	






--修改


ALTER VIEW odsopr.infra_sms_sms_message_log 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,'' mobile_num,a.biz_template_id,a.content_params,a.current_channel,a.used_channel,a.task_id,a.serial_num,a.status,a.timeout,a.report_time,a.create_time,a.update_time,a.version,a.attribute,a.extension,a.channel_code	
FROM ODSOPR.INFRA_SMS_SMS_MESSAGE_LOG_HIST A	
LEFT JOIN ODSOPR.INFRA_SMS_SMS_MESSAGE_LOG_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,'' mobile_num,a.biz_template_id,a.content_params,a.current_channel,a.used_channel,a.task_id,a.serial_num,a.status,a.timeout,a.report_time,a.create_time,a.update_time,a.version,a.attribute,a.extension,a.channel_code	
FROM ODSOPR.INFRA_SMS_SMS_MESSAGE_LOG_CUR A	

