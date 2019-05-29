set mapreduce.job.name = DMT_BF_DH_FACT_OVERDUE_BORROWS_END_DAILY;
set mapreduce.job.queuename = etl-dw;
set hive.groupby.skewindata=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_BF.DH_FACT_OVERDUE_BORROWS_END_DAILY partition
  (STAT_DATE)
select overdue_cnt
,first_overdue_cnt
,first_overdue_rate
,overdue_unrepay_price_b
,overdue_unrepay_price_l
,overdue_unrepay_price_punish
,overdue_unrepay_service_fee
,first_overdue_unrepay_price_b
,first_overdue_unrepay_price_l
,first_overdue_unrepay_price_punish
,first_overdue_unrepay_service_fee
,'SYS' AS DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME
,'SYS' DW_UPDATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
,t.stat_date
from
(
select 
sum(case when a.overdue_unrepay_days=1 then 1 else 0 end) as overdue_cnt
,sum(case when first_overdue_br_time ='{LAST_DATA_TIME}' then 1 else 0 end) as first_overdue_cnt
,sum(case when first_overdue_br_time ='{LAST_DATA_TIME}' then 1 else 0 end)/count(a.bo_id) as first_overdue_rate
,sum(case when first_overdue_br_time ='{LAST_DATA_TIME}' then a.overdue_unrepay_price_b else 0 end) as first_overdue_unrepay_price_b
,sum(case when first_overdue_br_time ='{LAST_DATA_TIME}' then a.overdue_unrepay_price_l else 0 end) as first_overdue_unrepay_price_l
,sum(case when first_overdue_br_time ='{LAST_DATA_TIME}' then a.overdue_unrepay_price_punish else 0 end) as first_overdue_unrepay_price_punish
,sum(case when first_overdue_br_time ='{LAST_DATA_TIME}' then a.overdue_unrepay_service_fee else 0 end) as first_overdue_unrepay_service_fee
,a.stat_date
from idw.fact_in_repay_borrows_snapshot as a
where a.stat_date='{LAST_DATA_TIME}'
group by a.stat_date
) t
left join(
select 
FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') stat_date
,sum(br_price_b) overdue_unrepay_price_b
,sum(br_price_l) overdue_unrepay_price_l
,sum(br_price_punish) overdue_unrepay_price_punish
,sum(br_service_fee) overdue_unrepay_service_fee
from idw.fact_borrows_repayment br where br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0
and datediff(FROM_UNIXTIME(UNIX_TIMESTAMP() , 'yyyy-MM-dd'),br.br_time)=1
) b on t.stat_date=b.stat_date