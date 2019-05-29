set mapreduce.job.name = idw_fact_biz_nono_invest_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_NONO_INVEST partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         nio.INVEST_SRC_ID,
         nio.INVEST_SRC_TAB,
         nio.USER_ID,
         nio.PRODUCT_CATEGORY,
         nio.FP_ID,
         nio.INVEST_TIME,
         nio.INVEST_AMT,
         nio.EXPECT,
         nio.EXPECT_UNIT_CODE,
         nio.LOCK_BEGIN_TIME,
         nio.LOCK_END_TIME,
         nio.MIN_RATE,
         nio.MAX_RATE,
         nio.ADD_RATE,
         nio.DEDUCTIBLE_AMT,
         nio.INVEST_AMT_YEARLY,
         row_number() over(partition by nio.user_id order by nio.INVEST_TIME) INVEST_NUM,
         row_number() over(partition by nio.user_id, nio.PRODUCT_CATEGORY order by nio.INVEST_TIME) PRODUCT_INVEST_NUM,
         nio.DATA_STATE
    from (select INVEST_SRC_ID,
                 INVEST_SRC_TAB,
                 USER_ID,
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
                 FP_ID,
                 INVEST_TIME,
                 INVEST_AMT,
                 EXPECT,
                 EXPECT_UNIT_CODE,
                 LOCK_BEGIN_TIME,
                 LOCK_END_TIME,
                 MIN_RATE,
                 MAX_RATE,
                 ADD_RATE,
                 DEDUCTIBLE_AMT,
                 INVEST_AMT_YEARLY,
                 DATA_STATE
            from IDW.FACT_NONO_INVEST_ORDER
           where status in (1, 2)
             and platform = 1) nio;