set mapreduce.job.name = idw_fact_biz_nono_withdraw_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_NONO_WITHDRAW partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t2.WITHDRAW_SRC_ID,
         t2.WITHDRAW_SRC_TAB,
         t2.USER_ID,
         t2.WITHDRAW_CHANNEL,
         t2.WITHDRAW_AMT,
         t2.WITHDRAW_TIME,
         t2.FEE,
         t2.BANK_NAME,
         t2.BANK_CARD_NO,
         t2.PROVINCE_NAME,
         t2.CITY_NAME,
         t2.DATA_STATE
    from IDW.FACT_NONO_WITHDRAW t2
   where t2.DATA_STATE = 'current'
     and t2.system_id = 'NONOBANK';

set mapreduce.job.name = idw_fact_biz_nono_withdraw_curing;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_NONO_WITHDRAW partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t2.WITHDRAW_SRC_ID,
         t2.WITHDRAW_SRC_TAB,
         t2.USER_ID,
         t2.WITHDRAW_CHANNEL,
         t2.WITHDRAW_AMT,
         t2.WITHDRAW_TIME,
         t2.FEE,
         t2.BANK_NAME,
         t2.BANK_CARD_NO,
         t2.PROVINCE_NAME,
         t2.CITY_NAME,
         t2.DATA_STATE
    from idw.dim_user t1
    join IDW.FACT_NONO_WITHDRAW t2
      on t1.user_id = t2.user_id
   where t1.register_biz in ('csyy', 'nono')
     and t2.DATA_STATE = 'curing'
     and t2.bo_id is null;