--原始

CREATE VIEW odsopr.user_login_detail_log_new AS SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.login_name,a.logon_time,a.logon_status,a.logon_status_desc,a.logon_type,a.client_type,a.login_biz,a.client_version,a.ip,a.phone_version,a.phone_brand,a.phone_model,a.deviceid,a.mac,a.idfa,a.longitude,a.latitude,a.isp,a.network,a.remark,a.create_time,a.update_time,a.version,a.guid,a.channel_id,a.channel_detail	
FROM ODSOPR.USER_LOGIN_DETAIL_LOG_NEW_HIST A	
LEFT JOIN ODSOPR.USER_LOGIN_DETAIL_LOG_NEW_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.login_name,a.logon_time,a.logon_status,a.logon_status_desc,a.logon_type,a.client_type,a.login_biz,a.client_version,a.ip,a.phone_version,a.phone_brand,a.phone_model,a.deviceid,a.mac,a.idfa,a.longitude,a.latitude,a.isp,a.network,a.remark,a.create_time,a.update_time,a.version,a.guid,a.channel_id,a.channel_detail	
FROM ODSOPR.USER_LOGIN_DETAIL_LOG_NEW_CUR A	



--修改

ALTER VIEW odsopr.user_login_detail_log_new 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,'' login_name,a.logon_time,a.logon_status,a.logon_status_desc,a.logon_type,a.client_type,a.login_biz,a.client_version,a.ip,a.phone_version,a.phone_brand,a.phone_model,a.deviceid,a.mac,a.idfa,a.longitude,a.latitude,a.isp,a.network,a.remark,a.create_time,a.update_time,a.version,a.guid,a.channel_id,a.channel_detail	
FROM ODSOPR.USER_LOGIN_DETAIL_LOG_NEW_HIST A	
LEFT JOIN ODSOPR.USER_LOGIN_DETAIL_LOG_NEW_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,'' login_name,a.logon_time,a.logon_status,a.logon_status_desc,a.logon_type,a.client_type,a.login_biz,a.client_version,a.ip,a.phone_version,a.phone_brand,a.phone_model,a.deviceid,a.mac,a.idfa,a.longitude,a.latitude,a.isp,a.network,a.remark,a.create_time,a.update_time,a.version,a.guid,a.channel_id,a.channel_detail	
FROM ODSOPR.USER_LOGIN_DETAIL_LOG_NEW_CUR A	

