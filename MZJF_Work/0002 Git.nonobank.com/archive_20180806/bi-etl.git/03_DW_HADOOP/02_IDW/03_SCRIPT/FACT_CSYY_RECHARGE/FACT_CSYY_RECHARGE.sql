set mapreduce.job.name = idw_fact_csyy_recharge_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table idw.FACT_CSYY_RECHARGE
  select t1.trans_detail_id RECHARGE_SRC_ID,
         'trans_detail' RECHARGE_SRC_TAB,
         t1.user_code USER_CODE,
         ar.nono_user_id USER_ID,
         from_unixtime(unix_timestamp(CONCAT(t1.trans_date,
                                             ' ',
                                             t1.trans_time),
                                      'yyyyMMdd HHmmss'),
                       'yyyy-MM-dd HH:mm:ss') RECHARGE_TIME,
         2 PAY_TYPE,
         t1.amount RECHARGE_AMT,
         t1.order_id ORDER_ID,
         t3.bank_name BANK_NAME,
         t2.bank_card_number BANK_CARD_NO,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    from ods.t_trans_detail_hist t1
    left join ods.t_user_bind_card_hist t2
      on t1.user_card_code = t2.user_card_code
    left join ods.t_bank_define_hist t3
      on t2.bank_code = t3.bank_code
    left join ods.t_account_relation_hist ar
      ON t1.user_code = ar.merchant_user_id
   where t1.trans_code = 1
     AND t1.STATUS = '2';