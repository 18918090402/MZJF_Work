set mapreduce.job.name = dmt_fd_fd_nono_fixed_invest_cash_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.fd_nono_fixed_invest_cash
  select t.CASH_SRC_ID SRC_ID,
         t.CASH_SRC_TAB SRC_TAB,
         t.USER_ID,
         t.FP_KEY,
         t.FP_ID,
         t.BO_ID,
         t.CATEGORY_CODE_02,
         t.CATEGORY_NAME_02,
         t.PLAN_CASH_TIME PLAN_ACCEPT_TIME,
         t.ACTUAL_CASH_TIME ACTUAL_ACCEPT_TIME,
         t.CASH_STATUS ACCEPT_STATUS,
         t.PRICE_PRINCIPAL,
         t.PRICE_INTEREST,
         t.PRICE_AMT,
         t.PRICE_PUNISH,
         t.CASH_TYPE_CODE ACCEPT_TYPE_CODE,
         t.INVEST_TYPE_CODE,
         t.INVEST_RELATION_NO DW_INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    from idw.fact_nono_invest_cash t
   where t.invest_type_code in (1, 2, 3);