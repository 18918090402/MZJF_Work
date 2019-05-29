set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_tag_01;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table idw.user_tag partition
  (stat_date)
  select 'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         user_id,
         max(case
               when tag_id = 45 then
                cast(tag_value as string)
             end) as authentication_time,
         max(case
               when tag_id = 57 then
                cast(tag_value as string)
             end) as first_bind_card_time,
         max(case
               when tag_id = 58 then
                cast(tag_value as string)
             end) as first_bind_card_account,
         max(case
               when tag_id = 59 then
                cast(tag_value as string)
             end) as first_bind_card_bank,
         max(case
               when tag_id = 61 then
                cast(tag_value as string)
             end) as last_bind_card_time,
         max(case
               when tag_id = 62 then
                cast(tag_value as string)
             end) as last_bind_card_account,
         max(case
               when tag_id = 63 then
                cast(tag_value as string)
             end) as last_bind_card_bank,
         max(case
               when tag_id = 60 then
                cast(tag_value as string)
             end) as bindcard_cnt,
         max(case
               when tag_id = 47 then
                cast(tag_value as string)
             end) as first_recharge_time,
         max(case
               when tag_id = 48 then
                cast(tag_value as decimal(38, 10))
             end) as first_recharge_amt,
         max(case
               when tag_id = 49 then
                cast(tag_value as string)
             end) as first_recharge_bank,
         max(case
               when tag_id = 50 then
                cast(tag_value as string)
             end) as first_recharge_type,
         max(case
               when tag_id = 51 then
                cast(tag_value as string)
             end) as first_recharge_terminal,
         max(case
               when tag_id = 291 then
                cast(tag_value as string)
             end) as first_recharge_biz,
         max(case
               when tag_id = 52 then
                cast(tag_value as string)
             end) as last_recharge_time,
         max(case
               when tag_id = 53 then
                cast(tag_value as decimal(38, 10))
             end) as last_recharge_amt,
         max(case
               when tag_id = 54 then
                cast(tag_value as string)
             end) as last_recharge_bank,
         max(case
               when tag_id = 55 then
                cast(tag_value as string)
             end) as last_recharge_type,
         max(case
               when tag_id = 56 then
                cast(tag_value as string)
             end) as last_recharge_terminal,
         max(case
               when tag_id = 292 then
                cast(tag_value as string)
             end) as last_recharge_biz,
         max(case
               when tag_id = 41 then
                cast(tag_value as string)
             end) as last_login_time,
         max(case
               when tag_id = 293 then
                cast(tag_value as string)
             end) as last_login_biz,
         max(case
               when tag_id = 64 then
                cast(tag_value as string)
             end) as nono_first_invest_time,
         max(case
               when tag_id = 97 then
                cast(tag_value as string)
             end) as csyy_first_invest_time,
         max(case
               when tag_id = 294 then
                cast(tag_value as string)
             end) as xyd_first_apply_time,
         max(case
               when tag_id = 295 then
                cast(tag_value as string)
             end) as bld_first_apply_time,
         max(case
               when tag_id = 296 then
                cast(tag_value as string)
             end) as mzjk_first_apply_time,
         date_sub(current_date(), 1) stat_date
    from idw.user_tag_hist
   where tag_id in (45,
                    57,
                    58,
                    59,
                    61,
                    62,
                    63,
                    60,
                    47,
                    48,
                    49,
                    50,
                    51,
                    291,
                    52,
                    53,
                    54,
                    55,
                    56,
                    292,
                    41,
                    293,
                    64,
                    97,
                    294,
                    295,
                    296)
     and user_id > 0
   group by user_id;