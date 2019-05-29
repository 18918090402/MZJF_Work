set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=IDW_FACT_USER_TAG_45_01;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

from 
(
  select user_id, login_time last_login_time, login_biz last_login_biz
    from (select user_id,
                 login_time,
                 login_biz,
                 row_number() over(partition by user_id order by login_time desc) rn
            from (select user_id, logon_time login_time, login_biz
                    from odsopr.user_login_detail_log_new_hist
                   where logon_status = '0000000'
                  union all
                  select user_id, login_time, login_biz
                    from idw.user_last_login_action_legacy) t) s
   where rn = 1
) output
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=41) select user_id,last_login_time, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=293) select user_id,last_login_biz, 4
;
-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=IDW_FACT_USER_TAG_45_02;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table idw.user_tag_hist partition
  (tag_id, hash_partition_id)
  select user_id,
         tag_value,
         'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         tag_id,
         cast(pmod(user_id, 10) as int) hash_partition_id
    from idw.user_tag_tmp_01
   where tag_id in (41, 293)
     and user_id is not null
     and tag_value is not null;