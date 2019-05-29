set mapreduce.job.name = DMT_BF.DH_FACT_OVERDUE_RATE_DAILY;
set mapreduce.job.queuename = etl-dw;
set hive.groupby.skewindata=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_BF.DH_FACT_OVERDUE_RATE_END_MONTH partition
  (STAT_MONTH)
select t.busi_line
,t.AGING
,t.HJ_PROVINCE_CODE
,t.BORROWER_CNT_line/t1.BORROWER_CNT as OVERDUE_RATE
,'SYS' AS DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME
,'SYS' DW_UPDATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
,substr(regexp_replace(cast(add_months(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'),-1) as string),'-',''),1,6) as STAT_MONTH
From(
select a.busi_line
,b.hj_province as HJ_PROVINCE_CODE
,count(bo_id) as BORROWER_CNT_line
,case when overdue_unrepay_days>=0 and overdue_unrepay_days<30 then 'm1'
      when overdue_unrepay_days>=30 and overdue_unrepay_days<60 then 'm2'
      when overdue_unrepay_days>=60 and overdue_unrepay_days<90 then 'm3'
      when overdue_unrepay_days>=90 then 'm4' end AGING
,add_months(concat(from_unixtime(unix_timestamp(), 'yyyy-MM'),'-01'),-1) as stat_date
from dmt.fact_repay_borrows_snapshot as a
left join idw.dim_user as b
on a.user_id=b.user_id
where a.stat_date=concat(from_unixtime(unix_timestamp(), 'yyyy-MM'),'-01')
and is_all_repayed=0
group by a.stat_date,a.busi_line,b.hj_province
,case when overdue_unrepay_days>=0 and overdue_unrepay_days<30 then 'm1'
      when overdue_unrepay_days>=30 and overdue_unrepay_days<60 then 'm2'
      when overdue_unrepay_days>=60 and overdue_unrepay_days<90 then 'm3'
      when overdue_unrepay_days>=90 then 'm4' end
) t 
left join(
select add_months(concat(from_unixtime(unix_timestamp(), 'yyyy-MM'),'-01'),-1) as stat_date
,count(*) BORROWER_CNT
from dmt.fact_repay_borrows_snapshot as a
where a.stat_date=concat(from_unixtime(unix_timestamp(), 'yyyy-MM'),'-01')
and is_all_repayed=0
) t1 on t.stat_date=t1.stat_date
;