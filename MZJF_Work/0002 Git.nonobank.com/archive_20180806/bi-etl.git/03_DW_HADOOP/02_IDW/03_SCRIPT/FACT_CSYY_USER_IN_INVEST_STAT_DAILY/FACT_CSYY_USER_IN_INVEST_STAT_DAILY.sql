set mapreduce.job.name = IDW_FACT_CSYY_USER_IN_INVEST_STAT_DAILY_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_CSYY_USER_IN_INVEST_STAT_DAILY partition
  (STAT_DATE)
  select ad.user_code,
         ad.user_id,
         ad.product_code,
         p.product_name,
         sum(ad.aum) AUM,
         sum(case
               when ad.product_code = 'NN0018' and
                    ad.stat_date < date_add(to_date(io.lock_begin_time), 15) then
                ad.aum
               else
                0
             end) KXCS_LOCK_AUM,
         sum(case
               when ad.product_code = 'NN0018' and
                    ad.stat_date >= date_add(to_date(io.lock_begin_time), 15) then
                ad.aum
               else
                0
             end) KXCS_UNLOCK_AUM,
         'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         ad.stat_date
    from idw.FACT_CSYY_AUM_DETAIL_SNAPSHOT ad
    join idw.fact_csyy_invest_order io
      on ad.invest_src_id = io.invest_src_id
     and ad.invest_src_tab = io.invest_src_tab
    left join idw.DIM_CSYY_PRODUCT p
      on ad.product_code = p.product_code
   where ad.stat_date >= to_date('{LAST_DATA_TIME}')
     and ad.stat_date < to_date('{T}')
   group by ad.user_code,
            ad.user_id,
            ad.product_code,
            p.product_name,
            ad.stat_date;