set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_36_01;

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
  select t1.user_id,
         max(if(t1.groupkwd = '辅导员' and t1.kind = 1, t1.value, null)) INSTRUCTOR_NAME,
         max(if(t1.groupkwd = '辅导员' and t1.kind = 2, t1.value, null)) INSTRUCTOR_MOBILE,
         max(if(t1.groupkwd = '辅导员' and t1.kind = 2, t1.call_state, null)) INSTRUCTOR_MOBILE_STATE,
         max(if(t1.groupkwd = '辅导员' and t1.kind = 2, t2.city, null)) INSTRUCTOR_MOBILE_ADDRESS,
         max(if(t1.groupkwd = '父母' and t1.kind = 1, t1.value, null)) PARENT_NAME,
         max(if(t1.groupkwd = '父母' and t1.kind = 2, t1.value, null)) PARENT_MOBILE,
         max(if(t1.groupkwd = '父母' and t1.kind = 2, t1.call_state, null)) PARENT_MOBILE_STATE,
         max(if(t1.groupkwd = '父母' and t1.kind = 2, t2.city, null)) PARENT_MOBILE_ADDRESS,
         max(if(t1.groupkwd = '好友1' and t1.kind = 1, t1.value, null)) FRIEND1_NAME,
         max(if(t1.groupkwd = '好友1' and t1.kind = 2, t1.value, null)) FRIEND1_MOBILE,
         max(if(t1.groupkwd = '好友1' and t1.kind = 2, t1.call_state, null)) FRIEND1_MOBILE_STATE,
         max(if(t1.groupkwd = '好友1' and t1.kind = 2, t2.city, null)) FRIEND1_MOBILE_ADDRESS,
         max(if(t1.groupkwd = '好友2' and t1.kind = 1, t1.value, null)) FRIEND2_NAME,
         max(if(t1.groupkwd = '好友2' and t1.kind = 2, t1.value, null)) FRIEND2_MOBILE,
         max(if(t1.groupkwd = '好友2' and t1.kind = 2, t1.call_state, null)) FRIEND2_MOBILE_STATE,
         max(if(t1.groupkwd = '好友2' and t1.kind = 2, t2.city, null)) FRIEND2_MOBILE_ADDRESS,
         max(if(t1.groupkwd = '好友3' and t1.kind = 1, t1.value, null)) FRIEND3_NAME,
         max(if(t1.groupkwd = '好友3' and t1.kind = 2, t1.value, null)) FRIEND3_MOBILE,
         max(if(t1.groupkwd = '好友3' and t1.kind = 2, t1.call_state, null)) FRIEND3_MOBILE_STATE,
         max(if(t1.groupkwd = '好友3' and t1.kind = 2, t2.city, null)) FRIEND3_MOBILE_ADDRESS
    from ods.t_borrows_dunning_contact_hist t1
    left join ods.t_mobile_site_hist t2
      on t1.kind = 2
     and SUBSTRING(t1.value, 1, 7) = CAST(t2.phone AS string)
   where t1.groupkwd IN ('辅导员', '父母', '好友1', '好友2', '好友3')
     and t1.kind in (1, 2)
   group by t1.user_id
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=148) SELECT  USER_ID,INSTRUCTOR_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=149) SELECT  USER_ID,INSTRUCTOR_MOBILE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=150) SELECT  USER_ID,INSTRUCTOR_MOBILE_STATE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=151) SELECT  USER_ID,INSTRUCTOR_MOBILE_ADDRESS, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=152) SELECT  USER_ID,PARENT_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=153) SELECT  USER_ID,PARENT_MOBILE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=154) SELECT  USER_ID,PARENT_MOBILE_STATE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=155) SELECT  USER_ID,PARENT_MOBILE_ADDRESS, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=156) SELECT  USER_ID,FRIEND1_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=157) SELECT  USER_ID,FRIEND1_MOBILE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=158) SELECT  USER_ID,FRIEND1_MOBILE_STATE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=159) SELECT  USER_ID,FRIEND1_MOBILE_ADDRESS, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=160) SELECT  USER_ID,FRIEND2_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=161) SELECT  USER_ID,FRIEND2_MOBILE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=162) SELECT  USER_ID,FRIEND2_MOBILE_STATE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=163) SELECT  USER_ID,FRIEND2_MOBILE_ADDRESS, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=164) SELECT  USER_ID,FRIEND3_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=165) SELECT  USER_ID,FRIEND3_MOBILE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=166) SELECT  USER_ID,FRIEND3_MOBILE_STATE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=167) SELECT  USER_ID,FRIEND3_MOBILE_ADDRESS, 4
;


set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_36_02;

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
WHERE TAG_ID >=148 and TAG_ID <=167
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;   