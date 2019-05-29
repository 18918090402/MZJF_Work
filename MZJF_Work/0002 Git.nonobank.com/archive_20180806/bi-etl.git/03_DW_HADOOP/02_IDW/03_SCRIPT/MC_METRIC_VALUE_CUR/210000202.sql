set hive.groupby.skewindata=false;
set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_23;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100035');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100036');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100037');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100038');

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,tb.metric_code,null as dim_group_id,al.metric_dim,tb.metric_value
,'{P_TASK_ID}' AS DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,'{P_TASK_ID}' AS DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME ,tb.metric_id,al.biz
from (select 1 as data_freq,map() as metric_dim,'nono' as biz,to_date(withdraw_time) as data_time
    ,sum(withdraw_amt) as WITHDRAW_AMT,count(1) as WITHDRAW_CNT
    ,count(distinct t1.user_id) as WITHDRAW_USER_CNT,count(distinct t2.user_id) as STATEMENT_WITHDRAW_USER_CNT
 from idw.FACT_NONO_WITHDRAW t1 left outer join (select user_id ,stat_date 
    from idw.FACT_NONO_USER_CASH_STAT_DAILY 
    where stat_date >= to_date('{LAST_DATA_TIME}') and stat_date < '{T}' 
    group by user_id ,stat_date ) t2
 on t1.user_id=t2.user_id
 and to_date(withdraw_time) = t2.stat_date
 where to_date(withdraw_time) >= to_date('{LAST_DATA_TIME}')
 and  to_date(withdraw_time) < '{T}'
 group by to_date(withdraw_time)

 union all 

  select 1 as data_freq,map() as metric_dim,'csyy' as biz,to_date(withdraw_time) as data_time
    ,sum(withdraw_amt) as WITHDRAW_AMT,count(1) as WITHDRAW_CNT
    ,count(distinct t1.user_id) as WITHDRAW_USER_CNT,count(distinct t2.user_id) as STATEMENT_WITHDRAW_USER_CNT
 from idw.fact_csyy_withdraw t1 left outer join (select user_id ,stat_date 
    from idw.fact_csyy_user_cash_stat_daily
    where stat_date >= to_date('{LAST_DATA_TIME}') and stat_date < '{T}' 
    group by user_id ,stat_date ) t2
 on t1.user_id=t2.user_id
 and to_date(withdraw_time) = t2.stat_date
 where to_date(withdraw_time) >= to_date('{LAST_DATA_TIME}')
 and  to_date(withdraw_time) < '{T}'
 group by to_date(withdraw_time) ) al
lateral view stack (4,100035,'WITHDRAW_AMT',cast(WITHDRAW_AMT as string),100036,'WITHDRAW_CNT',cast(WITHDRAW_CNT as string)
    ,100037,'WITHDRAW_USER_CNT',cast(WITHDRAW_USER_CNT as string),100038,'STATEMENT_WITHDRAW_USER_CNT',cast(STATEMENT_WITHDRAW_USER_CNT as string) ) tb as metric_id,metric_code,metric_value
where tb.metric_value is not null
