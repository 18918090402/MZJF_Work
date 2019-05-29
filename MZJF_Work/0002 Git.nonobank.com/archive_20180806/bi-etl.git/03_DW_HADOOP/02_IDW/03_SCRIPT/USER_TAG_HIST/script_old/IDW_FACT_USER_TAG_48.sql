set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_48_01;

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
  select user_id,
         MAIYA_SALARY,
         MAIYA_WORK_POSITION,
         MAIYA_WORK_POSITION_NAME,
         MAIYA_USER_NAME,
         MAIYA_REAL_NAME,
         MAIYA_MOBILE_NUM,
         MAIYA_FAMILY_USER,
         MAIYA_FAMILY_USER_MOBILE,
         MAIYA_REGISTER_PROVINCE_CODE,
         MAIYA_REGISTER_CITY_CODE,
         MAIYA_REGISTER_PROVINCE_NAME,
         MAIYA_REGISTER_CITY_NAME,
         MAIYA_COMPANY_NAME,
         MAIYA_ID_NUM,
         MAIYA_GENDER,
         MAIYA_EDUCATION,
         MAIYA_EMAIL,
         MAIYA_USER_SOURCE,
         MAIYA_WORK_TYPE,
         MAIYA_IS_QIZHA,
         ms.city MAIYA_MOBILE_ADDRESS
    from (select ou.nonobank_userid user_id,
                 ou.salary MAIYA_SALARY,
                 if(oud.work_position = 0, null, oud.work_position) MAIYA_WORK_POSITION,
                 sdi1.dic_item_name MAIYA_WORK_POSITION_NAME,
                 ou.username MAIYA_USER_NAME,
                 oud.name MAIYA_REAL_NAME,
                 ou.mobile MAIYA_MOBILE_NUM,
                 oud.family_user MAIYA_FAMILY_USER,
                 oud.family_user_mobile MAIYA_FAMILY_USER_MOBILE,
                 oud.province_code MAIYA_REGISTER_PROVINCE_CODE,
                 oud.city_code MAIYA_REGISTER_CITY_CODE,
                 r1.name MAIYA_REGISTER_PROVINCE_NAME,
                 r2.name MAIYA_REGISTER_CITY_NAME,
                 oud.company_name MAIYA_COMPANY_NAME,
                 oud.idcard MAIYA_ID_NUM,
                 oud.sex MAIYA_GENDER,
                 sdi2.dic_item_name MAIYA_EDUCATION,
                 oud.email MAIYA_EMAIL,
                 oud.use_source MAIYA_USER_SOURCE,
                 sdi3.dic_item_name MAIYA_WORK_TYPE,
                 ou.is_qizha MAIYA_IS_QIZHA,
                 row_number() over(partition by ou.nonobank_userid order by oud.id desc) rn
            from odsopr.ORD_USER ou
            left join odsopr.ORD_USER_DETAIL oud
              on ou.id = oud.user_id
             and oud.disabled = 0
            LEFT JOIN ods.t_region_hist r1
              on oud.province_code = cast(r1.code as string)
            LEFT JOIN ods.t_region_hist r2
              on oud.city_code = cast(r2.code as string)
            left join ods.t_sys_dic_item_hist sdi1
              on cast(oud.work_position as string) = sdi1.dic_item_value
             and sdi1.disabled = 0
             and sdi1.dic_id = 5
            left join ods.t_sys_dic_item_hist sdi2
              on sdi2.dic_id = 20
             AND sdi2.disabled = 0
             AND cast(oud.academic as string) = sdi2.dic_item_value
            left join ods.t_sys_dic_item_hist sdi3
              on sdi3.dic_id = 4
             AND sdi3.disabled = 0
             AND cast(oud.work_type as string) = sdi3.dic_item_value
           where ou.disabled = 0) t
    left join ods.t_mobile_site_hist ms
      on SUBSTRING(t.MAIYA_MOBILE_NUM, 1, 7) = CAST(ms.phone AS string)
   where rn = 1
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=211) SELECT  USER_ID,MAIYA_SALARY, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=212) SELECT  USER_ID,MAIYA_COMPANY_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=213) SELECT  USER_ID,MAIYA_WORK_POSITION, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=214) SELECT  USER_ID,MAIYA_WORK_POSITION_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=215) SELECT  USER_ID,MAIYA_FAMILY_USER, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=216) SELECT  USER_ID,MAIYA_FAMILY_USER_MOBILE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=254) SELECT  USER_ID,MAIYA_USER_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=255) SELECT  USER_ID,MAIYA_REAL_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=256) SELECT  USER_ID,MAIYA_MOBILE_NUM, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=257) SELECT  USER_ID,MAIYA_REGISTER_PROVINCE_CODE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=258) SELECT  USER_ID,MAIYA_REGISTER_CITY_CODE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=259) SELECT  USER_ID,MAIYA_REGISTER_PROVINCE_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=260) SELECT  USER_ID,MAIYA_REGISTER_CITY_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=279) SELECT  USER_ID,MAIYA_ID_NUM, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=280) SELECT  USER_ID,MAIYA_GENDER, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=281) SELECT  USER_ID,MAIYA_EDUCATION, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=282) SELECT  USER_ID,MAIYA_EMAIL, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=283) SELECT  USER_ID,MAIYA_USER_SOURCE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=284) SELECT  USER_ID,MAIYA_WORK_TYPE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=285) SELECT  USER_ID,MAIYA_IS_QIZHA, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=286) SELECT  USER_ID,MAIYA_MOBILE_ADDRESS, 4
;
-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_48_02;

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
WHERE ((TAG_ID >=211 AND TAG_ID <=216) OR (TAG_ID >=254 AND TAG_ID <=260) OR (TAG_ID >=279 AND TAG_ID <=286))
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;