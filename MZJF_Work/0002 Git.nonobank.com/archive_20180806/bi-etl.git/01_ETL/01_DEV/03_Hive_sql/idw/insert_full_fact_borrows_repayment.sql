DROP TABLE IF EXISTS TMP.TMP_FACT_BORROWS_REPAYMENT_01;

create table if not exists TMP.TMP_FACT_BORROWS_REPAYMENT_01
stored as parquet 
as 
select bo_id, BR_EXPECT_NUM
  from (select br.bo_id,
               br.BR_EXPECT_NUM,
               row_number() over(partition by br.bo_id order by br.BR_EXPECT_NUM) as rn
          from odsopr.BORROWS_REPAYMENT br
         where br.BR_OVERDUE_TERMS > 0) x
 where rn = 1;

set hive.exec.dynamic.partition.mode=nonstrict;
insert overwrite table IDW.FACT_BORROWS_REPAYMENT partition
  (PD)
  select br.ID BR_ID,
         br.USER_ID,
         br.BO_ID,
         br.BR_PRICE,
         br.BR_PRICE_B,
         br.BR_PRICE_L,
         br.BR_PRICE_PUNISH,
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
         br.BR_SERVICE_FEE,
         br.BR_IS_SEND_SMS,
         br.BR_EXPECT_NUM,
         br.PRICE_RETURN,
         bo.BO_AUDIT_TIME,
         CASE
           WHEN br.BR_OVERDUE_TERMS > 0 AND br.BR_EXPECT_NUM = 1 THEN
            1
           ELSE
            0
         END IS_FIRST_REPAY_OVERDUE,
         case
           when tmp1.bo_id is null then
            0
           else
            1
         end IS_FIRST_OVERDUE,
         br.CREATOR,
         br.UPDATOR,
         br.CREATE_TIME,
         br.UPDATE_TIME,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         SUBSTR(br.CREATE_TIME, 1, 7) PD
    from odsopr.BORROWS_REPAYMENT br
    JOIN odsopr.BORROWS bo
      ON br.bo_id = bo.id
    left outer join TMP.TMP_FACT_BORROWS_REPAYMENT_01 tmp1
      on br.bo_id = tmp1.bo_id
     and br.BR_EXPECT_NUM = tmp1.BR_EXPECT_NUM;
 
DROP TABLE IF EXISTS TMP.TMP_FACT_BORROWS_REPAYMENT_01;