set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_1_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

FROM 
(
  select to_date(register_time) as DATA_TIME,
         register_biz BIZ,
         count(1) as CURDATE_REGISTER_CNT
    from idw.dim_user
   where register_time >= to_date('{T_SUB_1}')
     and register_time < to_date('{T}')
   group by to_date(register_time), register_biz
) OUTPUT
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_REGISTER_CNT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_REGISTER_CNT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         1 METRIC_ID,
         BIZ;