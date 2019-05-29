ALTER VIEW odsopr.hor_data_header_hist AS
SELECT
       a.dw_create_by
       , a.dw_create_time
       , a.dw_update_by
       , a.dw_update_time
       , a.id
       , a.disabled
       , a.uuid
       , a.create_user
       , a.create_time
       , a.update_user
       , a.update_time
       , a.remark
       , a.channel_code
       , a.channel_name
       , a.version
       , a.platform_id
       , a.platform_name
       , case
              when length(trim(a.user_cert_no)) = 0
                     or a.user_cert_no    is NULL
                     then ''
              when length(trim(a.user_cert_no)) = 9
                     then CONCAT(substr(trim(a.user_cert_no),1,2), '*****' ,substr(trim(a.user_cert_no),-2,2))
              when length(trim(a.user_cert_no)) = 15
                     then CONCAT(substr(trim(a.user_cert_no),1,3), '*********' ,substr(trim(a.user_cert_no),-3,3))
              when length(trim(a.user_cert_no)) = 18
                     then CONCAT(substr(trim(a.user_cert_no),1,3), '***********' ,substr(trim(a.user_cert_no),-4,4))
       end user_cert_no
       , a.user_cert_type
       , a.status
       , a.err_data
FROM
       ODS.T_HOR_DATA_HEADER_HIST A
;


--

ALTER VIEW odsopr.hor_data_header_hist AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.disabled, a.uuid, a.create_user, a.create_time, a.update_user, a.update_time, a.remark, a.channel_code, a.channel_name, a.version, a.platform_id, a.platform_name, a.user_cert_no, a.user_cert_type, a.status, a.err_data FROM ODS.T_HOR_DATA_HEADER_HIST A	



--Ô­Ê¼
createtab_stmt	
CREATE VIEW odsopr.hor_data_header AS SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.channel_code,a.channel_name,a.version,a.platform_id,a.platform_name,a.user_cert_no,a.user_cert_type,a.status,a.err_data	
FROM ODSOPR.HOR_DATA_HEADER_HIST A	
LEFT JOIN ODSOPR.HOR_DATA_HEADER_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.channel_code,a.channel_name,a.version,a.platform_id,a.platform_name,a.user_cert_no,a.user_cert_type,a.status,a.err_data	
FROM ODSOPR.HOR_DATA_HEADER_CUR A	




--ÐÞ¸Ä
ALTER VIEW odsopr.hor_data_header 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.channel_code,a.channel_name,a.version,a.platform_id,a.platform_name
        ,case
              when length(trim(a.user_cert_no)) = 0
                     or a.user_cert_no    is NULL
                     then ''
              when length(trim(a.user_cert_no)) = 9
                     then CONCAT(substr(trim(a.user_cert_no),1,2), '*****' ,substr(trim(a.user_cert_no),-2,2))
              when length(trim(a.user_cert_no)) = 15
                     then CONCAT(substr(trim(a.user_cert_no),1,3), '*********' ,substr(trim(a.user_cert_no),-3,3))
              when length(trim(a.user_cert_no)) = 18
                     then CONCAT(substr(trim(a.user_cert_no),1,3), '***********' ,substr(trim(a.user_cert_no),-4,4))
        end user_cert_no
        ,a.user_cert_type,a.status,a.err_data	
FROM ODSOPR.HOR_DATA_HEADER_HIST A	
LEFT JOIN ODSOPR.HOR_DATA_HEADER_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.channel_code,a.channel_name,a.version,a.platform_id,a.platform_name
        ,case
              when length(trim(a.user_cert_no)) = 0
                     or a.user_cert_no    is NULL
                     then ''
              when length(trim(a.user_cert_no)) = 9
                     then CONCAT(substr(trim(a.user_cert_no),1,2), '*****' ,substr(trim(a.user_cert_no),-2,2))
              when length(trim(a.user_cert_no)) = 15
                     then CONCAT(substr(trim(a.user_cert_no),1,3), '*********' ,substr(trim(a.user_cert_no),-3,3))
              when length(trim(a.user_cert_no)) = 18
                     then CONCAT(substr(trim(a.user_cert_no),1,3), '***********' ,substr(trim(a.user_cert_no),-4,4))
        end user_cert_no
        ,a.user_cert_type,a.status,a.err_data	
FROM ODSOPR.HOR_DATA_HEADER_CUR A	
