set mapreduce.job.name = dmt_fd_fd_nono_fixed_invest_order_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.fd_nono_fixed_invest_order
  select t.INVEST_SRC_ID SRC_ID,
         t.INVEST_SRC_TAB SRC_TAB,
         t.USER_ID,
         t.FP_KEY,
         t.FP_ID,
         t.BO_ID,
         t.CATEGORY_CODE_02,
         t.CATEGORY_NAME_02,
         t.INVEST_TIME,
         t.INVEST_AMT,
         t.EXPECT,
         t.EXPECT_UNIT_CODE,
         t.LOCK_BEGIN_TIME,
         t.LOCK_END_TIME,
         t.MIN_RATE,
         t.MAX_RATE,
         t.ADD_RATE,
         t.DEDUCTIBLE_AMT,
         t.INVEST_TYPE_CODE,
         t.INVEST_RELATION_NO DW_INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    from idw.fact_nono_invest_order t
   where t.invest_type_code in (1, 2, 3)
     and t.status in (1, 2);