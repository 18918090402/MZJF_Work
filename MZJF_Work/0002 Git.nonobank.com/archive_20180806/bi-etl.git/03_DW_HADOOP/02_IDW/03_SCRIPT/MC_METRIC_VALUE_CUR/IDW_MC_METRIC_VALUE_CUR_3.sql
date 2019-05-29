set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_3_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

FROM 
(
  select stat_date DATA_TIME,
         'nono' BIZ,
         sum(if(curdate_invest_amt > 0, 1, 0)) as CURDATE_INVEST_USER_CNT,
         sum(curdate_invest_amt) as CURDATE_INVEST_AMT,
         sum(if(aum > 0, 1, 0)) as AUM_USER_CNT,
         sum(aum) as AUM,
         sum(curdate_withdraw_amt) as CURDATE_WITHDRAW_AMT,
         sum(curdate_cash_amt) as CURDATE_CASH_AMT,
         sum(curdate_deductible_amt) as CURDATE_DEDUCTIBLE_AMT,
         sum(curdate_add_rate) as CURDATE_ADD_AMT,
         sum(curdate_balance_amt) as CURDATE_USER_BALANCE_AMT,
         sum(if(curdate_first_invest_amt > 0, 1, 0)) as CURDATE_FIRST_INVEST_USER_CNT,
         sum(curdate_first_invest_amt) as CURDATE_FIRST_INVEST_AMT,
         sum(if(curdate_second_invest_amt > 0, 1, 0)) as CURDATE_SECOND_INVEST_USER_CNT,
         sum(curdate_second_invest_amt) as CURDATE_SECOND_INVEST_AMT,
         sum(if(curdate_third_or_more_nvest_amt > 0, 1, 0)) as CURDATE_THIRD_OR_MORE_INVEST_USER_CNT,
         sum(curdate_third_or_more_nvest_amt) as CURDATE_THIRD_OR_MORE_NVEST_AMT
    from idw.fact_nono_user_stat_daily
   where stat_date = to_date('{T_SUB_1}')
     and user_id != 13936
   group by stat_date
) OUTPUT
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_INVEST_USER_CNT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_INVEST_USER_CNT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         3 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_INVEST_AMT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_INVEST_AMT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         4 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_FIRST_INVEST_USER_CNT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_FIRST_INVEST_USER_CNT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         5 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_FIRST_INVEST_AMT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_FIRST_INVEST_AMT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         6 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_SECOND_INVEST_USER_CNT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_SECOND_INVEST_USER_CNT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         7 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_SECOND_INVEST_AMT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_SECOND_INVEST_AMT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         8 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_THIRD_OR_MORE_INVEST_USER_CNT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_THIRD_OR_MORE_INVEST_USER_CNT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         9 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_THIRD_OR_MORE_NVEST_AMT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_THIRD_OR_MORE_NVEST_AMT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         10 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'AUM_USER_CNT' METRIC_CODE,
         null METRIC_DIM_KEY,
         AUM_USER_CNT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         11 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'AUM' METRIC_CODE,
         null METRIC_DIM_KEY,
         AUM METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         12 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_CASH_AMT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_CASH_AMT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         13 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_WITHDRAW_AMT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_WITHDRAW_AMT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         14 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_DEDUCTIBLE_AMT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_DEDUCTIBLE_AMT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         15 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_ADD_AMT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_ADD_AMT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         16 METRIC_ID,
         BIZ
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION
  (METRIC_ID, BIZ)
  SELECT DATA_TIME,
         'CURDATE_USER_BALANCE_AMT' METRIC_CODE,
         null METRIC_DIM_KEY,
         CURDATE_USER_BALANCE_AMT METRIC_VALUE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         17 METRIC_ID,
         BIZ;