set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_3_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100029');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100030');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100031');

from (select 1 as data_freq --数据频率
,5 as dim_group_id --资金产品线
,'nono' as biz
,stat_date as data_time
--,map() as metric_dim
,map('finance_product',product_category) as metric_dim
,'{P_TASK_ID}' AS DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
,'{P_TASK_ID}' AS DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
,sum(cash_amt) as STATEMENT_B --兑付本金
,count(1) as STATEMENT_CNT --兑付次数
,count(distinct user_id) STATEMENT_USER_CNT--兑付用户数
from idw.FACT_NONO_USER_CASH_STAT_DAILY
where stat_date >='{LAST_DATA_TIME}'
and stat_date<'{T}'
group by stat_date,product_category

union all

select 1 as data_freq --数据频率
,5 as dim_group_id --资金产品线
,'csyy' as biz
,stat_date as data_time
--,map() as metric_dim
,map('finance_product',product_name) as metric_dim
,'{P_TASK_ID}' AS DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
,'{P_TASK_ID}' AS DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
,sum(cash_amt) as STATEMENT_B --兑付本金
,count(1) as STATEMENT_CNT --兑付次数
,count(distinct user_code) STATEMENT_USER_CNT--兑付用户数
from idw.fact_csyy_user_cash_stat_daily
where stat_date >='{LAST_DATA_TIME}'
and stat_date<'{T}'
group by stat_date,product_name
) al
lateral view stack (3,100029,'STATEMENT_B',cast(STATEMENT_B as string),100030,'STATEMENT_CNT',cast(STATEMENT_CNT as string),100031,'STATEMENT_USER_CNT',cast(STATEMENT_USER_CNT as string) ) tb as metric_id,metric_code,metric_value

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,tb.metric_code,al.dim_group_id,al.metric_dim,tb.metric_value,al.DW_CREATE_BY,al.DW_CREATE_TIME,al.DW_UPDATE_BY,al.DW_UPDATE_TIME
,tb.metric_id,al.biz
where tb.metric_value is not null;