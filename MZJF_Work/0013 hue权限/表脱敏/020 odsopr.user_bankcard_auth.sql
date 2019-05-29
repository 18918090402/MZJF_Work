--原始
createtab_stmt	
CREATE VIEW odsopr.user_bankcard_auth AS SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.bank_card_id,a.bank_short_code,a.auth_type,a.auth_status,a.auth_time,a.short_no,a.return_code,a.return_detail,a.create_time,a.update_time,a.creater,a.updater,a.version,a.id_card_no,a.mobile,a.name,a.merchant_code,a.merchant_no	
FROM ODSOPR.USER_BANKCARD_AUTH_HIST A	
LEFT JOIN ODSOPR.USER_BANKCARD_AUTH_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.bank_card_id,a.bank_short_code,a.auth_type,a.auth_status,a.auth_time,a.short_no,a.return_code,a.return_detail,a.create_time,a.update_time,a.creater,a.updater,a.version,a.id_card_no,a.mobile,a.name,a.merchant_code,a.merchant_no	
FROM ODSOPR.USER_BANKCARD_AUTH_CUR A	


--修改

ALTER VIEW odsopr.user_bankcard_auth 
AS 
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.bank_card_id,a.bank_short_code,a.auth_type,a.auth_status,a.auth_time,a.short_no,a.return_code,a.return_detail,a.create_time,a.update_time,a.creater,a.updater,a.version
       ,case
            when length(trim(a.id_card_no)) = 0 or a.id_card_no    is NULL then ''
            else CONCAT(substr(trim(a.id_card_no),1,4), '***********' ,substr(trim(a.id_card_no),-4,4))
       end id_card_no
       ,t.mobile_num
       ,t.real_name
       ,a.merchant_code,a.merchant_no	
FROM ODSOPR.USER_BANKCARD_AUTH_HIST A	
LEFT JOIN ODSOPR.USER_BANKCARD_AUTH_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
left join ods.t_insensitive_date_hist t 
on t.user_id = a.user_id
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.user_id,a.bank_card_id,a.bank_short_code,a.auth_type,a.auth_status,a.auth_time,a.short_no,a.return_code,a.return_detail,a.create_time,a.update_time,a.creater,a.updater,a.version
       ,case
            when length(trim(a.id_card_no)) = 0 or a.id_card_no    is NULL then ''
            else CONCAT(substr(trim(a.id_card_no),1,4), '***********' ,substr(trim(a.id_card_no),-4,4))
       end id_card_no
       ,t.mobile_num
       ,t.real_name
       ,a.merchant_code,a.merchant_no	
FROM ODSOPR.USER_BANKCARD_AUTH_CUR A	
left join ods.t_insensitive_date_hist t 
on t.user_id = a.user_id

