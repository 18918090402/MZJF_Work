set mapreduce.job.name = idw_fact_reinvest_set_snapshot_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table IDW.FACT_REINVEST_SET_SNAPSHOT partition
  (STAT_DATE)
  select 'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         rt.va_id VA_ID,
         rt.user_id USER_ID,
         fp.scope PRODUCT_CATEGORY_CODE,
         fps.label PRODUCT_CATEGORY_NAME,
         fp.expect EXPECT,
         CASE
           WHEN fp.expect_unit = 0 THEN
            2
           WHEN fp.expect_unit = 1 THEN
            1
         END EXPECT_UNIT_CODE,
         rt.reinvest_type REINVEST_TYPE,
         rt.expect REINVEST_EXPECT,
         CASE
           WHEN rt.expect_unit = 0 THEN
            2
           WHEN rt.expect_unit = 1 THEN
            1
         END REINVEST_EXPECT_UNIT_CODE,
         case
           when rt.reinvest_type = 1 then
            va.amount
           when rt.reinvest_type = 2 then
            va.amount + va.expect_profit_principal + va.expect_profit_coupon
         end REINVEST_AMT,
         case
           when rt.reinvest_type = 1 and rt.expect_unit = 0 then
            va.amount * rt.expect / 12
           when rt.reinvest_type = 1 and rt.expect_unit = 1 then
            va.amount * rt.expect / 360
           when rt.reinvest_type = 2 and rt.expect_unit = 0 then
            (va.amount + va.expect_profit_principal +
            va.expect_profit_coupon) * rt.expect / 12
           when rt.reinvest_type = 2 and rt.expect_unit = 1 then
            (va.amount + va.expect_profit_principal +
            va.expect_profit_coupon) * rt.expect / 360
         end REINVEST_AMT_YEARLY,
         rt.reinvest_start_date REINVEST_START_DATE,
         rt.status REINVEST_STATUS,
         rt.next_va_id NEXT_VA_ID,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') STAT_DATE
    from odsopr.invt_va_reinvest_task_hist rt
    join odsopr.vip_account_hist va
      on rt.va_id = va.id
    JOIN odsopr.finance_plan_hist fp
      ON va.fp_id = fp.id
    LEFT JOIN odsopr.finance_plan_scope_hist fps
      ON fp.scope = fps.id;