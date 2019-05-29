set mapreduce.job.name = IDW_FACT_CSYY_USER_CASH_STAT_DAILY_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_CSYY_USER_CASH_STAT_DAILY partition
  (STAT_DATE)
  select ic.user_code,
         ic.user_id,
         ic.product_code,
         p.product_name,
         sum(case
               when ic.product_code = 'NN0018' then
                ic.price_amt
               else
                ic.price_principal
             end) CASH_AMT,
         sum(case
               when ic.cash_type_code = 2 then
                ic.price_principal
               else
                0
             end) HZD_AMT,
         sum(case
               when ic.cash_type_code = 1 then
                ic.price_principal
               else
                0
             end) HQ_WITHDRAW_AMT,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         to_date(ic.cash_time) STAT_DATE
    from idw.fact_csyy_invest_cash ic
    left join idw.DIM_CSYY_PRODUCT p
      on ic.product_code = p.product_code
   where ic.cash_time >= to_date('{LAST_DATA_TIME}')
     and ic.cash_time < to_date('{T}')
   group by ic.user_code,
            ic.user_id,
            ic.product_code,
            p.product_name,
            to_date(ic.cash_time);