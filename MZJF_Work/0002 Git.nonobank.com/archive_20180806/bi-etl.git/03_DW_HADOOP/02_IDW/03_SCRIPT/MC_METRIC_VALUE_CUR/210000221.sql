set mapreduce.job.name =IDW_MC_METRIC_VALUE_CUR_30;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;
set hive.groupby.skewindata=true;

ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP IF EXISTS PARTITION (METRIC_ID= 100059,biz='nono');

insert overwrite TABLE idw.MC_METRIC_VALUE_CUR partition (metric_id=100059,biz='nono')
select 1 as data_freq 
     ,to_date('{LAST_DATA_TIME}') as data_time
     ,null as dim_group_id 
    ,'NONO_GW_DEAL_TOTAL'
     ,map() as metric_dim
     ,sum(amount)
     ,'{P_TASK_ID}' AS DW_CREATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
     ,'{P_TASK_ID}' AS DW_UPDATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
FROM (
SELECT SUM(bo_finish_price * bo_expect / 12) as  amount
FROM idw.fact_borrows
WHERE bo_is_success = 1 -- 借款
and to_date(bo_sign_time) <=to_date('{LAST_DATA_TIME}')
UNION ALL
SELECT SUM(price * ds.transfer_rate / 100 * ds.expect / 12) as  amount
FROM ods.t_debt_sale_hist ds -- 债转
WHERE STATUS IN (1,4)
and to_date(create_time )<=to_date('{LAST_DATA_TIME}')
     ) a
