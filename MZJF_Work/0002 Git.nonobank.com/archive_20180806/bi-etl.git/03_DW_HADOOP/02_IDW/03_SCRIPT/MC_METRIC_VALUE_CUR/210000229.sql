et mapreduce.job.name =IDW_MC_METRIC_VALUE_CUR_37;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;
set hive.groupby.skewindata=true;

ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP IF EXISTS PARTITION (METRIC_ID= 100060,biz='nono');

insert overwrite TABLE idw.MC_METRIC_VALUE_CUR partition (metric_id=100060,biz='nono')
select 1 as data_freq 
     ,to_date('{LAST_DATA_TIME}') as stat_date
     ,null as dim_group_id 
    ,'NONO_PROFIT_TOTAL'
     ,map() as metric_dim
     ,sum(t1.amount)
     ,'{P_TASK_ID}' AS DW_CREATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
     ,'{P_TASK_ID}' AS DW_UPDATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
from (
select SUM(amount) as amount
from odsopr.finance_log_all
where to_date(create_time) <=to_date('{LAST_DATA_TIME}')
and ( (operation_relation = 470 and remark LIKE '%收益%') or operation_relation=121 )

union all

SELECT SUM(ba.price_interest*ba.owner_rate)  as amount
FROM odsopr.borrows_accept ba  --债转收益
WHERE ba.is_pay=1 AND ba.is_vip=0
and to_date(plan_time)  <= to_date('{LAST_DATA_TIME}')

union all

SELECT SUM(dac_price_l)  as amount
FROM odsopr.debt_accept --VIP收益
where to_date(dac_time) <= to_date('{LAST_DATA_TIME}')
) t1
