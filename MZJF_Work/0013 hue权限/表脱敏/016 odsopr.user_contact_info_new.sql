--原始

CREATE VIEW odsopr.user_contact_info_new AS SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.type,a.name,a.mobile,a.relation_ship,a.biz_code,a.is_delete,a.creator,a.updator,a.version,a.create_time,a.update_time,a.call_state	
FROM ODSOPR.USER_CONTACT_INFO_NEW_HIST A	
LEFT JOIN ODSOPR.USER_CONTACT_INFO_NEW_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.type,a.name,a.mobile,a.relation_ship,a.biz_code,a.is_delete,a.creator,a.updator,a.version,a.create_time,a.update_time,a.call_state	
FROM ODSOPR.USER_CONTACT_INFO_NEW_CUR A	




--修改

ALTER VIEW odsopr.user_contact_info_new 
AS 
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.type,'' name,'' mobile,a.relation_ship,a.biz_code,a.is_delete,a.creator,a.updator,a.version,a.create_time,a.update_time,a.call_state	
FROM ODSOPR.USER_CONTACT_INFO_NEW_HIST A	
LEFT JOIN ODSOPR.USER_CONTACT_INFO_NEW_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.type,'' name,'' mobile,a.relation_ship,a.biz_code,a.is_delete,a.creator,a.updator,a.version,a.create_time,a.update_time,a.call_state	
FROM ODSOPR.USER_CONTACT_INFO_NEW_CUR A	

