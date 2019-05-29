--hist 原始
CREATE VIEW odsopr.user_bankcard_info_hist AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.user_id, a.bank_card_no, a.bank_code, a.province_code, a.city_code, a.open_bank_code, a.last_used_time, a.in_money, a.out_money, a.is_default, a.is_deleted, a.create_time, a.update_time, a.creater, a.updater, a.version FROM ODS.T_USER_BANKCARD_INFO_HIST A

--hist 修改
ALTER VIEW odsopr.user_bankcard_info_hist 
AS 
SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.user_id
       ,CASE
              WHEN length(trim(a.bank_card_no)) = 0
                     OR a.bank_card_no    IS NULL
                     THEN ''
                     ELSE CONCAT ( substr(trim(a.bank_card_no), 1, 4) ,'****' ,substr(trim(a.bank_card_no), - 4, 4) )
       END bank_card_no
       , a.bank_code, a.province_code, a.city_code, a.open_bank_code, a.last_used_time, a.in_money, a.out_money, a.is_default, a.is_deleted, a.create_time, a.update_time, a.creater, a.updater, a.version 
FROM ODS.T_USER_BANKCARD_INFO_HIST A


--cur 原始
CREATE VIEW odsopr.user_bankcard_info_cur AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.user_id, a.bank_card_no, a.bank_code, a.province_code, a.city_code, a.open_bank_code, a.last_used_time, a.in_money, a.out_money, a.is_default, a.is_deleted, a.create_time, a.update_time, a.creater, a.updater, a.version, a.p_run_id FROM ODS.T_USER_BANKCARD_INFO_CUR A	
    WHERE a.p_run_id = 255715	




--原始
ALTER VIEW odsopr.user_bankcard_info AS SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.bank_card_no,a.bank_code,a.province_code,a.city_code,a.open_bank_code,a.last_used_time,a.in_money,a.out_money,a.is_default,a.is_deleted,a.create_time,a.update_time,a.creater,a.updater,a.version	
FROM ODSOPR.USER_BANKCARD_INFO_HIST A	
LEFT JOIN ODSOPR.USER_BANKCARD_INFO_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.bank_card_no,a.bank_code,a.province_code,a.city_code,a.open_bank_code,a.last_used_time,a.in_money,a.out_money,a.is_default,a.is_deleted,a.create_time,a.update_time,a.creater,a.updater,a.version	
FROM ODSOPR.USER_BANKCARD_INFO_CUR A	



--修改
ALTER VIEW odsopr.user_bankcard_info 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id
       ,CASE
              WHEN length(trim(a.bank_card_no)) = 0
                     OR a.bank_card_no    IS NULL
                     THEN ''
                     ELSE CONCAT ( substr(trim(a.bank_card_no), 1, 4) ,'****' ,substr(trim(a.bank_card_no), - 4, 4) )
       END bank_card_no
        ,a.bank_code,a.province_code,a.city_code,a.open_bank_code,a.last_used_time,a.in_money,a.out_money,a.is_default,a.is_deleted,a.create_time,a.update_time,a.creater,a.updater,a.version	
FROM ODSOPR.USER_BANKCARD_INFO_HIST A	
LEFT JOIN ODSOPR.USER_BANKCARD_INFO_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id
       ,CASE
              WHEN length(trim(a.bank_card_no)) = 0
                     OR a.bank_card_no    IS NULL
                     THEN ''
                     ELSE CONCAT ( substr(trim(a.bank_card_no), 1, 4) ,'****' ,substr(trim(a.bank_card_no), - 4, 4) )
       END bank_card_no
        ,a.bank_code,a.province_code,a.city_code,a.open_bank_code,a.last_used_time,a.in_money,a.out_money,a.is_default,a.is_deleted,a.create_time,a.update_time,a.creater,a.updater,a.version	
FROM ODSOPR.USER_BANKCARD_INFO_CUR A	





