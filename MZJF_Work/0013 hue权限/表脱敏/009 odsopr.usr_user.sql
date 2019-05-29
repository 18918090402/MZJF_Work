ALTER VIEW odsopr.usr_user_hist AS
SELECT
       a.dw_create_by
       , a.dw_create_time
       , a.dw_update_by
       , a.dw_update_time
       , a.id
       , a.disabled
       , a.uuid
       , a.create_user
       , a .create_time
       , a.update_user
       , a.update_time
       , a.remark
       , a.username
       , a.login_pwd
       , a.deal_pwd
       , case
              when length(trim(a.mobile)) = 0
                     or a.mobile    is NULL
                     then ''
                     else CONCAT(substr(trim(a.mobile),1,3), '****' ,substr(trim(a.mobile),-4,4))
       end mobile
       , a.mobile_address
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
       , a.sex
       , a.nation
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
       , a.idcard_address
       , case
              when length(trim(a.bank_card_no)) = 0
                     or a.bank_card_no    is NULL
                     then ''
                     else CONCAT(substr(trim(a.bank_card_no),1,4), '***********' ,substr(trim(a.bank_card_no),-4,4))
       end bank_card_no
       , a.bank_name
       , a.nono_userid
       , a.nono_old_user
       , a.channel_id
       , a.last_login_time
       , a.forbid_withdraw
       , a.package_type
FROM
       ODS.T_USR_USER_HIST A
;