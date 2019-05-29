--原始

CREATE VIEW odsopr.user_shebao_auth_log AS SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.shebao_account,a.shebao_password,a.city_id,a.auth_status,a.auth_time,a.verify_status,a.verify_id,a.verify_time,a.verify_comment,a.expire_time,a.is_delete,a.create_time,a.update_time,a.creater,a.updater,a.version,a.task_id,a.uuid,a.biz_code	
FROM ODSOPR.USER_SHEBAO_AUTH_LOG_HIST A	
LEFT JOIN ODSOPR.USER_SHEBAO_AUTH_LOG_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.shebao_account,a.shebao_password,a.city_id,a.auth_status,a.auth_time,a.verify_status,a.verify_id,a.verify_time,a.verify_comment,a.expire_time,a.is_delete,a.create_time,a.update_time,a.creater,a.updater,a.version,a.task_id,a.uuid,a.biz_code	
FROM ODSOPR.USER_SHEBAO_AUTH_LOG_CUR A	



--修改


ALTER VIEW odsopr.user_shebao_auth_log 
AS 
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,'' shebao_account,'' shebao_password,a.city_id,a.auth_status,a.auth_time,a.verify_status,a.verify_id,a.verify_time,a.verify_comment,a.expire_time,a.is_delete,a.create_time,a.update_time,a.creater,a.updater,a.version,a.task_id,a.uuid,a.biz_code	
FROM ODSOPR.USER_SHEBAO_AUTH_LOG_HIST A	
LEFT JOIN ODSOPR.USER_SHEBAO_AUTH_LOG_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,'' shebao_account,'' shebao_password,a.city_id,a.auth_status,a.auth_time,a.verify_status,a.verify_id,a.verify_time,a.verify_comment,a.expire_time,a.is_delete,a.create_time,a.update_time,a.creater,a.updater,a.version,a.task_id,a.uuid,a.biz_code	
FROM ODSOPR.USER_SHEBAO_AUTH_LOG_CUR A	

