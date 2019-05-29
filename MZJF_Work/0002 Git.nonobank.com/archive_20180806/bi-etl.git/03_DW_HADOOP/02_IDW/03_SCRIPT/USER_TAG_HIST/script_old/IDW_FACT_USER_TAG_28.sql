set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_28_01;

set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

FROM 
(
  select user_id,
         min(ml_time) first_ml_time,
         min(PASS_TIME) first_bo_success_time,
         min(BO_SUCCESS_TIME) first_actual_bo_time
    from idw.fact_borrows bo
   group by user_id
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=138) SELECT  USER_ID,FIRST_BO_SUCCESS_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=287) SELECT  USER_ID,first_ml_time, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=288) SELECT  USER_ID,first_actual_bo_time, 4
;


set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_28_02;

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

INSERT OVERWRITE TABLE   IDW.USER_TAG_HIST  PARTITION(TAG_ID,HASH_PARTITION_ID)
SELECT   USER_ID       
        ,TAG_VALUE
        ,'SYS' AS DW_CREATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
        ,'SYS' AS DW_UPDATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
        ,TAG_ID
        ,CAST(PMOD(USER_ID,10) AS INT) HASH_PARTITION_ID 
FROM    IDW.USER_TAG_TMP_01  
WHERE TAG_ID in (138,287,288)
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;   