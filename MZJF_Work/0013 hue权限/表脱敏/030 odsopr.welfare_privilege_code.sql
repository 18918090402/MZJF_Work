--原始
CREATE VIEW odsopr.welfare_privilege_code AS SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.privilege_code_id,a.privilege_code,a.exchange_status,a.use_status,a.object_mobile,a.user_code,a.privilege_amount,a.effective_days,a.description,a.create_date,a.update_date,a.start_date,a.end_date,a.card_start_date,a.card_end_date,a.channel_type,a.welfare_type,a.activity_name,a.activity_reward_id,a.service_condition,a.product_info_code,a.investment_amount,a.card_update_date,a.is_bag,a.order_id,a.message	
FROM ODSOPR.WELFARE_PRIVILEGE_CODE_HIST A	
LEFT JOIN ODSOPR.WELFARE_PRIVILEGE_CODE_CUR B 	
ON a.privilege_code_id= b.privilege_code_id AND a.privilege_code_id = b.privilege_code_id AND a.privilege_code_id = b.privilege_code_id	
WHERE b.privilege_code_id IS NULL AND b.privilege_code_id IS NULL AND b.privilege_code_id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.privilege_code_id,a.privilege_code,a.exchange_status,a.use_status,a.object_mobile,a.user_code,a.privilege_amount,a.effective_days,a.description,a.create_date,a.update_date,a.start_date,a.end_date,a.card_start_date,a.card_end_date,a.channel_type,a.welfare_type,a.activity_name,a.activity_reward_id,a.service_condition,a.product_info_code,a.investment_amount,a.card_update_date,a.is_bag,a.order_id,a.message	
FROM ODSOPR.WELFARE_PRIVILEGE_CODE_CUR A	



--
CREATE VIEW odsopr.welfare_privilege_code_x 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.privilege_code_id,a.privilege_code,a.exchange_status,a.use_status
       ,case
              when length(trim(a.object_mobile)) = 0
                     or a.object_mobile    is NULL
                     then ''
                     else CONCAT(substr(trim(a.object_mobile),1,3), '****' ,substr(trim(a.object_mobile),-4,4))
       end object_mobile        
        ,a.user_code,a.privilege_amount,a.effective_days,a.description,a.create_date,a.update_date,a.start_date,a.end_date,a.card_start_date,a.card_end_date,a.channel_type,a.welfare_type,a.activity_name,a.activity_reward_id,a.service_condition,a.product_info_code,a.investment_amount,a.card_update_date,a.is_bag,a.order_id,a.message	
FROM ODSOPR.WELFARE_PRIVILEGE_CODE A	
