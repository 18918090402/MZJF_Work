
/* 
    fact_in_repay_borrows_snapshot 在当前ETL调度系统中, 每天凌晨3-4点左右被调起, 因逻辑判断不严谨, 
    故0点至执行点发生的还款被纳入昨日的快照中, 导致部分指标值不精准, 如: UNREPAY_PRICE_B
    另, 在代码中对指标加入"名称备注"
    修复日期 2018-09-20 
    修复人   frank
*/ 


select 
    br.bo_id,
    sum(case when br.br_time <= to_date('{T_SUB_1}') then 1 else 0 end) SHOULD_REPAY_CNT, --应还期数
    sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then 1 else 0 end) REPAYED_CNT, --已还期数
    sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then 1 else 0 end) UNREPAY_CNT, --未还期数
    sum(case when BR_IS_REPAY > 0 and month(BR_REPAY_TIME) = month('{T_SUB_1}') then 1 else 0 end) REPAYED_CNT_THIS_MONTH, --本月已还期数
    
    sum(case when br.br_time <= to_date('{T_SUB_1}') then BR_PRICE else 0 end) SHOULD_REPAY_PRICE, --应还金额
    sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE else 0 end) REPAYED_PRICE, --已还金额
    sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then BR_PRICE else 0 end) UNREPAY_PRICE, --未还金额
    sum(case when BR_IS_REPAY > 0 and month(BR_REPAY_TIME) = month('{T_SUB_1}') then BR_PRICE else 0 end) REPAYED_PRICE_THIS_MONTH, --本月已还金额
    
    sum(case when br.br_time <= to_date('{T_SUB_1}') then BR_PRICE_B else 0 end) SHOULD_REPAY_PRICE_B, --应还本金
    sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE_B else 0 end) REPAYED_PRICE_B, --已还本金
    sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then BR_PRICE_B else 0 end) UNREPAY_PRICE_B, --未还本金
    sum(case when BR_IS_REPAY > 0 and month(BR_REPAY_TIME) = month('{T_SUB_1}') then BR_PRICE_B else 0 end) REPAYED_PRICE_B_THIS_MONTH, --本月已还本金
    
    sum(case when br.br_time <= to_date('{T_SUB_1}') then BR_PRICE_L else 0 end) SHOULD_REPAY_PRICE_L, --应还利息
    sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE_L else 0 end) REPAYED_PRICE_L, --已还利息
    sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then BR_PRICE_L else 0 end) UNREPAY_PRICE_L, --未还利息
    sum(case when BR_IS_REPAY > 0 and month(BR_REPAY_TIME) = month('{T_SUB_1}') then BR_PRICE_L else 0 end) REPAYED_PRICE_L_THIS_MONTH, --本月已还利息
    
    sum(case when br.br_time <= to_date('{T_SUB_1}') and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end) SHOULD_REPAY_PRICE_PUNISH, --应还罚息
    sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end) REPAYED_PRICE_PUNISH, --已还罚息
    sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end) UNREPAY_PRICE_PUNISH, --未还罚息
    sum(case when BR_IS_REPAY > 0 and month(BR_REPAY_TIME) = month('{T_SUB_1}') and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end) REPAYED_PRICE_PUNISH_THIS_MONTH, --本月已还罚息
    
    sum(case when br.br_time <= to_date('{T_SUB_1}') then BR_SERVICE_FEE else 0 end) SHOULD_REPAY_SERVICE_FEE, --应还服务费
    sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_SERVICE_FEE else 0 end) + sum(case when BR_IS_REPAY = 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then br_repayed_tech_fee else 0 end) REPAYED_SERVICE_FEE, --已还服务费
    sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then BR_SERVICE_FEE - br_repayed_tech_fee else 0 end) UNREPAY_SERVICE_FEE, --未还服务费
    sum(case when BR_IS_REPAY > 0 and month(BR_REPAY_TIME) = month('{T_SUB_1}') then BR_SERVICE_FEE - br_repayed_tech_fee else 0 end) REPAYED_SERVICE_FEE_THIS_MONTH, --本月已还服务费
    
    sum(case when br.br_time <= to_date('{T_SUB_1}') then br.PRICE_RETURN else 0 end) SHOULD_RETURN_PRICE, --应返还金额
    sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then br.PRICE_RETURN else 0 end) RETURNED_PRICE, --已返还金额
    sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then br.PRICE_RETURN else 0 end) UNRETURNED_PRICE, --未返还金额
    sum(case when BR_IS_REPAY > 0 and month(BR_REPAY_TIME) = month('{T_SUB_1}') then br.PRICE_RETURN else 0 end) RETURNED_PRICE_THIS_MONTH, --本月已返还金额
    
    sum(case when br.br_time <= to_date('{T_SUB_1}') then br_extra_fee else 0 end) SHOULD_REPAY_EXTRA_FEE, --应还额外费用
    sum(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then br_extra_fee else 0 end) REPAYED_EXTRA_FEE, --已还额外费用
    sum(case when BR_IS_REPAY = 0 or (BR_IS_REPAY > 0 and to_date(br.br_repay_time) > to_date('{T_SUB_1}')) then br_extra_fee else 0 end) UNREPAY_EXTRA_FEE, --未还额外费用
    sum(case when BR_IS_REPAY > 0 and month(BR_REPAY_TIME) = month('{T_SUB_1}') then br_extra_fee else 0 end) REPAYED_EXTRA_FEE_THIS_MONTH, --本月已还额外费用
    
    min(BR_TIME) REPAY_BEGIN_DAY, --起始计划还款日
    max(BR_TIME) REPAY_END_DAY, --最终计划还款日
    min(case when BR_IS_REPAY > 0 then BR_REPAY_TIME end) FIRST_REPAY_TIME, --首次还款时间
    max(case when BR_IS_REPAY > 0 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_REPAY_TIME end) LAST_REPAYED_TIME, --最近还款时间
    
    sum(case when IS_COMPENSATE = 1 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE else 0 end) COMPENSATE_AMT, --代偿金额
    sum(case when IS_COMPENSATE_RETURNED = 1 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE else 0 end) REPAYED_COMPENSATE_AMT, --已还代偿金额
    sum(case when IS_COMPENSATE = 1 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE_B else 0 end) COMPENSATE_PRICE_B, --代偿本金
    sum(case when IS_COMPENSATE_RETURNED = 1 and to_date(br.br_repay_time) <= to_date('{T_SUB_1}') then BR_PRICE_B else 0 end) REPAYED_COMPENSATE_PRICE_B, --已还代偿本金
    if(sum(case when br.BR_OVERDUE_TERMS > 0 then 1 end) > 0, 1, 0) IS_OVERDUE, --是否有过逾期
    max(case when br.BR_OVERDUE_TERMS > 0 then datediff(coalesce(br.br_repay_time, from_unixtime(unix_timestamp(),'yyyy-MM-dd')), br.br_time) end) MAX_OVERDUE_DAYS, --最大逾期天数
    if(sum(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then 1 end) > 0,1,0) IS_OVERDUE_UNREPAY, --是否逾期未还
    sum(case when BR_OVERDUE_TERMS > 0 then 1 else 0 end) OVERDUE_EXPECT_CNT, --当前逾期期数
    sum(case when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY > 0 then BR_PRICE else 0 end) OVERDUE_REPAYED_PRICE, --逾期已还金额
    sum(case when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then 1 else 0 end) OVERDUE_UNREPAY_EXPECT_CNT, --当前逾期未还期数
    max(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then datediff(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'),br.br_time) end) OVERDUE_UNREPAY_DAYS, --当前逾期未还天数
    sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE else 0 end) OVERDUE_UNREPAY_PRICE, --逾期未还金额
    sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE_B else 0 end) OVERDUE_UNREPAY_PRICE_B, --逾期未还本金
    sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE_L else 0 end) OVERDUE_UNREPAY_PRICE_L, --逾期未还利息
    sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE_PUNISH else 0 end) OVERDUE_UNREPAY_PRICE_PUNISH, --逾期未还罚息
    sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_SERVICE_FEE - br_repayed_tech_fee else 0 end) OVERDUE_UNREPAY_SERVICE_FEE, --逾期未还服务费
    sum(case when br.br_time >= to_date('{T}') and br.br_time < add_months('{T}', 1) then br.BR_PRICE else 0 end) CUR_PRICE, --当期应还金额
    sum(case when br.br_time >= to_date('{T}') and br.br_time < add_months('{T}', 1) then br.BR_PRICE_B else 0 end) CUR_PRICE_B, --当期应还本金
    sum(case when br.br_time >= to_date('{T}') and br.br_time < add_months('{T}', 1) then br.BR_PRICE_L else 0 end) CUR_PRICE_L, --当期应还利息
    sum(case when br.br_time >= to_date('{T}') and br.br_time < add_months('{T}', 1) then br.BR_SERVICE_FEE - br.br_repayed_tech_fee else 0 end) CUR_SERVICE_FEE, --当期应还平台服务费
    sum(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY > 0 then br.PRICE_RETURN else 0 end) OVERDUE_RETURNED_PRICE, --逾期已返还金额
    sum(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then br.PRICE_RETURN else 0 end) OVERDUE_UNRETURNED_PRICE, --逾期未返还金额
    min(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then br.BR_TIME end) OVERDUE_UNREPAY_EARLIEST_BR_TIME, --逾期未还最早还应还时间
    sum(case when br.br_time < add_months('{T}', 1) or br.br_is_repay>0 then 1 else 0 end) POSTED_BILL_NUM, --已出账单期数
    sum(case when br.br_time < add_months('{T}', 1) and br.br_is_repay = 0 then br.BR_PRICE + br.BR_PRICE_PUNISH else 0 end) POSTED_BILL_UNREPAY_AMT, --已出账单未还金额
    sum(case when br.br_time >= add_months('{T}', 1) and br.br_is_repay = 0 then br.BR_PRICE_B else 0 end) PENDING_BILL_UNREPAY_B --已出账单未还本金
from idw.fact_borrows bo
join idw.fact_borrows_repayment br
on bo.bo_id = br.bo_id
where bo.bo_is_success = 1
and ( bo.bo_all_repayed = 0 or  (bo.bo_all_repayed = 1 and ))
group by br.bo_id
