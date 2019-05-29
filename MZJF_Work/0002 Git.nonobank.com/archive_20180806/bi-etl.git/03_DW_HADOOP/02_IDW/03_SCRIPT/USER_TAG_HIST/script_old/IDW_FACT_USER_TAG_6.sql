set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_6_01;

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
  select ui.user_id,
         coalesce(c.create_time, b.stu_auth_time) stu_auth_time,
         b.authentication_time
    from idw.user_info ui
    left join (select na.idnum,
                      max(stu_auth_time) as stu_auth_time,
                      max(card_auth_time) as authentication_time
                 from odsopr.nono_authentication_hist na
                group by idnum) b
      on ui.id_num = b.idnum
    left join idw.user_pengyuan_stu_legacy c
      on ui.user_id = c.user_id
   where ui.stat_date = '{T_SUB_1}'
     and (ui.is_authentication = 1 or ui.is_student_auth = 1)
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=45) SELECT  USER_ID,AUTHENTICATION_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=134) SELECT  USER_ID,STU_AUTH_TIME, 4
;

-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_6_02;

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

INSERT OVERWRITE TABLE IDW.USER_TAG_HIST PARTITION
  (TAG_ID, HASH_PARTITION_ID)
  SELECT USER_ID,
         TAG_VALUE,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         TAG_ID,
         CAST(PMOD(USER_ID, 10) AS INT) HASH_PARTITION_ID
    FROM IDW.USER_TAG_TMP_01
   WHERE TAG_ID in (45,134)
     AND USER_ID IS NOT NULL
     AND TAG_VALUE IS NOT NULL; 