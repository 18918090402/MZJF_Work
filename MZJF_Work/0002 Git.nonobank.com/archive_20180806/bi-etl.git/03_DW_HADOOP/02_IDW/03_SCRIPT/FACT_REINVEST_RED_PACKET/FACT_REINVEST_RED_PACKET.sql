set mapreduce.job.name = idw_fact_reinvest_red_packet_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table IDW.FACT_REINVEST_RED_PACKET
  select 'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         rp.id ID,
         rp.user_id USER_ID,
         cbo.va_id VA_ID,
         fp.scope PRODUCT_CATEGORY_CODE,
         fps.label PRODUCT_CATEGORY_NAME,
         fp.expect EXPECT,
         CASE
           WHEN fp.expect_unit = 0 THEN
            2
           WHEN fp.expect_unit = 1 THEN
            1
         END EXPECT_UNIT_CODE,
         cbo.expect REINVEST_EXPECT,
         CASE
           WHEN cbo.expect_unit = 0 THEN
            2
           WHEN cbo.expect_unit = 1 THEN
            1
         END REINVEST_EXPECT_UNIT_CODE,
         cbo.principal REINVEST_AMT,
         cbo.annualised_amount REINVEST_AMT_YEARLY,
         rp.amount AMOUNT,
         rp.is_enable IS_ENABLE,
         rp.status STATUS,
         rp.create_time hand_time,
         rp.active_date ACTIVE_DATE
    from odsopr.mkt_red_packet_hist rp
    join odsopr.mkt_continue_bid_order_hist cbo
      on rp.id = cbo.red_packet_id
     and cbo.op_type = 1
    join odsopr.vip_account_hist va
      on cbo.va_id = va.id
    JOIN odsopr.finance_plan_hist fp
      ON va.fp_id = fp.id
    LEFT JOIN odsopr.finance_plan_scope_hist fps
      ON fp.scope = fps.id;