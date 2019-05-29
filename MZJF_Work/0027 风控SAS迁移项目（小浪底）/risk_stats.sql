INSERT OVERWRITE TABLE dw_srm.fact_risk_stats_m partition (STAT_DATE)
        select t.bo_id
               ,t.user_id
               ,'${T_SUB_1}' as statis_dt
               --,t.product_cd
               ,p.product_line_name
               ,p.product_type_name
               ,p.product_name
               ,t.bo_success_date                                                  as DISBURSED_DATE
               ,t.bo_finish_price                                                  as DISBURSED_AMT
               ,t.expect_type                                                      as TERM
               ,case when t.overdue_unrepay_days = 0 and t.unrepay_price_b = 0 then "closed"
                    when t.overdue_unrepay_days > 0 then "overdue"
                    else "current"
               end                                                                 as status
               ,br.repay_date                                                      as repay_date
               ,br.actrepay_date                                                   as actrepay_date
               ,t.overdue_unrepay_days                                             as OVERDUE_DAY
               ,if(br.max_overdue_days<0, 0, br.max_overdue_days)                  as max_overdue_days
               ,br.overdue_expect_cnt                                              as OVERDUE_TERM
               ,t.unrepay_price_b                                                  as OUTSTANDING_AMT
               ,br.repayed_cnt                                                     as TERM_PAID
               ,br.due_unrepay_price_b                                             as OVERDUE_PRINCIPAL_AMT
               ,br.repayed_price_b_this_month                                      as PRINCIPAL_TMONTH_AMT
               ,pd.fpd_1_flag
               ,pd.fpd_3_flag
               ,pd.fpd_7_flag
               ,pd.fpd_15_flag
               ,pd.fpd_30_flag
               ,pd.spd_30_flag
               ,pd.tpd_30_flag
               ,pd.qpd_30_flag
               ,pd.fifthpd_30_flag
               ,pd.sixthpd_30_flag
               ,pd.seventhpd_30_flag
               ,pd.eighthpd_30_flag
               ,pd.ninthpd_30_flag
               ,pd.tenthpd_30_flag
               ,pd.eleventhpd_30_flag
               ,pd.twelfthpd_30_flag
               ,case 
                  when t.overdue_unrepay_days = 0 then 'M0'
                  when t.overdue_unrepay_days > 0 and t.overdue_unrepay_days < 30 then 'M1'
                  when t.overdue_unrepay_days >= 30 and t.overdue_unrepay_days < 60 then 'M2'
                  when t.overdue_unrepay_days >= 60 and t.overdue_unrepay_days < 90 then 'M3'
                  when t.overdue_unrepay_days >= 90 and t.overdue_unrepay_days < 120 then 'M4'
                  when t.overdue_unrepay_days >= 120 and t.overdue_unrepay_days < 150 then 'M5'
                  when t.overdue_unrepay_days >= 150 and t.overdue_unrepay_days < 180 then 'M6'
                  when t.overdue_unrepay_days >= 180 then 'M7+'
               end as aging
               ,t.mob
               ,substr(d.year_long_desc,1,4)                                as year
               ,d.quarter_short_desc                                        as quarter
               ,d.month_short_desc                                          as month

               ,o.new_loss                                                  as loss_mark
               ,o.new_loss_unrepay_price_b                                  as loss_amt
               ,case when o.new_loss = 1 then o.stat_date else null end     as loss_date
               ,o.net_new_loss_price                                        as net_loss_amt
               ,case when o2.bo_id is not null 
                     then 0 else o.unrepay_price_b end                      as stock_amt

               ,o.recover_loss                                              as recovery_mark
               ,o.new_loss_repayed_price_b                                  as recovery_amt
               ,case when o.recover_loss = 1 then o.stat_date else null end as recover_date

               ,o.fraud_loss                                                as floss_mark
               ,o.fraud_loss_unrepay_price_b                                as floss_amt
               ,o.fraud_loss_repayed_price_b                                as frecovery_amt
               ,o.net_fraud_loss_price                                      as net_floss_amt
               ,'${T_SUB_1}'                                                as stat_date
          from dw_srmopr.fact_risk_vintage_quota_m t

     left join dw_srmopr.dim_product_cat p 
            on p.product_cd = t.product_cd
          
     left join (
                    select br.bo_id
                           ,max(case when substr(br.br_time,1,7) = substr('${T_SUB_1}',1,7) then br.br_time else NULL end) as repay_date
                           ,max(case when substr(br.br_time,1,7) = substr('${T_SUB_1}',1,7) then to_date(br.br_repay_time) else NULL end) as actrepay_date
                           ,if(max(if(br.br_time <= '${T_SUB_1}', datediff(if(to_date(br_repay_time) <= '${T_SUB_1}', to_date(br_repay_time),date_add('${T_SUB_1}', 1)), br.br_time), 0)) > 0,1,0)  IS_OVERDUE                  --是否有过逾期
                           ,max(if(br.br_time <= '${T_SUB_1}', datediff(if(to_date(br_repay_time) <= '${T_SUB_1}', to_date(br_repay_time),date_add('${T_SUB_1}', 1)), br.br_time), 0))              MAX_OVERDUE_DAYS            --最大逾期天数
                           ,sum(if(br.br_time <= '${T_SUB_1}' and datediff(if(to_date(br_repay_time) <= '${T_SUB_1}', to_date(br_repay_time),date_add('${T_SUB_1}', 1)), br.br_time) > 0, 1, 0))    OVERDUE_EXPECT_CNT          --历史累计逾期期数
                           ,sum(case when br_is_repay > 0 and to_date(br.br_repay_time) <= to_date('${T_SUB_1}') then 1 else 0 end)                                                                 REPAYED_CNT                 --已还期数
                           ,sum(case when (br.br_is_repay = 0 or to_date(br.br_repay_time) > to_date('${T_SUB_1}')) and br.br_time <= to_date('${T_SUB_1}') then BR_PRICE_B else 0 end)             DUE_UNREPAY_PRICE_B         --到期未还本金
                           ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('${T_SUB_1}',1,7) then BR_PRICE_B else 0 end)                                                      REPAYED_PRICE_B_THIS_MONTH  --本月已还本金
                      from idw.fact_borrows_repayment br 
                  group by br.bo_id
               ) br     
            on br.bo_id = t.bo_id
            
     left join dw_srmopr.fact_risk_payment_delay_d pd
            on pd.bo_id = t.bo_id 
           and pd.stat_date = '${T_SUB_1}' 
            
     left join dw_srmopr.dim_date d 
            on d.day_short_desc = t.bo_success_date
            
     left join dw_srmopr.fact_risk_overdue_quota_m o
            on o.bo_id = t.bo_id 
           and o.stat_date = '${T_SUB_1}' 
           
     left join (
                    select bo_id from dw_srmopr.fact_risk_overdue_quota_m 
                     where stat_date <= '${T_SUB_1}'
                       and new_loss = 1 
                  group by bo_id
               
               ) o2
            on o2.bo_id = t.bo_id      
            
         where t.stat_date = '${T_SUB_1}' 
         ;
