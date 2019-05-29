set mapreduce.job.name = IDW_MC_METRIC_VALUE_CUR_1_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100000');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100001');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100002');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100003');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100004');
ALTER TABLE idw.MC_METRIC_VALUE_CUR DROP PARTITION (METRIC_ID='100009');

from (select 1 as data_freq --数据频率
    ,2 as dim_group_id --资金产品线、资金期限组合
    ,'nono' as biz
    ,stat_date as data_time
    ,map('finance_product',product_category
        ,'finance_expect',(case when expect_month<=1 then 13 when expect_month<=3 then 14 
        when expect_month<=6 then 15 when expect_month<=12 then 16 when expect_month<=24 then 17 when expect_month<=36 then 18 else 19 end )) as metric_dim
    ,'{P_TASK_ID}' AS DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
    ,'{P_TASK_ID}' AS DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
,sum(invest_amt) as INVEST_AMT --投资额(新增投资额)
,sum(annualized_invest_amt) as INVEST_AMT_YEAR --年化投资额(新增年化投资额)
,sum(deductible_amt) as COUPON_AMT --现金券金额
,sum(add_rate_amt) as BONUS_COUPONS_AMT --加息券金额（add_rate）
,sum(invest_cnt) as INVEST_CNT --投资次数
,sum(expected_earnings_amt) as INVEST_EARNINGS --投资收益
,count(1) as INVEST_USER_CNT --投资用户数
from idw.fact_nono_user_invest_stat_daily
where stat_date >='{LAST_DATA_TIME}'
and stat_date<'{T}'
group by stat_date,product_category
    ,(case when expect_month<=1 then 13 when expect_month<=3 then 14 
        when expect_month<=6 then 15 when expect_month<=12 then 16 when expect_month<=24 then 17 when expect_month<=36 then 18 else 19 end )

union all

select 1 as data_freq --数据频率
    ,2 as dim_group_id --资金产品线、资金期限组合
    ,'csyy' as biz
    ,stat_date as data_time
    ,map('finance_product',product_name
        ,'finance_expect',(case when expect_month<=1 then 13 when expect_month<=3 then 14 
        when expect_month<=6 then 15 when expect_month<=12 then 16 when expect_month<=24 then 17 when expect_month<=36 then 18 else 19 end )) as metric_dim
    ,'{P_TASK_ID}' AS DW_CREATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
    ,'{P_TASK_ID}' AS DW_UPDATE_BY,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
,sum(invest_amt) as INVEST_AMT --投资额(新增投资额)
,sum(annualized_invest_amt) as INVEST_AMT_YEAR --年化投资额(新增年化投资额)
,sum(deductible_amt) as COUPON_AMT --现金券金额
,null as BONUS_COUPONS_AMT --加息券金额（add_rate）
,sum(invest_cnt) as INVEST_CNT --投资次数
,sum(expected_earnings_amt) as INVEST_EARNINGS --投资收益
,count(1) as INVEST_USER_CNT --投资用户数
from idw.fact_csyy_user_invest_stat_daily
where stat_date >='{LAST_DATA_TIME}'
and stat_date<'{T}'
group by stat_date,product_name
    ,(case when expect_month<=1 then 13 when expect_month<=3 then 14 
        when expect_month<=6 then 15 when expect_month<=12 then 16 when expect_month<=24 then 17 when expect_month<=36 then 18 else 19 end ) ) al
lateral view stack (6,100000,'INVEST_AMT',cast(INVEST_AMT as string),100001,'INVEST_AMT_YEAR',cast(INVEST_AMT_YEAR as string)
    ,100002,'INVEST_EARNINGS',cast(INVEST_EARNINGS as string),100003,'COUPON_AMT',cast(COUPON_AMT as string)
    ,100004,'BONUS_COUPONS_AMT',cast(BONUS_COUPONS_AMT as string),100009,'INVEST_CNT',cast(INVEST_CNT as string) ) tb as metric_id,metric_code,metric_value

INSERT OVERWRITE TABLE idw.MC_METRIC_VALUE_CUR PARTITION (METRIC_ID, BIZ)
select al.data_freq,al.data_time,tb.metric_code,al.dim_group_id,al.metric_dim,tb.metric_value,al.DW_CREATE_BY,al.DW_CREATE_TIME,al.DW_UPDATE_BY,al.DW_UPDATE_TIME
 ,tb.metric_id,al.biz
 where tb.metric_value is not null;
