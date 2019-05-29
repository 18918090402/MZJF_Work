set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_DIM_REGION;

set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;


INSERT OVERWRITE TABLE IDW.DIM_REGION
SELECT CODE AS KEY
    ,CODE AS REGION_ID
    ,NAME AS REGION_NAME
    ,LEVEL AS REGION_LEVEL
    ,PARENT_CODE AS PARENT_ID
    ,CREATE_TIME
    ,UPDATE_TIME
    ,'SYS' AS DW_CREATE_BY
    ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
    ,'SYS' AS DW_UPDATE_BY
    ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
FROM ODS.T_REGION_HIST;