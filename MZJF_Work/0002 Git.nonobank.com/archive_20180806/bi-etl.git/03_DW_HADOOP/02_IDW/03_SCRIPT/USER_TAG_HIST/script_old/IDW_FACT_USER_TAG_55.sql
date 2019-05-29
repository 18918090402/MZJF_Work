set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_55_01;

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
  select USER_ID,
         case
           when NONO_TOTAL_PLAN_INVEST_CNT >= 3 and NONO_AUM > 0 and
                ((NONO_LAST_INVEST_TIME < to_date(date_sub('{T}', 90)) and
                NONO_LAST_90_DAYS_WITHDRAW_CNT > 2) or
                LAST_LOGIN_TIME < to_date(date_sub('{T}', 90)) or
                NONO_AUM < 0.3 * NONO_MAX_AUM) then
            '潜在流失'
           when NONO_LAST_INVEST_TIME < to_date(date_sub('{T}', 90)) and
                NONO_TOTAL_PLAN_INVEST_CNT >= 3 and NONO_AUM = 0 then
            '流失'
         end NONO_USER_LOST_STATUS
    from (SELECT t1.USER_ID,
                 NVL(MAX(CASE
                           WHEN TAG_ID = 73 THEN
                            CAST(TAG_VALUE AS STRING)
                         END),
                     NULL) AS NONO_LAST_INVEST_TIME,
                 NVL(MAX(CASE
                           WHEN TAG_ID = 41 THEN
                            CAST(TAG_VALUE AS STRING)
                         END),
                     NULL) AS LAST_LOGIN_TIME,
                 NVL(MAX(CASE
                           WHEN TAG_ID = 79 THEN
                            CAST(TAG_VALUE AS DECIMAL(38, 10))
                         END),
                     NULL) AS NONO_AUM,
                 NVL(MAX(CASE
                           WHEN TAG_ID = 80 THEN
                            CAST(TAG_VALUE AS DECIMAL(38, 10))
                         END),
                     NULL) AS NONO_MAX_AUM,
                 NVL(MAX(CASE
                           WHEN TAG_ID = 234 THEN
                            CAST(TAG_VALUE AS INT)
                         END),
                     NULL) AS NONO_TOTAL_PLAN_INVEST_CNT,
                 NVL(MAX(CASE
                           WHEN TAG_ID = 249 THEN
                            CAST(TAG_VALUE AS INT)
                         END),
                     NULL) AS NONO_LAST_90_DAYS_WITHDRAW_CNT
            FROM IDW.USER_TAG_HIST t1
           WHERE TAG_ID in (73, 41, 79, 80, 234, 249)
           GROUP BY t1.USER_ID) a
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=253) SELECT  USER_ID,NONO_USER_LOST_STATUS, 4
;
-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_55_02;

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

INSERT OVERWRITE TABLE IDW.USER_TAG_HIST  PARTITION(TAG_ID,HASH_PARTITION_ID)
SELECT   USER_ID       
        ,TAG_VALUE
        ,'SYS' AS DW_CREATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
        ,'SYS' AS DW_UPDATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
        ,TAG_ID
        ,CAST(PMOD(USER_ID,10) AS INT) HASH_PARTITION_ID 
FROM    IDW.USER_TAG_TMP_01  
WHERE TAG_ID = 253
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;