-- 代码5
-- 1.将数据 列转行 插入 IDW.USER_TAG_TMP_02
set mapreduce.job.name=TASK_NAME_XX;

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
    SELECT USER_ID
           ,SUM(A) A
           ,SUM(B) B
    FROM ODSOPR.AAA
    WHERE UPDATE_TIME>='1900-01-01'
    GROUP BY USER_ID
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_02 PARTITION(TAG_ID=1)SELECT  USER_ID,A, 1
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_02 PARTITION(TAG_ID=2)SELECT  USER_ID,B, 2
;