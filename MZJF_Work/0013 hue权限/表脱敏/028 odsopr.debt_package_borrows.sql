--原始
CREATE VIEW odsopr.debt_package_borrows AS SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.dp_id,a.bo_id,a.bo_extno,a.bo_finish_price,a.br_price,a.bo_expect,a.bo_remain,a.bo_sign_time,a.last_plan_time,a.real_name,a.user_name,a.id_num,a.brithday,a.mobile_num,a.academy,a.major,a.education,a.edu_start_date,a.campus,a.emergency_parent,a.emergency_counselor,a.emergency_other,a.address,a.gender,a.bo_aim,a.apply_no,a.seri_no,a.version,a.create_time,a.update_time,a.is_delete,a.bank_flag,a.va_id	
FROM ODSOPR.DEBT_PACKAGE_BORROWS_HIST A	
LEFT JOIN ODSOPR.DEBT_PACKAGE_BORROWS_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.dp_id,a.bo_id,a.bo_extno,a.bo_finish_price,a.br_price,a.bo_expect,a.bo_remain,a.bo_sign_time,a.last_plan_time,a.real_name,a.user_name,a.id_num,a.brithday,a.mobile_num,a.academy,a.major,a.education,a.edu_start_date,a.campus,a.emergency_parent,a.emergency_counselor,a.emergency_other,a.address,a.gender,a.bo_aim,a.apply_no,a.seri_no,a.version,a.create_time,a.update_time,a.is_delete,a.bank_flag,a.va_id	
FROM ODSOPR.DEBT_PACKAGE_BORROWS_CUR A	




--hist 原始
CREATE VIEW odsopr.debt_package_borrows_hist AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.dp_id, a.bo_id, a.bo_extno, a.bo_finish_price, a.br_price, a.bo_expect, a.bo_remain, a.bo_sign_time, a.last_plan_time, a.real_name, a.user_name, a.id_num, a.brithday, a.mobile_num, a.academy, a.major, a.education, a.edu_start_date, a.campus, a.emergency_parent, a.emergency_counselor, a.emergency_other, a.address, a.gender, a.bo_aim, a.apply_no, a.seri_no, a.version, a.create_time, a.update_time, a.is_delete, a.bank_flag, a.va_id FROM ODS.T_DEBT_PACKAGE_BORROWS_HIST A	



--cur 原始
CREATE VIEW odsopr.debt_package_borrows_cur AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.dp_id, a.bo_id, a.bo_extno, a.bo_finish_price, a.br_price, a.bo_expect, a.bo_remain, a.bo_sign_time, a.last_plan_time, a.real_name, a.user_name, a.id_num, a.brithday, a.mobile_num, a.academy, a.major, a.education, a.edu_start_date, a.campus, a.emergency_parent, a.emergency_counselor, a.emergency_other, a.address, a.gender, a.bo_aim, a.apply_no, a.seri_no, a.version, a.create_time, a.update_time, a.is_delete, a.bank_flag, a.va_id, a.p_run_id FROM ODS.T_DEBT_PACKAGE_BORROWS_CUR A	
    WHERE A.P_RUN_ID IN (	
    SELECT MAX(B.P_RUN_ID) AS P_RUN_ID FROM ODS.T_DEBT_PACKAGE_BORROWS_CUR B	
    )	


--  odsopr.debt_package_borrows_x
CREATE VIEW odsopr.debt_package_borrows_x 
AS 
SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.dp_id, a.bo_id, a.bo_extno, a.bo_finish_price, a.br_price, a.bo_expect, a.bo_remain, a.bo_sign_time, a.last_plan_time
        ,case 
            when trim(a.real_name) = '' or a.real_name is NULL then ''
            when length('中') = 3 -- hive sql
                then case 
                        when length(trim(a.real_name)) = 6 then concat(substr(trim(regexp_replace(a.real_name,'[A-Za-z0-9_-]+','')) ,1 ,3) ,'*')
                        when length(trim(a.real_name)) > 6 then concat(substr(trim(regexp_replace(a.real_name,'[A-Za-z0-9_-]+','')) ,1 ,3) ,'*' ,substr(trim(regexp_replace(a.real_name,'[A-Za-z0-9_-]+','')) ,-3 ,3))
                     end
            when length('中') = 1 -- impala sql
                then case 
                        when length(trim(a.real_name)) = 6 then concat(substr(trim(regexp_replace(a.real_name,'[A-Za-z0-9_-]+','')) ,1 ,1) ,'*')
                        when length(trim(a.real_name)) > 6 then concat(substr(trim(regexp_replace(a.real_name,'[A-Za-z0-9_-]+','')) ,1 ,1) ,'*' ,substr(trim(regexp_replace(a.real_name,'[A-Za-z0-9_-]+','')) ,-1 ,1))
                     end
        end real_name       
        ,a.user_name
        ,case
              when length(trim(a.id_num)) = 0
                     or a.id_num    is NULL
                     then ''
              when length(trim(a.id_num)) = 9
                     then CONCAT(substr(trim(a.id_num),1,2), '*****' ,substr(trim(a.id_num),-2,2))
              when length(trim(a.id_num)) = 15
                     then CONCAT(substr(trim(a.id_num),1,3), '*********' ,substr(trim(a.id_num),-3,3))
              when length(trim(a.id_num)) = 18
                     then CONCAT(substr(trim(a.id_num),1,3), '***********' ,substr(trim(a.id_num),-4,4))
                     else CONCAT(substr(trim(a.id_num),1,2), '***********' ,substr(trim(a.id_num),-2,2))
        end id_num
       ,a.brithday
       ,case
              when length(trim(a.mobile_num)) = 0
                     or a.mobile_num    is NULL
                     then ''
                     else CONCAT(substr(trim(a.mobile_num),1,3), '****' ,substr(trim(a.mobile_num),-4,4))
       end mobile
       ,a.academy, a.major, a.education, a.edu_start_date, a.campus
       ,case
              when length(trim(a.emergency_parent)) = 0
                     or a.emergency_parent    is NULL
                     then ''
                     else CONCAT(substr(trim(a.emergency_parent),1,3), '****' ,substr(trim(a.emergency_parent),-4,4))
       end emergency_parent       
       ,case
              when length(trim(a.emergency_counselor)) = 0
                     or a.emergency_counselor    is NULL
                     then ''
                     else CONCAT(substr(trim(a.emergency_counselor),1,3), '****' ,substr(trim(a.emergency_counselor),-4,4))
       end emergency_counselor       
       ,case
              when length(trim(a.emergency_other)) = 0
                     or a.emergency_other    is NULL
                     then ''
                     else CONCAT(substr(trim(a.emergency_other),1,3), '****' ,substr(trim(a.emergency_other),-4,4))
       end emergency_other       
       ,a.address, a.gender, a.bo_aim, a.apply_no, a.seri_no, a.version, a.create_time, a.update_time, a.is_delete, a.bank_flag, a.va_id 
FROM odsopr.debt_package_borrows A	


