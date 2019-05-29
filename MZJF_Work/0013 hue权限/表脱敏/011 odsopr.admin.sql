
--原始
CREATE VIEW odsopr.admin 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.am_username,a.am_name,a.am_password,a.dept_id,a.channel_id,a.am_level,a.am_work_id,a.am_deleted,a.am_login_admin,a.am_login_platform,a.am_roles,a.am_admin_style,a.am_pswdcard,a.am_name_short,a.am_mail,a.am_idcard,a.am_mobile,a.am_ext,a.am_duty,a.am_remark,a.is_system,a.is_score,a.is_auto_assign,a.token,a.am_show_menu,a.am_type,a.am_qq,a.version,a.create_time,a.update_time	
FROM ODSOPR.ADMIN_HIST A	
LEFT JOIN ODSOPR.ADMIN_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.am_username,a.am_name,a.am_password,a.dept_id,a.channel_id,a.am_level,a.am_work_id,a.am_deleted,a.am_login_admin,a.am_login_platform,a.am_roles,a.am_admin_style,a.am_pswdcard,a.am_name_short,a.am_mail,a.am_idcard,a.am_mobile,a.am_ext,a.am_duty,a.am_remark,a.is_system,a.is_score,a.is_auto_assign,a.token,a.am_show_menu,a.am_type,a.am_qq,a.version,a.create_time,a.update_time	
FROM ODSOPR.ADMIN_CUR A	




--修改
ALTER VIEW odsopr.admin 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.am_username,a.am_name,a.am_password,a.dept_id,a.channel_id,a.am_level,a.am_work_id,a.am_deleted,a.am_login_admin,a.am_login_platform,a.am_roles,a.am_admin_style,a.am_pswdcard,a.am_name_short,a.am_mail
       ,case
              when length(trim(a.am_idcard)) = 0
                     or a.am_idcard    is NULL
                     then ''
              when length(trim(a.am_idcard)) = 9
                     then CONCAT(substr(trim(a.am_idcard),1,2), '*****' ,substr(trim(a.am_idcard),-2,2))
              when length(trim(a.am_idcard)) = 15
                     then CONCAT(substr(trim(a.am_idcard),1,3), '*********' ,substr(trim(a.am_idcard),-3,3))
              when length(trim(a.am_idcard)) = 18
                     then CONCAT(substr(trim(a.am_idcard),1,3), '***********' ,substr(trim(a.am_idcard),-4,4))
       end am_idcard        
        ,case
              when length(trim(a.am_mobile)) = 0
                     or a.am_mobile    is NULL
                     then ''
                     else CONCAT(substr(trim(a.am_mobile),1,3), '****' ,substr(trim(a.am_mobile),-4,4))
       end am_mobile
        ,a.am_ext,a.am_duty,a.am_remark,a.is_system,a.is_score,a.is_auto_assign,a.token,a.am_show_menu,a.am_type,a.am_qq,a.version,a.create_time,a.update_time	
FROM ODSOPR.ADMIN_HIST A	
LEFT JOIN ODSOPR.ADMIN_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.am_username,a.am_name,a.am_password,a.dept_id,a.channel_id,a.am_level,a.am_work_id,a.am_deleted,a.am_login_admin,a.am_login_platform,a.am_roles,a.am_admin_style,a.am_pswdcard,a.am_name_short,a.am_mail
       ,case
              when length(trim(a.am_idcard)) = 0
                     or a.am_idcard    is NULL
                     then ''
              when length(trim(a.am_idcard)) = 9
                     then CONCAT(substr(trim(a.am_idcard),1,2), '*****' ,substr(trim(a.am_idcard),-2,2))
              when length(trim(a.am_idcard)) = 15
                     then CONCAT(substr(trim(a.am_idcard),1,3), '*********' ,substr(trim(a.am_idcard),-3,3))
              when length(trim(a.am_idcard)) = 18
                     then CONCAT(substr(trim(a.am_idcard),1,3), '***********' ,substr(trim(a.am_idcard),-4,4))
       end am_idcard        
        ,case
              when length(trim(a.am_mobile)) = 0
                     or a.am_mobile    is NULL
                     then ''
                     else CONCAT(substr(trim(a.am_mobile),1,3), '****' ,substr(trim(a.am_mobile),-4,4))
       end am_mobile
        ,a.am_ext,a.am_duty,a.am_remark,a.is_system,a.is_score,a.is_auto_assign,a.token,a.am_show_menu,a.am_type,a.am_qq,a.version,a.create_time,a.update_time	
FROM ODSOPR.ADMIN_CUR A	
