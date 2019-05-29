
-- -------------------------------------------------------------------------------------------------  
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_3_01;

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
  SELECT A.USER_ID,
         A.CHANNEL_ID AS CHANNEL_ID,
         B.AM_NAME AS CHANNEL_NAME,
         A.AD_PLAN,
         A.AD_UNIT,
         A.CHANNEL_DETAIL,
         case
           when referer in ('1', '2', '3', '4') then
            referer
         end UNIFI_REGISTER_COUNTRY_CODE,
         case referer
           when '1' then
            '美国'
           when '2' then
            '加拿大'
           when '3' then
            '澳大利亚'
           when '4' then
            '英国'
         end UNIFI_REGISTER_COUNTRY_NAME
    FROM ODS.T_USER_APPROACH_INFO_HIST A
    LEFT JOIN ODS.T_ADMIN_HIST B
      ON B.ID = A.CHANNEL_ID
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=39) SELECT  USER_ID,CHANNEL_ID, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=40) SELECT  USER_ID,CHANNEL_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=170) SELECT  USER_ID,AD_PLAN, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=171) SELECT  USER_ID,AD_UNIT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=172) SELECT  USER_ID,CHANNEL_DETAIL, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=270) SELECT  USER_ID,UNIFI_REGISTER_COUNTRY_CODE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=271) SELECT  USER_ID,UNIFI_REGISTER_COUNTRY_NAME, 4
;

-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_3_02;

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
   WHERE TAG_ID in (39, 40, 170, 171, 172, 270, 271)
     AND USER_ID IS NOT NULL
     AND TAG_VALUE IS NOT NULL;