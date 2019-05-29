/**投资用户数、三次及以上投资**/
set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_19;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100008');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100016');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100017');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100018');

from (select 1 as data_freq --数据频率
    ,NULL as dim_group_id --资金产品线、资金期限组合
    ,'nono' as biz
    ,t1.stat_date as data_time
    ,map() as metric_dim
   ,count(distinct t1.user_id) as INVEST_USER_CNT --投资用户数
   , count(distinct (case when t1.stat_date >=t2.nono_third_invest_time then t1.user_id else null end) )as INVEST_GTE_THREE_USER_CNT --三次及以上投资用户数
   ,sum (case when t1.stat_date >=t2.nono_third_invest_time then t1.invest_amt else 0 end)as INVEST_GTE_THREE_AMT
   ,sum (case when t1.stat_date >=t2.nono_third_invest_time then t1.annualized_invest_amt else 0 end)as INVEST_GTE_THREE_AMT_YEAR
    ,'{P_TASK_ID}' AS DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
    ,'{P_TASK_ID}' AS DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
from idw.fact_nono_user_invest_stat_daily t1 left outer join idw.dim_user t2
on t1.user_id=t2.user_id
where t1.stat_date >='{LAST_DATA_TIME}'
and t1.stat_date<'{T}'
group by t1.stat_date

union all

select 1 as data_freq --数据频率
    ,NULL as dim_group_id --资金产品线、资金期限组合
    ,'csyy' as biz
    ,t1.stat_date as data_time
    ,map() as metric_dim
    ,count(distinct t1.user_id) as INVEST_USER_CNT --投资用户数
    ,count(distinct (case when t1.stat_date >=t2.csyy_third_invest_time then t1.user_id else null end) )as INVEST_GTE_THREE_USER_CNT --三次及以上投资用户数
    ,sum (case when t1.stat_date >=t2.csyy_third_invest_time then t1.invest_amt else 0 end)as INVEST_GTE_THREE_AMT
    ,sum (case when t1.stat_date >=t2.csyy_third_invest_time then t1.annualized_invest_amt else 0 end)as INVEST_GTE_THREE_AMT_YEAR
    ,'{P_TASK_ID}' AS DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
    ,'{P_TASK_ID}' AS DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
from idw.fact_csyy_user_invest_stat_daily t1 left outer join idw.dim_user t2
on t1.user_id=t2.user_id
where t1.stat_date >='{LAST_DATA_TIME}'
and t1.stat_date<'{T}'
group by t1.stat_date
) al
lateral view stack (4,100008,'INVEST_USER_CNT',cast(INVEST_USER_CNT as string),100016,'INVEST_GTE_THREE_USER_CNT',cast(INVEST_GTE_THREE_USER_CNT as string)
    ,100017,'INVEST_GTE_THREE_AMT',cast(INVEST_GTE_THREE_AMT as string),100018,'INVEST_GTE_THREE_AMT_YEAR',cast(INVEST_GTE_THREE_AMT_YEAR as string)) tb as metric_id,metric_code,metric_value
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,tb.metric_code,al.dim_group_id,al.metric_dim,tb.metric_value,al.DW_CREATE_BY,al.DW_CREATE_TIME,al.DW_UPDATE_BY,al.DW_UPDATE_TIME
 ,tb.metric_id,al.biz
