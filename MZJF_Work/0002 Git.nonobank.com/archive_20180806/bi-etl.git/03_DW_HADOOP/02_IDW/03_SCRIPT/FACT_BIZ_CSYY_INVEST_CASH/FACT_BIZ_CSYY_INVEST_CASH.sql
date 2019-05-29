set mapreduce.job.name = idw_fact_biz_csyy_invest_cash_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_CSYY_INVEST_CASH partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         CASH_SRC_ID,
         CASH_SRC_TAB,
         t2.merchant_user_id USER_CODE,
         USER_ID,
         case
           when CATEGORY_CODE_02 = 1 then
            '招财新人宝'
           when CATEGORY_CODE_02 = 11 then
            '招财卡'
           when CATEGORY_CODE_02 = 26 then
            '招牌财神'
           ELSE
            'NA'
         end PRODUCT_CATEGORY,
         cast(FP_ID as string) PRODUCT_CODE,
         PLAN_CASH_TIME,
         ACTUAL_CASH_TIME,
         CASH_STATUS,
         PRICE_PRINCIPAL,
         PRICE_INTEREST,
         PRICE_AMT,
         DATA_STATE
    from IDW.FACT_NONO_INVEST_CASH t1
    left join ods.t_account_relation_hist t2
      on t1.user_id = t2.nono_user_id
   WHERE platform = 2
     and DATA_STATE = 'current'
  union all
  SELECT 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         user_product_id as CASH_SRC_ID,
         'user_product' as CASH_SRC_TAB,
         up.user_code as USER_CODE,
         ar.nono_user_id as USER_ID,
         t2.product_name PRODUCT_CATEGORY,
         up.product_code as PRODUCT_CODE,
         to_date(DATE_ADD(up.invest_end_date, 1)) PLAN_CASH_TIME,
         case
           when up.invest_end_date < to_date('{T_SUB_1}') then
            to_date(DATE_ADD(up.invest_end_date, 1))
         end as ACTUAL_CASH_TIME,
         case
           when up.invest_end_date < to_date('{T_SUB_1}') then
            1
           else
            0
         end CASH_STATUS,
         invest_amount as PRICE_PRINCIPAL,
         total_interest as PRICE_INTEREST,
         invest_amount + total_interest as PRICE_AMT,
         'current' DATA_STATE
    FROM ods.t_user_product_hist up
    LEFT JOIN ods.t_account_relation_hist ar
      ON up.user_code = ar.merchant_user_id
    left join idw.DIM_CSYY_PRODUCT t2
      on up.PRODUCT_CODE = t2.PRODUCT_CODE
   WHERE up.product_code NOT IN ('NN0005', 'NN00011', 'NN0017', 'NN0018')
     AND up.trans_code = 1
     AND up.status = '1'
  union all
  SELECT 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         user_product_id as CASH_SRC_ID,
         'user_product' as CASH_SRC_TAB,
         up.user_code as USER_CODE,
         ar.nono_user_id as USER_ID,
         t2.product_name PRODUCT_CATEGORY,
         up.product_code as PRODUCT_CODE,
         to_date(DATE_ADD(up.invest_end_date, 1)) PLAN_CASH_TIME,
         null ACTUAL_CASH_TIME,
         0 CASH_STATUS,
         remaining_principal as PRICE_PRINCIPAL,
         remaining_interest as PRICE_INTEREST,
         remaining_principal + remaining_interest as PRICE_AMT,
         'current' DATA_STATE
    FROM ods.t_user_product_hist up
    LEFT JOIN ods.t_account_relation_hist ar
      ON up.user_code = ar.merchant_user_id
    left join idw.DIM_CSYY_PRODUCT t2
      on up.PRODUCT_CODE = t2.PRODUCT_CODE
   WHERE up.product_code = 'NN0018'
     AND up.trans_code = 1
     AND up.status = '1'
     and (remaining_principal > 0 or remaining_interest > 0)
  union all
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         CASH_SRC_ID,
         CASH_SRC_TAB,
         USER_CODE,
         USER_ID,
         t2.product_name PRODUCT_CATEGORY,
         t1.PRODUCT_CODE,
         null PLAN_CASH_TIME,
         CASH_TIME ACTUAL_CASH_TIME,
         1 CASH_STATUS,
         PRICE_PRINCIPAL,
         PRICE_INTEREST,
         PRICE_AMT,
         'current' DATA_STATE
    from IDW.FACT_CSYY_INVEST_CASH t1
    left join idw.DIM_CSYY_PRODUCT t2
      on t1.PRODUCT_CODE = t2.PRODUCT_CODE
   where t1.PRODUCT_CODE = 'NN0018';

set mapreduce.job.name = idw_fact_biz_csyy_invest_cash_curing;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_CSYY_INVEST_CASH partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         CASH_SRC_ID,
         CASH_SRC_TAB,
         USER_CODE,
         USER_ID,
         t2.product_name PRODUCT_CATEGORY,
         t1.PRODUCT_CODE,
         null PLAN_CASH_TIME,
         CASH_TIME ACTUAL_CASH_TIME,
         1 CASH_STATUS,
         PRICE_PRINCIPAL,
         PRICE_INTEREST,
         PRICE_AMT,
         'curing' DATA_STATE
    from IDW.FACT_CSYY_INVEST_CASH t1
    left join idw.DIM_CSYY_PRODUCT t2
      on t1.PRODUCT_CODE = t2.PRODUCT_CODE
   where t1.PRODUCT_CODE in ('NN0005', 'NN00011', 'NN0017');