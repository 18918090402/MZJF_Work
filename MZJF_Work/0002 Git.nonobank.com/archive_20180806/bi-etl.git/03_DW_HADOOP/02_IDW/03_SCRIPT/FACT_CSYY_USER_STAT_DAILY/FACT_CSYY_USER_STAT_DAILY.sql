set mapreduce.job.name = idw_fact_csyy_user_stat_daily_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

drop table if exists tmp.tmp_idw_fact_csyy_user_stat_daily_01;
create table if not exists tmp.tmp_idw_fact_csyy_user_stat_daily_01
stored as parquet 
as
select user_code,
       user_id,
       sum(INVEST_AMT) INVEST_AMT,
       sum(ANNUALIZED_INVEST_AMT) ANNUALIZED_INVEST_AMT,
       sum(EXPECTED_EARNINGS_AMT) EXPECTED_EARNINGS_AMT,
       sum(INVEST_CNT) INVEST_CNT,
       sum(DEDUCTIBLE_AMT) DEDUCTIBLE_AMT,
       STAT_DATE
  from idw.FACT_CSYY_USER_INVEST_STAT_DAILY
 where stat_date >= to_date('{LAST_DATA_TIME}')
   and stat_date < to_date('{T}')
 group by user_code, user_id, stat_date;
 
set mapreduce.job.name = idw_fact_csyy_user_stat_daily_02;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

drop table if exists tmp.tmp_idw_fact_csyy_user_stat_daily_02;
create table if not exists tmp.tmp_idw_fact_csyy_user_stat_daily_02
stored as parquet 
as
select user_code,
       user_id,
       sum(aum) aum,
       sum(KXCS_LOCK_AUM) KXCS_LOCK_AUM,
       sum(KXCS_UNLOCK_AUM) KXCS_UNLOCK_AUM,
       stat_date
  from idw.FACT_CSYY_USER_IN_INVEST_STAT_DAILY
 where stat_date >= to_date('{LAST_DATA_TIME}')
   and stat_date < to_date('{T}')
 group by user_code, user_id, stat_date;
 
set mapreduce.job.name = idw_fact_csyy_user_stat_daily_03;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

drop table if exists tmp.tmp_idw_fact_csyy_user_stat_daily_03;
create table if not exists tmp.tmp_idw_fact_csyy_user_stat_daily_03
stored as parquet
as
select user_code,
       user_id,
       sum(CASH_AMT) CASH_AMT,
       sum(HZD_AMT) HZD_AMT,
       sum(HQ_WITHDRAW_AMT) HQ_WITHDRAW_AMT,
       sum(case
             when product_code = 'NN0018' then
              CASH_AMT
           end) KXCS_CASH_AMT,
       stat_date
  from idw.FACT_CSYY_USER_CASH_STAT_DAILY
 where stat_date >= to_date('{LAST_DATA_TIME}')
   and stat_date < to_date('{T}')
 group by user_code, user_id, stat_date;

set mapreduce.job.name = idw_fact_csyy_user_stat_daily_04;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

drop table if exists tmp.tmp_idw_fact_csyy_user_stat_daily_04;
create table if not exists tmp.tmp_idw_fact_csyy_user_stat_daily_04
stored as parquet 
as
select ar.merchant_user_id             user_code,
       ui.user_id,
       ui.csyy_invest_cnt              total_invest_cnt,
       ui.csyy_total_invest_amt        total_invest_amt,
       ui.csyy_total_invest_amt_yearly total_annualized_invest_amt,
       ui.csyy_max_aum                 max_aum,
       ui.csyy_max_aum_date            max_aum_date,
       ui.csyy_balance_amt             balance_amt,
       ui.stat_date
  from idw.dim_user_hist ui
  join odsopr.account_relation ar
    on ui.user_id = ar.nono_user_id
 where (ui.CSYY_BALANCE_AMT > 0 or ui.CSYY_TOTAL_INVEST_AMT > 0)
   and ui.stat_date >= to_date('{LAST_DATA_TIME}')
   and ui.stat_date < to_date('{T}');

set mapreduce.job.name = idw_fact_csyy_user_stat_daily_05;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table idw.FACT_CSYY_USER_STAT_DAILY partition
  (STAT_DATE)
  select t1.user_code,
         t1.user_id,
         tmp1.INVEST_AMT,
         tmp1.ANNUALIZED_INVEST_AMT,
         tmp1.EXPECTED_EARNINGS_AMT,
         tmp1.INVEST_CNT,
         tmp1.DEDUCTIBLE_AMT,
         tmp4.TOTAL_INVEST_CNT,
         tmp4.TOTAL_INVEST_AMT,
         tmp4.TOTAL_ANNUALIZED_INVEST_AMT,
         tmp2.AUM,
         tmp4.MAX_AUM,
         tmp4.MAX_AUM_DATE,
         tmp2.KXCS_LOCK_AUM,
         tmp2.KXCS_UNLOCK_AUM,
         tmp3.CASH_AMT,
         tmp3.HZD_AMT,
         tmp3.HQ_WITHDRAW_AMT,
         tmp3.KXCS_CASH_AMT,
         tmp4.BALANCE_AMT,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         t1.STAT_DATE
    from (select user_code, user_id, stat_date
            from (select user_code, user_id, stat_date
                    from tmp.tmp_idw_fact_csyy_user_stat_daily_01
                  union all
                  select user_code, user_id, stat_date
                    from tmp.tmp_idw_fact_csyy_user_stat_daily_02
                  union all
                  select user_code, user_id, stat_date
                    from tmp.tmp_idw_fact_csyy_user_stat_daily_03
                  union all
                  select user_code, user_id, stat_date
                    from tmp.tmp_idw_fact_csyy_user_stat_daily_04) a
           group by user_code, user_id, stat_date) t1
    left join tmp.tmp_idw_fact_csyy_user_stat_daily_01 tmp1
      on t1.user_code = tmp1.user_code
     and t1.stat_date = tmp1.stat_date
    left join tmp.tmp_idw_fact_csyy_user_stat_daily_02 tmp2
      on t1.user_code = tmp2.user_code
     and t1.stat_date = tmp2.stat_date
    left join tmp.tmp_idw_fact_csyy_user_stat_daily_03 tmp3
      on t1.user_code = tmp3.user_code
     and t1.stat_date = tmp3.stat_date
    left join tmp.tmp_idw_fact_csyy_user_stat_daily_04 tmp4
      on t1.user_code = tmp4.user_code
     and t1.stat_date = tmp4.stat_date;