set mapreduce.job.name=DMT_RM_FACT_USER_CONTACT_03; 
set mapreduce.job.queuename = etl-dw;  

set hive.exec.parallel=true ;
set hive.map.aggr = true ; 

set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict; 
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

INSERT OVERWRITE DMT_RM.FACT_USER_CONTACT
SELECT 
a.user_id,
a.PHONE_COUNSELLOR_NO_FLAG,
a.PHONE_PARENTS_NO_FLAG,
a.PHONE_CONTACT1_NO_FLAG,  
a.PHONE_CONTACT2_NO_FLAG,
a.PHONE_CONTACT3_NO_FLAG,   
a.PHONE_NO_CNT,
b.BO_USER_CNT,
b.BO_CNT,
b.BO_S_CNT,
b.BO_OVER_DUE_CNT
    ,'SYS' AS DW_CREATE_BY
    ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
    ,'SYS' AS DW_UPDATE_BY
    ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
FROM 
TMP.DMT_RM_FACT_USER_CONTACT_01 A
LEFT JOIN 
TMP.DMT_RM_FACT_USER_CONTACT_02 B
ON A.USER_ID=B.USER_ID
;

DROP TABLE IF EXISTS TMP.DMT_RM_FACT_USER_CONTACT_01;
DROP TABLE IF EXISTS TMP.DMT_RM_FACT_USER_CONTACT_02;
