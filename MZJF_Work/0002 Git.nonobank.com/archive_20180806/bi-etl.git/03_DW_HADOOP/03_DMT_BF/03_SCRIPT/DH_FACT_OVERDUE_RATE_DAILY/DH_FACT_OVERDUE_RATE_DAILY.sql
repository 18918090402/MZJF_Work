set mapreduce.job.name = DMT_BF.DH_FACT_OVERDUE_RATE_DAILY;
set mapreduce.job.queuename = etl-dw;
set hive.groupby.skewindata=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_BF.DH_FACT_OVERDUE_RATE_DAILY partition
  (STAT_DATE)
select busi_line
,sum(case when overdue_unrepay_expect_cnt>0 then 1 else 0 end)/count(bo_id) as OVERDUE_RATE
,'SYS' AS DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME
,'SYS' DW_UPDATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
,stat_date
from idw.fact_in_repay_borrows_snapshot where stat_date='2017-05-01'
group by stat_date,busi_line
UNION ALL
select 'ALL' as busi_line
,sum(case when overdue_unrepay_expect_cnt>0 then 1 else 0 end)/count(bo_id) as OVERDUE_RATE
,'SYS' AS DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME
,'SYS' DW_UPDATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
,stat_date
from idw.fact_in_repay_borrows_snapshot where stat_date=FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') 
group by stat_date
;