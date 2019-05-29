set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_27_01;

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
  select ui.user_id,
         coalesce(b.auth_time, c.create_time) edu_auth_time,
         coalesce(b.degree, c.degree) edu_education,
         coalesce(b.graduate_date, c.graduatetime) edu_graduate_time
    from idw.user_info ui
    left join (select t1.user_id, t2.degree, t2.auth_time, t2.graduate_date
                 from odsopr.user_loan_auth_info_hist t1
                 join odsopr.user_edu_auth_log_hist t2
                   on t1.auth_code = 1
                  and t1.auth_id = t2.id) b
      on ui.user_id = b.user_id
    left join idw.user_pengyuan_edu_legacy c
      on ui.user_id = c.user_id
   where ui.stat_date = '{T_SUB_1}'
     and coalesce(b.user_id, c.user_id) is not null
) OUTPUT
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=135) select  user_id,edu_auth_time, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=297) select  user_id,edu_education, 4
insert overwrite table idw.user_tag_tmp_01 partition(tag_id=298) select  user_id,edu_graduate_time, 4
;


set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_27_02;

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
   WHERE TAG_ID in (135, 297, 298)
     AND USER_ID IS NOT NULL
     AND TAG_VALUE IS NOT NULL;   