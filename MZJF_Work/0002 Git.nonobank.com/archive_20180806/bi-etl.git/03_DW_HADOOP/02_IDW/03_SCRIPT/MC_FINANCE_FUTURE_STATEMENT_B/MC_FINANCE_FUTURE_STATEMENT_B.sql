et mapreduce.job.name =IDW_MC_FINANCE_FUTURE_STATEMENT_B;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;
set hive.groupby.skewindata=true;


INSERT OVERWRITE TABLE IDW.MC_FINANCE_FUTURE_STATEMENT_B
select '{T}' as stat_date
  ,to_date(plan_cash_time) as data_time
   ,'nono' as biz_code
 ,'诺诺' as biz_value
  ,sum(price_principal) as value
  ,'{P_TASK_ID}',FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
  ,'{P_TASK_ID}',FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
from idw.fact_nono_invest_cash
where to_date(plan_cash_time) > to_date('{T}')
and to_date(plan_cash_time) < date_add('{T}',91)
group by to_date(plan_cash_time)
union all 
select  '{T}' as stat_date
  , date_add(lock_end_time,1) as data_time
   ,'csyy'as biz_code ,'财神爷爷' as biz_value
  ,sum(remaining_principal) as value
  ,'{P_TASK_ID}',FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
  ,'{P_TASK_ID}',FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
from idw.fact_csyy_invest_order
where  product_code NOT IN ('NN0005', 'NN00011', 'NN0017', 'NN0018')
and date_add(lock_end_time,1) > to_date('{T}')
and date_add(lock_end_time,1) < date_add('{T}',91)
group by date_add(lock_end_time,1);

