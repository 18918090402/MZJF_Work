-- 代码4
-- 1.将数据 全量 插入 IDW.USER_TAG_HIST
set mapreduce.job.name=TASK_NAME_XX;

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

INSERT OVERWRITE TABLE   IDW.USER_TAG_HIST   PARTITION(TAG_ID,HASH_PARTITION_ID)
SELECT  USER_ID       
       ,TAG_VALUE
       ,'SYS' AS DW_CREATE_BY
       ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
       ,'SYS' AS DW_UPDATE_BY
       ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
       ,TAG_ID
       ,CAST(PMOD(USER_ID,10) AS INT) HASH_PARTITION_ID 
FROM   IDW.USER_TAG_TMP_01  
WHERE TAG_ID    IN (    ) 
 AND  USER_ID   IS NOT NULL 
 AND  TAG_VALUE IS NOT NULL
 
UNION ALL

SELECT  T1.USER_ID       
       ,T1.TAG_VALUE                
       ,T1.DW_CREATE_BY
       ,T1.DW_CREATE_TIME
       ,T1.DW_UPDATE_BY
       ,T1.DW_UPDATE_TIME
       ,T1.TAG_ID
       ,T1.HASH_PARTITION_ID
FROM 
        ( SELECT * FROM   IDW.USER_TAG_HIST       WHERE TAG_ID  IN (    ) ) T1
LEFT JOIN 
        ( SELECT * FROM   IDW.USER_TAG_TMP_01     WHERE TAG_ID  IN (    ) ) T2
ON       T1.USER_ID = T2.USER_ID AND T1.TAG_ID = T2.TAG_ID
WHERE T2.TAG_ID IS NULL AND T2.USER_ID IS NULL;
