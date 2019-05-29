set mapreduce.job.name = idw_MC_METRIC_VALUE_CUR_03_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100057');

--nonobank
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select 3 as data_freq
,trunc(add_months('{T}',-1), 'MM') as data_time
,'STATEMENT_USERS_INVEST_AMT_MONTH' as metric_code
,null as dim_group_id
,map() as metric_dim
,sum(t2.invest_amt) as metric_value --到期再投资的
,'{P_TASK_ID}' AS DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
,'{P_TASK_ID}' AS DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
,100057 as METRIC_ID,'nono' as BIZ
from (select user_id,min(stat_date) as cash_date,sum(cash_amt) as STATEMENT_B_MONTH
from idw.FACT_NONO_USER_CASH_STAT_DAILY
where stat_date <= last_day(add_months('{T}',-1)) --'{LAST_DATA_TIME}'
and stat_date >= trunc(add_months('{T}',-1), 'MM')
group by user_id) t1 ,idw.fact_nono_user_invest_stat_daily t2
where t2.stat_date <= last_day(add_months('{T}',-1)) 
and t2.stat_date>= trunc(add_months('{T}',-1), 'MM')
and t1.user_id =t2.user_id
and t1.cash_date <=t2.stat_date;
--csyy
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select 3 as data_freq
,trunc(add_months('{T}',-1), 'MM') as data_time
,'STATEMENT_USERS_INVEST_AMT_MONTH' as metric_code
,null as dim_group_id
,map() as metric_dim
,sum(t2.invest_amt) as metric_value --到期再投资的
,'{P_TASK_ID}' AS DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
,'{P_TASK_ID}' AS DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
,100057 as METRIC_ID
,'csyy' as BIZ
from (select user_code,min(stat_date) as cash_date,sum(cash_amt) as STATEMENT_B_MONTH
from idw.fact_csyy_user_cash_stat_daily
where stat_date <= last_day(add_months('{T}',-1)) 
and stat_date >= trunc(add_months('{T}',-1), 'MM')
group by user_code) t1 ,idw.fact_csyy_user_invest_stat_daily t2
where t2.stat_date <= last_day(add_months('{T}',-1)) 
and t2.stat_date>= trunc(add_months('{T}',-1), 'MM')
and t1.user_code =t2.user_code
and t1.cash_date <=t2.stat_date;
