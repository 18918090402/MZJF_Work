set mapreduce.job.name = idw_fact_nono_user_stat_daily_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

drop table if exists tmp.tmp_idw_fact_nono_user_stat_daily_01;
create table if not exists tmp.tmp_idw_fact_nono_user_stat_daily_01
stored as parquet 
as
select user_id,
       sum(INVEST_AMT) INVEST_AMT,
       sum(ANNUALIZED_INVEST_AMT) ANNUALIZED_INVEST_AMT,
       sum(EXPECTED_EARNINGS_AMT) EXPECTED_EARNINGS_AMT,
       sum(INVEST_CNT) INVEST_CNT,
       sum(DEDUCTIBLE_AMT) DEDUCTIBLE_AMT,
       sum(ADD_RATE_AMT) ADD_RATE_AMT,
       STAT_DATE
  from IDW.FACT_NONO_USER_INVEST_STAT_DAILY
 where stat_date >= to_date('{LAST_DATA_TIME}')
   and stat_date < to_date('{T}')
 group by USER_ID, STAT_DATE;
 
set mapreduce.job.name = idw_fact_nono_user_stat_daily_02;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

drop table if exists tmp.tmp_idw_fact_nono_user_stat_daily_02;
create table if not exists tmp.tmp_idw_fact_nono_user_stat_daily_02
stored as parquet 
as
select user_id,
       sum(IN_INVEST_AMT) IN_INVEST_AMT,
       sum(AUM) AUM,
       sum(YYS_LOCK_AUM) YYS_LOCK_AUM,
       sum(YYS_UNLOCK_AUM) YYS_UNLOCK_AUM,
       STAT_DATE
  from idw.FACT_NONO_USER_IN_INVEST_STAT_DAILY
 where stat_date >= to_date('{LAST_DATA_TIME}')
   and stat_date < to_date('{T}')
 group by USER_ID, STAT_DATE;
 
set mapreduce.job.name = idw_fact_nono_user_stat_daily_03;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

drop table if exists tmp.tmp_idw_fact_nono_user_stat_daily_03;
create table if not exists tmp.tmp_idw_fact_nono_user_stat_daily_03
stored as parquet 
as
select user_id,
       sum(CASH_AMT) CASH_AMT,
       sum(case
             when PRODUCT_CATEGORY = '月月升计划' then
              CASH_AMT
           end) YYS_CASH_AMT,
       STAT_DATE
  from idw.FACT_NONO_USER_CASH_STAT_DAILY
 where stat_date >= to_date('{LAST_DATA_TIME}')
   and stat_date < to_date('{T}')
 group by USER_ID, STAT_DATE;

set mapreduce.job.name = idw_fact_nono_user_stat_daily_04;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

drop table if exists tmp.tmp_idw_fact_nono_user_stat_daily_04;
create table if not exists tmp.tmp_idw_fact_nono_user_stat_daily_04
stored as parquet 
as
select user_id,
       sum(withdraw_amt) WITHDRAW_AMT,
       to_date(withdraw_time) STAT_DATE
  from idw.FACT_NONO_WITHDRAW
 where (bo_id <= 0 or bo_id is null)
   and withdraw_time >= to_date('{LAST_DATA_TIME}')
   and withdraw_time < to_date('{T}')
 group by user_id, to_date(withdraw_time);

set mapreduce.job.name = idw_fact_nono_user_stat_daily_05;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

drop table if exists tmp.tmp_idw_fact_nono_user_stat_daily_05;
create table if not exists tmp.tmp_idw_fact_nono_user_stat_daily_05
stored as parquet 
as
select user_id,
       nono_invest_cnt                   total_invest_cnt,
       nono_total_invest_amt             total_invest_amt,
       nono_total_invest_amt_yearly      total_annualized_invest_amt,
       nono_total_plan_invest_cnt        total_plan_invest_cnt,
       nono_total_plan_invest_amt        total_plan_invest_amt,
       nono_total_plan_invest_amt_yearly total_plan_annualized_invest_amt,
       nono_max_in_invest_amt            max_in_invest_amt,
       nono_max_in_invest_amt_date       max_in_invest_amt_date,
       nono_max_aum                      max_aum,
       nono_max_aum_date                 max_aum_date,
       nono_balance_amt                  balance_amt,
       stat_date
  from idw.dim_user_hist
 where (nono_balance_amt > 0 or nono_total_invest_amt > 0)
   and stat_date >= to_date('{LAST_DATA_TIME}')
   and stat_date < to_date('{T}');

set mapreduce.job.name = idw_fact_nono_user_stat_daily_06;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table idw.FACT_NONO_USER_STAT_DAILY partition
  (STAT_DATE)
  select t1.user_id,
         tmp1.INVEST_AMT,
         tmp1.ANNUALIZED_INVEST_AMT,
         tmp1.EXPECTED_EARNINGS_AMT,
         tmp1.INVEST_CNT,
         tmp1.DEDUCTIBLE_AMT,
         tmp1.ADD_RATE_AMT,
         tmp5.TOTAL_INVEST_CNT,
         tmp5.TOTAL_INVEST_AMT,
         tmp5.TOTAL_ANNUALIZED_INVEST_AMT,
         tmp5.TOTAL_PLAN_INVEST_CNT,
         tmp5.TOTAL_PLAN_INVEST_AMT,
         tmp5.TOTAL_PLAN_ANNUALIZED_INVEST_AMT,
         tmp2.IN_INVEST_AMT,
         tmp5.MAX_IN_INVEST_AMT,
         tmp5.MAX_IN_INVEST_AMT_DATE,
         tmp2.AUM,
         tmp5.MAX_AUM,
         tmp5.MAX_AUM_DATE,
         tmp2.YYS_LOCK_AUM,
         tmp2.YYS_UNLOCK_AUM,
         tmp3.CASH_AMT,
         tmp3.YYS_CASH_AMT,
         tmp4.WITHDRAW_AMT,
         tmp5.BALANCE_AMT,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         t1.STAT_DATE
    from (select user_id, STAT_DATE
            from (select user_id, STAT_DATE
                    from tmp.tmp_idw_fact_nono_user_stat_daily_01
                  union all
                  select user_id, STAT_DATE
                    from tmp.tmp_idw_fact_nono_user_stat_daily_02
                  union all
                  select user_id, STAT_DATE
                    from tmp.tmp_idw_fact_nono_user_stat_daily_03
                  union all
                  select user_id, STAT_DATE
                    from tmp.tmp_idw_fact_nono_user_stat_daily_04
                  union all
                  select user_id, STAT_DATE
                    from tmp.tmp_idw_fact_nono_user_stat_daily_05) a
           group by user_id, STAT_DATE) t1
    left join tmp.tmp_idw_fact_nono_user_stat_daily_01 tmp1
      on t1.user_id = tmp1.user_id
     and t1.STAT_DATE = tmp1.STAT_DATE
    left join tmp.tmp_idw_fact_nono_user_stat_daily_02 tmp2
      on t1.user_id = tmp2.user_id
     and t1.STAT_DATE = tmp2.STAT_DATE
    left join tmp.tmp_idw_fact_nono_user_stat_daily_03 tmp3
      on t1.user_id = tmp3.user_id
     and t1.STAT_DATE = tmp3.STAT_DATE
    left join tmp.tmp_idw_fact_nono_user_stat_daily_04 tmp4
      on t1.user_id = tmp4.user_id
     and t1.STAT_DATE = tmp4.STAT_DATE
    left join tmp.tmp_idw_fact_nono_user_stat_daily_05 tmp5
      on t1.user_id = tmp5.user_id
     and t1.STAT_DATE = tmp5.STAT_DATE;