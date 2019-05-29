set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_2_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

FROM 
(
  select to_date(uba.auth_time) as DATA_TIME,
         ui.register_biz BIZ,
         count(distinct uba.user_id) as CURDATE_BIND_CARD_USER_CNT
    from odsopr.user_bankcard_auth uba
    join idw.dim_user ui
      on uba.user_id = ui.user_id
   where uba.auth_status = 1
     and uba.auth_time >= to_date('{T_SUB_1}')
     and uba.auth_time < to_date('{T}')
   group by to_date(uba.auth_time), ui.register_biz
) OUTPUT
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_BIND_CARD_USER_CNT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_BIND_CARD_USER_CNT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         2 METRIC_ID,
         BIZ;