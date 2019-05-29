set mapreduce.job.name = dmt_fd_fd_csyy_fixed_invest_order_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.fd_csyy_fixed_invest_order
  SELECT up.user_product_id SRC_ID,
         'user_product' SRC_TAB,
         ar.nono_user_id USER_ID,
         up.user_code USER_CODE,
         up.product_code PRODUCT_CODE,
         up.created_date INVEST_TIME,
         up.invest_amount INVEST_AMT,
         up.remaining_principal REMAINING_PRINCIPAL,
         up.total_interest TOTAL_INTEREST,
         up.remaining_interest REMAINING_INTEREST,
         DATEDIFF(up.invest_end_date, up.invest_begin_date) + 1 EXPECT,
         1 EXPECT_UNIT_CODE,
         up.invest_begin_date LOCK_BEGIN_TIME,
         up.invest_end_date LOCK_END_TIME,
         CASE
           WHEN pr.product_rate_id IN (13, 14, 15, 16) THEN
            7.30 + pr.rate
           WHEN pr.product_rate_id IN (6, 7, 8, 9, 12) THEN
            8.88 + pr.rate
           ELSE
            pr.rate
         END MIN_RATE,
         CASE
           WHEN pr.product_rate_id IN (13, 14, 15, 16) THEN
            7.30 + pr.rate
           WHEN pr.product_rate_id IN (6, 7, 8, 9, 12) THEN
            8.88 + pr.rate
           ELSE
            pr.rate
         END MAX_RATE,
         wpc.privilege_amount DEDUCTIBLE_AMT,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_user_product_hist up
    LEFT JOIN ods.t_product_rate_hist pr
      ON up.product_code = pr.product_code
    LEFT JOIN ods.t_account_relation_hist ar
      ON up.user_code = ar.merchant_user_id
    left join ods.t_welfare_privilege_code_hist wpc
      on up.order_id = wpc.order_id
     and wpc.welfare_type = 5
     AND wpc.use_status = 1
   WHERE up.product_code NOT IN ('NN0005', 'NN00011', 'NN0017')
     AND up.trans_code = 1
     AND up.status = '1'
     AND up.user_code != 999999999;