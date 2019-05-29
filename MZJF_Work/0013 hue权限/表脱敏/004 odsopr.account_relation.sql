ALTER VIEW odsopr.account_relation_hist AS
SELECT
       a.dw_create_by
       , a.dw_create_time
       , a.dw_update_by
       , a.dw_update_time
       , a.id
       , case
              when length(trim(a.id_num)) = 0
                     or a.id_num    is NULL
                     then ''
              when length(trim(a.id_num)) = 9
                     then CONCAT(substr(trim(a.id_num),1,2), '*****' ,substr(trim(a.id_num),-2,2))
              when length(trim(a.id_num)) = 15
                     then CONCAT(substr(trim(a.id_num),1,3), '*********' ,substr(trim(a.id_num),-3,3))
              when length(trim(a.id_num)) = 18
                     then CONCAT(substr(trim(a.id_num),1,3), '***********' ,substr(trim(a.id_num),-4,4))
       end id_num
       , a.nono_user_id
       , a.merchant_user_id
       , a.merchant_type
       , a.confirm
       , a.create_time
       , a.update_time
       , a.version
       , a.attribute
       , a.status
FROM
       ODS.T_ACCOUNT_RELATION_HIST A
;