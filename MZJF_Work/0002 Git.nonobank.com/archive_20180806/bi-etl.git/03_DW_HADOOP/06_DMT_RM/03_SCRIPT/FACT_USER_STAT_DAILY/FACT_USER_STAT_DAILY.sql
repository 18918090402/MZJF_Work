set mapreduce.job.name = DMT_RM_FACT_USER_STAT_DAILY_01;
set mapreduce.job.queuename = etl-dw;

drop table if exists tmp.tmp_dmt_rm_fact_user_stat_daily_01;
create table if not exists tmp.tmp_dmt_rm_fact_user_stat_daily_01 stored as parquet as 
select bo.user_id USER_ID,
       sum(case
             when bo.bo_is_success = 1 and bo.bo_all_repayed = 0 then
              1
             else
              0
           end) IN_REPAYMENT_CNT,
       sum(case
             when bo.bo_is_success = 1 and bo.bo_all_repayed = 1 then
              1
             else
              0
           end) ALREADY_REPAYMENT_CNT,
       sum(case
             when bo.bo_is_success = 2 then
              1
             else
              0
           end) REJECT_CNT,
       max(case
             when bo.bo_is_success = 2 then
              bo.bo_audit_time
             else
              null
           end) LAST_REJECT_TIME,
       max(case
             when bo.bo_is_success = 1 then
              bo.bo_finish_price
             else
              null
           end) MAX_BO_BRICE,
       sum(case
             when bo.bo_is_success = 1 and bo.p_id = 77 then
              1
             else
              0
           end) LOAN_MXD_BKB_CNT,
       sum(case
             when bo.bo_is_success = 1 and bo.p_id = 88 then
              1
             else
              0
           end) LOAN_MXD_ZKB_CNT,
       sum(case
             when bo.bo_is_success = 1 and bo.p_id = 83 then
              1
             else
              0
           end) LOAN_MXD_YJB_CNT,
       sum(case
             when bo.bo_is_success = 1 and bo.p_id = 87 then
              1
             else
              0
           end) LOAN_MXD_BLB_CNT,
       sum(case
             when bo.bo_is_success = 1 and bo.p_id = 96 then
              1
             else
              0
           end) LOAN_MYFQ_CNT,
       sum(case
             when bo.bo_is_success = 1 and bo.p_id = 94 then
              1
             else
              0
           end) LOAN_USA_MXD_CNT,
       sum(case
             when bo.bo_is_success = 1 and bo.p_id = 97 then
              1
             else
              0
           end) LOAN_UNIFI_XED_CNT
  from ods.t_borrows_hist bo
 where bo.bo_is_success in (1, 2)
 group by bo.user_id;

set mapreduce.job.name = DMT_RM_FACT_USER_STAT_DAILY_02;
set mapreduce.job.queuename = etl-dw;

drop table if exists tmp.tmp_dmt_rm_fact_user_stat_daily_02;
create table if not exists tmp.tmp_dmt_rm_fact_user_stat_daily_02 stored as parquet as
select user_id USER_ID,
       sum(case
             when overdue_day <= 7 then
              1
             else
              0
           end) OVERDUE_LESS_7_DAY_CNT,
       sum(case
             when overdue_day <= 30 then
              1
             else
              0
           end) OVERDUE_LESS_30_DAY_CNT,
       sum(case
             when overdue_day <= 60 then
              1
             else
              0
           end) OVERDUE_LESS_60_DAY_CNT,
       sum(case
             when overdue_day > 60 then
              1
             else
              0
           end) OVERDUE_MORE_60_DAY_CNT
  from (select br.user_id,
               datediff(coalesce(br.br_repay_time,
                                 from_unixtime(unix_timestamp(), 'yyyy-MM-dd')),
                        br_time) overdue_day
          from ods.t_borrows_repayment_hist br
         where br.br_overdue_terms > 0) a
 group by user_id;

set mapreduce.job.name = DMT_RM_FACT_USER_STAT_DAILY_03;
set mapreduce.job.queuename = etl-dw;

insert overwrite table DMT_RM.FACT_USER_STAT_DAILY partition
  (stat_date = {TSUB1})
  select tmp1.USER_ID,
         ui.USER_NAME,
         ui.REAL_NAME,
         tmp1.IN_REPAYMENT_CNT,
         tmp1.ALREADY_REPAYMENT_CNT,
         tmp1.REJECT_CNT,
         tmp1.LAST_REJECT_TIME,
         tmp2.OVERDUE_LESS_7_DAY_CNT,
         tmp2.OVERDUE_LESS_30_DAY_CNT,
         tmp2.OVERDUE_LESS_60_DAY_CNT,
         tmp2.OVERDUE_MORE_60_DAY_CNT,
         tmp1.MAX_BO_BRICE,
         tmp1.LOAN_MXD_BKB_CNT,
         tmp1.LOAN_MXD_ZKB_CNT,
         tmp1.LOAN_MXD_YJB_CNT,
         tmp1.LOAN_MXD_BLB_CNT,
         tmp1.LOAN_MYFQ_CNT,
         tmp1.LOAN_USA_MXD_CNT,
         tmp1.LOAN_UNIFI_XED_CNT,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         ui.MLD_CREDIT_APPLY_CNT,
         ui.MLD_BO_SUCCESS_CNT,
         ui.REGISTER_TIME
    from tmp.tmp_dmt_rm_fact_user_stat_daily_01 tmp1
    join IDW.DIM_USER AS ui
      on tmp1.user_id = ui.user_id
    left join tmp.tmp_dmt_rm_fact_user_stat_daily_02 tmp2
      on tmp1.user_id = tmp2.user_id;

set mapreduce.job.name = DMT_RM_FACT_USER_STAT_DAILY_04;
set mapreduce.job.queuename = etl-dw;

drop table if exists tmp.tmp_dmt_rm_fact_user_stat_daily_01;
drop table if exists tmp.tmp_dmt_rm_fact_user_stat_daily_02;