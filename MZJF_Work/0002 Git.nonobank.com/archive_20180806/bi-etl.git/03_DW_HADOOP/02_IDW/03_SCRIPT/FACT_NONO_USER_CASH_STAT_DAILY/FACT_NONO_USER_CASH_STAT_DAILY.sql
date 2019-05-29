set mapreduce.job.name = idw_fact_nono_user_cash_stat_daily_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table idw.FACT_NONO_USER_CASH_STAT_DAILY partition
  (STAT_DATE)
  select nic.user_id,
         case
           when nic.INVEST_TYPE_CODE = 1 then
            '散投'
           when nic.INVEST_TYPE_CODE = 2 then
            '债转'
           when nic.INVEST_TYPE_CODE = 3 then
            nic.CATEGORY_NAME_02
           WHEN nic.INVEST_TYPE_CODE = 4 THEN
            'E诺千金'
           WHEN nic.INVEST_TYPE_CODE = 5 THEN
            '活期'
           WHEN nic.INVEST_TYPE_CODE = 99 THEN
            'NA'
           ELSE
            'NA'
         end PRODUCT_CATEGORY,
         nic.PLATFORM,
         np.EXPECT,
         np.expect_unit_code,
         case np.expect_unit_code
           when 1 then
            concat(cast(expect as string), '日')
           when 2 then
            concat(cast(expect as string), '月')
         end EXPECT_NAME,
         case np.expect_unit_code
           when 1 then
            ceil(expect / 30)
           when 2 then
            expect
         end EXPECT_MONTH,
         sum(case
               when nic.INVEST_TYPE_CODE = 5 then
                price_amt
               else
                PRICE_PRINCIPAL
             end) CURDATE_CASH_AMT,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         to_date(nic.ACTUAL_CASH_TIME) STAT_DATE
    from idw.FACT_NONO_INVEST_CASH nic
    left join idw.DIM_NONO_PRODUCT np
      on nic.fp_key = np.fp_key
   where nic.CASH_STATUS = 1
     and (case
           when nic.INVEST_TYPE_CODE = 5 then
            nic.price_amt
           else
            nic.PRICE_PRINCIPAL
         end) > 0
     and nic.ACTUAL_CASH_TIME >= to_date('{LAST_DATA_TIME}')
     and nic.ACTUAL_CASH_TIME < to_date('{T}')
   group by nic.user_id,
            case
              when nic.INVEST_TYPE_CODE = 1 then
               '散投'
              when nic.INVEST_TYPE_CODE = 2 then
               '债转'
              when nic.INVEST_TYPE_CODE = 3 then
               nic.CATEGORY_NAME_02
              WHEN nic.INVEST_TYPE_CODE = 4 THEN
               'E诺千金'
              WHEN nic.INVEST_TYPE_CODE = 5 THEN
               '活期'
              WHEN nic.INVEST_TYPE_CODE = 99 THEN
               'NA'
              ELSE
               'NA'
            end,
            nic.PLATFORM,
            np.EXPECT,
            np.expect_unit_code,
            to_date(nic.ACTUAL_CASH_TIME);