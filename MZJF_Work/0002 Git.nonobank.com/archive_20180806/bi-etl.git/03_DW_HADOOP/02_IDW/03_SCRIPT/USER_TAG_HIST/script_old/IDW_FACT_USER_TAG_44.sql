set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=IDW_FACT_USER_TAG_44_01;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

from 
(
  select user_id,
         min(apply_time) first_apply_time,
         min(xyd_apply_time) xyd_first_apply_time,
         min(bld_apply_time) bld_first_apply_time,
         min(mzjk_apply_time) mzjk_first_apply_time
    from (select user_id,
                 bp_publish_time apply_time,
                 case
                   when p_id in (77, 83, 84, 88, 99, 102) then
                    bp_publish_time
                 end xyd_apply_time,
                 case
                   when p_id in (87) then
                    bp_publish_time
                 end bld_apply_time,
                 case
                   when p_id in (110, 111, 140) then
                    bp_publish_time
                 end mzjk_apply_time
            from idw.fact_borrows_prepare) t
   group by user_id
) output
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=182) select  user_id,first_apply_time, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=294) select  user_id,xyd_first_apply_time, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=295) select  user_id,bld_first_apply_time, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=296) select  user_id,mzjk_first_apply_time, 4
;
-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=IDW_FACT_USER_TAG_44_02;
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
   where tag_id in (182, 294, 295, 296)
     and user_id is not null
     and tag_value is not null;