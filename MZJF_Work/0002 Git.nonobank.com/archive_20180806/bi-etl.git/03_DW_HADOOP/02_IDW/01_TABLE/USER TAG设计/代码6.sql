-- 代码6
-- 1.将IDW.USER_TAG_TMP_02的数据比较大小后插入 IDW.USER_TAG_TMP_01

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

INSERT OVERWRITE TABLE   IDW.USER_TAG_TMP_01   PARTITION(TAG_ID) 
            SELECT A.USER_ID                   
                  ,CASE 
                        WHEN A.TAG_COVER_TYPE_IND= 0 THEN A.TAG_VALUE  
                        WHEN A.TAG_COVER_TYPE_IND= 1 THEN (CASE WHEN CAST(NVL(B.TAG_VALUE,A.TAG_VALUE) AS STRING)>=CAST(A.TAG_VALUE AS STRING) THEN A.TAG_VALUE ELSE NVL(B.TAG_VALUE,A.TAG_VALUE) END)
                        -- WHEN A.TAG_COVER_TYPE_IND= 1 THEN (CASE WHEN CAST(NVL(B.TAG_VALUE,A.TAG_VALUE) AS DECIMAL(38,10))>=CAST(A.TAG_VALUE AS DECIMAL(38,10)) THEN A.TAG_VALUE ELSE NVL(B.TAG_VALUE,A.TAG_VALUE) END)
                        WHEN A.TAG_COVER_TYPE_IND= 2 THEN (CASE WHEN CAST(NVL(B.TAG_VALUE,A.TAG_VALUE) AS STRING)>=CAST(A.TAG_VALUE AS STRING) THEN NVL(B.TAG_VALUE,A.TAG_VALUE) ELSE A.TAG_VALUE END)
                        -- WHEN A.TAG_COVER_TYPE_IND= 2 THEN (CASE WHEN CAST(NVL(B.TAG_VALUE,A.TAG_VALUE) AS DECIMAL(38,10))>=CAST(A.TAG_VALUE AS DECIMAL(38,10)) THEN NVL(B.TAG_VALUE,A.TAG_VALUE) ELSE A.TAG_VALUE END)
                        WHEN A.TAG_COVER_TYPE_IND= 3 THEN CONCAT(CONCAT(B.TAG_VALUE,'|'),A.TAG_VALUE) 
                   END  TAG_VALUE 
                  ,A.TAG_COVER_TYPE_IND
                  ,A.TAG_ID 
            FROM   
                  (SELECT * FROM IDW.USER_TAG_TMP_02 WHERE  TAG_ID  IN (   )  ) A
            LEFT   JOIN 
                  (SELECT * FROM IDW.USER_TAG_HIST   WHERE  TAG_ID  IN (   )  ) B
            ON     A.USER_ID = B.USER_ID AND A.TAG_ID = B.TAG_ID 
;

