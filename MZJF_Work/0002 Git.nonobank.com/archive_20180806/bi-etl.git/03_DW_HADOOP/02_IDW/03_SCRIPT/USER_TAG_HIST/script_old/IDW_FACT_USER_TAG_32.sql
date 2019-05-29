set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_32_01;

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
  select b.user_id, max(create_time) as gjj_submit_time
    from (SELECT user_id, create_time
            FROM ods.t_user_profile_info_hist upi
           WHERE upi.attribute_name = 'social_gjj_number'
          union all
          SELECT user_id, create_time
            FROM ods.t_user_credit_investigation_hist
           WHERE credit_type = 9) b
   group by b.user_id
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=142) SELECT  USER_ID,1 IS_GJJ_SUBMIT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=143) SELECT  USER_ID,GJJ_SUBMIT_TIME, 4
;


set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_32_02;

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
WHERE TAG_ID >=142 AND TAG_ID <=143
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;   