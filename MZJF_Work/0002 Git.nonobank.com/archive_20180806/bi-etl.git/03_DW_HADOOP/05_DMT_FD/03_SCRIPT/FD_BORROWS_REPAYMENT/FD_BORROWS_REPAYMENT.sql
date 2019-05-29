set mapreduce.job.name = dmt_fd_fd_borrows_repayment_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.fd_borrows_repayment
  select ta.BR_ID,
         ta.USER_ID,
         ta.BO_ID,
         ta.BR_TIME,
         ta.BR_REPAY_TIME,
         ta.BR_IS_REPAY,
         ta.BR_PRICE,
         ta.BR_PRICE_B,
         ta.BR_PRICE_L,
         ta.BR_PRICE_PUNISH,
         ta.BR_SERVICE_FEE,
         ta.BR_OVERDUE_TERMS,
         ta.BR_EXPECT_NUM,
         ta.DW_CREATE_BY,
         ta.DW_CREATE_TIME,
         ta.DW_UPDATE_BY,
         ta.DW_UPDATE_TIME
    from dmt_fd.fd_borrows_repayment ta
    left join IDW.FACT_BORROWS_REPAYMENT br
      on ta.BR_ID = br.BR_ID
     and br.DW_UPDATE_TIME >= '{LAST_DATA_TIME}'
   where br.BR_ID is null
  union all
  SELECT br.BR_ID,
         br.USER_ID,
         br.BO_ID,
         br.BR_TIME,
         br.BR_REPAY_TIME,
         br.BR_IS_REPAY,
         br.BR_PRICE,
         br.BR_PRICE_B,
         br.BR_PRICE_L,
         br.BR_PRICE_PUNISH,
         br.BR_SERVICE_FEE,
         br.BR_OVERDUE_TERMS,
         br.BR_EXPECT_NUM,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM IDW.FACT_BORROWS_REPAYMENT br
   WHERE br.DW_UPDATE_TIME >= '{LAST_DATA_TIME}';