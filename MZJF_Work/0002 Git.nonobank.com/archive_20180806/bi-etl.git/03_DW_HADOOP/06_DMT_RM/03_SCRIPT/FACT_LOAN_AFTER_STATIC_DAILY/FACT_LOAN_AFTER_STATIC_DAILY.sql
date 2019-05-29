set mapreduce.job.name = DMT_RM_FACT_LOAN_AFTER_STATIC_DAILY;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table DMT_RM.FACT_LOAN_AFTER_STATIC_DAILY partition
  (STAT_DATE)
  SELECT mr.bo_id as APPLY_NO, -- 借款ID
         to_DATE(mr.bo_agree_time) as DISBURSED_DATE, -- 借款同意时间
         mr.bo_finish_price as DISBURSED_AMT, -- 完成金额
         mr.bo_expect as TERM, -- 借款期限
         mr.bo_expect_cat as TERM_UNIT, -- 借款期限单位 
         mr.bo_rate as INTEREST_RATE, -- 借款年利率
         CASE
           WHEN mr.UNREPAY_CNT = 0 THEN
            "closed"
           WHEN mr.OVERDUE_UNREPAY_DAYS > 0 THEN
            "overdue"
           ELSE
            "current"
         END STATUS, -- 借款状态
         mr.OVERDUE_UNREPAY_DAYS as OVERDUE_DAY, -- 截止当前最大逾期天数
         mr.MAX_OVERDUE_DAYS as OVERDUE_DAY_MAX, -- 截止当前最大逾期天数
         mr.OVERDUE_UNREPAY_EXPECT_CNT as OVERDUE_TERM, -- 未还逾期次数
         mr.OVERDUE_TERM_MAX, -- 最大逾期期数
         NULL OVERDUE_AMT,
         NULL OVERDUE_AMT_MAX,
         mr.UNREPAY_PRICE_B as OUTSTANDING_AMT, -- 未还本金
         mr.REPAYED_CNT as TERM_PAID, -- 还款次数
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') as FILE_DATE, -- 快照日期
         mr.OVERDUE_UNREPAY_PRICE_B as OVERDUE_PRINCIPAL_AMT, -- 逾期未还本金
         mr.overdue_price_b_max AS MAX_OVERDUE_PRINCIPAL_AMT, -- 最大逾期未还本金
         case
           when FBO.p_id = 87 and bp.bp_channel = 5 then
            '社保贷'
           when FBO.p_id = 87 and bp.bp_channel = 6 then
            '应届贷'
           when FBO.p_id = 87 and bp.bp_channel = 7 then
            '按揭贷'
           when FBO.p_id = 110 and FBO.credit_type = 2 then
             '高学历贷'
           when FBO.p_id = 110 and FBO.credit_type = 3 then
             '消费能力贷'
           else
            FBO.p_name
         end PRODUCT,
         -- p.p_name as PRODUCT, -- 产品名称
         mr.REPAYED_PRICE_B_THIS_MONTH as repay_b_this_month, -- 本月还款本金
         mr.user_id as USER_ID, -- 用户ID
         CASE
           WHEN mr.FIRST_REPAY_OVERDUE_DAYS > 7 THEN
            1
           ELSE
            0
         END AS IS_FIRST_REPAY_OVERDUE_7D, -- 是否首还逾期大于7天
         mr.OVERDUE_UNREPAY_PRICE AS OVERDUE_UNREPAY_AMT, -- 逾期未还金额
         mr.OVERDUE_UNREPAY_PRICE_L AS OVERDUE_UNREPAY_L, -- 逾期未还利息
         mr.OVERDUE_UNREPAY_SERVICE_FEE AS OVERDUE_UNREPAY_SERVICE_FEE, -- 逾期未还平台服务费
         mr.OVERDUE_UNREPAY_PRICE_PUNISH AS OVERDUE_UNREPAY_PUNISH, -- 逾期未还罚息
         mr.REPAYED_PRICE_THIS_MONTH AS REPAY_AMT_THIS_MONTH, -- 当月还款金额
         mr.REPAYED_PRICE_L_THIS_MONTH AS REPAY_L_THIS_MONTH, -- 当月还款利息
         mr.REPAYED_PRICE_PUNISH_THIS_MONTH AS REPAY_PUNISH_THIS_MONTH, -- 当月还款罚息
         mr.REPAYED_SERVICE_FEE_THIS_MONTH AS REPAY_SERVICE_FEE_THIS_MONTH, -- 当月还款平台服务费
         mr.should_repay_price_b_this_month, -- 当月1号截止到当前应还本金
         mr.should_repay_price_l_this_month, -- 当月1号截止到当前应还利息
         mr.should_repay_cnt_this_month as SHOULD_REPAY_CNT, -- 应还期数
         mr.REPAY_BEGIN_DAY, -- 起始还款日
         FBO.ZX_PRICE, -- 咨询费
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         mr.OVERDUE_REPAY_PRICE_B, --逾期已还本金
         mr.REPAYED_PRICE + mr.REPAYED_PRICE_PUNISH as REPAYED_AMT, --累计已还金额
         mr.REPAYED_PRICE_B, --累计已还本金
         mr.UNREPAY_PRICE + mr.UNREPAY_PRICE_PUNISH as UNREPAYED_AMT, --剩余金额
         CASE
           WHEN mr.IS_ALL_REPAYED = 1 THEN
            substring(mr.LAST_REPAYED_TIME, 1, 10)
         END ALL_REPAYED_TIME, --结清日期
         u.user_name, --用户名
         mr.OVERDUE_REPAY_PRICE, --逾期已还金额
         case
           when FBO.bo_paytype in ('DEBX', 'DBDX') then
            br.br_price
         end br_price_per_expect,
         FBO.bo_paytype REPAYMENT_TYPE,
         mr.repayed_price_l ACCU_PAID_INT,
         mr.repayed_price_punish ACCU_PAID_PULISH,
         mr.first_repay_time,
         FBO.RC_NAME,
         mr.REPAYED_OVERDUE_PRICE_B_THIS_MONTH,
         mr.REPAYED_OVERDUE_PRICE_THIS_MONTH+mr.repayed_overdue_price_punish_this_month as REPAYED_OVERDUE_PRICE_THIS_MONTH,
         mr.SETTLEMENT_SHOULD_REPAY_AMT,
         mr.LAST_REPAYED_TIME,
         oo.GOODS_ID,
         mr.CUR_PRICE,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') STAT_DATE
    FROM DMT.FACT_REPAY_BORROWS_SNAPSHOT mr
   INNER JOIN IDW.FACT_BORROWS FBO
      ON mr.BO_ID = FBO.BO_ID
     AND mr.stat_date = '{T_SUB_1}'
    LEFT JOIN IDW.DIM_USER AS u
      on mr.user_id = u.user_id
    left join idw.fact_borrows_prepare bp
      on FBO.bp_id = bp.bp_id
    left join odsopr.ORD_ORDER oo
    on fbo.bo_id=oo.bo_id
    and oo.bo_id > 0 
    left join (select bo_id,
                      br_price,
                      row_number() over(partition by bo_id order by br_expect_num) rn
                 from idw.fact_borrows_repayment) br
      on mr.BO_ID = br.bo_id
     and br.rn = 1;