LAST_DATA_TIME=$1
echo ${LAST_DATA_TIME}

###################
#
#可以跑多天数据的数据
#传入参数：跑的最小时间 
#	格式：yyyyy-MM-dd
###################

hive <<EOF
set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_5_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;


ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100010');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100011');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100012');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100013');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100014');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100015');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100026');

from (select 1 data_freq,null as dim_group_id,map() as metric_dim,'{INTI}' AS DW_CREATE_BY,'{INTI}' AS DW_UPDATE_BY
,register_biz as biz
--注册用户数
,to_date(register_time) as register_time
--nono首投相关
,to_date(nono_first_invest_time) as nono_first_invest_time
,nono_first_invest_amt as  NONO_INVEST_FIRST_AMT --首投金额
,NONO_FIRST_INVEST_AMT_YEARLY as NONO_INVEST_FIRST_AMT_YEAR ----首投年化金额
--csyy首投相关
,to_date(csyy_first_invest_time) as csyy_first_invest_time
,csyy_first_invest_amt as CSYY_INVEST_FIRST_AMT --首投金额
,0 as CSYY_INVEST_FIRST_AMT_YEAR ----首投年化金额
--nono复投相关
,to_date(nono_second_invest_time) as nono_second_invest_time --复投用户数
,NONO_SECOND_INVEST_AMT as NONO_INVEST_TWICE_AMT --复投金额
,NONO_SECOND_INVEST_AMT_YEARLY as NONO_INVEST_TWICE_AMT_YEAR ----复投年化金额
--csyy复投相关
,to_date(csyy_second_invest_time) as csyy_second_invest_time --复投用户数
,csyy_second_invest_amt as CSYY_INVEST_TWICE_AMT --复投金额
,csyy_second_invest_amt_yearly as CSYY_INVEST_TWICE_AMT_YEAR ----复投年化金额
from idw.dim_user
) al
--nono首投用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,nono_first_invest_time,'INVEST_FIRST_USER_CNT' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME
,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100010 as metric_id,'nono'
 where nono_first_invest_time >=to_date('${LAST_DATA_TIME}')
 group by data_freq,nono_first_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY
 
--nono首投金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,nono_first_invest_time,'INVEST_FIRST_AMT' as metric_code,dim_group_id,metric_dim
,sum(NONO_INVEST_FIRST_AMT) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME
,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100011 as metric_id,'nono'
 where nono_first_invest_time >=to_date('${LAST_DATA_TIME}')
 group by data_freq,nono_first_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

--注册用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,register_time,'REGISTER_USER_CNT' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value,DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100026 as metric_id,biz
 where register_time >=to_date('${LAST_DATA_TIME}')
 group by data_freq,register_time,biz,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY



 --nono首投年化金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,nono_first_invest_time,'INVEST_FIRST_AMT_YEAR' as metric_code,dim_group_id,metric_dim
,sum(NONO_INVEST_FIRST_AMT_YEAR) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME
,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100012 as metric_id,'nono'
 where nono_first_invest_time >=to_date('${LAST_DATA_TIME}')
 group by data_freq,nono_first_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY


--csyy首投用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,csyy_first_invest_time,'INVEST_FIRST_USER_CNT' as metric_code,dim_group_id,metric_dim
,count(1) as metric_value,DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100010 as metric_id,'csyy'
 where csyy_first_invest_time>=to_date('${LAST_DATA_TIME}')
 group by data_freq,csyy_first_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

--csyy首投金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,csyy_first_invest_time,'INVEST_FIRST_AMT' as metric_code,dim_group_id,metric_dim
,sum(csyy_INVEST_FIRST_AMT) as metric_value,DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100011 as metric_id,'csyy'
 where csyy_first_invest_time>=to_date('${LAST_DATA_TIME}')
 group by data_freq,csyy_first_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

--csyy首投年化金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,csyy_first_invest_time,'INVEST_FIRST_AMT_YEAR' as metric_code,dim_group_id,metric_dim
,sum(CSYY_INVEST_FIRST_AMT_YEAR) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME
,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100012 as metric_id,'csyy'
 where csyy_first_invest_time>=to_date('${LAST_DATA_TIME}')
 group by data_freq,csyy_first_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

--nono复投用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,nono_second_invest_time,'INVEST_TWICE_USER_CNT' as metric_code
,dim_group_id,metric_dim,count(1) as metric_value,DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,DW_UPDATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100013 as metric_id,'nono'
 where nono_second_invest_time >=to_date('${LAST_DATA_TIME}')
 group by data_freq,nono_second_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

--nono复投金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,nono_second_invest_time,'INVEST_TWICE_AMT' as metric_code,dim_group_id
,metric_dim,sum(NONO_INVEST_TWICE_AMT) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME
,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100014 as metric_id,'nono'
  where nono_second_invest_time >=to_date('${LAST_DATA_TIME}')
 group by data_freq,nono_second_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

--nono复投年化金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,nono_second_invest_time,'INVEST_TWICE_AMT_YEAR' as metric_code
,dim_group_id,metric_dim,sum(NONO_INVEST_TWICE_AMT_YEAR) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME
,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100015 as metric_id,'nono'
 where nono_second_invest_time >=to_date('${LAST_DATA_TIME}')
 group by data_freq,nono_second_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

 --csyy复投用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,csyy_second_invest_time,'INVEST_TWICE_USER_CNT' as metric_code,dim_group_id,metric_dim,count(1) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME
,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100013 as metric_id,'csyy'
 where csyy_second_invest_time >=to_date('${LAST_DATA_TIME}')
 group by data_freq,csyy_second_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

--csyy复投金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,csyy_second_invest_time,'INVEST_TWICE_AMT' as metric_code,dim_group_id,metric_dim
,sum(CSYY_INVEST_TWICE_AMT) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME
,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100014 as metric_id,'csyy'
 where csyy_second_invest_time >=to_date('${LAST_DATA_TIME}')
 group by data_freq,csyy_second_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY

--csyy复投年化金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select data_freq,csyy_second_invest_time,'INVEST_TWICE_AMT_YEAR' as metric_code,dim_group_id,metric_dim
,sum(CSYY_INVEST_TWICE_AMT_YEAR) as metric_value
,DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME
,DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100015 as metric_id,'csyy'
 where csyy_second_invest_time >=to_date('${LAST_DATA_TIME}')
 group by data_freq,csyy_second_invest_time,dim_group_id,metric_dim,DW_CREATE_BY,DW_UPDATE_BY
;
 EOF