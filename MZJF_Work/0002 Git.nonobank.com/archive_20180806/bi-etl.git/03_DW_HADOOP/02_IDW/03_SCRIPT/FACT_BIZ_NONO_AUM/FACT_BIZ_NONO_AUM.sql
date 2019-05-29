set mapreduce.job.name = idw_fact_biz_nono_aum_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_BIZ_NONO_AUM partition
  (STAT_DATE)
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
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
         sum(IN_INVEST_AMT) IN_INVEST_AMT,
         sum(aum) aum,
         stat_date
    from idw.FACT_NONO_AUM_DETAIL_SNAPSHOT
   where stat_date >= to_date('{LAST_DATA_TIME}')
     and stat_date < to_date('{T}')
     and platform = 1
   group by USER_ID,
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
            FP_ID,
            stat_date;