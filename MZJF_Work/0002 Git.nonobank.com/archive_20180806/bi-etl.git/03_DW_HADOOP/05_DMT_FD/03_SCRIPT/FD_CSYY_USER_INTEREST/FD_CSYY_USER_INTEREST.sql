set mapreduce.job.name = dmt_fd_fd_csyy_user_interest_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table dmt_fd.fd_csyy_user_interest
  select i.user_interest_id SRC_ID,
         'user_interest' SRC_TAB,
         ar.nono_user_id USER_ID,
         i.user_code USER_CODE,
         i.product_code PRODUCT_CODE,
         i.demand_amount PRINCIPAL_AMT,
         i.actual_interest INTEREST_AMT,
         i.interest_date INTEREST_DATE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         i.updated_date UPDATE_TIME
    from ods.t_user_interest_hist i
    LEFT JOIN ods.t_account_relation_hist ar
      ON i.user_code = ar.merchant_user_id
  union all
  select i.interest_info_id SRC_ID,
         'interest_info' SRC_TAB,
         ar.nono_user_id USER_ID,
         i.user_code USER_CODE,
         i.product_code PRODUCT_CODE,
         i.principal_amount PRINCIPAL_AMT,
         i.interest_amount INTEREST_AMT,
         i.interest_date INTEREST_DATE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         i.update_date UPDATE_TIME
    from ods.t_interest_info_hist i
    LEFT JOIN ods.t_account_relation_hist ar
      ON i.user_code = ar.merchant_user_id;