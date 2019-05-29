set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_25_01;

set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;

set hive.exec.parallel=true ;
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

FROM 
(
  select ui.id user_id,
         case
           when ui.pc_id = 18 then
            '财神'
           when ui.user_type in (0, 1) then
            'nono'
           when uai.channel_id IN (1867, 1882, 1915) then
            '麦芽'
           when uic.mobile_num is not null or length(ui.mobile_num) = 10 or
                uai.landing_page regexp '美国' then
            'unifi'
           when ui.user_type in (3, 5, 12) then
            '名校贷'
           else
            '其他'
         end busi_line
    from ods.t_user_info_hist ui
    LEFT JOIN ods.t_user_approach_info_hist uai
      ON uai.user_id = ui.id
    left join (select mobile_num
                 from ods.t_unifi_interestratecut_hist
                group by mobile_num) uic
      on ui.mobile_num = uic.mobile_num
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=131) SELECT  USER_ID,BUSI_LINE, 4;


set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_25_02;

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.auto.convert.join=true;
set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

INSERT OVERWRITE TABLE IDW.USER_TAG_HIST PARTITION
  (TAG_ID, HASH_PARTITION_ID)
  SELECT USER_ID,
         TAG_VALUE,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         TAG_ID,
         CAST(PMOD(USER_ID, 10) AS INT) HASH_PARTITION_ID
    FROM IDW.USER_TAG_TMP_01
   WHERE TAG_ID in (131)
     AND USER_ID IS NOT NULL
     AND TAG_VALUE IS NOT NULL; 