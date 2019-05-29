set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_23_01;

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
  select t2.nono_user_id USER_ID, t3.nono_user_id CSYY_INVITE_USER_ID
     from (select new_usercode user_code, old_usercode invite_user_code
             from ods.t_red_user_relation_hist
           union all
           select invited_user_code user_code, user_code invite_user_code
             from ods.t_invite_relations_hist) t1
     join ods.t_account_relation_hist t2
       on t1.user_code = t2.merchant_user_id
     join ods.t_account_relation_hist t3
       on t1.invite_user_code = t3.merchant_user_id
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=129) SELECT  USER_ID,CSYY_INVITE_USER_ID, 4
;


set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_23_02;

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
WHERE TAG_ID =129
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;   