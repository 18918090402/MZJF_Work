set mapreduce.job.name = idw_fact_biz_csyy_aum_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_CSYY_AUM partition
  (STAT_DATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
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
         sum(IN_INVEST_AMT) IN_INVEST_AMT,
         sum(aum) aum,
         stat_date
    from idw.FACT_NONO_AUM_DETAIL_SNAPSHOT t1
    left join ods.t_account_relation_hist t2
      on t1.user_id = t2.nono_user_id
   where stat_date >= to_date('{LAST_DATA_TIME}')
     and stat_date < to_date('{T}')
     and platform = 2
   group by t2.merchant_user_id,
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
            end,
            FP_ID,
            stat_date
  union all
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         USER_CODE,
         USER_ID,
         coalesce(t2.product_name, 'NA') PRODUCT_CATEGORY,
         t1.PRODUCT_CODE,
         sum(aum) IN_INVEST_AMT,
         sum(aum) aum,
         stat_date
    from idw.FACT_CSYY_AUM_DETAIL_SNAPSHOT t1
    left join idw.DIM_CSYY_PRODUCT t2
      on t1.PRODUCT_CODE = t2.PRODUCT_CODE
   where stat_date >= to_date('{LAST_DATA_TIME}')
     and stat_date < to_date('{T}')
   group by USER_CODE, USER_ID, t2.product_name, t1.PRODUCT_CODE, stat_date;