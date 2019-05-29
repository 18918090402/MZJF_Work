LAST_DATA_TIME=$1
echo ${LAST_DATA_TIME}

###################
#
#只能一天天跑数据，重跑之前需要删掉分区
#	ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100005');
#	ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100006');
#	ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100007');
#	传入参数：日期
#	格式：yyyyy-MM-dd
#		start_date=`date +%Y%m%d -d "2016-01-01"`
#		for((i=0;i<=563;i++));
#		do date_id=`date +%Y-%m-%d -d "$i day $start_date"`
#		echo $date_id;
#		./210000179_init_02.sh $date_id
#		done;
###################

hive <<EOF

set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_5_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

from (select 1 data_freq,null as dim_group_id,map() as metric_dim,'INIT' AS DW_CREATE_BY,'INIT' AS DW_UPDATE_BY
,register_biz as biz,to_date('${LAST_DATA_TIME}') as data_time

--nono累计投资用户数
,sum(case when from_unixtime(unix_timestamp(nono_first_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('${LAST_DATA_TIME}') then 1 else 0 end) as NONO_INVEST_USER_CNT_TOTAL
--csyy累计投资用户数
,sum(case when from_unixtime(unix_timestamp(csyy_first_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('${LAST_DATA_TIME}') then 1 else 0 end) as CSYY_INVEST_USER_CNT_TOTAL

--nono累计复投用户数
,sum(case when from_unixtime(unix_timestamp(nono_second_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('${LAST_DATA_TIME}') then 1 else 0 end) as NONO_INVEST_TWICE_USER_CNT_TOTAL
--csyy累计复投用户数
,sum(case when from_unixtime(unix_timestamp(csyy_second_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('${LAST_DATA_TIME}') then 1 else 0 end) as CSYY_INVEST_TWICE_USER_CNT_TOTAL

--nono累计三投用户数 
,sum(case when from_unixtime(unix_timestamp(nono_third_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('${LAST_DATA_TIME}') then 1 else 0 end) as NONO_INVEST_THREE_USER_CNT_TOTAL
--CSYY累计三投用户数 
,sum(case when from_unixtime(unix_timestamp(csyy_third_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('${LAST_DATA_TIME}') then 1 else 0 end) as CSYY_INVEST_THREE_USER_CNT_TOTAL
from idw.dim_user
group by register_biz) al

--nono累计投资用户数
INSERT INTO TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100005 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY


--csyy累计投资用户数
INSERT INTO TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100005 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--nono累计复投投资用户数
INSERT INTO TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_TWICE_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_TWICE_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100006 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY


--csyy累计复投投资用户数
INSERT INTO TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_TWICE_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_TWICE_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100006 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--nono累计三投投资用户数
INSERT INTO TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_THREE_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_THREE_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100007 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY


--csyy累计三投投资用户数
INSERT INTO TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_THREE_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_THREE_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100007 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY;


 EOF