set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_info_finance_extend_01;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table idw.user_info_finance_extend partition
  (stat_date)
  select 'sys' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-mm-dd hh:mm:ss') as dw_create_time,
         'sys' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-mm-dd hh:mm:ss') as dw_update_time,
         ui.id user_id,
         ul.level user_rank,
         case ul.level
           when 0 then
            '普通会员'
           when 1 then
            'vip1'
           when 2 then
            'vip2'
           when 3 then
            'vip3'
         end as user_rank_desc,
         date_sub(current_date(), 1) stat_date
    from odsopr.user_info_hist ui
    left join odsopr.user_level_hist ul
      on ui.id = ul.user_id;