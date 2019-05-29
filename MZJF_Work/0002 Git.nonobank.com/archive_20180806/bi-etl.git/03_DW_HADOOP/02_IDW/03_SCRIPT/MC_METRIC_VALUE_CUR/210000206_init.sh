LAST_DATA_TIME=$1
echo ${LAST_DATA_TIME}

###################
#
#可以全量跑，重跑之前需要删掉分区
#传入参数：最小日期
#	格式：yyyyy-MM-dd
#./210000179_init_02.sh 2016-01-01
###################

hive <<EOF

set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_MC_METRIC_VALUE_CUR_24;

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.auto.convert.join=true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100041');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100042');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100043');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100044');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100045');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100046');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100047');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100048');

from (
select 1 as data_freq,null as dim_group_id,map() as metric_dim,'{P_TASK_ID}' AS DW_CREATE_BY,'{P_TASK_ID}' AS DW_UPDATE_BY
,register_biz as biz
,to_date(register_time) as data_time
,to_date(first_bind_card_time) as bind_time
,datediff(to_date(if(register_biz='nono',nono_first_invest_time,csyy_first_invest_time) )
    ,to_date(register_time)) as days --注册 - 投资
,datediff(to_date(if(register_biz='nono',nono_first_recharge_time,csyy_first_recharge_time))
    ,to_date(first_bind_card_time) ) as bind_days --绑卡 - 充值
from idw.dim_user
where to_date(register_time)  >= date_sub(to_date('${LAST_DATA_TIME}'),14)
  or to_date(first_bind_card_time) >= date_sub(to_date('${LAST_DATA_TIME}'),14)
and register_biz in ('nono','csyy') ) al

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,data_time,'REGISTER_INVEST_ONE_RATE' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
 ,'100041' as metric_id,biz
 where days = 0
 and data_time >= date_sub(to_date('${LAST_DATA_TIME}'),14)
 group by data_freq,biz,data_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,data_time,'REGISTER_INVEST_THREE_RATE' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
 ,'100042' as metric_id,biz
 where days <=2
 and data_time >= date_sub(to_date('${LAST_DATA_TIME}'),14)
 group by data_freq,biz,data_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,data_time,'REGISTER_INVEST_SEVEN_RATE' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
 ,'100043' as metric_id,biz
 where days <=6
 and data_time >= date_sub(to_date('${LAST_DATA_TIME}'),14)
 group by data_freq,biz,data_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,data_time,'REGISTER_INVEST_FIFTEEN_RATE' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
 ,'100044' as metric_id,biz
 where days <=14
 and data_time >= date_sub(to_date('${LAST_DATA_TIME}'),14)
 group by data_freq,biz,data_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,bind_time,'BIND_RECHARGE_ONE_RATE' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
 ,'100045' as metric_id,biz
 where bind_days = 0
 and bind_time >= date_sub(to_date('${LAST_DATA_TIME}'),14)
 group by data_freq,biz,bind_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,bind_time,'BIND_RECHARGE_THREE_RATE' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
 ,'100046' as metric_id,biz
 where bind_days <= 2
 and bind_days >=0
 and bind_time >= date_sub(to_date('${LAST_DATA_TIME}'),14)
 group by data_freq,biz,bind_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,bind_time,'BIND_RECHARGE_SEVEN_RATE' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
 ,'100047' as metric_id,biz
 where bind_days <= 6
 and bind_days >=0
 and bind_time >= date_sub(to_date('${LAST_DATA_TIME}'),14)
 group by data_freq,biz,bind_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,bind_time,'BIND_RECHARGE_FIFTEEN_RATE' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
 ,'100048' as metric_id,biz
 where bind_days <= 14
 and bind_days >=0
 and bind_time >= date_sub(to_date('${LAST_DATA_TIME}'),14)
 group by data_freq,biz,bind_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY;

EOF
