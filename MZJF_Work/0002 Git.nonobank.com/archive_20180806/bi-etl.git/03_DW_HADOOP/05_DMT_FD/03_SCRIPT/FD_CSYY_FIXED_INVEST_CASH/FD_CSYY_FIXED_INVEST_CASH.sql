set mapreduce.job.name = dmt_fd_fd_csyy_fixed_invest_cash_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table dmt_fd.fd_csyy_fixed_invest_cash
  SELECT user_product_id SRC_ID,
         'user_product' SRC_TAB,
         ar.nono_user_id USER_ID,
         up.user_code USER_CODE,
         up.product_code PRODUCT_CODE,
         to_date(DATE_ADD(up.invest_end_date, 1)) ACCEPT_TIME,
         invest_amount PRICE_PRINCIPAL,
         total_interest PRICE_INTEREST,
         invest_amount + total_interest PRICE_AMT,
         user_product_id DW_ORDER_ID,
         'user_product' DW_ORDER_TAB,
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
     AND up.user_code != 999999999
     AND up.invest_end_date < '{T_SUB_1}'
  union all
  SELECT uatl.log_id SRC_ID,
         'user_account_trans_log' SRC_TAB,
         ar.nono_user_id USER_ID,
         uatl.user_code USER_CODE,
         uatl.role_key_word PRODUCT_CODE,
         uatl.create_date ACCEPT_TIME,
         null PRICE_PRINCIPAL,
         null PRICE_INTEREST,
         uatl.amount PRICE_AMT,
         uatl.syncId DW_ORDER_ID,
         'user_product' DW_ORDER_TAB,
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
     AND uatl.operation_type = 40;