set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_56_01;

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
  select user_id,
         base_amount      BASE_AMT_110,
         increase_amount  INCREASE_AMT_110,
         total_amount     TOTAL_AMT_110,
         used_amount      USED_AMT_110,
         base_amount_type BASE_AMOUNT_TYPE_110
    from odsopr.borrows_credit_amount_hist
   where is_delete = 0
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=263) SELECT  USER_ID,BASE_AMT_110, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=264) SELECT  USER_ID,INCREASE_AMT_110, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=265) SELECT  USER_ID,TOTAL_AMT_110, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=266) SELECT  USER_ID,USED_AMT_110, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=290) SELECT  USER_ID,BASE_AMOUNT_TYPE_110, 4
;
-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_56_02;

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
   WHERE TAG_ID in (263, 264, 265, 266, 290)
     AND USER_ID IS NOT NULL
     AND TAG_VALUE IS NOT NULL;