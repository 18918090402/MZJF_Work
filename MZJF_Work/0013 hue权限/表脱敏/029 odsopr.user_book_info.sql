--原始
createtab_stmt	
CREATE VIEW odsopr.user_book_info AS SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.user_name,a.mobile_num,a.product,a.is_delete,a.creator,a.updator,a.version,a.create_time,a.update_time	
FROM ODSOPR.USER_BOOK_INFO_HIST A	
LEFT JOIN ODSOPR.USER_BOOK_INFO_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.user_name,a.mobile_num,a.product,a.is_delete,a.creator,a.updator,a.version,a.create_time,a.update_time	
FROM ODSOPR.USER_BOOK_INFO_CUR A	


--cur 原始
CREATE VIEW odsopr.user_book_info_cur AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.user_id, a.user_name, a.mobile_num, a.product, a.is_delete, a.creator, a.updator, a.version, a.create_time, a.update_time, a.p_run_id FROM ODS.T_USER_BOOK_INFO_CUR A	
WHERE a.p_run_id IN (273483)	


--hist 原始

ALTER VIEW odsopr.user_book_info_hist 
AS 
SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.user_id
       ,a.user_name
       ,case
              when length(trim(a.mobile_num)) = 0
                     or a.mobile_num    is NULL
                     then ''
                     else CONCAT(substr(trim(a.mobile_num),1,3), '****' ,substr(trim(a.mobile_num),-4,4))
       end mobile_num
       ,a.product, a.is_delete, a.creator, a.updator, a.version, a.create_time, a.update_time 
FROM ODS.T_USER_BOOK_INFO_HIST A	

