set mapreduce.job.name = DMT_FACT_NONO_CUBE_AUM_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT.FACT_NONO_CUBE_AUM partition
  (stat_date)
  select coalesce(td.user_id, yd.user_id, tm.user_id) user_id,
         coalesce(td.invest_type_code,
                  yd.invest_type_code,
                  tm.invest_type_code) invest_type_code,
         coalesce(td.fp_key, yd.fp_key, tm.fp_key) fp_key,
         np.fp_id,
         np.category_code_02,
         np.category_name_02,
         np.expect,
         np.expect_unit_code,
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
                 t1.user_id,
                 t1.invest_type_code,
                 t1.fp_key,
                 sum(aum) aum
            from idw.fact_nono_aum_detail_snapshot t1
           where t1.stat_date >= date_sub('{LAST_DATA_TIME}', 2)
             and t1.stat_date < '{T}'
           group by t1.stat_date, t1.user_id, t1.invest_type_code, t1.fp_key) td
    full outer join (select t1.stat_date,
                            t1.user_id,
                            t1.invest_type_code,
                            t1.fp_key,
                            sum(aum) aum
                       from idw.fact_nono_aum_detail_snapshot t1
                      where t1.stat_date >= date_sub('{LAST_DATA_TIME}', 3)
                        and t1.stat_date < date_sub('{T}', 1)
                      group by t1.stat_date,
                               t1.user_id,
                               t1.invest_type_code,
                               t1.fp_key) yd
      on yd.stat_date = date_sub(td.stat_date, 1)
     and yd.user_id = td.user_id
     and yd.invest_type_code = td.invest_type_code
     and nvl(yd.fp_key, -999999) = nvl(td.fp_key, -999999)
    full outer join (select t1.stat_date,
                            t1.user_id,
                            t1.invest_type_code,
                            t1.fp_key,
                            sum(aum) aum
                       from idw.fact_nono_aum_detail_snapshot t1
                      where t1.stat_date >= date_sub('{LAST_DATA_TIME}', 1)
                        and t1.stat_date < '{T}'
                      group by t1.stat_date,
                               t1.user_id,
                               t1.invest_type_code,
                               t1.fp_key) tm
      on tm.stat_date = date_add(td.stat_date, 1)
     and tm.user_id = td.user_id
     and tm.invest_type_code = td.invest_type_code
     and nvl(tm.fp_key, -999999) = nvl(td.fp_key, -999999)
    left join idw.DIM_NONO_PRODUCT np
      on coalesce(td.fp_key, yd.fp_key, tm.fp_key) = np.fp_key;