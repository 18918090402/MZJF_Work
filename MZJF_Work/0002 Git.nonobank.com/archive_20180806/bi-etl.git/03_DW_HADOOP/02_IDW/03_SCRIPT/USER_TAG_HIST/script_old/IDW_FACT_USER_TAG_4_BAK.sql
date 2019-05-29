
  -- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_4_01;

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
         max(lower(terminal)) AS REGISTER_TERMINAL,
         max(REGISTER_IP) REGISTER_IP
    FROM (SELECT USER_ID,
                 CASE
                   WHEN terminal IN ('0', '11', 'pc') THEN
                    'pc'
                   WHEN terminal IN ('1', '13', '15', '17', '5', '31') THEN
                    'android'
                   WHEN terminal IN ('12', '14', '16', '2', '4', 'app', '30') THEN
                    'ios'
                   WHEN terminal IN ('6') THEN
                    'ipad'
                   WHEN terminal IN ('7') THEN
                    'weixin'
                   WHEN terminal IN ('3', '10') THEN
                    'weizhan'
                   ELSE
                    terminal
                 END terminal,
                 ip REGISTER_IP
            FROM ODS.T_USER_ACTION_LOG_HIST
           WHERE ACTION_TYPE = 7
          union all
          select user_id, client_type terminal, ip REGISTER_IP
            from ods.t_user_register_detail_log_hist
           where register_status = '0000000') A
   group by USER_ID
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=42) SELECT  USER_ID,REGISTER_TERMINAL, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=209) SELECT  USER_ID,REGISTER_IP, 4
;

-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_4_02;

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
WHERE TAG_ID in (42,209)
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ; 