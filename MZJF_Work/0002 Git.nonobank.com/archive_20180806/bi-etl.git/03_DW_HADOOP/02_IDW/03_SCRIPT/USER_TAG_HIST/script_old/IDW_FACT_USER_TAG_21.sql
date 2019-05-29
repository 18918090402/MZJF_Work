set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_21_01;

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
  select coalesce(t1.USER_ID, t2.user_id) USER_ID,
         coalesce(t1.CSYY_AUM, 0) CSYY_AUM,
         case
           when coalesce(t2.CSYY_MAX_AUM, t1.CSYY_AUM, 0) >=
                coalesce(t1.CSYY_AUM, 0) then
            coalesce(t2.CSYY_MAX_AUM, t1.CSYY_AUM, 0)
           else
            coalesce(t1.CSYY_AUM, 0)
         end CSYY_MAX_AUM,
         case
           when coalesce(t2.CSYY_MAX_AUM, t1.CSYY_AUM, 0) >=
                coalesce(t1.CSYY_AUM, 0) then
            coalesce(t2.CSYY_MAX_AUM_DATE, t1.stat_date)
           else
            t1.stat_date
         end CSYY_MAX_AUM_DATE
    from (SELECT USER_ID, sum(AUM) CSYY_AUM, stat_date
            FROM IDW.FACT_BIZ_CSYY_AUM
           WHERE stat_date = '{T_SUB_1}'
           group by USER_ID, stat_date) t1
    full outer join (select user_id,
                            MAX(CASE
                                  WHEN TAG_ID = 115 THEN
                                   CAST(TAG_VALUE AS DECIMAL(38, 10))
                                END) CSYY_MAX_AUM,
                            MAX(CASE
                                  WHEN TAG_ID = 116 THEN
                                   CAST(TAG_VALUE AS STRING)
                                END) CSYY_MAX_AUM_DATE
                       from IDW.USER_TAG_HIST
                      where tag_id in (115, 116)
                      group by user_id) t2
      on t1.USER_ID = t2.USER_ID
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=114) SELECT  USER_ID,CSYY_AUM, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=115) SELECT  USER_ID,CSYY_MAX_AUM, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=116) SELECT  USER_ID,CSYY_MAX_AUM_DATE, 4
;

set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_21_02;

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
WHERE TAG_ID >=114 AND TAG_ID <=116
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;   