set mapreduce.job.name = idw_fact_biz_csyy_withdraw_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_CSYY_WITHDRAW partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t1.WITHDRAW_SRC_ID,
         t1.WITHDRAW_SRC_TAB,
         t2.merchant_user_id USER_CODE,
         t1.USER_ID,
         t1.WITHDRAW_CHANNEL,
         t1.WITHDRAW_AMT,
         t1.WITHDRAW_TIME,
         t1.FEE,
         t1.BANK_NAME,
         t1.BANK_CARD_NO,
         t1.PROVINCE_NAME,
         t1.CITY_NAME,
         t1.DATA_STATE
    from IDW.FACT_NONO_WITHDRAW t1
    left join ods.t_account_relation_hist t2
      on t1.user_id = t2.nono_user_id
   where t1.DATA_STATE = 'current'
     and t1.system_id = 'CSYY'
  union all
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t1.WITHDRAW_SRC_ID,
         t1.WITHDRAW_SRC_TAB,
         t1.USER_CODE,
         t1.USER_ID,
         null WITHDRAW_CHANNEL,
         t1.WITHDRAW_AMT,
         t1.WITHDRAW_TIME,
         null FEE,
         null BANK_NAME,
         null BANK_CARD_NO,
         null PROVINCE_NAME,
         null CITY_NAME,
         'current' DATA_STATE
    from IDW.FACT_CSYY_WITHDRAW t1;