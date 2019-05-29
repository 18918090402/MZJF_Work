set mapreduce.job.name = idw_fact_biz_nono_invest_cash_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_NONO_INVEST_CASH partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         CASH_SRC_ID,
         CASH_SRC_TAB,
         USER_ID,
         case
           when INVEST_TYPE_CODE = 1 then
            '散投'
           when INVEST_TYPE_CODE = 2 then
            '债转'
           when INVEST_TYPE_CODE = 3 then
            CATEGORY_NAME_02
           WHEN INVEST_TYPE_CODE = 4 THEN
            'E诺千金'
           WHEN INVEST_TYPE_CODE = 5 THEN
            '活期'
           WHEN INVEST_TYPE_CODE = 99 THEN
            'NA'
           ELSE
            'NA'
         end PRODUCT_CATEGORY,
         FP_ID,
         PLAN_CASH_TIME,
         ACTUAL_CASH_TIME,
         CASH_STATUS,
         PRICE_PRINCIPAL,
         PRICE_INTEREST,
         PRICE_AMT,
         PRICE_PUNISH,
         CASH_TYPE_CODE,
         DATA_STATE
    from IDW.FACT_NONO_INVEST_CASH
   WHERE platform = 1
     and DATA_STATE = 'current';

set mapreduce.job.name = idw_fact_biz_nono_invest_cash_curing;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_NONO_INVEST_CASH partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         CASH_SRC_ID,
         CASH_SRC_TAB,
         USER_ID,
         case
           when INVEST_TYPE_CODE = 1 then
            '散投'
           when INVEST_TYPE_CODE = 2 then
            '债转'
           when INVEST_TYPE_CODE = 3 then
            CATEGORY_NAME_02
           WHEN INVEST_TYPE_CODE = 4 THEN
            'E诺千金'
           WHEN INVEST_TYPE_CODE = 5 THEN
            '活期'
           WHEN INVEST_TYPE_CODE = 99 THEN
            'NA'
           ELSE
            'NA'
         end PRODUCT_CATEGORY,
         FP_ID,
         PLAN_CASH_TIME,
         ACTUAL_CASH_TIME,
         CASH_STATUS,
         PRICE_PRINCIPAL,
         PRICE_INTEREST,
         PRICE_AMT,
         PRICE_PUNISH,
         CASH_TYPE_CODE,
         DATA_STATE
    from IDW.FACT_NONO_INVEST_CASH
   WHERE platform = 1
     and DATA_STATE = 'curing';