set mapreduce.job.name = idw_fact_biz_csyy_recharge_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_CSYY_RECHARGE partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t1.RECHARGE_SRC_ID,
         t1.RECHARGE_SRC_TAB,
         t2.merchant_user_id USER_CODE,
         t1.USER_ID,
         t1.RECHARGE_TIME,
         t1.PAY_TYPE,
         t1.RECHARGE_TYPE,
         t1.RECHARGE_AMT,
         t1.ORDER_NO,
         t1.ORDER_SN,
         t1.BANK_NAME,
         t1.BANK_CARD_NO,
         t1.DATA_STATE
    from idw.FACT_NONO_RECHARGE t1
    left join ods.t_account_relation_hist t2
      on t1.user_id = t2.nono_user_id
   where t1.DATA_STATE = 'current'
     and t1.system_id = 'CSYY'
  union all
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t1.RECHARGE_SRC_ID,
         t1.RECHARGE_SRC_TAB,
         t1.USER_CODE,
         t1.USER_ID,
         t1.RECHARGE_TIME,
         t1.PAY_TYPE,
         null RECHARGE_TYPE,
         t1.RECHARGE_AMT,
         t1.ORDER_ID ORDER_NO,
         null ORDER_SN,
         t1.BANK_NAME,
         t1.BANK_CARD_NO,
         'current' DATA_STATE
    from idw.FACT_CSYY_RECHARGE t1;