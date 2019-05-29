set mapreduce.job.name = idw_fact_csyy_invest_cash_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table IDW.FACT_CSYY_INVEST_CASH
  SELECT wr.withdraw_reward_id AS CASH_SRC_ID,
         'withdraw_reward' AS CASH_SRC_TAB,
         wr.user_code AS USER_CODE,
         ar.nono_user_id AS USER_ID,
         CASE
           WHEN wr.trans_code = 2 THEN
            'NN0005'
           WHEN wr.trans_code = 13 THEN
            'NN00011'
           WHEN wr.trans_code = 15 THEN
            'NN0017'
         END AS PRODUCT_KEY,
         CASE
           WHEN wr.trans_code = 2 THEN
            'NN0005'
           WHEN wr.trans_code = 13 THEN
            'NN00011'
           WHEN wr.trans_code = 15 THEN
            'NN0017'
         END AS PRODUCT_CODE,
         wr.create_date CASH_TIME,
         wr.withdraw_amount AS PRICE_PRINCIPAL, --财神活期利息进入余额
         NULL AS PRICE_INTEREST,
         NULL AS PRICE_AMT,
         NULL AS INVEST_SRC_ID, --区分不出
         NULL AS INVEST_SRC_TAB,
         2 AS INVEST_TYPE_CODE,
         1 AS CASH_TYPE_CODE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_withdraw_reward_hist wr
    LEFT JOIN ods.t_account_relation_hist ar
      ON wr.user_code = ar.merchant_user_id
   WHERE wr.status IN (2, 3, 8)
     AND wr.trans_code IN (2, 13, 15)
  union all
  SELECT cast(concat(cast(urr.user_product_id as string),
                     lpad(cast(urr.ratecard_product_id as string), 10, '0')) as
              bigint) AS CASH_SRC_ID,
         'userproduct_ratecard_relation' AS CASH_SRC_TAB,
         urr.user_code AS USER_CODE,
         ar.nono_user_id AS USER_ID,
         up.product_code AS PRODUCT_KEY,
         up.product_code AS PRODUCT_CODE,
         urr.create_date AS CASH_TIME,
         urr.amount AS PRICE_PRINCIPAL, --财神活期活转定只转本金，利息己进入余额
         NULL AS PRICE_INTEREST,
         NULL AS PRICE_AMT,
         up.user_product_id AS INVEST_SRC_ID,
         'user_product' AS INVEST_SRC_TAB,
         2 AS INVEST_TYPE_CODE,
         2 AS CASH_TYPE_CODE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_userproduct_ratecard_relation_hist urr
    JOIN ods.t_user_product_hist up
      ON up.user_product_id = urr.user_product_id
    LEFT JOIN ods.t_account_relation_hist ar
      ON urr.user_code = ar.merchant_user_id
   WHERE up.product_code IN ('NN0005', 'NN00011', 'NN0017')
  union all
  SELECT user_product_id as CASH_SRC_ID,
         'user_product' as CASH_SRC_TAB,
         up.user_code as USER_CODE,
         ar.nono_user_id as USER_ID,
         up.product_code as PRODUCT_KEY,
         up.product_code as PRODUCT_CODE,
         to_date(DATE_ADD(up.invest_end_date, 1)) as CASH_TIME,
         invest_amount as PRICE_PRINCIPAL,
         total_interest as PRICE_INTEREST,
         invest_amount + total_interest as PRICE_AMT,
         user_product_id as INVEST_SRC_ID,
         'user_product' as INVEST_SRC_TAB,
         1 as INVEST_TYPE_CODE,
         3 as CASH_TYPE_CODE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_user_product_hist up
    LEFT JOIN ods.t_account_relation_hist ar
      ON up.user_code = ar.merchant_user_id
   WHERE up.product_code NOT IN ('NN0005', 'NN00011', 'NN0017', 'NN0018')
     AND up.trans_code = 1
     AND up.status = '1'
     AND up.invest_end_date < to_date('{T_SUB_1}')
  union all
  SELECT uatl.log_id as CASH_SRC_ID,
         'user_account_trans_log' as CASH_SRC_TAB,
         uatl.user_code as USER_CODE,
         ar.nono_user_id as USER_ID,
         uatl.role_key_word as PRODUCT_KEY,
         uatl.role_key_word as PRODUCT_CODE,
         uatl.create_date as CASH_TIME,
         null as PRICE_PRINCIPAL,
         null as PRICE_INTEREST,
         uatl.amount as PRICE_AMT,
         uatl.syncId as INVEST_SRC_ID,
         'user_product' as INVEST_SRC_TAB,
         1 as INVEST_TYPE_CODE,
         3 as CASH_TYPE_CODE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_user_account_trans_log_hist uatl
    LEFT JOIN ods.t_user_product_hist up
      ON cast(uatl.syncId as int) = up.user_product_id
    LEFT JOIN ods.t_account_relation_hist ar
      ON uatl.user_code = ar.merchant_user_id
   WHERE uatl.role_key_word = 'NN0018'
     AND uatl.operation_type in (4, 5, 40)
  union all
  select ctd.id as CASH_SRC_ID,
         'product_change_trade_detail' as CASH_SRC_TAB,
         eoi.user_code as USER_CODE,
         ar.nono_user_id as USER_ID,
         'NN0018' as PRODUCT_KEY,
         'NN0018' as PRODUCT_CODE,
         eoi.trade_time as CASH_TIME,
         null as PRICE_PRINCIPAL,
         null as PRICE_INTEREST,
         ctd.amount as PRICE_AMT,
         ctd.user_product_id as INVEST_SRC_ID,
         'user_product' as INVEST_SRC_TAB,
         1 as INVEST_TYPE_CODE,
         3 as CASH_TYPE_CODE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    from ods.t_product_exchange_order_info_hist eoi
    join ods.t_product_change_trade_detail_hist ctd
      on eoi.order_no = ctd.order_id
     and eoi.status = 6
    LEFT JOIN ods.t_account_relation_hist ar
      ON eoi.user_code = ar.merchant_user_id;