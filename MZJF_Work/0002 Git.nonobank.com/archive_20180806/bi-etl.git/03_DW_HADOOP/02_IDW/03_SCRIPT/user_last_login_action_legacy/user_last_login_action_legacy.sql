set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_last_login_action_legacy_01;
set hive.exec.parallel=true;

insert overwrite table idw.user_last_login_action_legacy
  select 'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         user_id,
         terminal,
         ip,
         login_time,
         login_biz
    from (select user_id,
                 terminal,
                 ip,
                 login_time,
                 login_biz,
                 row_number() over(partition by user_id order by login_time desc) rn
            from (select user_id,
                         terminal,
                         case
                           when ip = '' then
                            null
                           else
                            ip
                         end ip,
                         create_time login_time,
                         action_from login_biz
                    from odsopr.user_action_log_hist
                   where action_type = 1
                     and create_time < '2018-01-01'
                     and user_id > 0
                  union all
                  select ar.nono_user_id user_id,
                         null terminal,
                         ip,
                         uli.logon_time login_time,
                         'csyy' login_biz
                    from odsopr.user_logon_info_hist uli
                    join odsopr.account_relation_hist ar
                      on uli.user_code = ar.merchant_user_id
                   where uli.logon_status = '0'
                     and uli.logon_time < '2018-01-01'
                     and ar.nono_user_id > 0) t) s
   where rn = 1;