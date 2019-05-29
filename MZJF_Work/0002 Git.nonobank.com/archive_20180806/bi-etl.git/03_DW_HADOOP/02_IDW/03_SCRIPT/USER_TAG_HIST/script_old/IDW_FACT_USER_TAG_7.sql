set mapreduce.job.queuename=etl-dw;
set hive.exec.parallel=true ;
set mapreduce.job.name=IDW_FACT_USER_TAG_7_01;
set hive.exec.dynamic.partition.mode=nonstrict;

from 
(
  select user_id,
         max(case
               when time_asc = 1 then
                recharge_time
             end) first_recharge_time,
         max(case
               when time_asc = 1 then
                recharge_amt
             end) first_recharge_amt,
         max(case
               when time_asc = 1 then
                bank_name
             end) first_recharge_bank,
         max(case
               when time_asc = 1 then
                recharge_type
             end) first_recharge_type,
         max(case
               when time_asc = 1 then
                terminal
             end) first_recharge_terminal,
         max(case
               when time_asc = 1 then
                system_id
             end) first_recharge_biz,
         max(case
               when time_desc = 1 then
                recharge_time
             end) last_recharge_time,
         max(case
               when time_desc = 1 then
                recharge_amt
             end) last_recharge_amt,
         max(case
               when time_desc = 1 then
                bank_name
             end) last_recharge_bank,
         max(case
               when time_desc = 1 then
                recharge_type
             end) last_recharge_type,
         max(case
               when time_desc = 1 then
                terminal
             end) last_recharge_terminal,
         max(case
               when time_desc = 1 then
                system_id
             end) last_recharge_biz
    from (select user_id,
                 recharge_time,
                 recharge_amt,
                 bank_name,
                 case pay_type
                   when 1 then
                    '易联'
                   when 2 then
                    '快钱'
                   when 3 then
                    '钱方'
                   when 4 then
                    '连连'
                   when 5 then
                    '宝付'
                   when 6 then
                    '盛付通'
                   when 7 then
                    '微信直连'
                   when 8 then
                    '微商存管'
                   else
                    cast(pay_type as string)
                 end recharge_type,
                 terminal,
                 system_id,
                 row_number() over(partition by user_id order by recharge_time asc) time_asc,
                 row_number() over(partition by user_id order by recharge_time desc) time_desc
            from idw.fact_nono_recharge) s
   group by user_id
) output
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=47) select  user_id,first_recharge_time, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=48) select  user_id,first_recharge_amt, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=49) select  user_id,first_recharge_bank, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=50) select  user_id,first_recharge_type, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=51) select  user_id,first_recharge_terminal, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=52) select  user_id,last_recharge_time, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=53) select  user_id,last_recharge_amt, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=54) select  user_id,last_recharge_bank, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=55) select  user_id,last_recharge_type, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=56) select  user_id,last_recharge_terminal, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=291) select  user_id,first_recharge_biz, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=292) select  user_id,last_recharge_biz, 4
;

-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=IDW_FACT_USER_TAG_7_02;
set hive.exec.parallel=true ;
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
   where ((tag_id >= 47 and tag_id <= 51) or tag_id in (291, 292))
     and user_id is not null
     and tag_value is not null;