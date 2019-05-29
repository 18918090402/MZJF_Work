set mapreduce.job.name = idw_fact_csyy_withdraw_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table idw.FACT_CSYY_WITHDRAW
  SELECT wr.withdraw_reward_id WITHDRAW_SRC_ID,
         'withdraw_reward' WITHDRAW_SRC_TAB,
         wr.user_code,
         ar.nono_user_id user_id,
         wr.trans_code WITHDRAW_TYPE,
         wr.withdraw_amount WITHDRAW_AMT,
         wr.create_date WITHDRAW_TIME,
         wr.orderid ORDER_ID,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM ods.t_withdraw_reward_hist wr
    left join ods.t_account_relation_hist ar
      ON wr.user_code = ar.merchant_user_id
   WHERE wr.STATUS IN (2, 3);