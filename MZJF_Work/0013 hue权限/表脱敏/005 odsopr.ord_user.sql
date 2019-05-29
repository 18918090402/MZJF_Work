ALTER VIEW odsopr.ord_user_hist AS
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
       , a.username
       , a.login_pwd
       , a.deal_pwd
       , case
              when length(trim(a.mobile)) = 0
                     or a.mobile    is NULL
                     then ''
                     else CONCAT(substr(trim(a.mobile),1,3), '****' ,substr(trim(a.mobile),-4,4))
       end mobile
       , a.honor_level
       , a.salary
       , a.is_qizha
       , a.open_id
       , a.nonobank_userid
       , case
              when length(trim(a.online_account_no)) = 0
                     or a.online_account_no    is NULL
                     then ''
                     else CONCAT(substr(trim(a.online_account_no),1,4), '***********' ,substr(trim(a.online_account_no),-4,4))
       end online_account_no
       , a.channle_id
       , a.user_channle_type
       , a.mb_open_id
FROM
       ODS.T_ORD_USER_HIST A
;