--原始
CREATE VIEW odsopr.user_pengyuan_edu_record AS SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.name,a.idnum,a.college,a.degree,a.enroldate,a.specialityname,a.graduatetime,a.studyresult,a.studystyle,a.status,a.create_time,a.update_time,a.version	
FROM ODSOPR.USER_PENGYUAN_EDU_RECORD_HIST A	
LEFT JOIN ODSOPR.USER_PENGYUAN_EDU_RECORD_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id,a.name,a.idnum,a.college,a.degree,a.enroldate,a.specialityname,a.graduatetime,a.studyresult,a.studystyle,a.status,a.create_time,a.update_time,a.version	
FROM ODSOPR.USER_PENGYUAN_EDU_RECORD_CUR A	




--修改
ALTER VIEW odsopr.user_pengyuan_edu_record 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id
        ,t.real_name
        ,t.id_num
        ,a.college,a.degree,a.enroldate,a.specialityname,a.graduatetime,a.studyresult,a.studystyle,a.status,a.create_time,a.update_time,a.version	
FROM ODSOPR.USER_PENGYUAN_EDU_RECORD_HIST A	
LEFT JOIN ODSOPR.USER_PENGYUAN_EDU_RECORD_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
left join ods.t_insensitive_date_hist t
on t.user_id = a.user_id
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.user_id
        ,t.real_name
        ,t.id_num
        ,a.college,a.degree,a.enroldate,a.specialityname,a.graduatetime,a.studyresult,a.studystyle,a.status,a.create_time,a.update_time,a.version	
FROM ODSOPR.USER_PENGYUAN_EDU_RECORD_CUR A	
left join ods.t_insensitive_date_hist t
on t.user_id = a.user_id


