set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_5_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;


ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100005');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100006');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100007');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100010');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100011');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100012');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100013');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100014');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100015');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100026');

from (select 1 data_freq,null as dim_group_id,map() as metric_dim,'{P_TASK_ID}' AS DW_CREATE_BY,'{P_TASK_ID}' AS DW_UPDATE_BY
,register_biz as biz,to_date('{LAST_DATA_TIME}') as data_time
--注册用户数
,sum(case when from_unixtime(unix_timestamp(register_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then 1 else 0 end) as REGISTER_USER_CNT
--nono首投相关
,sum(case when from_unixtime(unix_timestamp(nono_first_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then 1 else 0 end) as NONO_INVEST_FIRST_USER_CNT --用户数
,sum(case when from_unixtime(unix_timestamp(nono_first_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then   nono_first_invest_amt  else 0 end) as NONO_INVEST_FIRST_AMT --首投金额
,sum(case when from_unixtime(unix_timestamp(nono_first_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then NONO_FIRST_INVEST_AMT_YEARLY else 0 end) as NONO_INVEST_FIRST_AMT_YEAR ----首投年化金额
--csyy首投相关
,sum(case when from_unixtime(unix_timestamp(csyy_first_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then 1 else 0 end) as CSYY_INVEST_FIRST_USER_CNT --首投用户数
,sum(case when from_unixtime(unix_timestamp(csyy_first_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then csyy_first_invest_amt else 0 end) as CSYY_INVEST_FIRST_AMT --首投金额
,sum(case when from_unixtime(unix_timestamp(csyy_first_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then 0 else 0 end) as CSYY_INVEST_FIRST_AMT_YEAR ----首投年化金额
--nono复投相关
,sum(case when from_unixtime(unix_timestamp(nono_second_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then 1 else 0 end) as NONO_INVEST_TWICE_USER_CNT --复投用户数
,sum(case when from_unixtime(unix_timestamp(nono_second_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then NONO_SECOND_INVEST_AMT else 0 end) as NONO_INVEST_TWICE_AMT --复投金额
,sum(case when from_unixtime(unix_timestamp(nono_second_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then NONO_SECOND_INVEST_AMT_YEARLY else 0 end) as NONO_INVEST_TWICE_AMT_YEAR ----复投年化金额
--csyy复投相关
,sum(case when from_unixtime(unix_timestamp(csyy_second_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then 1 else 0 end) as CSYY_INVEST_TWICE_USER_CNT --复投用户数
,sum(case when from_unixtime(unix_timestamp(csyy_second_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then csyy_second_invest_amt else 0 end) as CSYY_INVEST_TWICE_AMT --复投金额
,sum(case when from_unixtime(unix_timestamp(csyy_second_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') =to_date('{LAST_DATA_TIME}') then csyy_second_invest_amt_yearly else 0 end) as CSYY_INVEST_TWICE_AMT_YEAR ----复投年化金额

--nono累计投资用户数
,sum(case when from_unixtime(unix_timestamp(nono_first_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('{LAST_DATA_TIME}') then 1 else 0 end) as NONO_INVEST_USER_CNT_TOTAL
--csyy累计投资用户数
,sum(case when from_unixtime(unix_timestamp(csyy_first_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('{LAST_DATA_TIME}') then 1 else 0 end) as CSYY_INVEST_USER_CNT_TOTAL

--nono累计复投用户数
,sum(case when from_unixtime(unix_timestamp(nono_second_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('{LAST_DATA_TIME}') then 1 else 0 end) as NONO_INVEST_TWICE_USER_CNT_TOTAL
--csyy累计复投用户数
,sum(case when from_unixtime(unix_timestamp(csyy_second_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('{LAST_DATA_TIME}') then 1 else 0 end) as CSYY_INVEST_TWICE_USER_CNT_TOTAL

--nono累计三投用户数 
,sum(case when from_unixtime(unix_timestamp(nono_third_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('{LAST_DATA_TIME}') then 1 else 0 end) as NONO_INVEST_THREE_USER_CNT_TOTAL
--CSYY累计三投用户数 
,sum(case when from_unixtime(unix_timestamp(csyy_third_invest_time,'yyyy-MM-dd'),'yyyy-MM-dd') <=to_date('{LAST_DATA_TIME}') then 1 else 0 end) as CSYY_INVEST_THREE_USER_CNT_TOTAL
from idw.dim_user
group by register_biz) al

--注册用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,data_time,'REGISTER_USER_CNT' as metric_code,dim_group_id,metric_dim,sum(REGISTER_USER_CNT) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100026 as metric_id,al.biz
 group by al.data_freq,al.data_time,al.biz,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--nono首投用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,data_time,'INVEST_FIRST_USER_CNT' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_FIRST_USER_CNT) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100010 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--nono首投金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_FIRST_AMT' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_FIRST_AMT) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100011 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--nono首投年化金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,data_time,'INVEST_FIRST_AMT_YEAR' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_FIRST_AMT_YEAR) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100012 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY


--csyy首投用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_FIRST_USER_CNT' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_FIRST_USER_CNT) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100010 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--csyy首投金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_FIRST_AMT' as metric_code,dim_group_id,metric_dim,sum(csyy_INVEST_FIRST_AMT) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100011 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--csyy首投年化金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_FIRST_AMT_YEAR' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_FIRST_AMT_YEAR) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100012 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--nono复投用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_TWICE_USER_CNT' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_TWICE_USER_CNT) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100013 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--nono复投金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_TWICE_AMT' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_TWICE_AMT) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100014 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--nono复投年化金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_TWICE_AMT_YEAR' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_TWICE_AMT_YEAR) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100015 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

 --csyy复投用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_TWICE_USER_CNT' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_TWICE_USER_CNT) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100013 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--csyy复投金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_TWICE_AMT' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_TWICE_AMT) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100014 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--csyy复投年化金额
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_TWICE_AMT_YEAR' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_TWICE_AMT_YEAR) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100015 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY


--nono累计投资用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100005 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY


--csyy累计投资用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100005 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--nono累计复投投资用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_TWICE_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_TWICE_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100006 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY


--csyy累计复投投资用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_TWICE_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_TWICE_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100006 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY

--nono累计三投投资用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_THREE_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(NONO_INVEST_THREE_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100007 as metric_id,'nono'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY


--csyy累计三投投资用户数
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'INVEST_THREE_USER_CNT_TOTAL' as metric_code,dim_group_id,metric_dim,sum(CSYY_INVEST_THREE_USER_CNT_TOTAL) as metric_value,al.DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME,al.DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
 ,100007 as metric_id,'csyy'
 group by al.data_freq,al.data_time,dim_group_id,metric_dim,al.DW_CREATE_BY,al.DW_UPDATE_BY
