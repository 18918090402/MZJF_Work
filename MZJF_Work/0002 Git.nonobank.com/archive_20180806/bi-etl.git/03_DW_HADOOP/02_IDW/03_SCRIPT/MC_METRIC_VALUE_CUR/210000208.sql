set mapreduce.job.name =IDW_MC_METRIC_VALUE_CUR_25;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;
set hive.groupby.skewindata=true;

---潜在流失用户数、潜在流失用户在投金额、流失用户数、
 from (select 1 as data_freq --数据频率
    ,t1.stat_date as data_time
    ,null as dim_group_id --资金产品线、资金期限组合
    ,'nono' as biz
    ,map() as metric_dim
    ,'SYS' AS DW_CREATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
    ,'SYS' AS DW_UPDATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    ,sum(if(t1.nono_user_lost_status='潜在流失',1,0)) as POTENTIAL_LOSS_USER_CNT --潜在流失用户数
    ,sum(if(t1.nono_user_lost_status='潜在流失',t1.nono_in_invest_amt,0)) as POTENTIAL_LOSS_USER_INVEST_AMT  --潜在流失用户在投金额
    ,sum(if(t1.nono_user_lost_status='流失',1,0)) as LOSS_USER_CNT --流失用户数
    ,sum(if(t1.nono_user_lost_status='流失',t1.nono_max_in_invest_amt,0)) as LOSS_USER_INVEST_AMT_MAX --流失用户峰值在投金额总和
from idw.dim_user_hist t1
where t1.stat_date >= to_date('{T_SUB_1}')
and t1.stat_date < to_date('{T}')
and t1.nono_user_lost_status in ('潜在流失','流失')
group by t1.stat_date) al 
lateral view stack (4,100049,'POTENTIAL_LOSS_USER_CNT',cast(POTENTIAL_LOSS_USER_CNT as string),100050,'POTENTIAL_LOSS_USER_INVEST_AMT',cast(POTENTIAL_LOSS_USER_INVEST_AMT as string) 
 ,100051,'LOSS_USER_CNT',cast(LOSS_USER_CNT as string) ,100052,'LOSS_USER_INVEST_AMT_MAX',cast(LOSS_USER_INVEST_AMT_MAX as string) ) tb as metric_id,metric_code,metric_value
INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,tb.metric_code,al.dim_group_id,al.metric_dim,tb.metric_value,al.DW_CREATE_BY,al.DW_CREATE_TIME,al.DW_UPDATE_BY,al.DW_UPDATE_TIME
 ,tb.metric_id,al.biz
 where tb.metric_value is not null;

--召回用户数、召回金额
from (select 1 as data_freq --数据频率
    ,t1.stat_date as data_time
    ,t1.user_id
    ,null as dim_group_id --资金产品线、资金期限组合
    ,'nono' as biz
    ,map() as metric_dim
    ,'SYS' AS DW_CREATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
    ,'SYS' AS DW_UPDATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    ,t1.nono_user_lost_status as cur_status
    ,t1.nono_in_invest_amt
    ,LEAD(t1.nono_user_lost_status) over(partition by t1.user_id order by t1.stat_date desc) as lead_status
    ,LEAD(t1.stat_date) over(partition by t1.user_id order by t1.stat_date desc) as lead_date
from idw.dim_user_hist t1
where t1.stat_date >= date_sub(to_date('{T_SUB_1}'),1)
and t1.stat_date < to_date('{T}') ) al

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'RECALL_USER_CNT' as metric_code,al.dim_group_id,al.metric_dim,count(1) as metric_value
  ,al.DW_CREATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
  ,al.DW_UPDATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
 ,100053,al.biz
 where al.data_time>=to_date('{T_SUB_1}')
 and al.data_time < to_date('{T}')
and nvl(al.cur_status,'') != '流失' --非流失、潜在流失状态
and al.lead_status  ='流失' --昨日处在流失
group by al.data_freq,al.data_time,al.dim_group_id,al.metric_dim,al.biz,al.DW_CREATE_BY,al.DW_UPDATE_BY

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,'RECALL_USER_AMT' as metric_code,al.dim_group_id,al.metric_dim,sum(nono_in_invest_amt) as metric_value
  ,al.DW_CREATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
  ,al.DW_UPDATE_BY,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
 ,100054,al.biz
 where al.data_time >= to_date('{T_SUB_1}')
 and al.data_time < to_date('{T}')
and nvl(al.cur_status,'') != '流失' --非流失、潜在流失状态
and al.lead_status  ='流失' --昨日处在流失
group by al.data_freq,al.data_time,al.dim_group_id,al.metric_dim,al.biz,al.DW_CREATE_BY,al.DW_UPDATE_BY;
