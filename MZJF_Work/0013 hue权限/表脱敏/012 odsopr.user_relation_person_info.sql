--原始
ALTER VIEW odsopr.user_relation_person_info 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.last_name,a.first_name,a.phone_arr,a.email_arr,a.address_arr,a.middle_name,a.notes,a.birthday,a.nick_name,a.department,a.job,a.organization,a.flag,a.create_time,a.update_time	
FROM ODSOPR.USER_RELATION_PERSON_INFO_HIST A	
LEFT JOIN ODSOPR.USER_RELATION_PERSON_INFO_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.last_name,a.first_name,a.phone_arr,a.email_arr,a.address_arr,a.middle_name,a.notes,a.birthday,a.nick_name,a.department,a.job,a.organization,a.flag,a.create_time,a.update_time	
FROM ODSOPR.USER_RELATION_PERSON_INFO_CUR A	


--hist 原始
CREATE VIEW odsopr.user_relation_person_info_hist AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.user_id, a.last_name, a.first_name, a.phone_arr, a.email_arr, a.address_arr, a.middle_name, a.notes, a.birthday, a.nick_name, a.department, a.job, a.organization, a.flag, a.create_time, a.update_time FROM ODS.T_USER_RELATION_PERSON_INFO_HIST A



--cur 原始
CREATE VIEW odsopr.user_relation_person_info_cur AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.user_id, a.last_name, a.first_name, a.phone_arr, a.email_arr, a.address_arr, a.middle_name, a.notes, a.birthday, a.nick_name, a.department, a.job, a.organization, a.flag, a.create_time, a.update_time, a.p_run_id FROM ODS.T_USER_RELATION_PERSON_INFO_CUR A	
    WHERE a.p_run_id = 277620	



-- user_relation_person_info_x  修改
CREATE VIEW odsopr.user_relation_person_info_x 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id
        ,case 
            when trim(a.last_name) = '' or a.last_name is NULL then ''
            when length('中') = 3 -- hive sql
                then substr(trim(regexp_replace(a.last_name,'[A-Za-z0-9_-]+','')) ,1 ,3)
            when length('中') = 1 -- impala sql
                then substr(trim(regexp_replace(a.last_name,'[A-Za-z0-9_-]+','')) ,1 ,1)
        end last_name
        ,case 
            when trim(a.first_name) = '' or a.first_name is NULL then ''
            else '*'
        end first_name
        ,case 
            when trim(a.phone_arr) = '' or a.phone_arr is NULL then ''
            else concat(substr(regexp_extract(a.phone_arr, '([0-9]+)', 1) ,1 ,3) ,'********') 
        end phone_arr
        ,a.email_arr
        ,a.address_arr,a.middle_name,a.notes,a.birthday,a.nick_name,a.department,a.job,a.organization,a.flag,a.create_time,a.update_time	
FROM ODSOPR.USER_RELATION_PERSON_INFO A	
