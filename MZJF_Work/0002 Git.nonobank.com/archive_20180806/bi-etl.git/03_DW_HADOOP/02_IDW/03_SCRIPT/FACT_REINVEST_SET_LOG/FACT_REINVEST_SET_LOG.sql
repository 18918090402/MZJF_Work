set mapreduce.job.name = idw_fact_reinvest_set_log_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table IDW.FACT_REINVEST_SET_LOG
  select 'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         rsl.id ID,
         rsl.user_id USER_ID,
         rsl.va_id VA_ID,
         fp.scope PRODUCT_CATEGORY_CODE,
         fps.label PRODUCT_CATEGORY_NAME,
         fp.expect EXPECT,
         CASE
           WHEN fp.expect_unit = 0 THEN
            2
           WHEN fp.expect_unit = 1 THEN
            1
         END EXPECT_UNIT_CODE,
         rsl.reinvest_type REINVEST_TYPE,
         rsl.expect REINVEST_EXPECT,
         CASE
           WHEN rsl.expect_unit = 0 THEN
            2
           WHEN rsl.expect_unit = 1 THEN
            1
         END REINVEST_EXPECT_UNIT_CODE,
         rsl.principal REINVEST_AMT,
         rsl.yearly_principal REINVEST_AMT_YEARLY,
         rsl.red_packet_price RED_PACKET_PRICE,
         rsl.create_time CREATE_TIME
    from odsopr.invt_va_reinvest_set_log_hist rsl
    join odsopr.vip_account_hist va
      on rsl.va_id = va.id
    JOIN odsopr.finance_plan_hist fp
      ON va.fp_id = fp.id
    LEFT JOIN odsopr.finance_plan_scope_hist fps
      ON fp.scope = fps.id;