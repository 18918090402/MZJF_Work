
/*在投用户数*/
set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_14;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;


ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100028');
ALTER TABLE idw.MC_METRIC_VALUE_CUR_TMP DROP PARTITION (METRIC_ID='100028');

FROM(
select stat_date as DATA_TIME
		,'csyy' as biz
		,user_id
from idw.FACT_CSYY_USER_IN_INVEST_STAT_DAILY
where  stat_date>=to_date('{LAST_DATA_TIME}')
AND stat_date<to_date('{T}')
union all
select stat_date as DATA_TIME
		,'nono' as biz
		,user_id
from idw.FACT_NONO_USER_IN_INVEST_STAT_DAILY
where  stat_date>=to_date('{LAST_DATA_TIME}')
AND stat_date<to_date('{T}')
) OUTPUT

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR_TMP PARTITION(METRIC_ID,DIM_TYPE, BIZ)
  SELECT 1 data_freq,
         DATA_TIME,
         'IN_INVEST_USER_CNT' METRIC_CODE,
         null dim_group_id,
         map() METRIC_DIM,
         count(distinct user_id) METRIC_VALUE,
         100028 METRIC_ID, 
		 1 AS dim_type,
         BIZ group by DATA_TIME,biz
		 
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR_TMP PARTITION(METRIC_ID,DIM_TYPE, BIZ)
  SELECT 1 data_freq,
         DATA_TIME,
         'IN_INVEST_USER_CNT' METRIC_CODE,
         null dim_group_id,
         map() METRIC_DIM,
         count(distinct user_id) METRIC_VALUE,
         100028 METRIC_ID,
		 2 AS dim_type,
         'ALL' BIZ group by DATA_TIME
;

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION(METRIC_ID, BIZ)
  SELECT data_freq,
         DATA_TIME,
         METRIC_CODE,
         dim_group_id,
         METRIC_DIM,
         METRIC_VALUE,
         '{P_TASK_ID}' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         '{P_TASK_ID}' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         METRIC_ID,
         BIZ
FROM idw.MC_METRIC_VALUE_CUR_TMP WHERE METRIC_ID=100028
;
