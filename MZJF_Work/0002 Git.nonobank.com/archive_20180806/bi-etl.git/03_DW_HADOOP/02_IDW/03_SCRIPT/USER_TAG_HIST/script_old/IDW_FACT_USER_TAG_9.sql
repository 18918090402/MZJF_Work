set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_9_01;

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
         MAX(CASE
               WHEN ID_ASC = 1 THEN
                AUTH_TIME
             END) AS FIRST_BIND_CARD_TIME,
         MAX(CASE
               WHEN ID_ASC = 1 THEN
                BANK_CARD_NO
             END) AS FIRST_BIND_CARD_ACCOUNT,
         MAX(CASE
               WHEN ID_ASC = 1 THEN
                NAME
             END) AS FIRST_BIND_CARD_BANK,
         count(1) BINDCARD_CNT,
         MAX(CASE
               WHEN ID_DESC = 1 THEN
                AUTH_TIME
             END) AS LAST_BIND_CARD_TIME,
         MAX(CASE
               WHEN ID_DESC = 1 THEN
                BANK_CARD_NO
             END) AS LAST_BIND_CARD_ACCOUNT,
         MAX(CASE
               WHEN ID_DESC = 1 THEN
                NAME
             END) AS LAST_BIND_CARD_BANK
    from (select uba.USER_ID,
                 uba.AUTH_TIME,
                 ubi.BANK_CARD_NO,
                 b.NAME,
                 ROW_NUMBER() OVER(PARTITION BY uba.USER_ID ORDER BY uba.AUTH_TIME ASC) ID_ASC,
                 ROW_NUMBER() OVER(PARTITION BY uba.USER_ID ORDER BY uba.AUTH_TIME DESC) ID_DESC
            from odsopr.USER_BANKCARD_AUTH uba
            left join odsopr.USER_BANKCARD_INFO ubi
              on uba.BANK_CARD_ID = ubi.id
            left join odsopr.BANK b
              on ubi.BANK_CODE = cast(b.ID as string)
           where uba.AUTH_STATUS IN (1, 2, 5)) A
   group by user_id
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=57) SELECT  USER_ID,FIRST_BIND_CARD_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=58) SELECT  USER_ID,FIRST_BIND_CARD_ACCOUNT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=59) SELECT  USER_ID,FIRST_BIND_CARD_BANK, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=60) SELECT  USER_ID,BINDCARD_CNT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=61) SELECT  USER_ID,LAST_BIND_CARD_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=62) SELECT  USER_ID,LAST_BIND_CARD_ACCOUNT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=63) SELECT  USER_ID,LAST_BIND_CARD_BANK, 4
;

set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_9_02;

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
WHERE TAG_ID >=57 AND TAG_ID <=63
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;