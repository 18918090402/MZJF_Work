--1
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_24_01;

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
    select 
        s.user_id,
        max(case when s.time_asc = 1 then s.recharge_time end) CSYY_FIRST_RECHARGE_TIME,
        max(case when s.time_asc = 1 then s.recharge_amt  end) CSYY_FIRST_RECHARGE_AMT,
        max(case when s.time_asc = 1 then s.bank_name     end) CSYY_FIRST_RECHARGE_BANK,
        max(case when s.time_asc = 1 then s.recharge_type end) CSYY_FIRST_RECHARGE_TYPE,
        max(case when s.time_desc = 1 then s.recharge_time end) CSYY_LAST_RECHARGE_TIME,
        max(case when s.time_desc = 1 then s.recharge_amt  end) CSYY_LAST_RECHARGE_AMT,
        max(case when s.time_desc = 1 then s.bank_name     end) CSYY_LAST_RECHARGE_BANK,
        max(case when s.time_desc = 1 then s.recharge_type end) CSYY_LAST_RECHARGE_TYPE
    from 
    (
        select
            user_id,
            recharge_time,
            recharge_amt,
            bank_name,
            case pay_type
                when 1 then '易联'
                when 2 then '快钱'
                when 3 then '钱方'
                when 4 then '连连'
                when 5 then '宝付'
                when 6 then '盛付通'
                when 7 then '微信直连'
                when 8 then '微商存管'
                else cast(pay_type as string)
            end recharge_type,
            row_number() over(partition by user_id order by recharge_time asc) time_asc,
            row_number() over(partition by user_id order by recharge_time desc) time_desc
        from idw.fact_biz_csyy_recharge
    ) s
    group by s.user_id
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=120) SELECT USER_ID, CSYY_FIRST_RECHARGE_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=121) SELECT USER_ID, CSYY_FIRST_RECHARGE_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=122) SELECT USER_ID, CSYY_FIRST_RECHARGE_BANK, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=123) SELECT USER_ID, CSYY_FIRST_RECHARGE_TYPE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=124) SELECT USER_ID, CSYY_LAST_RECHARGE_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=125) SELECT USER_ID, CSYY_LAST_RECHARGE_AMT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=126) SELECT USER_ID, CSYY_LAST_RECHARGE_BANK, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=127) SELECT USER_ID, CSYY_LAST_RECHARGE_TYPE, 4
;


--2
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_24_02;

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
WHERE TAG_ID in (120,121,122,123,124,125,126,127)
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
;
  
--3
invalidate metadata IDW.USER_TAG_HIST
