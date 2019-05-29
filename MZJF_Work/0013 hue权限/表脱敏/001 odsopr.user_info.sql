


--原始
ALTER VIEW odsopr.user_info 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_key,a.user_name,a.password,a.pay_password,a.mobile_num,a.id_num,a.user_type,a.real_name,a.gender,a.email,a.is_mobile,a.is_card,a.card_needcheck,a.is_education,a.is_student,a.is_email,a.is_photo,a.is_dunning,a.is_cheat,a.status,a.is_special,a.customer_servicer,a.finance_advisor,a.finance_advisor_manager,a.recommender,a.pc_id,a.is_sync,a.is_bbs_sync,a.nono_id_checked,a.register_time,a.create_time,a.update_time,a.creater,a.updater,a.version,a.is_deposit,a.biz_code,a.card_type	
FROM ODSOPR.USER_INFO_HIST A	
LEFT JOIN ODSOPR.USER_INFO_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_key,a.user_name,a.password,a.pay_password,a.mobile_num,a.id_num,a.user_type,a.real_name,a.gender,a.email,a.is_mobile,a.is_card,a.card_needcheck,a.is_education,a.is_student,a.is_email,a.is_photo,a.is_dunning,a.is_cheat,a.status,a.is_special,a.customer_servicer,a.finance_advisor,a.finance_advisor_manager,a.recommender,a.pc_id,a.is_sync,a.is_bbs_sync,a.nono_id_checked,a.register_time,a.create_time,a.update_time,a.creater,a.updater,a.version,a.is_deposit,a.biz_code,a.card_type	
FROM ODSOPR.USER_INFO_CUR A	



--修改
ALTER VIEW odsopr.user_info
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_key,a.user_name,a.password,a.pay_password
        ,t.mobile_num
        ,t.id_num,a.user_type
        ,t.real_name
        ,a.gender,a.email,a.is_mobile,a.is_card,a.card_needcheck,a.is_education,a.is_student,a.is_email,a.is_photo,a.is_dunning,a.is_cheat,a.status,a.is_special,a.customer_servicer,a.finance_advisor,a.finance_advisor_manager,a.recommender,a.pc_id,a.is_sync,a.is_bbs_sync,a.nono_id_checked,a.register_time,a.create_time,a.update_time,a.creater,a.updater,a.version,a.is_deposit,a.biz_code,a.card_type	
FROM ODSOPR.USER_INFO_HIST A	
LEFT JOIN ODSOPR.USER_INFO_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
left join idw.dim_insensitive_data t
on t.user_id = a.id
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_key,a.user_name,a.password,a.pay_password
        ,t.mobile_num
        ,t.id_num,a.user_type
        ,t.real_name
        ,a.gender,a.email,a.is_mobile,a.is_card,a.card_needcheck,a.is_education,a.is_student,a.is_email,a.is_photo,a.is_dunning,a.is_cheat,a.status,a.is_special,a.customer_servicer,a.finance_advisor,a.finance_advisor_manager,a.recommender,a.pc_id,a.is_sync,a.is_bbs_sync,a.nono_id_checked,a.register_time,a.create_time,a.update_time,a.creater,a.updater,a.version,a.is_deposit,a.biz_code,a.card_type	
FROM ODSOPR.USER_INFO_CUR A	
left join idw.dim_insensitive_data t
on t.user_id = a.id





--cur 原始
CREATE VIEW odsopr.user_info_cur AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.user_key, a.user_name, a.password, a.pay_password, a.mobile_num, a.id_num, a.user_type, a.real_name, a.gender, a.email, a.is_mobile, a.is_card, a.card_needcheck, a.is_education, a.is_student, a.is_email, a.is_photo, a.is_dunning, a.is_cheat, a.status, a.is_special, a.customer_servicer, a.finance_advisor, a.finance_advisor_manager, a.recommender, a.pc_id, a.is_sync, a.is_bbs_sync, a.nono_id_checked, a.register_time, a.create_time, a.update_time, a.creater, a.updater, a.version, a.is_deposit, a.biz_code, a.card_type, a.p_run_id FROM ODS.T_USER_INFO_CUR A	
    WHERE a.p_run_id = 262336	



--hist 原始
ALTER VIEW odsopr.user_info_hist AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.user_key, a.user_name, a.password, a.pay_password, a.mobile_num, a.id_num, a.user_type, a.real_name, a.gender, a.email, a.is_mobile, a.is_card, a.card_needcheck, a.is_education, a.is_student, a.is_email, a.is_photo, a.is_dunning, a.is_cheat, a.status, a.is_special, a.customer_servicer, a.finance_advisor, a.finance_advisor_manager, a.recommender, a.pc_id, a.is_sync, a.is_bbs_sync, a.nono_id_checked, a.register_time, a.create_time, a.update_time, a.creater, a.updater, a.version, a.is_deposit, a.biz_code, a.card_type FROM ODS.T_USER_INFO_hist A	




--hist 修改
ALTER VIEW odsopr.user_info_hist
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_key,a.user_name,a.password,a.pay_password
       ,case
              when length(trim(a.mobile_num)) = 0
                     or a.mobile_num    is NULL
                     then ''
                     else CONCAT(substr(trim(regexp_replace(a.mobile_num,'\[\_\-\]\+','')),1,3), '****' ,substr(trim(regexp_replace(a.mobile_num,'\[\_\-\]\+','')),-4,4))
       end mobile_num
        ,case
              when length(trim(a.id_num)) = 0
                     or a.id_num    is NULL
                     then ''
              when length(trim(a.id_num)) = 9
                     then CONCAT(substr(trim(regexp_replace(a.id_num,'\[\-\_1\]\+','')),1,2), '*****' ,substr(trim(regexp_replace(a.id_num,'\[\-\_1\]\+','')),-2,2))
              when length(trim(a.id_num)) = 15
                     then CONCAT(substr(trim(regexp_replace(a.id_num,'\[\-\_1\]\+','')),1,3), '*********' ,substr(trim(regexp_replace(a.id_num,'\[\-\_1\]\+','')),-3,3))
              when length(trim(a.id_num)) = 18
                     then CONCAT(substr(trim(regexp_replace(a.id_num,'\[\-\_1\]\+','')),1,3), '***********' ,substr(trim(regexp_replace(a.id_num,'\[\-\_1\]\+','')),-4,4))
                     else CONCAT(substr(trim(regexp_replace(a.id_num,'\[\-\_1\]\+','')),1,2), '***********' ,substr(trim(regexp_replace(a.id_num,'\[\-\_1\]\+','')),-2,2))
        end id_num
        ,a.user_type
        ,case
            when length(trim(a.real_name)) = 0
                 or a.real_name    is NULL
                 then ''
            when length('中') = 1 and length(trim(a.real_name)) = 1
                 then a.real_name
            when length('中') = 1 and length(trim(a.real_name)) = 2
                 then CONCAT(substr(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+',''),1,1) ,'*')
            when length('中') = 1 and length(trim(a.real_name)) = 3
                 then CONCAT(substr(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+',''),1,1) ,'*' ,substr(trim(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+','')),-1))
            when length('中') = 1 and length(trim(a.real_name)) > 3
                 then
                 case
                    when a.real_name like '%公司'
                        then CONCAT(substr(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+',''),1,1) ,'*' ,substr(trim(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+','')),-2))
                        else CONCAT(substr(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+',''),1,1) ,'*' ,substr(trim(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+','')),-1))
                 end
            when length('中') = 3 and length(trim(a.real_name)) = 3
                 then a.real_name
            when length('中') = 3 and length(trim(a.real_name)) = 6
                 then CONCAT(substr(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+',''),1,3) ,'*')
            when length('中') = 3 and length(trim(a.real_name)) = 6
                 then CONCAT(substr(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+',''),1,3) ,'*' ,substr(trim(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+','')),-3))
            when length('中') = 3 and length(trim(a.real_name)) > 6
                 then
                 case
                    when a.real_name like '%公司'
                        then CONCAT(substr(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+',''),1,3) ,'*' ,substr(trim(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+','')),-6))
                        else CONCAT(substr(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+',''),1,3) ,'*' ,substr(trim(regexp_replace(a.real_name,'\[\-\·\)\_1\]\+','')),-3))
                 end                 
        end real_name
        ,a.gender,a.email,a.is_mobile,a.is_card,a.card_needcheck,a.is_education,a.is_student,a.is_email,a.is_photo,a.is_dunning,a.is_cheat,a.status,a.is_special,a.customer_servicer,a.finance_advisor,a.finance_advisor_manager,a.recommender,a.pc_id,a.is_sync,a.is_bbs_sync,a.nono_id_checked,a.register_time,a.create_time,a.update_time,a.creater,a.updater,a.version,a.is_deposit,a.biz_code,a.card_type	
FROM ODS.T_USER_INFO_hist A	


