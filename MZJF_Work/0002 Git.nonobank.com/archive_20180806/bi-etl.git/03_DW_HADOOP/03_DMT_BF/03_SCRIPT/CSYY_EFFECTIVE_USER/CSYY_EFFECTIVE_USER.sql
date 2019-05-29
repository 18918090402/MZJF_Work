set mapreduce.job.name = DMT_BF_CSYY_EFFECTIVE_USER_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table DMT_BF.CSYY_EFFECTIVE_USER partition
  (STAT_DATE)
  select 'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         ui.user_id,
         ar.merchant_user_id user_code,
         ui.mobile_num,
         ui.gender,
         ui.real_name,
         '{T_SUB_1}' stat_date
    from idw.dim_user ui
    left join odsopr.account_relation_hist ar
      on ui.user_id = ar.nono_user_id
    left join (select user_code,
                      row_number() over(partition by user_code order by create_date desc) rn
                 from odsopr.user_bind_card_hist) ubc
      on ar.merchant_user_id = ubc.user_code
     and ubc.rn = 1
   where ui.register_biz = 'csyy'
     and (ui.FIRST_BIND_CARD_TIME is not null or
         ui.register_time >=
         date_add(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'), -180) or
         ubc.user_code is not null)
     and length(ui.mobile_num) = 11;