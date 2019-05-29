set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_tag_hist_legacy_01;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

FROM 
(
    select USER_ID,
         max(case
               when TIME_ASC = 1 then
                RECHARGE_TIME
             end) CSYY_FIRST_RECHARGE_TIME,
         max(case
               when TIME_ASC = 1 then
                RECHARGE_AMT
             end) CSYY_FIRST_RECHARGE_AMT,
         max(case
               when TIME_ASC = 1 then
                BANK_NAME
             end) CSYY_FIRST_RECHARGE_BANK,
         max(case
               when TIME_ASC = 1 then
                RECHARGE_TYPE
             end) CSYY_FIRST_RECHARGE_TYPE,
         max(case
               when TIME_DESC = 1 then
                RECHARGE_TIME
             end) CSYY_LAST_RECHARGE_TIME,
         max(case
               when TIME_DESC = 1 then
                RECHARGE_AMT
             end) CSYY_LAST_RECHARGE_AMT,
         max(case
               when TIME_DESC = 1 then
                BANK_NAME
             end) CSYY_LAST_RECHARGE_BANK,
         max(case
               when TIME_DESC = 1 then
                RECHARGE_TYPE
             end) CSYY_LAST_RECHARGE_TYPE
    from (select USER_ID,
                 RECHARGE_TIME,
                 RECHARGE_AMT,
                 BANK_NAME,
                 case PAY_TYPE
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
                   else
                    PAY_TYPE
                 end RECHARGE_TYPE,
                 ROW_NUMBER() OVER(PARTITION BY USER_ID ORDER BY RECHARGE_TIME ASC) TIME_ASC,
                 ROW_NUMBER() OVER(PARTITION BY USER_ID ORDER BY RECHARGE_TIME DESC) TIME_DESC
            from idw.FACT_CSYY_RECHARGE
           where USER_ID is not null) s
   group by USER_ID
) OUTPUT
INSERT OVERWRITE TABLE idw.user_tag_hist_legacy PARTITION
  (tag_id, hash_partition_id)
  select user_id,
         csyy_first_recharge_time,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         120 tag_id,
         cast(pmod(user_id, 10) as int) hash_partition_id
INSERT OVERWRITE TABLE idw.user_tag_hist_legacy PARTITION
  (tag_id, hash_partition_id)
  select user_id,
         csyy_first_recharge_amt,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         121 tag_id,
         cast(pmod(user_id, 10) as int) hash_partition_id
INSERT OVERWRITE TABLE idw.user_tag_hist_legacy PARTITION
  (tag_id, hash_partition_id)
  select user_id,
         csyy_first_recharge_bank,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         122 tag_id,
         cast(pmod(user_id, 10) as int) hash_partition_id
INSERT OVERWRITE TABLE idw.user_tag_hist_legacy PARTITION
  (tag_id, hash_partition_id)
  select user_id,
         csyy_first_recharge_type,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         123 tag_id,
         cast(pmod(user_id, 10) as int) hash_partition_id
INSERT OVERWRITE TABLE idw.user_tag_hist_legacy PARTITION
  (tag_id, hash_partition_id)
  select user_id,
         csyy_last_recharge_time,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         124 tag_id,
         cast(pmod(user_id, 10) as int) hash_partition_id
INSERT OVERWRITE TABLE idw.user_tag_hist_legacy PARTITION
  (tag_id, hash_partition_id)
  select user_id,
         csyy_last_recharge_amt,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         125 tag_id,
         cast(pmod(user_id, 10) as int) hash_partition_id
INSERT OVERWRITE TABLE idw.user_tag_hist_legacy PARTITION
  (tag_id, hash_partition_id)
  select user_id,
         csyy_last_recharge_bank,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         126 tag_id,
         cast(pmod(user_id, 10) as int) hash_partition_id
INSERT OVERWRITE TABLE idw.user_tag_hist_legacy PARTITION
  (tag_id, hash_partition_id)
  select user_id,
         csyy_last_recharge_type,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         127 tag_id,
         cast(pmod(user_id, 10) as int) hash_partition_id