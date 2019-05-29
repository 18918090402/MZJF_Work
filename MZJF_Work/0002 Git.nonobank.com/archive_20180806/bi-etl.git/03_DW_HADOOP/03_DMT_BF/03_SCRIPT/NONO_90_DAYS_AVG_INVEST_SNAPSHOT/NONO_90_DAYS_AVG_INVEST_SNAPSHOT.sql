set mapreduce.job.name = dmt_bf_nono_90_days_avg_invest_snapshot_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table DMT_BF.NONO_90_DAYS_AVG_INVEST_SNAPSHOT partition
  (STAT_DATE = '{T_SUB_1}')
  select user_id,
         sum(case
               when stat_date = '{T_SUB_1}' then
                invest_amt
               else
                0
             end) invest_amt,
         avg(invest_amt) avg_invest_amt_90,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    from dmt_bf.nono_invest_snapshot
   where stat_date > date_sub('{T_SUB_1}', 90)
     and stat_date <= '{T_SUB_1}'
   group by user_id;