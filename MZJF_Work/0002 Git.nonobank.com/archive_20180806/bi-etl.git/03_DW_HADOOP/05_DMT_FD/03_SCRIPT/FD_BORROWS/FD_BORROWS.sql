set mapreduce.job.name = dmt_fd_fd_borrows_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.fd_borrows
  select ta.BO_ID,
         ta.USER_ID,
         ta.P_ID,
         ta.BO_EXPECT,
         ta.BO_EXPECT_CAT,
         ta.BO_RATE,
         ta.BO_AUDIT_TIME,
         ta.BO_AGREE_TIME,
         ta.BO_FINISH_PRICE,
         ta.ZX_PRICE,
         ta.DW_CREATE_BY,
         ta.DW_CREATE_TIME,
         ta.DW_UPDATE_BY,
         ta.DW_UPDATE_TIME
    from dmt_fd.fd_borrows ta
    left join IDW.FACT_BORROWS bo
      on ta.BO_ID = bo.BO_ID
     and bo.DW_UPDATE_TIME >= '{LAST_DATA_TIME}'
     and bo.BO_IS_SUCCESS = 1
   where bo.BO_ID is null
  union all
  SELECT BO_ID,
         USER_ID,
         P_ID,
         BO_EXPECT,
         BO_EXPECT_CAT,
         BO_RATE,
         BO_AUDIT_TIME,
         BO_AGREE_TIME,
         BO_FINISH_PRICE,
         ZX_PRICE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM IDW.FACT_BORROWS bo
   WHERE bo.DW_UPDATE_TIME >= '{LAST_DATA_TIME}'
     and bo.BO_IS_SUCCESS = 1;