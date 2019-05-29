/*在投本金*/
set mapreduce.job.name =IDW_MC_METRIC_VALUE_CUR_15;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100027');

FROM(
select stat_date as DATA_TIME
		,'csyy' as biz
		,product_name
		,sum(nvl(aum,0)) as IN_INVEST_AMT_B
from idw.FACT_CSYY_USER_IN_INVEST_STAT_DAILY
where  stat_date>=to_date('{LAST_DATA_TIME}')
AND stat_date<to_date('{T}')
group by stat_date,product_name
union all
select stat_date as DATA_TIME
		,'nono' as biz
		,product_category as product_name
		,sum(nvl(in_invest_amt,0)) as IN_INVEST_AMT_B
from idw.FACT_NONO_USER_IN_INVEST_STAT_DAILY
where  stat_date>=to_date('{LAST_DATA_TIME}')
AND stat_date<to_date('{T}')
group by stat_date,product_category
) OUTPUT

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION(METRIC_ID, BIZ)
  SELECT 1 data_freq,
         DATA_TIME,
         'IN_INVEST_AMT_B' METRIC_CODE,
         5 dim_group_id,
         map('finance_product',product_name) METRIC_DIM,
         IN_INVEST_AMT_B METRIC_VALUE,
         '{P_TASK_ID}' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         '{P_TASK_ID}' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         100027 METRIC_ID,
         BIZ
;
