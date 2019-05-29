--原始

CREATE VIEW odsopr.black_gray_list AS SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.bo_id,a.user_id,a.user_name,a.real_name,a.source,a.p_id,a.p_name,a.province_code,a.province_name,a.type,a.operator_id,a.operator_real_name,a.operator_user_name,a.remark,a.id_num,a.mobile_num,a.home_address,a.current_address,a.school_company_name,a.school_company_address,a.school_company_phone,a.qq_num,a.email,a.parent_phone,a.counsellor_phone,a.friend1_phone,a.friend2_phone,a.friend3_phone,a.contact_phone,a.delete_flag,a.bo_finish_time,a.bo_overdue_day_count,a.lib_name,a.submit_time,a.create_time,a.update_time,a.delete_remark,a.sync_flag	
FROM ODSOPR.BLACK_GRAY_LIST_HIST A	
LEFT JOIN ODSOPR.BLACK_GRAY_LIST_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.bo_id,a.user_id,a.user_name,a.real_name,a.source,a.p_id,a.p_name,a.province_code,a.province_name,a.type,a.operator_id,a.operator_real_name,a.operator_user_name,a.remark,a.id_num,a.mobile_num,a.home_address,a.current_address,a.school_company_name,a.school_company_address,a.school_company_phone,a.qq_num,a.email,a.parent_phone,a.counsellor_phone,a.friend1_phone,a.friend2_phone,a.friend3_phone,a.contact_phone,a.delete_flag,a.bo_finish_time,a.bo_overdue_day_count,a.lib_name,a.submit_time,a.create_time,a.update_time,a.delete_remark,a.sync_flag	
FROM ODSOPR.BLACK_GRAY_LIST_CUR A	





--修复

ALTER VIEW odsopr.black_gray_list 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.bo_id,a.user_id,a.user_name
        ,t.real_name
        ,a.source,a.p_id,a.p_name,a.province_code,a.province_name,a.type,a.operator_id,a.operator_real_name,a.operator_user_name,a.remark
        ,t.id_num
        ,t.mobile_num
        ,a.home_address,a.current_address,a.school_company_name,a.school_company_address,a.school_company_phone,a.qq_num,a.email,'' parent_phone,'' counsellor_phone,'' friend1_phone,'' friend2_phone,'' friend3_phone,'' contact_phone,a.delete_flag,a.bo_finish_time,a.bo_overdue_day_count,a.lib_name,a.submit_time,a.create_time,a.update_time,a.delete_remark,a.sync_flag	
FROM ODSOPR.BLACK_GRAY_LIST_HIST A	
LEFT JOIN ODSOPR.BLACK_GRAY_LIST_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id 
left join ods.t_insensitive_date_hist t
on t.user_id = a.user_id
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.bo_id,a.user_id,a.user_name
        ,t.real_name
        ,a.source,a.p_id,a.p_name,a.province_code,a.province_name,a.type,a.operator_id,a.operator_real_name,a.operator_user_name,a.remark
        ,t.id_num
        ,t.mobile_num
        ,a.home_address,a.current_address,a.school_company_name,a.school_company_address,a.school_company_phone,a.qq_num,a.email,'' parent_phone,'' counsellor_phone,'' friend1_phone,'' friend2_phone,'' friend3_phone,'' contact_phone,a.delete_flag,a.bo_finish_time,a.bo_overdue_day_count,a.lib_name,a.submit_time,a.create_time,a.update_time,a.delete_remark,a.sync_flag	
FROM ODSOPR.BLACK_GRAY_LIST_CUR A	
left join ods.t_insensitive_date_hist t
on t.user_id = a.user_id
