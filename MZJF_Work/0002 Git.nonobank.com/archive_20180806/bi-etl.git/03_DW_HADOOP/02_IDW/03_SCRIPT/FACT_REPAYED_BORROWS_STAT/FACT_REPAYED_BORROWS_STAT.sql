set mapreduce.job.name = idw_fact_repayed_borrows_stat_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table idw.fact_repayed_borrows_stat
  select bo.BO_ID,
         bo.P_ID,
         bo.BUSI_LINE,
         bo.USER_ID,
         bo.BO_RATE,
         bo.INTEREST_RATE_CUT,
         bo.BO_FINISH_PRICE,
         bo.BO_EXPECT,
         bo.BO_EXPECT_CAT,
         bo.IS_FIRST_REPAY_OVERDUE,
         bo.FIRST_REPAY_OVERDUE_DAYS,
         bo.BO_AUDIT_TIME,
         bo.BO_AGREE_TIME,
         bo.ALL_REPAYED_TIME,
         t1.OVERDUE_CNT,
         t1.OVERDUE_PRICE,
         t1.OVERDUE_PRICE_B,
         t1.OVERDUE_PRICE_L,
         t1.OVERDUE_PRICE_PUNISH,
         t1.OVERDUE_SERVICE_FEE,
         t1.MAX_OVERDUE_DAYS,
         t1.TOTAL_OVERDUE_DAYS,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t1.IS_OVERDUE,
         t1.FIRST_REPAY_TIME,
         t1.REPAY_BEGIN_DAY,
         t1.REPAY_END_DAY,
         t1.PREPAYMENT_PRICE,
         t1.RETURNED_PRICE,
         t1.REPAYED_PRICE,
         t1.REPAYED_PRICE_B,
         t1.REPAYED_PRICE_L,
         t1.REPAYED_PRICE_PUNISH,
         t2.MAX_CONTINUOUS_OVERDUE_PRICE_B,
         t2.MAX_CONTINUOUS_OVERDUE_CNT,
         bo.CATEGORY_NAME_01,
         bo.BIZ_CODE_01,
         bo.BIZ_NAME_01,
         bo.DEPOSITORY_FLAG,
         bo.FIRST_OVERDUE_EXPECT_NUM,
         bo.FIRST_OVERDUE_BR_TIME,
         bo.TRANSFER_ACCOUNT_TIME,
         bo.P_NAME,
         bo.MONTHLY_REPAYMENT_AMT,
         t1.REPAYED_EXTRA_FEE,
         bo.P_KEY
    from idw.fact_borrows bo
    join (select br.BO_ID,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        1
                       else
                        0
                     end) OVERDUE_CNT,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        BR_PRICE
                       else
                        0
                     end) OVERDUE_PRICE,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        BR_PRICE_B
                       else
                        0
                     end) OVERDUE_PRICE_B,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        BR_PRICE_L
                       else
                        0
                     end) OVERDUE_PRICE_L,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) OVERDUE_PRICE_PUNISH,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        BR_SERVICE_FEE
                       else
                        0
                     end) OVERDUE_SERVICE_FEE,
                 max(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        datediff(br.br_repay_time, br.br_time)
                     end) MAX_OVERDUE_DAYS,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        datediff(br.br_repay_time, br.br_time)
                     end) TOTAL_OVERDUE_DAYS,
                 if(sum(case
                          when br.BR_OVERDUE_TERMS > 0 then
                           1
                        end) > 0,
                    1,
                    0) IS_OVERDUE,
                 min(br.br_repay_time) FIRST_REPAY_TIME,
                 min(BR_TIME) REPAY_BEGIN_DAY,
                 max(BR_TIME) REPAY_END_DAY,
                 sum(case
                       when add_months(to_date(br.br_repay_time), 1) <=
                            br.br_time then
                        br.BR_PRICE
                       else
                        0
                     end) PREPAYMENT_PRICE,
                 sum(br.PRICE_RETURN) RETURNED_PRICE,
                 sum(br.BR_PRICE) REPAYED_PRICE,
                 sum(br.BR_PRICE_B) REPAYED_PRICE_B,
                 sum(br.BR_PRICE_L) REPAYED_PRICE_L,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        br.BR_PRICE_PUNISH
                       else
                        0
                     end) REPAYED_PRICE_PUNISH,
                 sum(br.BR_EXTRA_FEE) REPAYED_EXTRA_FEE
            from idw.fact_borrows bo
            join idw.fact_borrows_repayment br
              on bo.bo_id = br.bo_id
           where bo.BO_IS_SUCCESS = 1
             and bo.BO_ALL_REPAYED = 1
           group by br.BO_ID) t1
      on bo.bo_id = t1.bo_id
     and bo.BO_IS_SUCCESS = 1
     and bo.BO_ALL_REPAYED = 1
    left join (select bo_id,
                      max(continuous_overdue_price_b) max_continuous_overdue_price_b,
                      max(br_overdue_terms) max_continuous_overdue_cnt
                 from (select br1.br_id,
                              br1.bo_id,
                              br1.br_overdue_terms,
                              sum(br2.br_price_b) continuous_overdue_price_b
                         from idw.fact_borrows bo
                         join idw.fact_borrows_repayment br1
                           on bo.bo_id = br1.bo_id
                          and bo.bo_is_success = 1
                          and bo.bo_all_repayed = 1
                          and br1.br_overdue_terms > 0
                         join idw.fact_borrows_repayment br2
                           on br1.bo_id = br2.bo_id
                        where (br1.br_expect_num - br1.br_overdue_terms + 1) <=
                              br2.br_expect_num
                          and br1.br_expect_num >= br2.br_expect_num
                        group by br1.br_id, br1.bo_id, br1.br_overdue_terms) s
                group by bo_id) t2
      on bo.bo_id = t2.bo_id;