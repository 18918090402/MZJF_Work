set mapreduce.job.name = idw_fact_in_repay_borrows_plus_snapshot_02;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table msc.fact_in_repay_borrows_plus_snapshot partition (STAT_DATE)
          select bo.BO_ID,
                 bo.USER_ID,
                 to_date('{T_SUB_1}') as Statis_Dt, 
                 bo.P_KEY,
                 bia.p_name as bia_prduct,
                 bia.biz_name as biz_name, 
                 
                 t1.IS_OVERDUE_UNREPAY,
                 t1.OVERDUE_UNREPAY_DAYS,
                 t1.OVERDUE_UNREPAY_EXPECT_CNT,
                 case 
                    when t1.OVERDUE_UNREPAY_DAYS = 0 then 'M0' 
                    when t1.OVERDUE_UNREPAY_DAYS > 0 and t1.OVERDUE_UNREPAY_DAYS < 30 then 'M1'
                    when t1.OVERDUE_UNREPAY_DAYS >= 30 and t1.OVERDUE_UNREPAY_DAYS < 60 then 'M2'
                    when t1.OVERDUE_UNREPAY_DAYS >= 60 and t1.OVERDUE_UNREPAY_DAYS < 90 then 'M3' 
                    when t1.OVERDUE_UNREPAY_DAYS >= 90 and t1.OVERDUE_UNREPAY_DAYS < 120 then 'M4'
                    when t1.OVERDUE_UNREPAY_DAYS >= 120 and t1.OVERDUE_UNREPAY_DAYS < 150 then 'M5'
                    when t1.OVERDUE_UNREPAY_DAYS >= 150 and t1.OVERDUE_UNREPAY_DAYS < 180 then 'M6'
                    when t1.OVERDUE_UNREPAY_DAYS >= 180 then 'M7+'
                 end AGING,                 
                 
                 t1.IS_OVERDUE,
                 t1.MAX_OVERDUE_DAYS,
                 t1.OVERDUE_EXPECT_CNT,
                 
                 t1.UNREPAY_CNT,
                 t1.UNREPAY_PRICE,
                 t1.UNREPAY_PRICE_B,
                 t1.UNREPAY_PRICE_L,
                 t1.UNREPAY_PRICE_PUNISH,
                 t1.UNREPAY_SERVICE_FEE,
                 t1.UNREPAY_PRICE_RETURN,
                 t1.UNREPAY_EXTRA_FEE,
                 t1.UNREPAY_SERVICE_FEE_OTHER,
                 t1.UNREPAY_POST_CONSULT_FEE,

                 t1.DUE_REPAID_CNT,
                 t1.DUE_REPAID_PRICE_B,
                 t1.DUE_REPAID_PRICE_L,
                 t1.DUE_REPAID_PUNISH,
                 t1.DUE_REPAID_SERVICE_FEE,
                 T1.DUE_REPAID_EXTRA_FEE,        
                 T1.DUE_REPAID_SERVICE_FEE_OTHER,
                 T1.DUE_REPAID_POST_CONSULT_FEE, 

                 t1.DUE_UNREPAY_CNT,                 
                 t1.DUE_UNREPAY_PRICE_B,
                 t1.DUE_UNREPAY_PRICE_L,
                 t1.DUE_UNREPAY_PUNISH,
                 t1.DUE_UNREPAY_SERVICE_FEE,
                 t1.DUE_UNREPAY_EXTRA_FEE,        
                 t1.DUE_UNREPAY_SERVICE_FEE_OTHER,
                 t1.DUE_UNREPAY_POST_CONSULT_FEE, 

                 t1.DUE_CNT,
                 t1.DUE_PRICE,
                 t1.DUE_PRICE_B,
                 t1.DUE_PRICE_L,
                 t1.DUE_PRICE_PUNISH,
                 t1.DUE_SERVICE_FEE,
                 t1.DUE_PRICE_RETURN,
                 t1.DUE_EXTRA_FEE,
                 t1.DUE_SERVICE_FEE_OTHER,
                 t1.DUE_POST_CONSULT_FEE,
                 
                 t1.REPAYED_CNT,
                 t1.REPAYED_PRICE,
                 t1.REPAYED_PRICE_B,
                 t1.REPAYED_PRICE_L,
                 t1.REPAYED_PRICE_PUNISH,
                 t1.REPAYED_SERVICE_FEE,
                 t1.REPAYED_PRICE_RETURN,
                 t1.REPAYED_EXTRA_FEE,
                 t1.REPAYED_SERVICE_FEE_OTHER,
                 t1.REPAYED_POST_CONSULT_FEE,
                 
                 t1.REPAYED_CNT_THIS_MONTH,
                 t1.REPAYED_PRICE_THIS_MONTH,
                 t1.REPAYED_PRICE_B_THIS_MONTH,
                 t1.REPAYED_PRICE_L_THIS_MONTH,
                 t1.REPAYED_PRICE_PUNISH_THIS_MONTH,
                 t1.REPAYED_SERVICE_FEE_THIS_MONTH,
                 t1.REPAYED_PRICE_RETURN_THIS_MONTH,
                 t1.REPAYED_EXTRA_FEE_THIS_MONTH,
                 t1.REPAYED_SERVICE_FEE_OTHER_THIS_MONTH,
                 t1.REPAYED_POST_CONSULT_FEE_THIS_MONTH,
                 
                 t1.COMPENSATE_AMT,
                 t1.COMPENSATE_PRICE_B,
                 t1.REPAYED_COMPENSATE_AMT,
                 t1.REPAYED_COMPENSATE_PRICE_B,
                 t1.UNREPAY_COMPENSATE_AMT,
                 t1.UNREPAY_COMPENSATE_PRICE_B,
                 
                 null,  --t1.OVERDUE_REPAYED_PRICE,
                 
                 t1.REPAY_BEGIN_DAY,
                 t1.REPAY_END_DAY,
                 t1.FIRST_REPAY_TIME,
                 t1.LAST_REPAYED_TIME,
                 t1.OVERDUE_UNREPAY_PRICE,
                 t1.OVERDUE_UNREPAY_PRICE_B,
                 t1.OVERDUE_UNREPAY_PRICE_L,
                 t1.OVERDUE_UNREPAY_PRICE_PUNISH,
                 t1.OVERDUE_UNREPAY_SERVICE_FEE,
                 t1.CUR_PRICE,
                 t1.CUR_PRICE_B,
                 t1.CUR_PRICE_L,
                 t1.CUR_SERVICE_FEE,
                 t1.OVERDUE_RETURNED_PRICE,
                 t1.OVERDUE_UNRETURNED_PRICE,
                 t1.OVERDUE_UNREPAY_EARLIEST_BR_TIME,                 
                 case
                    when t1.POSTED_BILL_NUM < 12 then t1.POSTED_BILL_UNREPAY_AMT + t1.PENDING_BILL_UNREPAY_B * 1.06
                    when t1.POSTED_BILL_NUM >= 12 then t1.POSTED_BILL_UNREPAY_AMT + t1.PENDING_BILL_UNREPAY_B * 1.05
                 end SETTLEMENT_SHOULD_REPAY_AMT,
                 t1.POSTED_BILL_NUM,         
                 t1.POSTED_BILL_UNREPAY_AMT,
                 t1.PENDING_BILL_UNREPAY_B,
                 
                 t2.id       DUN_COMPANY,
                 t2.odc_name DUN_COMPANY_NAME,
                 t2.mod_start_time DUN_START_TIME,
                 t2.mod_end_time   DUN_END_TIME,
                 t2.odc_type       DUN_TYPE,
                 case when t2.bo_id is null then 0 else 1 end IS_DUNNING,

                 t3.MAX_CONTINUOUS_OVERDUE_PRICE_B,
                 t3.MAX_CONTINUOUS_OVERDUE_CNT,
                 
                 bo.IS_FIRST_REPAY_OVERDUE,
                 bo.FIRST_REPAY_OVERDUE_DAYS,
                 bo.bo_success_time,
                 bo.BO_FINISH_PRICE,
                 bo.BO_RATE,
                 bo.BO_EXPECT,
                 bo.BO_EXPECT_CAT,
                 bo.BO_AUDIT_TIME,
                 bo.BO_AGREE_TIME,
                 bo.DEPOSITORY_FLAG,
                 bo.INTEREST_RATE_CUT,
                 bo.FIRST_OVERDUE_EXPECT_NUM,
                 bo.FIRST_OVERDUE_BR_TIME,
                 bo.MONTHLY_REPAYMENT_AMT,
                 bo.TRANSFER_ACCOUNT_TIME,                         
                 bo.P_ID,
                 bo.CATEGORY_NAME_01,
                 bo.P_NAME,
                 bo.BIZ_CODE_01,
                 bo.BIZ_NAME_01,         
                 bo.BUSI_LINE,
                 'SYS'                                                  AS DW_CREATE_BY,
                 from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
                 'SYS'                                                  AS DW_UPDATE_BY,
                 from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
                 to_date('{T_SUB_1}')                                   as STAT_DATE
            from idw.fact_borrows_plus bo
      inner join 
               (
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
               ) t1
              on bo.bo_id = t1.bo_id
       left join 
               (
                         select od.bo_id,
                                case odc.odc_type when 0 then od.create_time else od.mod_start_time end mod_start_time,
                                od.mod_end_time,
                                odc.id,
                                odc.odc_name,
                                odc.odc_type,
                                row_number() over(partition by od.bo_id order by od.id desc) as RID
                           from odsopr.borrows_outsource_dunning od
                     inner join odsopr.borrows_outsource_dunning_company odc
                             on od.mod_company = odc.id
                          where od.mod_status in (0, 4)
                            and od.mod_close_time is null
               ) t2
              on t1.bo_id = t2.bo_id
             and t2.RID = 1
       left join 
               (
                         select bo_id,
                                max(continuous_overdue_price_b) max_continuous_overdue_price_b,
                                max(br_overdue_terms) max_continuous_overdue_cnt
                           from 
                           (
                                         select br1.br_id,
                                                br1.bo_id,
                                                br1.br_overdue_terms,
                                                sum(br2.br_price_b) continuous_overdue_price_b
                                           from idw.fact_borrows_plus bo
                                     inner join idw.fact_borrows_repayment_plus br1
                                             on bo.bo_id = br1.bo_id
                                            and br1.br_overdue_terms > 0
                                     inner join idw.fact_borrows_repayment_plus br2
                                             on br1.bo_id = br2.bo_id
                                          where (br1.br_expect_num - br1.br_overdue_terms + 1) <= br2.br_expect_num
                                            and br1.br_expect_num >= br2.br_expect_num
                                            and bo.bo_is_success = 1
                                            and to_date(bo.bo_success_time) <= '{T_SUB_1}'
                                            and ( bo.bo_all_repayed = 0 or bo.bo_all_repayed = 1 and to_date(bo.all_repayed_time) >= '{T_SUB_1}' )     --20180927 增加 'or 条件' 
                                       group by br1.br_id, br1.bo_id, br1.br_overdue_terms
                            ) s
                       group by bo_id
              ) t3
             on t1.bo_id = t3.bo_id
      left join odsopr.dim_bia_asset_product_plus bia
             on bia.p_key = bo.p_key             
          where bo.bo_is_success = 1 
            and to_date(bo.bo_success_time) <= '{T_SUB_1}'
            and ( bo.bo_all_repayed = 0 or bo.bo_all_repayed = 1 and to_date(bo.all_repayed_time) >= '{T_SUB_1}' )     --20180927 增加 'or 条件'   
        ;
