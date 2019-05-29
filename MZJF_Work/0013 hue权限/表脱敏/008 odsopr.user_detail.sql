alter VIEW odsopr.user_detail_hist AS
SELECT
       a.dw_create_by
       , a.dw_create_time
       , a.dw_update_by
       , a.dw_update_time
       , a.user_code
       , a.certificate_type
       , case
              when length(trim(a.certificate_number)) = 0
                     or a.certificate_number    is NULL
                     then ''
              when length(trim(a.certificate_number)) = 9
                     then CONCAT(substr(trim(a.certificate_number),1,2), '*****' ,substr(trim(a.certificate_number),-2,2))
              when length(trim(a.certificate_number)) = 15
                     then CONCAT(substr(trim(a.certificate_number),1,3), '*********' ,substr(trim(a.certificate_number),-3,3))
              when length(trim(a.certificate_number)) = 18
                     then CONCAT(substr(trim(a.certificate_number),1,3), '***********' ,substr(trim(a.certificate_number),-4,4))
       end certificate_number
       , case
              when length(trim(a.real_name)) = 0
                     or a.real_name    is NULL
                     then ''
              when length(trim(a.real_name)) = 1
                     then a.real_name
              when length(trim(a.real_name)) = 2
                     then CONCAT(substr(a.real_name,1,1), '*')
              when length(trim(a.real_name)) = 3
                     then CONCAT(substr(a.real_name,1,1), repeat('*',length(a.real_name)-2),substr(trim(a.real_name),-1))
              when length(trim(a.real_name)) > 3
                     then
                     case
                            when a.real_name like '%公司%'
                                   then CONCAT(substr(a.real_name,1,1), repeat('*',length(a.real_name)-2),substr(trim(a.real_name),-2))
                                   else CONCAT(substr(a.real_name,1,1), repeat('*',length(a.real_name)-2),substr(trim(a.real_name),-1))
                     end
       end real_name
       , a.pay_password
       , a.has_pay_password
       , a.is_mobile_authen
       , a.mobile_authen_time
       , a.is_certificate_authen
       , a.certificate_authen_time
       , a.register_time
       , a.is_bind_bankcard
       , a.register_approach
       , a.openid
       , a.operation
       , a.is_mxd_student
       , a.is_schoolroll_authen
       , a.schoolroll_authen_time
       , a.sync_flag
       , a.born_year
       , a.born_month
       , a.born_day
       , a.sex
FROM
       ODS.T_USER_DETAIL_HIST A
;