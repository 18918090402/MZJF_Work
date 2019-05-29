set mapreduce.job.name = DMT_BF_CSYY_INVESTING_USER_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table DMT_BF.CSYY_INVESTING_USER partition
  (STAT_DATE)
  select 'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t1.user_id,
         t1.user_code,
         t2.mobile_num,
         t2.gender,
         t2.real_name,
         '{T_SUB_1}' stat_date
    from (select user_id, user_code
            from idw.FACT_BIZ_CSYY_AUM
           where stat_date = '{T_SUB_1}'
             and aum > 0
           group by user_id, user_code) t1
    join idw.fact_user_info t2
      on t1.user_id = t2.user_id;