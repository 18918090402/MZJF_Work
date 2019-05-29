set mapreduce.job.name = DMT_BF_DH_FACT_OVERDUE_STAT_DAILY;
set mapreduce.job.queuename = etl-dw;
set hive.groupby.skewindata=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_BF.DH_FACT_OVERDUE_STAT_DAILY partition
  (STAT_DATE)
select a.busi_line
,b.hj_city as HJ_CITY_CODE
,count(distinct a.user_id) as BORROWER_CNT
,'SYS' AS DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME
,'SYS' DW_UPDATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
,a.stat_date
from dmt.fact_repay_borrows_snapshot as a
left join idw.dim_user as b
on a.user_id=b.user_id
where a.stat_date=FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') 
group by a.stat_date,a.busi_line,b.hj_city
;