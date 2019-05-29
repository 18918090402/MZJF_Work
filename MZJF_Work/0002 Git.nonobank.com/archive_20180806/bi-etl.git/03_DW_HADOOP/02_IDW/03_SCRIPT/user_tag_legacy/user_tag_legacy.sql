set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_tag_legacy_01;
set hive.exec.parallel=true;

insert overwrite table idw.user_tag_legacy
  select 'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         t1.user_id,
         nvl(max(case
                   when tag_id = 120 then
                    cast(tag_value as string)
                 end),
             null) as csyy_first_recharge_time,
         nvl(max(case
                   when tag_id = 121 then
                    cast(tag_value as decimal(38, 10))
                 end),
             null) as csyy_first_recharge_amt,
         nvl(max(case
                   when tag_id = 122 then
                    cast(tag_value as string)
                 end),
             null) as csyy_first_recharge_bank,
         nvl(max(case
                   when tag_id = 123 then
                    cast(tag_value as string)
                 end),
             null) as csyy_first_recharge_type,
         nvl(max(case
                   when tag_id = 124 then
                    cast(tag_value as string)
                 end),
             null) as csyy_last_recharge_time,
         nvl(max(case
                   when tag_id = 125 then
                    cast(tag_value as decimal(38, 10))
                 end),
             null) as csyy_last_recharge_amt,
         nvl(max(case
                   when tag_id = 126 then
                    cast(tag_value as string)
                 end),
             null) as csyy_last_recharge_bank,
         nvl(max(case
                   when tag_id = 127 then
                    cast(tag_value as string)
                 end),
             null) as csyy_last_recharge_type,
         nvl(max(case
                   when tag_id = 128 then
                    cast(tag_value as int)
                 end),
             null) as nono_is_loss_before_2017
    from idw.user_tag_hist_legacy t1
    join odsopr.user_info_hist t2
      on t1.user_id = t2.id
   where t1.tag_id >= 120
     and t1.tag_id <= 128
   group by t1.user_id;