set mapreduce.job.name = IDW_FACT_CSYY_USER_INVEST_STAT_DAILY_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_CSYY_USER_INVEST_STAT_DAILY partition
  (stat_date)
  select io.user_code,
         io.user_id,
         io.product_code,
         p.product_name,
         io.expect,
         io.expect_unit_code,
         case io.expect_unit_code
           when 1 then
            concat(cast(io.expect as string), '日')
           when 2 then
            concat(cast(io.expect as string), '月')
           when 3 then
            concat(cast(io.expect as string), '年')
           else
            'NA'
         end EXPECT_NAME,
         case expect_unit_code
           when 1 then
            ceil(expect / 30)
           when 2 then
            expect
           when 3 then
            expect * 12
         end EXPECT_MONTH,
         sum(io.invest_amt) INVEST_AMT,
         sum(io.invest_amt_yearly) ANNUALIZED_INVEST_AMT,
         sum(io.INVEST_AMT_YEARLY * io.RATE) EXPECTED_EARNINGS_AMT,
         count(1) INVEST_CNT,
         sum(io.deductible_amt) DEDUCTIBLE_AMT,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         to_date(invest_time) STAT_DATE
    from idw.fact_csyy_invest_order io
    left join idw.DIM_CSYY_PRODUCT p
      on io.product_code = p.product_code
   where io.invest_time >= to_date('{LAST_DATA_TIME}')
     and io.invest_time < to_date('{T}')
   group by io.user_code,
            io.user_id,
            io.product_code,
            p.product_name,
            io.expect_unit_code,
            io.expect,
            to_date(invest_time);