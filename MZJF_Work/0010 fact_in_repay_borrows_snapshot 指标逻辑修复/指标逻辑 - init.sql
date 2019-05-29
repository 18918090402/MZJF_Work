
/* 
    fact_in_repay_borrows_snapshot 在当前ETL调度系统中, 每天凌晨3-4点左右被调起, 因逻辑判断不严谨, 
    故0点至执行点发生的还款被纳入昨日的快照中, 导致部分指标值不精准, 如: UNREPAY_PRICE_B
    另, 在代码中对指标加入"名称备注"
    修复日期 2018-09-20 
    修复人   frank
*/ 
select 
    br.bo_id,
    sum(case when br.br_time < to_date('{T}') then 1 else 0 end) SHOULD_REPAY_CNT,  --应还期数
    sum(case when BR_IS_REPAY > 0 then 1 else 0 end) REPAYED_CNT,   --已还期数
    sum(case when BR_IS_REPAY = 0 then 1 else 0 end) UNREPAY_CNT,   --未还期数
    sum(case when BR_IS_REPAY > 0 and BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then 1 else 0 end) REPAYED_CNT_THIS_MONTH,
    sum(case when br.br_time < to_date('{T}') then BR_PRICE else 0 end) SHOULD_REPAY_PRICE,
    sum(case when BR_IS_REPAY > 0 then BR_PRICE else 0 end) REPAYED_PRICE,
    sum(case when BR_IS_REPAY = 0 then BR_PRICE else 0 end) UNREPAY_PRICE,
    sum(case when BR_IS_REPAY > 0 and BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then BR_PRICE else 0 end) REPAYED_PRICE_THIS_MONTH,
    sum(case when br.br_time < to_date('{T}') then BR_PRICE_B else 0 end) SHOULD_REPAY_PRICE_B,
    sum(case when BR_IS_REPAY > 0 then BR_PRICE_B else 0 end) REPAYED_PRICE_B,
    sum(case when BR_IS_REPAY = 0 then BR_PRICE_B else 0 end) UNREPAY_PRICE_B,
    sum(case when BR_IS_REPAY > 0 and BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then BR_PRICE_B else 0 end) REPAYED_PRICE_B_THIS_MONTH,
    sum(case when br.br_time < to_date('{T}') then BR_PRICE_L else 0 end) SHOULD_REPAY_PRICE_L,
    sum(case when BR_IS_REPAY > 0 then BR_PRICE_L else 0 end) REPAYED_PRICE_L,
    sum(case when BR_IS_REPAY = 0 then BR_PRICE_L else 0 end) UNREPAY_PRICE_L,
    sum(case when BR_IS_REPAY > 0 and BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then BR_PRICE_L else 0 end) REPAYED_PRICE_L_THIS_MONTH,
    sum(case when br.br_time < to_date('{T}') and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end) SHOULD_REPAY_PRICE_PUNISH,
    sum(case when BR_IS_REPAY > 0 and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end) REPAYED_PRICE_PUNISH,
    sum(case when BR_IS_REPAY = 0 and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end) UNREPAY_PRICE_PUNISH,
    sum(case when BR_IS_REPAY > 0 and BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') and br.BR_OVERDUE_TERMS > 0 then BR_PRICE_PUNISH else 0 end) REPAYED_PRICE_PUNISH_THIS_MONTH,
    sum(case when br.br_time < to_date('{T}') then BR_SERVICE_FEE else 0 end) SHOULD_REPAY_SERVICE_FEE,
    sum(case when BR_IS_REPAY > 0 then BR_SERVICE_FEE else 0 end) + sum(case when BR_IS_REPAY = 0 then br_repayed_tech_fee else 0 end) REPAYED_SERVICE_FEE,
    sum(case when BR_IS_REPAY = 0 then BR_SERVICE_FEE - br_repayed_tech_fee else 0 end) UNREPAY_SERVICE_FEE,
    sum(case when BR_IS_REPAY > 0 and BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then BR_SERVICE_FEE - br_repayed_tech_fee else 0 end) REPAYED_SERVICE_FEE_THIS_MONTH,
    min(BR_TIME) REPAY_BEGIN_DAY, 
    max(case when BR_IS_REPAY > 0 then BR_REPAY_TIME end) LAST_REPAYED_TIME,
    sum(case when IS_COMPENSATE = 1 then BR_PRICE else 0 end) COMPENSATE_AMT,
    sum(case when IS_COMPENSATE_RETURNED = 1 then BR_PRICE else 0 end) REPAYED_COMPENSATE_AMT,
    if(sum(case when br.BR_OVERDUE_TERMS > 0 then 1 end) > 0, 1, 0) IS_OVERDUE,
    max(case when br.BR_OVERDUE_TERMS > 0 then datediff(coalesce(br.br_repay_time, from_unixtime(unix_timestamp(),'yyyy-MM-dd')), br.br_time) end) MAX_OVERDUE_DAYS,
    if(sum(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then 1 end) > 0,1,0) IS_OVERDUE_UNREPAY,
    sum(case when BR_OVERDUE_TERMS > 0 then 1 else 0 end) OVERDUE_EXPECT_CNT,
    sum(case when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY > 0 then BR_PRICE else 0 end) OVERDUE_REPAYED_PRICE,
    sum(case when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then 1 else 0 end) OVERDUE_UNREPAY_EXPECT_CNT,
    max(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then datediff(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'),br.br_time) end) OVERDUE_UNREPAY_DAYS,
    sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE else 0 end) OVERDUE_UNREPAY_PRICE,
    sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE_B else 0 end) OVERDUE_UNREPAY_PRICE_B,
    sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE_L else 0 end) OVERDUE_UNREPAY_PRICE_L,
    sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_PRICE_PUNISH else 0 end) OVERDUE_UNREPAY_PRICE_PUNISH,
    sum(case when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then BR_SERVICE_FEE - br_repayed_tech_fee else 0 end) OVERDUE_UNREPAY_SERVICE_FEE,
    max(BR_TIME) REPAY_END_DAY,
    sum(case when IS_COMPENSATE = 1 then BR_PRICE_B else 0 end) COMPENSATE_PRICE_B,
    sum(case when IS_COMPENSATE_RETURNED = 1 then BR_PRICE_B else 0 end) REPAYED_COMPENSATE_PRICE_B,
    sum(case when br.br_time >= to_date('{T}') and br.br_time < add_months('{T}', 1) then br.BR_PRICE else 0 end) CUR_PRICE,
    sum(case when br.br_time >= to_date('{T}') and br.br_time < add_months('{T}', 1) then br.BR_PRICE_B else 0 end) CUR_PRICE_B,
    sum(case when br.br_time >= to_date('{T}') and br.br_time < add_months('{T}', 1) then br.BR_PRICE_L else 0 end) CUR_PRICE_L,
    sum(case when br.br_time >= to_date('{T}') and br.br_time < add_months('{T}', 1) then br.BR_SERVICE_FEE - br.br_repayed_tech_fee else 0 end) CUR_SERVICE_FEE,
    min(br.br_repay_time) FIRST_REPAY_TIME, 
    sum(case when br.br_time < to_date('{T}') then br.PRICE_RETURN else 0 end) SHOULD_RETURN_PRICE,
    sum(case when BR_IS_REPAY > 0 then br.PRICE_RETURN else 0 end) RETURNED_PRICE,
    sum(case when BR_IS_REPAY = 0 then br.PRICE_RETURN else 0 end) UNRETURNED_PRICE,
    sum(case when BR_IS_REPAY > 0 and  BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then br.PRICE_RETURN else 0 end) RETURNED_PRICE_THIS_MONTH,
    sum(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY > 0 then br.PRICE_RETURN else 0 end) OVERDUE_RETURNED_PRICE,
    sum(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then br.PRICE_RETURN else 0 end) OVERDUE_UNRETURNED_PRICE,
    min(case when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then br.BR_TIME end) OVERDUE_UNREPAY_EARLIEST_BR_TIME,
    sum(case when br.br_time < add_months('{T}', 1) or br.br_is_repay>0 then 1 else 0 end) POSTED_BILL_NUM,
    sum(case when br.br_time < add_months('{T}', 1) and br.br_is_repay = 0 then br.BR_PRICE + br.BR_PRICE_PUNISH else 0 end) POSTED_BILL_UNREPAY_AMT,
    sum(case when br.br_time >= add_months('{T}', 1) and br.br_is_repay = 0 then br.BR_PRICE_B else 0 end) PENDING_BILL_UNREPAY_B,
    sum(case when br.br_time < to_date('{T}') then br_extra_fee else 0 end) SHOULD_REPAY_EXTRA_FEE,
    sum(case when BR_IS_REPAY > 0 then br_extra_fee else 0 end) REPAYED_EXTRA_FEE,
    sum(case when BR_IS_REPAY = 0 then br_extra_fee else 0 end) UNREPAY_EXTRA_FEE,
    sum(case when BR_IS_REPAY > 0 and BR_REPAY_TIME >= trunc('{T_SUB_1}', 'MM') then br_extra_fee else 0 end) REPAYED_EXTRA_FEE_THIS_MONTH
from idw.fact_borrows bo
join idw.fact_borrows_repayment br
on bo.bo_id = br.bo_id
where bo.bo_is_success = 1
and bo.bo_all_repayed = 0
group by br.bo_id
