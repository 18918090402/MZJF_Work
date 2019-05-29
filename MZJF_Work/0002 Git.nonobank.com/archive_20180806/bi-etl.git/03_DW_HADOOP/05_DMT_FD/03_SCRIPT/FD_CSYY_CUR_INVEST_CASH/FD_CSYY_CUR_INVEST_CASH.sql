set mapreduce.job.name = dmt_fd_fd_csyy_cur_invest_cash_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table dmt_fd.fd_csyy_cur_invest_cash
  SELECT wr.withdraw_reward_id SRC_ID,
         'withdraw_reward' SRC_TAB,
         ar.nono_user_id USER_ID,
         wr.user_code USER_CODE,
         CASE
           WHEN wr.trans_code = 2 THEN
            'NN0005'
           WHEN wr.trans_code = 13 THEN
            'NN00011'
           WHEN wr.trans_code = 15 THEN
            'NN0017'
         END PRODUCT_CODE,
         wr.create_date CASH_TIME,
         wr.withdraw_amount CASH_AMT,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_withdraw_reward_hist wr
    LEFT JOIN ods.t_account_relation_hist ar
      ON wr.user_code = ar.merchant_user_id
   WHERE wr.status IN (2, 3, 8)
     AND wr.trans_code IN (2, 13, 15)
     AND wr.user_code != 999999999
  union all
  SELECT cast(concat(cast(urr.user_product_id as string),
                     lpad(cast(urr.ratecard_product_id as string), 10, '0')) as
              bigint) SRC_ID,
         'userproduct_ratecard_relation' SRC_TAB,
         ar.nono_user_id USER_ID,
         urr.user_code USER_CODE,
         up.product_code PRODUCT_CODE,
         urr.create_date CASH_TIME,
         urr.amount CASH_AMT,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_userproduct_ratecard_relation_hist urr
    JOIN ods.t_user_product_hist up
      ON up.user_product_id = urr.user_product_id
    LEFT JOIN ods.t_account_relation_hist ar
      ON urr.user_code = ar.merchant_user_id
   WHERE up.product_code IN ('NN0005', 'NN00011', 'NN0017');