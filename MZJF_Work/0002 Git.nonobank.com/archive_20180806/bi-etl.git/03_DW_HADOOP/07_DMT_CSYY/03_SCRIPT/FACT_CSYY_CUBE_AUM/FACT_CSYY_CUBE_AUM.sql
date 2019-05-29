set mapreduce.job.name = DMT_CSYY_FACT_CSYY_CUBE_AUM_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_CSYY.FACT_CSYY_CUBE_AUM partition
  (stat_date)
  select coalesce(td.user_code, yd.user_code, tm.user_code) user_code,
         coalesce(td.user_id, yd.user_id, tm.user_id) user_id,
         coalesce(td.product_key, yd.product_key, tm.product_key) product_key,
         coalesce(td.product_code, yd.product_code, tm.product_code) product_code,
         coalesce(td.invest_type_code,
                  yd.invest_type_code,
                  tm.invest_type_code) invest_type_code,
         nvl(td.aum, 0) aum,
         nvl(td.aum, 0) - nvl(yd.aum, 0) diff_between_today_and_yesterday,
         case
           when coalesce(td.stat_date,
                         to_date(date_add(yd.stat_date, 1)),
                         to_date(date_sub(tm.stat_date, 1))) =
                to_date('{T_SUB_1}') then
            null
           else
            nvl(td.aum, 0) - nvl(tm.aum, 0)
         end diff_between_today_and_tomorrow,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         coalesce(td.stat_date,
                  to_date(date_add(yd.stat_date, 1)),
                  to_date(date_sub(tm.stat_date, 1))) stat_date
    from (select t1.stat_date,
                 t1.user_code,
                 t1.user_id,
                 t1.product_key,
                 t1.product_code,
                 t1.invest_type_code,
                 sum(aum) aum
            from idw.fact_csyy_aum_detail_snapshot t1
           where t1.stat_date >= date_sub('{LAST_DATA_TIME}', 2)
             and t1.stat_date < '{T}'
           group by t1.stat_date,
                    t1.user_code,
                    t1.user_id,
                    t1.product_key,
                    t1.product_code,
                    t1.invest_type_code) td
    full outer join (select t1.stat_date,
                            t1.user_code,
                            t1.user_id,
                            t1.product_key,
                            t1.product_code,
                            t1.invest_type_code,
                            sum(aum) aum
                       from idw.fact_csyy_aum_detail_snapshot t1
                      where t1.stat_date >= date_sub('{LAST_DATA_TIME}', 3)
                        and t1.stat_date < date_sub('{T}', 1)
                      group by t1.stat_date,
                               t1.user_code,
                               t1.user_id,
                               t1.product_key,
                               t1.product_code,
                               t1.invest_type_code) yd
      on yd.stat_date = date_sub(td.stat_date, 1)
     and yd.user_code = td.user_code
     and yd.product_key = td.product_key
    full outer join (select t1.stat_date,
                            t1.user_code,
                            t1.user_id,
                            t1.product_key,
                            t1.product_code,
                            t1.invest_type_code,
                            sum(aum) aum
                       from idw.fact_csyy_aum_detail_snapshot t1
                      where t1.stat_date >= date_sub('{LAST_DATA_TIME}', 1)
                        and t1.stat_date < '{T}'
                      group by t1.stat_date,
                               t1.user_code,
                               t1.user_id,
                               t1.product_key,
                               t1.product_code,
                               t1.invest_type_code) tm
      on tm.stat_date = date_add(td.stat_date, 1)
     and tm.user_code = td.user_code
     and tm.product_key = td.product_key;

set mapreduce.job.name = DMT_CSYY_FACT_CSYY_CUBE_AUM_02;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_CSYY.FACT_CSYY_CUBE_AUM partition
  (stat_date)
  SELECT t1.USER_CODE,
         ar.nono_user_id USER_ID,
         t1.PRODUCT_KEY,
         t1.PRODUCT_CODE,
         t1.INVEST_TYPE_CODE,
         t1.AUM,
         t1.DIFF_BETWEEN_TODAY_AND_YESTERDAY,
         t1.DIFF_BETWEEN_TODAY_AND_TOMORROW,
         t1.DW_CREATE_BY,
         t1.DW_CREATE_TIME,
         t1.DW_UPDATE_BY,
         case
           when t1.user_id <> ar.nono_user_id then
            from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss')
           else
            t1.DW_UPDATE_TIME
         end DW_UPDATE_TIME,
         t1.STAT_DATE
    FROM DMT_CSYY.FACT_CSYY_CUBE_AUM t1
    left join ods.t_account_relation_hist ar
      ON t1.user_code = ar.merchant_user_id;