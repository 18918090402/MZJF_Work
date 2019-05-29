set mapreduce.job.name = idw_fact_nono_user_invest_stat_daily_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table idw.FACT_NONO_USER_INVEST_STAT_DAILY partition
  (STAT_DATE)
  select user_id,
         case
           when INVEST_TYPE_CODE = 1 then
            '散投'
           when INVEST_TYPE_CODE = 2 then
            '债转'
           when INVEST_TYPE_CODE = 3 then
            CATEGORY_NAME_02
           WHEN INVEST_TYPE_CODE = 4 THEN
            'E诺千金'
           WHEN INVEST_TYPE_CODE = 5 THEN
            '活期'
           WHEN INVEST_TYPE_CODE = 99 THEN
            'NA'
           ELSE
            'NA'
         end PRODUCT_CATEGORY,
         PLATFORM,
         EXPECT,
         EXPECT_UNIT_CODE,
         case expect_unit_code
           when 1 then
            concat(cast(expect as string), '日')
           when 2 then
            concat(cast(expect as string), '月')
           when 3 then
            concat(cast(expect as string), '年')
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
         sum(INVEST_AMT) INVEST_AMT,
         sum(INVEST_AMT_YEARLY) ANNUALIZED_INVEST_AMT,
         sum(INVEST_AMT_YEARLY * (min_rate + max_rate) / 2) EXPECTED_EARNINGS_AMT,
         count(1) INVEST_CNT,
         sum(DEDUCTIBLE_AMT) DEDUCTIBLE_AMT,
         sum(case
               when EXPECT_UNIT_CODE = 1 then
                ADD_RATE / 100 * INVEST_AMT * EXPECT / 365
               when EXPECT_UNIT_CODE = 2 then
                ADD_RATE / 100 * INVEST_AMT * EXPECT / 12
               when EXPECT_UNIT_CODE = 3 then
                ADD_RATE / 100 * INVEST_AMT * EXPECT
             end) ADD_RATE_AMT,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         to_date(INVEST_TIME) STAT_DATE
    from idw.FACT_NONO_INVEST_ORDER
   where STATUS in (1, 2)
     and INVEST_TIME >= to_date('{LAST_DATA_TIME}')
     and INVEST_TIME < to_date('{T}')
   group by user_id,
            case
              when INVEST_TYPE_CODE = 1 then
               '散投'
              when INVEST_TYPE_CODE = 2 then
               '债转'
              when INVEST_TYPE_CODE = 3 then
               CATEGORY_NAME_02
              WHEN INVEST_TYPE_CODE = 4 THEN
               'E诺千金'
              WHEN INVEST_TYPE_CODE = 5 THEN
               '活期'
              WHEN INVEST_TYPE_CODE = 99 THEN
               'NA'
              ELSE
               'NA'
            end,
            PLATFORM,
            expect_unit_code,
            expect,
            to_date(INVEST_TIME);