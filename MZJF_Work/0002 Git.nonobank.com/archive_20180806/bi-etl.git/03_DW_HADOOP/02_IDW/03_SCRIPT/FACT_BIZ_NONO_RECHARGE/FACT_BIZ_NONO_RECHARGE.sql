set mapreduce.job.name = idw_fact_biz_nono_recharge_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_NONO_RECHARGE partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t2.RECHARGE_SRC_ID,
         t2.RECHARGE_SRC_TAB,
         t2.USER_ID,
         t2.RECHARGE_TIME,
         t2.PAY_TYPE,
         t2.RECHARGE_TYPE,
         t2.RECHARGE_AMT,
         t2.ORDER_NO,
         t2.ORDER_SN,
         t2.BANK_NAME,
         t2.BANK_CARD_NO,
         t2.DATA_STATE
    from idw.FACT_NONO_RECHARGE t2
   where t2.DATA_STATE = 'current'
     and t2.system_id = 'NONOBANK';

set mapreduce.job.name = idw_fact_biz_nono_recharge_curing;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_NONO_RECHARGE partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t2.RECHARGE_SRC_ID,
         t2.RECHARGE_SRC_TAB,
         t2.USER_ID,
         t2.RECHARGE_TIME,
         t2.PAY_TYPE,
         t2.RECHARGE_TYPE,
         t2.RECHARGE_AMT,
         t2.ORDER_NO,
         t2.ORDER_SN,
         t2.BANK_NAME,
         t2.BANK_CARD_NO,
         t2.DATA_STATE
    from idw.dim_user t1
    join idw.FACT_NONO_RECHARGE t2
      on t1.user_id = t2.user_id
   where t1.register_biz in ('csyy', 'nono')
     and t2.DATA_STATE = 'curing';