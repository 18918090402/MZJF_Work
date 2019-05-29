--原始
ALTER VIEW odsopr.borrows_dunning_contact 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.name,a.value,a.expand,a.state,a.call_state,a.kind,a.groupkwd,a.create_time,a.update_time,a.creater,a.updater,a.version	
FROM ODSOPR.BORROWS_DUNNING_CONTACT_HIST A	
LEFT JOIN ODSOPR.BORROWS_DUNNING_CONTACT_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.name,a.value,a.expand,a.state,a.call_state,a.kind,a.groupkwd,a.create_time,a.update_time,a.creater,a.updater,a.version	
FROM ODSOPR.BORROWS_DUNNING_CONTACT_CUR A	









--修改
ALTER VIEW odsopr.borrows_dunning_contact 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.name,'' value,a.expand,a.state,a.call_state,a.kind,a.groupkwd,a.create_time,a.update_time,a.creater,a.updater,a.version	
FROM ODSOPR.BORROWS_DUNNING_CONTACT_HIST A	
LEFT JOIN ODSOPR.BORROWS_DUNNING_CONTACT_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.name,'' value,a.expand,a.state,a.call_state,a.kind,a.groupkwd,a.create_time,a.update_time,a.creater,a.updater,a.version	
FROM ODSOPR.BORROWS_DUNNING_CONTACT_CUR A	

