set mapreduce.job.name =IDW_MC_IDW_MC_METRIC_VALUE_CUR_22;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;
set hive.groupby.skewindata=true;

ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100033');

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select 1 as data_freq,to_date(success_time) AS data_time,'PAYMENT_B' as metric_code, null as ,map() as metric_dim,sum(price_principal) as metric_value
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,'{P_TASK_ID}' AS DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME,'{P_TASK_ID}' AS DW_UPDATE_BY
,100033 as metric_id,'nono'
from ods.T_BORROWS_ACCEPT_hist
where is_vip=1
and is_pay=1
and to_date(success_time) >=to_date('{LAST_DATA_TIME}')
and to_date(success_time)<'{T}'
group by to_date(success_time);

