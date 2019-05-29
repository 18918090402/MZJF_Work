set mapreduce.job.name = idw_fact_month_repay_stat_daily_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table idw.FACT_MONTH_REPAY_STAT_DAILY partition
  (STAT_DATE)
  select bo.BO_ID,
         bo.P_ID,
         bo.BUSI_LINE,
         bo.USER_ID,
         bo.BO_RATE,
         bo.INTEREST_RATE_CUT,
         bo.BO_AUDIT_TIME,
         bo.BO_AGREE_TIME,
         t1.SHOULD_REPAY_PRICE_THIS_MONTH,
         t1.SHOULD_REPAY_PRICE_B_THIS_MONTH,
         t1.SHOULD_REPAY_PRICE_L_THIS_MONTH,
         t1.SHOULD_REPAY_PRICE_PUNISH_THIS_MONTH,
         t1.SHOULD_REPAY_SERVICE_FEE_THIS_MONTH,
         t1.SHOULD_RETURN_PRICE_THIS_MONTH,
         t1.REPAYED_PRICE_THIS_MONTH,
         t1.REPAYED_PRICE_B_THIS_MONTH,
         t1.REPAYED_PRICE_L_THIS_MONTH,
         t1.REPAYED_PRICE_PUNISH_THIS_MONTH,
         t1.REPAYED_SERVICE_FEE_THIS_MONTH,
         t1.RETURNED_PRICE_THIS_MONTH,
         t1.SHOULD_REPAY_PRICE_TO_END_MONTH,
         t1.SHOULD_REPAY_PRICE_B_TO_END_MONTH,
         t1.SHOULD_REPAY_PRICE_L_TO_END_MONTH,
         t1.SHOULD_REPAY_PRICE_PUNISH_TO_END_MONTH,
         t1.SHOULD_REPAY_SERVICE_FEE_TO_END_MONTH,
         t1.SHOULD_RETURN_PRICE_TO_END_MONTH,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         bo.CATEGORY_NAME_01,
         bo.BIZ_CODE_01,
         bo.BIZ_NAME_01,
         bo.DEPOSITORY_FLAG,
         bo.TRANSFER_ACCOUNT_TIME,
         bo.P_NAME,
         t1.REPAYED_NORMAL_PRICE_THIS_MONTH,
         t1.REPAYED_OVERDUE_PRICE_THIS_MONTH,
         t1.LAST_REPAYED_TIME_THIS_MONTH,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') STAT_DATE
    from (select bo.BO_ID,
       sum(case
             when (br.br_is_repay = 0 or
                  br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM')) and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.BR_PRICE
             else
              0
           end) SHOULD_REPAY_PRICE_THIS_MONTH,
       sum(case
             when (br.br_is_repay = 0 or
                  br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM')) and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.BR_PRICE_B
             else
              0
           end) SHOULD_REPAY_PRICE_B_THIS_MONTH,
       sum(case
             when (br.br_is_repay = 0 or
                  br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM')) and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.BR_PRICE_L
             else
              0
           end) SHOULD_REPAY_PRICE_L_THIS_MONTH,
       sum(case
             when (br.br_is_repay = 0 or
                  br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM')) and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') and
                  br.BR_OVERDUE_TERMS > 0 then
              br.BR_PRICE_PUNISH
             else
              0
           end) SHOULD_REPAY_PRICE_PUNISH_THIS_MONTH,
       sum(case
             when (br.br_is_repay = 0 or
                  br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM')) and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') and
                  br_repay_status <> 4 then
              br.BR_SERVICE_FEE - br.br_repayed_tech_fee
             else
              0
           end) SHOULD_REPAY_SERVICE_FEE_THIS_MONTH,
       sum(case
             when (br.br_is_repay = 0 or
                  br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM')) and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') and
                  br_repay_status <> 4 then
              br.PRICE_RETURN
             else
              0
           end) SHOULD_RETURN_PRICE_THIS_MONTH,
       sum(case
             when br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.BR_PRICE
             else
              0
           end) REPAYED_PRICE_THIS_MONTH,
       sum(case
             when br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.BR_PRICE_B
             else
              0
           end) REPAYED_PRICE_B_THIS_MONTH,
       sum(case
             when br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.BR_PRICE_L
             else
              0
           end) REPAYED_PRICE_L_THIS_MONTH,
       sum(case
             when br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM') and
                  br.BR_OVERDUE_TERMS > 0 then
              br.BR_PRICE_PUNISH
             else
              0
           end) REPAYED_PRICE_PUNISH_THIS_MONTH,
       sum(case
             when br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM') and
                  br_repay_status <> 4 then
              br.BR_SERVICE_FEE - br.br_repayed_tech_fee
             else
              0
           end) REPAYED_SERVICE_FEE_THIS_MONTH,
       sum(case
             when br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM') and
                  br_repay_status <> 4 then
              br.PRICE_RETURN
             else
              0
           end) RETURNED_PRICE_THIS_MONTH,
       sum(case
             when br.br_is_repay = 0 and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.BR_PRICE
             else
              0
           end) SHOULD_REPAY_PRICE_TO_END_MONTH,
       sum(case
             when br.br_is_repay = 0 and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.BR_PRICE_B
             else
              0
           end) SHOULD_REPAY_PRICE_B_TO_END_MONTH,
       sum(case
             when br.br_is_repay = 0 and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.BR_PRICE_L
             else
              0
           end) SHOULD_REPAY_PRICE_L_TO_END_MONTH,
       sum(case
             when br.br_is_repay = 0 and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') and
                  br.BR_OVERDUE_TERMS > 0 then
              br.BR_PRICE_PUNISH
             else
              0
           end) SHOULD_REPAY_PRICE_PUNISH_TO_END_MONTH,
       sum(case
             when br.br_is_repay = 0 and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.BR_SERVICE_FEE - br.br_repayed_tech_fee
             else
              0
           end) SHOULD_REPAY_SERVICE_FEE_TO_END_MONTH,
       sum(case
             when br.br_is_repay = 0 and
                  br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') then
              br.PRICE_RETURN
             else
              0
           end) SHOULD_RETURN_PRICE_TO_END_MONTH,
       sum(case
             when br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM') and
                  br.BR_OVERDUE_TERMS = 0 then
              br.BR_PRICE
             else
              0
           end) REPAYED_NORMAL_PRICE_THIS_MONTH,
       sum(case
             when br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
                  br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM') and
                  br.BR_OVERDUE_TERMS > 0 then
              br.BR_PRICE
             else
              0
           end) REPAYED_OVERDUE_PRICE_THIS_MONTH,
       min(br.br_repay_time) LAST_REPAYED_TIME_THIS_MONTH
  from idw.fact_borrows bo
  join idw.fact_borrows_repayment br
    on bo.bo_id = br.bo_id
 where bo.BO_IS_SUCCESS = 1
   and ((br.br_time < trunc(add_months('{T_SUB_1}', 1), 'MM') and
       br.br_is_repay = 0) or
       (br.br_repay_time >= trunc('{T_SUB_1}', 'MM') and
       br.br_repay_time < trunc(add_months('{T_SUB_1}', 1), 'MM')))
 group by bo.BO_ID) t1
    join idw.fact_borrows bo
      on t1.bo_id = bo.bo_id;