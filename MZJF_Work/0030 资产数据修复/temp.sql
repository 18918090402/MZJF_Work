select br.bo_id
                                    ,if(max(if((br.br_is_repay = 0 or to_date(br.br_repay_time) > '{T_SUB_1}') and br.br_time <= '{T_SUB_1}', datediff(if(to_date(br_repay_time) <= '{T_SUB_1}', to_date(br_repay_time),date_add('{T_SUB_1}', 1)), br.br_time), 0)) > 0, 1, 0)   IS_OVERDUE_UNREPAY          --是否当前逾期未还***        
                                    ,max(if((br.br_is_repay = 0 or to_date(br.br_repay_time) > '{T_SUB_1}') and br.br_time <= '{T_SUB_1}', datediff(if(to_date(br_repay_time) <= '{T_SUB_1}', to_date(br_repay_time),date_add('{T_SUB_1}', 1)), br.br_time), 0))                 OVERDUE_UNREPAY_DAYS        --当前逾期未还天数***
                                    ,sum(if((br.br_is_repay = 0 or to_date(br.br_repay_time) > '{T_SUB_1}') and br.br_time <= '{T_SUB_1}' and datediff(if(to_date(br_repay_time) <= '{T_SUB_1}', to_date(br_repay_time),date_add('{T_SUB_1}', 1)), br.br_time) > 0 , 1, 0))      OVERDUE_UNREPAY_EXPECT_CNT  --当前逾期未还期数***

                                    ,if(max(if(br.br_time <= '{T_SUB_1}', datediff(if(to_date(br_repay_time) <= '{T_SUB_1}', to_date(br_repay_time),date_add('{T_SUB_1}', 1)), br.br_time), 0)) > 0,1,0)  IS_OVERDUE           --是否有过逾期***
                                    ,max(if(br.br_time <= '{T_SUB_1}', datediff(if(to_date(br_repay_time) <= '{T_SUB_1}', to_date(br_repay_time),date_add('{T_SUB_1}', 1)), br.br_time), 0))              MAX_OVERDUE_DAYS     --最大逾期天数***
                                    ,sum(if(br.br_time <= '{T_SUB_1}' and datediff(if(to_date(br_repay_time) <= '{T_SUB_1}', to_date(br_repay_time),date_add('{T_SUB_1}', 1)), br.br_time) > 0, 1, 0))    OVERDUE_EXPECT_CNT   --历史累计逾期期数***

                                    ,sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then 1 else 0 end)                                           UNREPAY_CNT                  --未还期数
                                    ,sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then BR_PRICE else 0 end)                                    UNREPAY_PRICE                --未还金额
                                    ,sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then BR_PRICE_B else 0 end)                                  UNREPAY_PRICE_B              --未还本金***
                                    ,sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then BR_PRICE_L else 0 end)                                  UNREPAY_PRICE_L              --未还利息***
                                    ,sum(case when (BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}'))) and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end) UNREPAY_PRICE_PUNISH       --未还罚息***
                                    ,sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then br_service_fee - br_repayed_tech_fee else 0 end)        UNREPAY_SERVICE_FEE          --未还服务费***
                                    ,sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then br.PRICE_RETURN else 0 end)                             UNREPAY_PRICE_RETURN         --未返还金额
                                    ,sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then br_extra_fee else 0 end)                                UNREPAY_EXTRA_FEE            --未还贷后管理费
                                    ,sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then br_service_fee_other else 0 end)                        UNREPAY_SERVICE_FEE_OTHER    --未还第三方服务费
                                    ,sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then br_post_consult_fee else 0 end)                         UNREPAY_POST_CONSULT_FEE     --未还后置咨询费

                                    ,sum(case when br.br_is_repay > 0 and br.br_repay_time <= to_date('{T_SUB_1}') and br.br_time <= to_date('{T_SUB_1}') then BR_PRICE_B else 0 end)                            DUE_REPAID_PRICE_B                --到期已还本金
                                    ,sum(case when br.br_is_repay > 0 and br.br_repay_time <= to_date('{T_SUB_1}') and br.br_time <= to_date('{T_SUB_1}') then BR_PRICE_L else 0 end)                            DUE_REPAID_PRICE_L                --到期已还利息
                                    ,sum(case when br.br_is_repay > 0 and br.br_repay_time <= to_date('{T_SUB_1}') and br.br_time <= to_date('{T_SUB_1}') then BR_PRICE_PUNISH else 0 end)                       DUE_REPAID_PUNISH                 --到期已还罚息
                                    ,sum(case when br.br_is_repay > 0 and br.br_repay_time <= to_date('{T_SUB_1}') and br.br_time <= to_date('{T_SUB_1}') then BR_SERVICE_FEE - br_repayed_tech_fee else 0 end)  DUE_REPAID_SERVICE_FEE            --到期已还服务费
                                    ,sum(case when br.br_is_repay > 0 and br.br_repay_time <= to_date('{T_SUB_1}') and br.br_time <= to_date('{T_SUB_1}') then br_extra_fee else 0 end)                          DUE_REPAID_EXTRA_FEE              --到期已还贷后管理费
                                    ,sum(case when br.br_is_repay > 0 and br.br_repay_time <= to_date('{T_SUB_1}') and br.br_time <= to_date('{T_SUB_1}') then br_service_fee_other else 0 end)                  DUE_REPAID_SERVICE_FEE_OTHER      --到期已还第三方服务费
                                    ,sum(case when br.br_is_repay > 0 and br.br_repay_time <= to_date('{T_SUB_1}') and br.br_time <= to_date('{T_SUB_1}') then br_post_consult_fee else 0 end)                   DUE_REPAID_POST_CONSULT_FEE       --到期已还后置咨询费
                                    ,sum(case when br.br_is_repay > 0 and br.br_repay_time <= to_date('{T_SUB_1}') and br.br_time <= to_date('{T_SUB_1}') then 1 else 0 end)                                     DUE_REPAID_CNT                    --到期已还期数
                                    
                                    ,sum(case when (br.br_is_repay = 0 or br.br_repay_time > to_date('{T_SUB_1}')) and br.br_time <= to_date('{T_SUB_1}') then BR_PRICE_B else 0 end)                            DUE_UNREPAY_PRICE_B               --到期未还本金
                                    ,sum(case when (br.br_is_repay = 0 or br.br_repay_time > to_date('{T_SUB_1}')) and br.br_time <= to_date('{T_SUB_1}') then BR_PRICE_L else 0 end)                            DUE_UNREPAY_PRICE_L               --到期未还利息
                                    ,sum(case when (br.br_is_repay = 0 or br.br_repay_time > to_date('{T_SUB_1}')) and br.br_time <= to_date('{T_SUB_1}') then BR_PRICE_PUNISH else 0 end)                       DUE_UNREPAY_PUNISH                --到期未还罚息
                                    ,sum(case when (br.br_is_repay = 0 or br.br_repay_time > to_date('{T_SUB_1}')) and br.br_time <= to_date('{T_SUB_1}') then BR_SERVICE_FEE - br_repayed_tech_fee else 0 end)  DUE_UNREPAY_SERVICE_FEE           --到期未还服务费
                                    ,sum(case when (br.br_is_repay = 0 or br.br_repay_time > to_date('{T_SUB_1}')) and br.br_time <= to_date('{T_SUB_1}') then br_extra_fee else 0 end)                          DUE_UNREPAY_EXTRA_FEE             --到期未还贷后管理费
                                    ,sum(case when (br.br_is_repay = 0 or br.br_repay_time > to_date('{T_SUB_1}')) and br.br_time <= to_date('{T_SUB_1}') then br_service_fee_other else 0 end)                  DUE_UNREPAY_SERVICE_FEE_OTHER     --到期未还第三方服务费
                                    ,sum(case when (br.br_is_repay = 0 or br.br_repay_time > to_date('{T_SUB_1}')) and br.br_time <= to_date('{T_SUB_1}') then br_post_consult_fee else 0 end)                   DUE_UNREPAY_POST_CONSULT_FEE      --到期未还后置咨询费
                                    ,sum(case when (br.br_is_repay = 0 or br.br_repay_time > to_date('{T_SUB_1}')) and br.br_time <= to_date('{T_SUB_1}') then 1 else 0 end)                                     DUE_UNREPAY_CNT                   --到期未还期数                             

                                    ,sum(case when br.br_time <= to_date('{T_SUB_1}') then 1 else 0 end)                                                        DUE_CNT                --应还期数
                                    ,sum(case when br.br_time <= to_date('{T_SUB_1}') then BR_PRICE else 0 end)                                                 DUE_PRICE              --应还金额
                                    ,sum(case when br.br_time <= to_date('{T_SUB_1}') then BR_PRICE_B else 0 end)                                               DUE_PRICE_B            --应还本金
                                    ,sum(case when br.br_time <= to_date('{T_SUB_1}') then BR_PRICE_L else 0 end)                                               DUE_PRICE_L            --应还利息
                                    ,sum(case when br.br_time <= to_date('{T_SUB_1}') and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end)              DUE_PRICE_PUNISH       --应还罚息
                                    ,sum(case when br.br_time <= to_date('{T_SUB_1}') then br_service_fee - br_repayed_tech_fee else 0 end)                     DUE_SERVICE_FEE        --应还服务费
                                    ,sum(case when br.br_time <= to_date('{T_SUB_1}') then br.PRICE_RETURN else 0 end)                                          DUE_PRICE_RETURN       --应返还金额
                                    ,sum(case when br.br_time <= to_date('{T_SUB_1}') then br_extra_fee else 0 end)                                             DUE_EXTRA_FEE          --应还贷后管理费
                                    ,sum(case when br.br_time <= to_date('{T_SUB_1}') then br_service_fee_other else 0 end)                                     DUE_SERVICE_FEE_OTHER  --应还第三方服务费
                                    ,sum(case when br.br_time <= to_date('{T_SUB_1}') then br_post_consult_fee else 0 end)                                      DUE_POST_CONSULT_FEE   --应还后置咨询费

                                    ,sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then 1 else 0 end)                                             REPAYED_CNT                 --已还期数
                                    ,sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE else 0 end)                                      REPAYED_PRICE               --已还金额
                                    ,sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE_B else 0 end)                                    REPAYED_PRICE_B             --已还本金
                                    ,sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE_L else 0 end)                                    REPAYED_PRICE_L             --已还利息
                                    ,sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end)   REPAYED_PRICE_PUNISH        --已还罚息
                                    ,sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then br_service_fee - br_repayed_tech_fee else 0 end)          REPAYED_SERVICE_FEE         --已还服务费
                                    ,sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then br.PRICE_RETURN else 0 end)                               REPAYED_PRICE_RETURN        --已返还金额
                                    ,sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then br_extra_fee else 0 end)                                  REPAYED_EXTRA_FEE           --已还贷后管理费
                                    ,sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then br_service_fee_other else 0 end)                          REPAYED_SERVICE_FEE_OTHER   --已还第三方服务费
                                    ,sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then br_post_consult_fee else 0 end)                           REPAYED_POST_CONSULT_FEE    --已还后置咨询费

                                    ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('{T_SUB_1}',1,7) then 1 else 0 end)                                              REPAYED_CNT_THIS_MONTH               --本月已还期数
                                    ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('{T_SUB_1}',1,7) then BR_PRICE else 0 end)                                       REPAYED_PRICE_THIS_MONTH             --本月已还金额
                                    ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('{T_SUB_1}',1,7) then BR_PRICE_B else 0 end)                                     REPAYED_PRICE_B_THIS_MONTH           --本月已还本金
                                    ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('{T_SUB_1}',1,7) then BR_PRICE_L else 0 end)                                     REPAYED_PRICE_L_THIS_MONTH           --本月已还利息
                                    ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('{T_SUB_1}',1,7) and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end)    REPAYED_PRICE_PUNISH_THIS_MONTH      --本月已还罚息
                                    ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('{T_SUB_1}',1,7) then br_service_fee - br_repayed_tech_fee else 0 end)           REPAYED_SERVICE_FEE_THIS_MONTH       --本月已还服务费
                                    ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('{T_SUB_1}',1,7) then br.PRICE_RETURN else 0 end)                                REPAYED_PRICE_RETURN_THIS_MONTH      --本月已返还金额
                                    ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('{T_SUB_1}',1,7) then br_extra_fee else 0 end)                                   REPAYED_EXTRA_FEE_THIS_MONTH         --本月已还贷后管理费
                                    ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('{T_SUB_1}',1,7) then br_service_fee_other else 0 end)                           REPAYED_SERVICE_FEE_OTHER_THIS_MONTH --本月已还第三方服务费
                                    ,sum(case when BR_IS_REPAY > 0 and substr(BR_REPAY_TIME,1,7) = substr('{T_SUB_1}',1,7) then br_post_consult_fee else 0 end)                            REPAYED_POST_CONSULT_FEE_THIS_MONTH  --本月已还后置咨询费                                    

                                    ,sum(case when IS_COMPENSATE = 1 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE else 0 end)                                                       COMPENSATE_AMT                 --代偿金额
                                    ,sum(case when to_date(br.compensate_time) <= to_date('{T_SUB_1}') then BR_PRICE_B else 0 end)                                                                         COMPENSATE_PRICE_B             --代偿本金***
                                    
                                    ,sum(case when IS_COMPENSATE_RETURNED = 1 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE else 0 end)                                              REPAYED_COMPENSATE_AMT         --已还代偿金额
                                    ,sum(case when to_date(br.compensate_time) <= to_date('{T_SUB_1}') and to_date(br.br_repay_time) <= '{T_SUB_1}' then BR_PRICE_B else 0 end)                            REPAYED_COMPENSATE_PRICE_B     --已还代偿本金***
                                    
                                    ,sum(case when to_date(br.compensate_time) <= to_date('{T_SUB_1}') and (BR_IS_REPAY = 0 or to_date(br.br_repay_time) > '{T_SUB_1}') then BR_PRICE else 0 end)          UNREPAY_COMPENSATE_AMT         --未还代偿金额***
                                    ,sum(case when to_date(br.compensate_time) <= to_date('{T_SUB_1}') and (BR_IS_REPAY = 0 or to_date(br.br_repay_time) > '{T_SUB_1}') then BR_PRICE_B else 0 end)        UNREPAY_COMPENSATE_PRICE_B     --未还代偿本金***

                                    ,sum(case when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY > 0 then BR_PRICE else 0 end) OVERDUE_REPAYED_PRICE --逾期已还金额

                                    --以下暂未修复
                                    ,min(BR_TIME) REPAY_BEGIN_DAY                                                                                                                                   --起始计划还款日
                                    ,max(BR_TIME) REPAY_END_DAY                                                                                                                                     --最终计划还款日
                                    ,min(case when BR_IS_REPAY > 0 then BR_REPAY_TIME end) FIRST_REPAY_TIME                                                                                         --首次还款时间
                                    ,max(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_REPAY_TIME end) LAST_REPAYED_TIME                                  --最近还款时间                
                                    ,sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE else 0 end) OVERDUE_UNREPAY_PRICE                                                      --逾期未还金额
                                    ,sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE_B else 0 end) OVERDUE_UNREPAY_PRICE_B                                                  --逾期未还本金
                                    ,sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE_L else 0 end) OVERDUE_UNREPAY_PRICE_L                                                  --逾期未还利息
                                    ,sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE_PUNISH else 0 end) OVERDUE_UNREPAY_PRICE_PUNISH                                        --逾期未还罚息
                                    ,sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_SERVICE_FEE - br_repayed_tech_fee else 0 end) OVERDUE_UNREPAY_SERVICE_FEE                    --逾期未还服务费
                                    ,sum(case when br.br_time > to_date('{T_SUB_1}') and br.br_time < add_months('{T_SUB_1}', 1) then br.BR_PRICE else 0 end) CUR_PRICE                             --当期应还金额
                                    ,sum(case when br.br_time > to_date('{T_SUB_1}') and br.br_time < add_months('{T_SUB_1}', 1) then br.BR_PRICE_B else 0 end) CUR_PRICE_B                         --当期应还本金
                                    ,sum(case when br.br_time > to_date('{T_SUB_1}') and br.br_time < add_months('{T_SUB_1}', 1) then br.BR_PRICE_L else 0 end) CUR_PRICE_L                         --当期应还利息
                                    ,sum(case when br.br_time > to_date('{T_SUB_1}') and br.br_time < add_months('{T_SUB_1}', 1) then br.BR_SERVICE_FEE - br.br_repayed_tech_fee else 0 end) CUR_SERVICE_FEE   --当期应还平台服务费
                                    ,sum(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY > 0 then br.PRICE_RETURN else 0 end) OVERDUE_RETURNED_PRICE                                           --逾期已返还金额
                                    ,sum(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then br.PRICE_RETURN else 0 end) OVERDUE_UNRETURNED_PRICE                                         --逾期未返还金额
                                    ,min(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then br.BR_TIME end) OVERDUE_UNREPAY_EARLIEST_BR_TIME                                             --逾期未还最早还应还时间
                                    ,sum(case when br.br_time < add_months('{T_SUB_1}', 1) or br.br_is_repay>0 then 1 else 0 end) POSTED_BILL_NUM                                                   --已出账单期数
                                    ,sum(case when br.br_time < add_months('{T_SUB_1}', 1) and br.br_is_repay = 0 then br.BR_PRICE + br.BR_PRICE_PUNISH else 0 end) POSTED_BILL_UNREPAY_AMT         --已出账单未还金额
                                    ,sum(case when br.br_time >= add_months('{T_SUB_1}', 1) and br.br_is_repay = 0 then br.BR_PRICE_B else 0 end) PENDING_BILL_UNREPAY_B                            --未出账单本金
                            from idw.fact_borrows_plus bo
                      inner join idw.fact_borrows_repayment_plus br
                              on bo.bo_id = br.bo_id
                           where bo.bo_is_success = 1
                             and to_date(bo.bo_success_time) <= '{T_SUB_1}'
                             and ( bo.bo_all_repayed = 0 or bo.bo_all_repayed = 1 and to_date(bo.all_repayed_time) >= '{T_SUB_1}' )  --20180927 增加 'or 条件'
                        group by br.bo_id 