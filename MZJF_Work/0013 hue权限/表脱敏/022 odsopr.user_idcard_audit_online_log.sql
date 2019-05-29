--原始
createtab_stmt	
CREATE VIEW odsopr.user_idcard_audit_online_log AS SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.real_name,a.id_num,a.status,a.create_time,a.update_time,a.version,a.biz_code,a.auth_type	
FROM ODSOPR.USER_IDCARD_AUDIT_ONLINE_LOG_HIST A	
LEFT JOIN ODSOPR.USER_IDCARD_AUDIT_ONLINE_LOG_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.real_name,a.id_num,a.status,a.create_time,a.update_time,a.version,a.biz_code,a.auth_type	
FROM ODSOPR.USER_IDCARD_AUDIT_ONLINE_LOG_CUR A	





--修改


ALTER VIEW odsopr.user_idcard_audit_online_log 
AS 
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,t.real_name,t.id_num,a.status,a.create_time,a.update_time,a.version,a.biz_code,a.auth_type	
FROM ODSOPR.USER_IDCARD_AUDIT_ONLINE_LOG_HIST A	
LEFT JOIN ODSOPR.USER_IDCARD_AUDIT_ONLINE_LOG_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
left join ods.t_insensitive_date_hist t 
on t.user_id = a.user_id
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,t.real_name,t.id_num,a.status,a.create_time,a.update_time,a.version,a.biz_code,a.auth_type	
FROM ODSOPR.USER_IDCARD_AUDIT_ONLINE_LOG_CUR A	
left join ods.t_insensitive_date_hist t 
on t.user_id = a.user_id


