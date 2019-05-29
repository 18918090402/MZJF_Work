set mapreduce.job.name = idw_fact_biz_csyy_invest_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_CSYY_INVEST partition
  (DATA_STATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         cio.INVEST_SRC_ID,
         cio.INVEST_SRC_TAB,
         cio.USER_CODE,
         cio.USER_ID,
         cio.PRODUCT_CATEGORY,
         cio.PRODUCT_CODE,
         cio.INVEST_TIME,
         cio.INVEST_AMT,
         cio.EXPECT,
         cio.EXPECT_UNIT_CODE,
         cio.LOCK_BEGIN_TIME,
         cio.LOCK_END_TIME,
         cio.RATE,
         cio.DEDUCTIBLE_AMT,
         cio.INVEST_AMT_YEARLY,
         row_number() over(partition by cio.user_id order by cio.INVEST_TIME) INVEST_NUM,
         row_number() over(partition by cio.user_id, cio.PRODUCT_CATEGORY order by cio.INVEST_TIME) PRODUCT_INVEST_NUM,
         cio.DATA_STATE
    from (select INVEST_SRC_ID,
                 INVEST_SRC_TAB,
                 t2.merchant_user_id USER_CODE,
                 USER_ID,
                 case
                   when CATEGORY_CODE_02 = 1 then
                    '招财新人宝'
                   when CATEGORY_CODE_02 = 11 then
                    '招财卡'
                   when CATEGORY_CODE_02 = 26 then
                    '招牌财神'
                   ELSE
                    'NA'
                 end PRODUCT_CATEGORY,
                 cast(FP_ID as string) PRODUCT_CODE,
                 INVEST_TIME,
                 INVEST_AMT,
                 EXPECT,
                 EXPECT_UNIT_CODE,
                 LOCK_BEGIN_TIME,
                 LOCK_END_TIME,
                 (MIN_RATE + MAX_RATE) / 2 RATE,
                 DEDUCTIBLE_AMT,
                 INVEST_AMT_YEARLY,
                 DATA_STATE
            from IDW.FACT_NONO_INVEST_ORDER t1
            left join ods.t_account_relation_hist t2
              on t1.user_id = t2.nono_user_id
           where t1.status in (1, 2)
             and platform = 2
          union all
          select INVEST_SRC_ID,
                 INVEST_SRC_TAB,
                 USER_CODE,
                 USER_ID,
                 coalesce(t2.product_name, 'NA') PRODUCT_CATEGORY,
                 t1.PRODUCT_CODE,
                 INVEST_TIME,
                 INVEST_AMT,
                 EXPECT,
                 EXPECT_UNIT_CODE,
                 LOCK_BEGIN_TIME,
                 LOCK_END_TIME,
                 t1.RATE,
                 DEDUCTIBLE_AMT,
                 INVEST_AMT_YEARLY,
                 'current' DATA_STATE
            from IDW.FACT_CSYY_INVEST_ORDER t1
            left join idw.DIM_CSYY_PRODUCT t2
              on t1.PRODUCT_CODE = t2.PRODUCT_CODE) cio;