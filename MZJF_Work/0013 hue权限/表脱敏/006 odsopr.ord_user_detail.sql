ALTER VIEW odsopr.ord_user_detail_hist AS
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
       , '****' remark
       , a.user_id
       , case
              when length(trim(a.name)) = 0
                     or a.name    is NULL
                     then ''
              when length(trim(a.name)) = 1
                     then a.name
              when length(trim(a.name)) = 2
                     then CONCAT(substr(a.name,1,1), '*')
              when length(trim(a.name)) = 3
                     then CONCAT(substr(a.name,1,1), repeat('*',length(a.name)-2),substr(trim(a.name),-1))
              when length(trim(a.name)) > 3
                     then
                     case
                            when a.name like '%公司%'
                                   then CONCAT(substr(a.name,1,1), repeat('*',length(a.name)-2),substr(trim(a.name),-2))
                                   else CONCAT(substr(a.name,1,1), repeat('*',length(a.name)-2),substr(trim(a.name),-1))
                     end
       end name
       , a.sex
       , a.idcard_address
       , case
              when length(trim(a.idcard)) = 0
                     or a.idcard    is NULL
                     then ''
              when length(trim(a.idcard)) = 9
                     then CONCAT(substr(trim(a.idcard),1,2), '*****' ,substr(trim(a.idcard),-2,2))
              when length(trim(a.idcard)) = 15
                     then CONCAT(substr(trim(a.idcard),1,3), '*********' ,substr(trim(a.idcard),-3,3))
              when length(trim(a.idcard)) = 18
                     then CONCAT(substr(trim(a.idcard),1,3), '***********' ,substr(trim(a.idcard),-4,4))
       end idcard
       , '*****'  idcard_photo
       , a.address
       , a.user_type
       , a.province_code
       , a.city_code
       , a.county_code
       , a.work_type
       , a.work_position
       , a.company_name
       , a.academic
       , case when length(trim(a.family_user)) = 0 then '' else CONCAT(substr(trim(a.family_user),1,1), '*') end family_user
       , case when length(trim(a.family_user_mobile)) = 0 then '' else CONCAT(substr(trim(a.family_user_mobile),1,3), '*******') end family_user_mobile
       , a.wechat
       , a.email
       , a.use_source
       , a.nono_old_user
       , a.entry_year
       , case when length(trim(a.spouse_name)) = 0 then '' else CONCAT(substr(trim(a.spouse_name),1,1), '*') end spouse_name
       , case
              when length(trim(a.spouse_idcard)) = 0
                     or a.spouse_idcard    is NULL
                     then ''
              when length(trim(a.spouse_idcard)) = 9
                     then CONCAT(substr(trim(a.spouse_idcard),1,2), '*****' ,substr(trim(a.spouse_idcard),-2,2))
              when length(trim(a.spouse_idcard)) = 15
                     then CONCAT(substr(trim(a.spouse_idcard),1,3), '*********' ,substr(trim(a.spouse_idcard),-3,3))
              when length(trim(a.spouse_idcard)) = 18
                     then CONCAT(substr(trim(a.spouse_idcard),1,3), '***********' ,substr(trim(a.spouse_idcard),-4,4))
       end spouse_idcard
       , case when length(trim(a.spouse_mobile)) = 0 then '' else CONCAT(substr(trim(a.spouse_mobile),1,3), '*******') end spouse_mobile
       , a.fdd_auth_status
       , a.nation
       , a.agency
       , a.valid_date_end
       , a.monthly_salary
       , a.marriage_status
       , a.house_status
       , a.family_relationship
FROM
       ODS.T_ORD_USER_DETAIL_HIST A
;