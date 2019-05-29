set mapreduce.job.name = DMT_FACT_NONO_USER_ACTIVITY_LEVEL_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT.FACT_NONO_USER_ACTIVITY_LEVEL partition
  (stat_date)
  select user_id,
         case
           when js is not null then
            5
           when cm is not null then
            4
           when xk = '1_4' and hy is not null and zc is not null then
            3
           when xk = '1_4' and hy is not null then
            2
           else
            1
         end USER_CATEGORY,
         case
           when js is not null then
            js
           when cm is not null then
            cm
           when xk = '1_4' and hy is not null and zc is not null then
            zc
           when xk = '1_4' and hy is not null then
            hy
           else
            xk
         end ACTIVITY_LEVEL,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         stat_date AS STAT_DATE
    from (select stat_date,
                 user_id,
                 case
                   when nvl(last_60_days_login_cnt, 0) <= 0 then
                    '5_1'
                 end js,
                 case
                   when last_60_days_login_cnt > 0 and
                        nvl(last_30_days_login_cnt, 0) <= 1 then
                    '4_2'
                   when last_60_days_login_cnt > 0 and
                        nvl(last_30_days_login_cnt, 0) /
                        last_60_days_login_cnt <= 0.5 then
                    '4_1'
                 end cm,
                 case
                   when first_invest_time is not null then
                    '1_4'
                   when first_bind_card_time is not null then
                    '1_3'
                   when is_authentication = 1 then
                    '1_2'
                   when register_time is not null then
                    '1_1'
                 end xk,
                 case if(last_30_days_login_cnt >= 4, 1, 0) +
                  if(last_30_days_view_column_cnt >= 2 and
                     last_30_days_view_product_cnt >= 2,
                     1,
                     0) + if(last_30_days_invest_cnt >= 1, 1, 0)
                   when 1 then
                    '2_1'
                   when 2 then
                    '2_2'
                   when 3 then
                    '2_3'
                 end hy,
                 case if(invest_cnt >= 4, 1, 0) +
                  if(second_invest_amt >= 10000, 1, 0) +
                  if(last_30_days_click_third_icon_cnt >= 1, 1, 0) +
                  if(prolocutor_invite_register_cnt >= 1, 1, 0)
                   when 1 then
                    '3_1'
                   when 2 then
                    '3_2'
                   when 3 then
                    '3_3'
                   when 4 then
                    '3_4'
                 end zc
            from dmt.fact_nono_user_activity_info
           where stat_date >= to_date('{LAST_DATA_TIME}')) s;