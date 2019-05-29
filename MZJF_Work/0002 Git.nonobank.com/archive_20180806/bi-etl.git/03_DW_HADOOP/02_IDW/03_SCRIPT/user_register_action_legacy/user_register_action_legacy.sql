set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_register_action_legacy_01;
set hive.exec.parallel=true;

insert overwrite table idw.user_register_action_legacy
  select 'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         ual.user_id,
         ual.register_terminal,
         ual.register_ip
    from (select user_id,
                 case
                   when terminal in ('0', '11', 'pc') then
                    'pc'
                   when terminal in ('1', '13', '15', '17', '5', '31') then
                    'android'
                   when terminal in ('12', '14', '16', '2', '4', 'app', '30') then
                    'ios'
                   when terminal in ('6') then
                    'ipad'
                   when terminal in ('7') then
                    'weixin'
                   when terminal in ('3', '10') then
                    'weizhan'
                   else
                    terminal
                 end register_terminal,
                 ip register_ip,
                 row_number() over(partition by user_id order by id desc) rn
            from odsopr.user_action_log_hist
           where action_type = 7
             and create_time < '2018-01-01'
             and user_id > 0) ual
   where ual.rn = 1;