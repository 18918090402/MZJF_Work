set mapreduce.job.name = idw_fact_borrows_repayment_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table IDW.FACT_BORROWS_REPAYMENT
  select br.ID BR_ID,
         bo.p_id,
         bo.busi_line,
         br.USER_ID,
         br.BO_ID,
         br.BR_PRICE,
         br.BR_PRICE_B,
         br.BR_PRICE_L,
         br.BR_PRICE_PUNISH,
         br.BR_SERVICE_FEE,
         br.PRICE_RETURN,
         br.BR_PRICE_PUNISH_LENDER,
         br.BR_PRICE_PUNISH_PC,
         br.BR_TIME,
         br.BR_REPAY_TIME,
         br.BR_IS_REPAY,
         br.BR_REPAY_STATUS,
         br.BR_TRANSFER_FA_ID,
         br.BR_CALL_RECORD,
         br.BR_REPAYED_TECH_FEE,
         br.DUNNING_WAY,
         br.BR_LOCKED,
         br.BR_OVERDUE_TERMS,
         br.BR_IS_HNAPAY_DEDUCT,
         br.BR_IS_SEND_SMS,
         br.BR_EXPECT_NUM,
         CASE
           WHEN br.BR_OVERDUE_TERMS > 0 AND br.BR_EXPECT_NUM = 1 THEN
            1
           WHEN br.BR_EXPECT_NUM = 1 THEN
            0
           ELSE
            null
         END IS_FIRST_REPAY_OVERDUE,
         case
           when br.BR_EXPECT_NUM = bo.FIRST_OVERDUE_EXPECT_NUM then
            1
           else
            0
         end IS_FIRST_OVERDUE,
         case
           when bg.br_id is not null then
            1
           else
            0
         end IS_COMPENSATE,
         bg.bg_time COMPENSATE_TIME,
         bg.bg_returned IS_COMPENSATE_RETURNED,
         bg.bg_returned_time COMPENSATE_RETURNED_TIME,
         br.CREATOR,
         br.UPDATOR,
         br.CREATE_TIME,
         br.UPDATE_TIME,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         bo.BO_AGREE_TIME,
         bo.CATEGORY_NAME_01,
         bo.BIZ_CODE_01,
         bo.BIZ_NAME_01,
         bo.DEPOSITORY_FLAG,
         bo.TRANSFER_ACCOUNT_TIME,
         bo.P_NAME,
         bo.P_KEY,
         br.BR_EXTRA_FEE,
         br.BR_SERVICE_FEE_OTHER,
         br.BR_POST_CONSULT_FEE
    from odsopr.borrows_repayment_hist br
    JOIN idw.fact_borrows bo
      ON br.bo_id = bo.bo_id
     and bo.bo_is_success = 1
    left join (select br_id,
                      bg_time,
                      bg_returned,
                      bg_returned_time,
                      row_number() over(partition by br_id order by id desc) as rn
                 from odsopr.borrows_guarantee_hist) bg
      on br.id = bg.br_id
     and bg.rn = 1;