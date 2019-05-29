set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_19_01;

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
  SELECT USER_ID,
         MAX(CASE
               WHEN ID_ASC = 1 THEN
                INVEST_TIME
             END) AS CSYY_FIRST_INVEST_TIME,
         MAX(CASE
               WHEN ID_ASC = 1 THEN
                INVEST_AMT
             END) AS CSYY_FIRST_INVEST_AMT,
         MAX(CASE
               WHEN ID_ASC = 1 THEN
                INVEST_AMT_YEARLY
             END) AS CSYY_FIRST_INVEST_AMT_YEARLY,
         MAX(CASE
               WHEN ID_ASC = 1 THEN
                PRODUCT_CODE
             END) AS CSYY_FIRST_INVEST_PRODUCT_CODE,
         MAX(CASE
               WHEN ID_ASC = 1 THEN
                EXPECT
             END) AS CSYY_FIRST_INVEST_EXPECT,
         MAX(CASE
               WHEN ID_ASC = 2 THEN
                INVEST_TIME
             END) AS CSYY_SECOND_INVEST_TIME,
         MAX(CASE
               WHEN ID_ASC = 2 THEN
                INVEST_AMT
             END) AS CSYY_SECOND_INVEST_AMT,
         MAX(CASE
               WHEN ID_ASC = 2 THEN
                INVEST_AMT_YEARLY
             END) AS CSYY_SECOND_INVEST_AMT_YEARLY,
         MAX(CASE
               WHEN ID_ASC = 2 THEN
                PRODUCT_CODE
             END) AS CSYY_SECOND_INVEST_PRODUCT_CODE,
         MAX(CASE
               WHEN ID_ASC = 2 THEN
                EXPECT
             END) AS CSYY_SECOND_INVEST_EXPECT,
         MAX(CASE
               WHEN ID_ASC = 3 THEN
                INVEST_TIME
             END) AS CSYY_THIRD_INVEST_TIME,
         MAX(CASE
               WHEN ID_ASC = 3 THEN
                INVEST_AMT
             END) AS CSYY_THIRD_INVEST_AMT,
         MAX(CASE
               WHEN ID_ASC = 3 THEN
                INVEST_AMT_YEARLY
             END) AS CSYY_THIRD_INVEST_AMT_YEARLY,
         MAX(CASE
               WHEN ID_ASC = 3 THEN
                PRODUCT_CODE
             END) AS CSYY_THIRD_INVEST_PRODUCT_CODE,
         MAX(CASE
               WHEN ID_ASC = 3 THEN
                EXPECT
             END) AS CSYY_THIRD_INVEST_EXPECT,
         MAX(CASE
               WHEN ID_DESC = 1 THEN
                INVEST_TIME
             END) AS CSYY_LAST_INVEST_TIME,
         MAX(CASE
               WHEN ID_DESC = 1 THEN
                INVEST_AMT
             END) AS CSYY_LAST_INVEST_AMT,
         MAX(CASE
               WHEN ID_DESC = 1 THEN
                INVEST_AMT_YEARLY
             END) AS CSYY_LAST_INVEST_AMT_YEARLY,
         MAX(CASE
               WHEN ID_DESC = 1 THEN
                PRODUCT_CODE
             END) AS CSYY_LAST_INVEST_PRODUCT_CODE,
         MAX(CASE
               WHEN ID_DESC = 1 THEN
                EXPECT
             END) AS CSYY_LAST_INVEST_EXPECT,
         SUM(CASE
               WHEN INVEST_TIME >= date_sub(current_date(), 30) THEN
                1
               ELSE
                0
             END) AS CSYY_LAST_30_DAYS_INVEST_CNT,
         COUNT(1) AS CSYY_INVEST_CNT,
         sum(invest_amt) CSYY_TOTAL_INVEST_AMT,
         sum(invest_amt_yearly) CSYY_TOTAL_INVEST_AMT_YEARLY
    from (select user_id,
                 PRODUCT_CATEGORY PRODUCT_CODE,
                 invest_time,
                 invest_amt,
                 lock_end_time,
                 case expect_unit_code
                   when 1 then
                    concat(cast(expect as string), '日')
                   when 2 then
                    concat(cast(expect as string), '月')
                   when 3 then
                    concat(cast(expect as string), '年')
                   else
                    'NA'
                 end EXPECT,
                 INVEST_AMT_YEARLY,
                 INVEST_NUM ID_ASC,
                 ROW_NUMBER() OVER(PARTITION BY USER_ID ORDER BY INVEST_TIME DESC) ID_DESC
            from IDW.FACT_BIZ_CSYY_INVEST
           where user_id is not null) a
   GROUP BY USER_ID
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=97) SELECT  USER_ID,CSYY_FIRST_INVEST_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=98) SELECT  USER_ID,CSYY_FIRST_INVEST_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=99) SELECT  USER_ID,CSYY_FIRST_INVEST_PRODUCT_CODE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=100) SELECT  USER_ID,CSYY_SECOND_INVEST_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=101) SELECT  USER_ID,CSYY_SECOND_INVEST_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=102) SELECT  USER_ID,CSYY_SECOND_INVEST_PRODUCT_CODE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=103) SELECT  USER_ID,CSYY_THIRD_INVEST_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=104) SELECT  USER_ID,CSYY_THIRD_INVEST_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=105) SELECT  USER_ID,CSYY_THIRD_INVEST_PRODUCT_CODE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=106) SELECT  USER_ID,CSYY_LAST_INVEST_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=107) SELECT  USER_ID,CSYY_LAST_INVEST_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=108) SELECT  USER_ID,CSYY_LAST_INVEST_PRODUCT_CODE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=109) SELECT  USER_ID,CSYY_LAST_30_DAYS_INVEST_CNT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=110) SELECT  USER_ID,CSYY_INVEST_CNT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=184) SELECT  USER_ID,CSYY_TOTAL_INVEST_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=240) SELECT  USER_ID,CSYY_FIRST_INVEST_AMT_YEARLY, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=241) SELECT  USER_ID,CSYY_FIRST_INVEST_EXPECT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=242) SELECT  USER_ID,CSYY_SECOND_INVEST_AMT_YEARLY, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=243) SELECT  USER_ID,CSYY_SECOND_INVEST_EXPECT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=244) SELECT  USER_ID,CSYY_THIRD_INVEST_AMT_YEARLY, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=245) SELECT  USER_ID,CSYY_THIRD_INVEST_EXPECT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=246) SELECT  USER_ID,CSYY_LAST_INVEST_AMT_YEARLY, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=247) SELECT  USER_ID,CSYY_LAST_INVEST_EXPECT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=248) SELECT  USER_ID,CSYY_TOTAL_INVEST_AMT_YEARLY, 4
;
-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_19_02;

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
WHERE ((TAG_ID >=97 AND TAG_ID <=110) OR TAG_ID in (184) OR (TAG_ID >=240 AND TAG_ID <=248))
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;   