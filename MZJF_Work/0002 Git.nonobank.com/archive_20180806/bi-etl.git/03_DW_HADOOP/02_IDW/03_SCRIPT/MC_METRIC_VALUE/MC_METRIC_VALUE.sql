set mapreduce.job.name = IDW_MC_METRIC_VALUE_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE PARTITION
  (DATA_TIME)
  SELECT METRIC_ID,
         BIZ,
         METRIC_CODE,
         METRIC_DIM_KEY,
         METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         DATA_TIME
    from idw.MC_METRIC_VALUE_CUR;