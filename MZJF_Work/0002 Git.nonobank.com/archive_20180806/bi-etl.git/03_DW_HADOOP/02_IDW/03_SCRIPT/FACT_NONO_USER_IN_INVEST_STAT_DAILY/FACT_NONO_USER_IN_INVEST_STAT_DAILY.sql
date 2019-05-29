set mapreduce.job.name = idw_fact_nono_user_in_invest_stat_daily_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_NONO_USER_IN_INVEST_STAT_DAILY partition
  (STAT_DATE)
  select nad.user_id, -- 在投
         case
           when INVEST_TYPE_CODE = 1 then
            '散投'
           when INVEST_TYPE_CODE = 2 then
            '债转'
           when INVEST_TYPE_CODE = 3 then
            nad.CATEGORY_NAME_02
           WHEN INVEST_TYPE_CODE = 4 THEN
            'E诺千金'
           WHEN INVEST_TYPE_CODE = 5 THEN
            '活期'
           WHEN INVEST_TYPE_CODE = 99 THEN
            'NA'
           ELSE
            'NA'
         end PRODUCT_CATEGORY,
         nad.PLATFORM,
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
         sum(nad.in_invest_amt) IN_INVEST_AMT,
         sum(nad.aum) aum,
         sum(case
               when nad.CATEGORY_CODE_02 = 15 and
                    nad.stat_date < date_add(to_date(nio.lock_begin_time), 30) then
                nad.aum
               else
                0
             end) YYS_LOCK_AUM,
         sum(case
               when nad.CATEGORY_CODE_02 = 15 and
                    nad.stat_date >= date_add(to_date(nio.lock_begin_time), 30) then
                nad.aum
               else
                0
             end) YYS_UNLOCK_AUM,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         nad.stat_date
    from idw.FACT_NONO_AUM_DETAIL_SNAPSHOT nad
    left join (select invest_relation_no, TRANS_ID, LOCK_BEGIN_TIME
                 from idw.FACT_NONO_INVEST_ORDER
                where CATEGORY_CODE_02 = 15
                group by invest_relation_no, TRANS_ID, LOCK_BEGIN_TIME) nio
      on nad.invest_relation_no = nio.invest_relation_no
     and nad.TRANS_ID = nio.TRANS_ID
    left join idw.DIM_NONO_PRODUCT np
      on nad.fp_key = np.fp_key
   where nad.stat_date >= to_date('{LAST_DATA_TIME}')
     and nad.stat_date < to_date('{T}')
   group by nad.user_id,
            case
              when INVEST_TYPE_CODE = 1 then
               '散投'
              when INVEST_TYPE_CODE = 2 then
               '债转'
              when INVEST_TYPE_CODE = 3 then
               nad.CATEGORY_NAME_02
              WHEN INVEST_TYPE_CODE = 4 THEN
               'E诺千金'
              WHEN INVEST_TYPE_CODE = 5 THEN
               '活期'
              WHEN INVEST_TYPE_CODE = 99 THEN
               'NA'
              ELSE
               'NA'
            end,
            nad.PLATFORM,
            np.EXPECT,
            np.expect_unit_code,
            nad.stat_date;