set mapreduce.job.name = DMT_BF_DH_FACT_OVERDUE_BORROWS_END_MONTH;
set mapreduce.job.queuename = etl-dw;
set hive.groupby.skewindata=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_BF.DH_FACT_OVERDUE_BORROWS_END_MONTH partition
  (STAT_MONTH)
select 
a.bo_id
,a.busi_line
,a.user_id
,case when overdue_unrepay_days>=0 and overdue_unrepay_days<30 then 'm1'
      when overdue_unrepay_days>=30 and overdue_unrepay_days<60 then 'm2'
      when overdue_unrepay_days>=60 and overdue_unrepay_days<90 then 'm3'
      when overdue_unrepay_days>=90 then 'm4' end AGING
,last_repayed_time as REPAY_DAY
,bo_finish_price
,overdue_unrepay_price_b
,overdue_unrepay_price_l
,overdue_unrepay_price_punish
,overdue_unrepay_service_fee
,unrepay_price_b
,unrepay_price_l
,unrepay_price_punish
,unrepay_service_fee
,'SYS' AS DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME
,'SYS' DW_UPDATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
,substr(regexp_replace(cast(add_months(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'),-1) as string),'-',''),1,6) as STAT_MONTH
from dmt.fact_repay_borrows_snapshot as a
where a.stat_date=concat(from_unixtime(unix_timestamp(), 'yyyy-MM'),'-01')
;