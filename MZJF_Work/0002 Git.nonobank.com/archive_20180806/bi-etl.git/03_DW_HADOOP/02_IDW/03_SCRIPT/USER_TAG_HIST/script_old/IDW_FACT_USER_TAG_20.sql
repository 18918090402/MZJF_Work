set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_20_01;

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
  SELECT USER_ID,
         cash_time       AS CSYY_LAST_CASH_TIME,
         price_principal AS CSYY_LAST_CASH_PRINCIPAL_AMT,
         price_amt       AS CSYY_LAST_CASH_AMT,
         product_code    AS CSYY_LAST_CASH_PRODUCT_CODE
    FROM (select user_id,
                 PRODUCT_CATEGORY product_code,
                 ACTUAL_CASH_TIME cash_time,
                 price_principal,
                 price_amt,
                 ROW_NUMBER() OVER(PARTITION BY USER_ID ORDER BY ACTUAL_CASH_TIME DESC) ID_DESC
            from idw.FACT_BIZ_CSYY_INVEST_CASH
           WHERE CASH_STATUS = 1) A
   WHERE ID_DESC = 1
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=111) SELECT  USER_ID,CSYY_LAST_CASH_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=112) SELECT  USER_ID,CSYY_LAST_CASH_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=113) SELECT  USER_ID,CSYY_LAST_CASH_PRODUCT_CODE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=118) SELECT  USER_ID,CSYY_LAST_CASH_PRINCIPAL_AMT, 4
;
-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_20_02;

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
WHERE ((TAG_ID >=111 AND TAG_ID <=113) OR TAG_ID =118)
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;   
