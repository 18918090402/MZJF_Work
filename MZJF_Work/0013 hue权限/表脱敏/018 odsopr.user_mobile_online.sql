--原始
CREATE VIEW odsopr.user_mobile_online AS SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.mobile,a.onlinetime,a.resultstatus,a.terminal,a.create_time,a.update_time,a.version	
FROM ODSOPR.USER_MOBILE_ONLINE_HIST A	
LEFT JOIN ODSOPR.USER_MOBILE_ONLINE_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.mobile,a.onlinetime,a.resultstatus,a.terminal,a.create_time,a.update_time,a.version	
FROM ODSOPR.USER_MOBILE_ONLINE_CUR A	










--修改
ALTER VIEW odsopr.user_mobile_online 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,'' mobile,a.onlinetime,a.resultstatus,a.terminal,a.create_time,a.update_time,a.version	
FROM ODSOPR.USER_MOBILE_ONLINE_HIST A	
LEFT JOIN ODSOPR.USER_MOBILE_ONLINE_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,'' mobile,a.onlinetime,a.resultstatus,a.terminal,a.create_time,a.update_time,a.version	
FROM ODSOPR.USER_MOBILE_ONLINE_CUR A	
