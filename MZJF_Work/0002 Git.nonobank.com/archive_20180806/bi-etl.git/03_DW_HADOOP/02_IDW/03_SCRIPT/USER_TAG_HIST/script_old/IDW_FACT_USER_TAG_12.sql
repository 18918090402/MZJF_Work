set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_12_01;

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
  select coalesce(t1.USER_ID, t2.user_id) USER_ID,
         coalesce(t1.NONO_AUM, 0) NONO_AUM,
         case
           when coalesce(t2.NONO_MAX_AUM, t1.NONO_AUM, 0) >=
                coalesce(t1.NONO_AUM, 0) then
            coalesce(t2.NONO_MAX_AUM, t1.NONO_AUM, 0)
           else
            coalesce(t1.NONO_AUM, 0)
         end NONO_MAX_AUM,
         case
           when coalesce(t2.NONO_MAX_AUM, t1.NONO_AUM, 0) >=
                coalesce(t1.NONO_AUM, 0) then
            coalesce(t2.NONO_MAX_AUM_DATE, t1.stat_date)
           else
            t1.stat_date
         end NONO_MAX_AUM_DATE,
         coalesce(t1.NONO_IN_INVEST_AMT, 0) NONO_IN_INVEST_AMT,
         case
           when coalesce(t2.NONO_MAX_IN_INVEST_AMT, t1.NONO_IN_INVEST_AMT, 0) >=
                coalesce(t1.NONO_IN_INVEST_AMT, 0) then
            coalesce(t2.NONO_MAX_IN_INVEST_AMT, t1.NONO_IN_INVEST_AMT, 0)
           else
            coalesce(t1.NONO_IN_INVEST_AMT, 0)
         end NONO_MAX_IN_INVEST_AMT,
         case
           when coalesce(t2.NONO_MAX_IN_INVEST_AMT, t1.NONO_IN_INVEST_AMT, 0) >=
                coalesce(t1.NONO_IN_INVEST_AMT, 0) then
            coalesce(t2.NONO_MAX_IN_INVEST_AMT_DATE, t1.stat_date)
           else
            t1.stat_date
         end NONO_MAX_IN_INVEST_AMT_DATE
    from (SELECT USER_ID,
                 sum(AUM) NONO_AUM,
                 sum(IN_INVEST_AMT) NONO_IN_INVEST_AMT,
                 stat_date
            FROM IDW.FACT_BIZ_NONO_AUM
           WHERE stat_date = '{T_SUB_1}'
           group by USER_ID, stat_date) t1
    full outer join (select user_id,
                            MAX(CASE
                                  WHEN TAG_ID = 80 THEN
                                   CAST(TAG_VALUE AS DECIMAL(38, 10))
                                END) NONO_MAX_AUM,
                            MAX(CASE
                                  WHEN TAG_ID = 81 THEN
                                   CAST(TAG_VALUE AS STRING)
                                END) NONO_MAX_AUM_DATE,
                            MAX(CASE
                                  WHEN TAG_ID = 238 THEN
                                   CAST(TAG_VALUE AS DECIMAL(38, 10))
                                END) NONO_MAX_IN_INVEST_AMT,
                            MAX(CASE
                                  WHEN TAG_ID = 239 THEN
                                   CAST(TAG_VALUE AS STRING)
                                END) NONO_MAX_IN_INVEST_AMT_DATE
                       from IDW.USER_TAG_HIST
                      where tag_id in (80, 81, 238, 239)
                      group by user_id) t2
      on t1.USER_ID = t2.USER_ID
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=79) SELECT  USER_ID,NONO_AUM, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=80) SELECT  USER_ID,NONO_MAX_AUM, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=81) SELECT  USER_ID,NONO_MAX_AUM_DATE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=237) SELECT  USER_ID,NONO_IN_INVEST_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=238) SELECT  USER_ID,NONO_MAX_IN_INVEST_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=239) SELECT  USER_ID,NONO_MAX_IN_INVEST_AMT_DATE, 4
;

set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_12_02;

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
WHERE ((TAG_ID >=79 AND TAG_ID <=81) OR (TAG_ID >=237 AND TAG_ID <=239))
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;   