set mapreduce.job.name = idw_fact_in_repay_borrows_snapshot_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table idw.FACT_IN_REPAY_BORROWS_SNAPSHOT partition
  (STAT_DATE)
  select bo.BO_ID,
         bo.P_ID,
         bo.BUSI_LINE,
         bo.USER_ID,
         bo.BO_RATE,
         bo.INTEREST_RATE_CUT,
         bo.BO_AUDIT_TIME,
         bo.BO_AGREE_TIME,
         t1.SHOULD_REPAY_CNT,
         t1.REPAYED_CNT,
         t1.UNREPAY_CNT,
         t1.REPAYED_CNT_THIS_MONTH,
         t1.SHOULD_REPAY_PRICE,
         t1.REPAYED_PRICE,
         t1.UNREPAY_PRICE,
         t1.REPAYED_PRICE_THIS_MONTH,
         t1.SHOULD_REPAY_PRICE_B,
         t1.REPAYED_PRICE_B,
         t1.UNREPAY_PRICE_B,
         t1.REPAYED_PRICE_B_THIS_MONTH,
         t1.SHOULD_REPAY_PRICE_L,
         t1.REPAYED_PRICE_L,
         t1.UNREPAY_PRICE_L,
         t1.REPAYED_PRICE_L_THIS_MONTH,
         t1.SHOULD_REPAY_PRICE_PUNISH,
         t1.REPAYED_PRICE_PUNISH,
         t1.UNREPAY_PRICE_PUNISH,
         t1.REPAYED_PRICE_PUNISH_THIS_MONTH,
         t1.SHOULD_REPAY_SERVICE_FEE,
         t1.REPAYED_SERVICE_FEE,
         t1.UNREPAY_SERVICE_FEE,
         t1.REPAYED_SERVICE_FEE_THIS_MONTH,
         t1.REPAY_BEGIN_DAY,
         t1.LAST_REPAYED_TIME,
         t1.COMPENSATE_AMT,
         t1.REPAYED_COMPENSATE_AMT,
         bo.IS_FIRST_REPAY_OVERDUE,
         bo.FIRST_REPAY_OVERDUE_DAYS,
         t1.IS_OVERDUE,
         t1.MAX_OVERDUE_DAYS,
         t1.IS_OVERDUE_UNREPAY,
         case
           when t2.bo_id is null then
            0
           else
            1
         end IS_DUNNING,
         t2.odc_type DUN_TYPE,
         t2.id DUN_COMPANY,
         t2.odc_name DUN_COMPANY_NAME,
         t2.mod_start_time DUN_START_TIME,
         t2.mod_end_time DUN_END_TIME,
         t1.OVERDUE_EXPECT_CNT,
         t1.OVERDUE_REPAYED_PRICE,
         t1.OVERDUE_UNREPAY_EXPECT_CNT,
         t1.OVERDUE_UNREPAY_DAYS,
         case
           when t1.OVERDUE_UNREPAY_DAYS = 0 then
            'M0'
           when t1.OVERDUE_UNREPAY_DAYS > 0 and t1.OVERDUE_UNREPAY_DAYS < 30 then
            'M1'
           when t1.OVERDUE_UNREPAY_DAYS >= 30 and
                t1.OVERDUE_UNREPAY_DAYS < 60 then
            'M2'
           when t1.OVERDUE_UNREPAY_DAYS >= 60 and
                t1.OVERDUE_UNREPAY_DAYS < 90 then
            'M3'
           when t1.OVERDUE_UNREPAY_DAYS >= 90 and
                t1.OVERDUE_UNREPAY_DAYS < 120 then
            'M4'
           when t1.OVERDUE_UNREPAY_DAYS >= 120 and
                t1.OVERDUE_UNREPAY_DAYS < 150 then
            'M5'
           when t1.OVERDUE_UNREPAY_DAYS >= 150 then
            'M6+'
         end AGING,
         t1.OVERDUE_UNREPAY_PRICE,
         t1.OVERDUE_UNREPAY_PRICE_B,
         t1.OVERDUE_UNREPAY_PRICE_L,
         t1.OVERDUE_UNREPAY_PRICE_PUNISH,
         t1.OVERDUE_UNREPAY_SERVICE_FEE,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         t1.REPAY_END_DAY,
         t1.COMPENSATE_PRICE_B,
         t1.REPAYED_COMPENSATE_PRICE_B,
         bo.BO_FINISH_PRICE,
         bo.BO_EXPECT,
         bo.BO_EXPECT_CAT,
         t1.CUR_PRICE,
         t1.CUR_PRICE_B,
         t1.CUR_PRICE_L,
         t1.CUR_SERVICE_FEE,
         t1.FIRST_REPAY_TIME,
         t1.SHOULD_RETURN_PRICE,
         t1.RETURNED_PRICE,
         t1.UNRETURNED_PRICE,
         t1.RETURNED_PRICE_THIS_MONTH,
         t1.OVERDUE_RETURNED_PRICE,
         t1.OVERDUE_UNRETURNED_PRICE,
         t1.OVERDUE_UNREPAY_EARLIEST_BR_TIME,
         t3.MAX_CONTINUOUS_OVERDUE_PRICE_B,
         t3.MAX_CONTINUOUS_OVERDUE_CNT,
         bo.CATEGORY_NAME_01,
         bo.BIZ_CODE_01,
         bo.BIZ_NAME_01,
         bo.DEPOSITORY_FLAG,
         bo.FIRST_OVERDUE_EXPECT_NUM,
         bo.FIRST_OVERDUE_BR_TIME,
         bo.TRANSFER_ACCOUNT_TIME,
         bo.P_NAME,
         bo.MONTHLY_REPAYMENT_AMT,
         case
           when t1.POSTED_BILL_NUM < 12 then
            t1.POSTED_BILL_UNREPAY_AMT + t1.PENDING_BILL_UNREPAY_B * 1.06
           when t1.POSTED_BILL_NUM >= 12 then
            t1.POSTED_BILL_UNREPAY_AMT + t1.PENDING_BILL_UNREPAY_B * 1.05
         end SETTLEMENT_SHOULD_REPAY_AMT,
         t1.POSTED_BILL_NUM,
         t1.SHOULD_REPAY_EXTRA_FEE,
         t1.REPAYED_EXTRA_FEE,
         t1.UNREPAY_EXTRA_FEE,
         t1.REPAYED_EXTRA_FEE_THIS_MONTH,
         bo.P_KEY,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') STAT_DATE
    from idw.fact_borrows bo
    join (select br.bo_id,
                 sum(case
                       when br.br_time < to_date('{T}') then
                        1
                       else
                        0
                     end) SHOULD_REPAY_CNT,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        1
                       else
                        0
                     end) REPAYED_CNT,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        1
                       else
                        0
                     end) UNREPAY_CNT,
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then
                        1
                       else
                        0
                     end) REPAYED_CNT_THIS_MONTH,
                 sum(case
                       when br.br_time < to_date('{T}') then
                        BR_PRICE
                       else
                        0
                     end) SHOULD_REPAY_PRICE,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        BR_PRICE
                       else
                        0
                     end) REPAYED_PRICE,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        BR_PRICE
                       else
                        0
                     end) UNREPAY_PRICE,
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then
                        BR_PRICE
                       else
                        0
                     end) REPAYED_PRICE_THIS_MONTH,
                 sum(case
                       when br.br_time < to_date('{T}') then
                        BR_PRICE_B
                       else
                        0
                     end) SHOULD_REPAY_PRICE_B,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        BR_PRICE_B
                       else
                        0
                     end) REPAYED_PRICE_B,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        BR_PRICE_B
                       else
                        0
                     end) UNREPAY_PRICE_B,
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then
                        BR_PRICE_B
                       else
                        0
                     end) REPAYED_PRICE_B_THIS_MONTH,
                 sum(case
                       when br.br_time < to_date('{T}') then
                        BR_PRICE_L
                       else
                        0
                     end) SHOULD_REPAY_PRICE_L,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        BR_PRICE_L
                       else
                        0
                     end) REPAYED_PRICE_L,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        BR_PRICE_L
                       else
                        0
                     end) UNREPAY_PRICE_L,
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then
                        BR_PRICE_L
                       else
                        0
                     end) REPAYED_PRICE_L_THIS_MONTH,
                 sum(case
                       when br.br_time < to_date('{T}') and
                            br.BR_OVERDUE_TERMS > 0 then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) SHOULD_REPAY_PRICE_PUNISH,
                 sum(case
                       when BR_IS_REPAY > 0 and br.BR_OVERDUE_TERMS > 0 then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) REPAYED_PRICE_PUNISH,
                 sum(case
                       when BR_IS_REPAY = 0 and br.BR_OVERDUE_TERMS > 0 then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) UNREPAY_PRICE_PUNISH,
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') and
                            br.BR_OVERDUE_TERMS > 0 then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) REPAYED_PRICE_PUNISH_THIS_MONTH,
                 sum(case
                       when br.br_time < to_date('{T}') then
                        BR_SERVICE_FEE
                       else
                        0
                     end) SHOULD_REPAY_SERVICE_FEE,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        BR_SERVICE_FEE
                       else
                        0
                     end) + sum(case
                                  when BR_IS_REPAY = 0 then
                                   br_repayed_tech_fee
                                  else
                                   0
                                end) REPAYED_SERVICE_FEE,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        BR_SERVICE_FEE - br_repayed_tech_fee
                       else
                        0
                     end) UNREPAY_SERVICE_FEE,
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then
                        BR_SERVICE_FEE - br_repayed_tech_fee
                       else
                        0
                     end) REPAYED_SERVICE_FEE_THIS_MONTH,
                 min(BR_TIME) REPAY_BEGIN_DAY,
                 max(case
                       when BR_IS_REPAY > 0 then
                        BR_REPAY_TIME
                     end) LAST_REPAYED_TIME,
                 sum(case
                       when IS_COMPENSATE = 1 then
                        BR_PRICE
                       else
                        0
                     end) COMPENSATE_AMT,
                 sum(case
                       when IS_COMPENSATE_RETURNED = 1 then
                        BR_PRICE
                       else
                        0
                     end) REPAYED_COMPENSATE_AMT,
                 if(sum(case
                          when br.BR_OVERDUE_TERMS > 0 then
                           1
                        end) > 0,
                    1,
                    0) IS_OVERDUE,
                 max(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        datediff(coalesce(br.br_repay_time,
                                          from_unixtime(unix_timestamp(),
                                                        'yyyy-MM-dd')),
                                 br.br_time)
                     end) MAX_OVERDUE_DAYS,
                 if(sum(case
                          when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then
                           1
                        end) > 0,
                    1,
                    0) IS_OVERDUE_UNREPAY,
                 sum(case
                       when BR_OVERDUE_TERMS > 0 then
                        1
                       else
                        0
                     end) OVERDUE_EXPECT_CNT,
                 sum(case
                       when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY > 0 then
                        BR_PRICE
                       else
                        0
                     end) OVERDUE_REPAYED_PRICE,
                 sum(case
                       when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        1
                       else
                        0
                     end) OVERDUE_UNREPAY_EXPECT_CNT,
                 max(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        datediff(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'),
                                 br.br_time)
                     end) OVERDUE_UNREPAY_DAYS,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        BR_PRICE
                       else
                        0
                     end) OVERDUE_UNREPAY_PRICE,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        BR_PRICE_B
                       else
                        0
                     end) OVERDUE_UNREPAY_PRICE_B,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        BR_PRICE_L
                       else
                        0
                     end) OVERDUE_UNREPAY_PRICE_L,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) OVERDUE_UNREPAY_PRICE_PUNISH,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        BR_SERVICE_FEE - br_repayed_tech_fee
                       else
                        0
                     end) OVERDUE_UNREPAY_SERVICE_FEE,
                 max(BR_TIME) REPAY_END_DAY,
                 sum(case
                       when IS_COMPENSATE = 1 then
                        BR_PRICE_B
                       else
                        0
                     end) COMPENSATE_PRICE_B,
                 sum(case
                       when IS_COMPENSATE_RETURNED = 1 then
                        BR_PRICE_B
                       else
                        0
                     end) REPAYED_COMPENSATE_PRICE_B,
                 sum(case
                       when br.br_time >= to_date('{T}') and
                            br.br_time < add_months('{T}', 1) then
                        br.BR_PRICE
                       else
                        0
                     end) CUR_PRICE,
                 sum(case
                       when br.br_time >= to_date('{T}') and
                            br.br_time < add_months('{T}', 1) then
                        br.BR_PRICE_B
                       else
                        0
                     end) CUR_PRICE_B,
                 sum(case
                       when br.br_time >= to_date('{T}') and
                            br.br_time < add_months('{T}', 1) then
                        br.BR_PRICE_L
                       else
                        0
                     end) CUR_PRICE_L,
                 sum(case
                       when br.br_time >= to_date('{T}') and
                            br.br_time < add_months('{T}', 1) then
                        br.BR_SERVICE_FEE - br.br_repayed_tech_fee
                       else
                        0
                     end) CUR_SERVICE_FEE,
                 min(br.br_repay_time) FIRST_REPAY_TIME,
                 sum(case
                       when br.br_time < to_date('{T}') then
                        br.PRICE_RETURN
                       else
                        0
                     end) SHOULD_RETURN_PRICE,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        br.PRICE_RETURN
                       else
                        0
                     end) RETURNED_PRICE,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        br.PRICE_RETURN
                       else
                        0
                     end) UNRETURNED_PRICE,
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then
                        br.PRICE_RETURN
                       else
                        0
                     end) RETURNED_PRICE_THIS_MONTH,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY > 0 then
                        br.PRICE_RETURN
                       else
                        0
                     end) OVERDUE_RETURNED_PRICE,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then
                        br.PRICE_RETURN
                       else
                        0
                     end) OVERDUE_UNRETURNED_PRICE,
                 min(case
                       when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then
                        br.BR_TIME
                     end) OVERDUE_UNREPAY_EARLIEST_BR_TIME,
                 sum(case
                       when br.br_time < add_months('{T}', 1) or br.br_is_repay>0 then
                        1
                       else
                        0
                     end) POSTED_BILL_NUM,
                 sum(case
                       when br.br_time < add_months('{T}', 1) and
                            br.br_is_repay = 0 then
                        br.BR_PRICE + br.BR_PRICE_PUNISH
                       else
                        0
                     end) POSTED_BILL_UNREPAY_AMT,
                 sum(case
                       when br.br_time >= add_months('{T}', 1) and
                            br.br_is_repay = 0 then
                        br.BR_PRICE_B
                       else
                        0
                     end) PENDING_BILL_UNREPAY_B,
                 sum(case
                       when br.br_time < to_date('{T}') then
                        br_extra_fee
                       else
                        0
                     end) SHOULD_REPAY_EXTRA_FEE,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        br_extra_fee
                       else
                        0
                     end) REPAYED_EXTRA_FEE,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        br_extra_fee
                       else
                        0
                     end) UNREPAY_EXTRA_FEE,
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then
                        br_extra_fee
                       else
                        0
                     end) REPAYED_EXTRA_FEE_THIS_MONTH
            from idw.fact_borrows bo
            join idw.fact_borrows_repayment br
              on bo.bo_id = br.bo_id
           where bo.bo_is_success = 1
             and bo.bo_all_repayed = 0
           group by br.bo_id) t1
      on bo.bo_id = t1.bo_id
     and bo.bo_is_success = 1
     and bo.bo_all_repayed = 0
    left join (select od.bo_id,
                      case odc.odc_type
                        when 0 then
                         od.create_time
                        else
                         od.mod_start_time
                      end mod_start_time,
                      od.mod_end_time,
                      odc.id,
                      odc.odc_name,
                      odc.odc_type,
                      row_number() over(partition by od.bo_id order by od.id desc) as RID
                 from ods.t_borrows_outsource_dunning_hist od
                 join ods.t_borrows_outsource_dunning_company_hist odc
                   on od.mod_company = odc.id
                where od.mod_status in (0, 4)
                  and od.mod_close_time is null) t2
      on t1.bo_id = t2.bo_id
     and t2.RID = 1
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
                          and bo.bo_all_repayed = 0
                          and br1.br_overdue_terms > 0
                         join idw.fact_borrows_repayment br2
                           on br1.bo_id = br2.bo_id
                        where (br1.br_expect_num - br1.br_overdue_terms + 1) <=
                              br2.br_expect_num
                          and br1.br_expect_num >= br2.br_expect_num
                        group by br1.br_id, br1.bo_id, br1.br_overdue_terms) s
                group by bo_id) t3
      on t1.bo_id = t3.bo_id;