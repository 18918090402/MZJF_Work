set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_11_01;

set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;

set hive.exec.parallel=true;
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

FROM 
(
   SELECT USER_ID,
         actual_cash_time AS NONO_LAST_CASH_TIME,
         price_principal  AS NONO_LAST_CASH_PRINCIPAL_AMT,
         CASH_AMT         AS NONO_LAST_CASH_AMT,
         P_SCOPE          AS NONO_LAST_CASH_PRODUCT_SCOPE,
         FP_ID            AS NONO_LAST_CASH_FP_ID
    FROM (SELECT A.USER_ID,
                 A.actual_cash_time,
                 A.PRICE_PRINCIPAL,
                 A.price_amt as CASH_AMT,
                 A.fp_id,
                 A.PRODUCT_CATEGORY P_SCOPE,
                 ROW_NUMBER() OVER(PARTITION BY USER_ID ORDER BY actual_cash_time DESC) ID_DESC
            FROM IDW.FACT_BIZ_NONO_INVEST_CASH AS A
           WHERE A.CASH_STATUS = 1) AS A
   WHERE ID_DESC = 1
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=76) SELECT  USER_ID,NONO_LAST_CASH_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=77) SELECT  USER_ID,NONO_LAST_CASH_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=78) SELECT  USER_ID,NONO_LAST_CASH_PRODUCT_SCOPE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=119) SELECT  USER_ID,NONO_LAST_CASH_PRINCIPAL_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=219) SELECT  USER_ID,NONO_LAST_CASH_FP_ID, 4
;
-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_11_02;

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
WHERE ((TAG_ID >=76 AND TAG_ID <=78) OR TAG_ID IN (119,219))
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;   
