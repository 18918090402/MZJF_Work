ALTER VIEW odsopr.user_hist AS
SELECT
       a.dw_create_by
       , a.dw_create_time
       , a.dw_update_by
       , a.dw_update_time
       , a.user_code
       , a.user_type
       , a.user_name
       , case
              when length(trim(a.mobile_number)) = 0
                     or a.mobile_number    is NULL
                     then ''
                     else CONCAT(substr(trim(a.mobile_number),1,3), '****' ,substr(trim(a.mobile_number),-4,4))
       end mobile_number
       , a.device_id
       , a.login_password
       , a.has_login_password
       , a.hand_password
       , a.has_hand_password
       , a.created_date
       , a.updated_date
       , a.is_old_user
       , a.user_style
       , a.valid_control
       , a.sync_flag
       , a.is_deleted
FROM
       ODS.T_USER_HIST A
;
