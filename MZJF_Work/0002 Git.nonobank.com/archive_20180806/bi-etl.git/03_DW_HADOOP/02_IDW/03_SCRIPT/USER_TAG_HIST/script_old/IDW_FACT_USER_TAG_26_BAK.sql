set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_26_01;

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
  select usi.user_id,
         if(regexp_extract(usi.edu_start_date, '^([0-9]{4}).*', 1) = '',
            null,
            CONCAT(regexp_extract(usi.edu_start_date, '^([0-9]{4}).*', 1),
                   '-09-01')) edu_start_date,
         usi.edu_graduate_date,
         CASE
           WHEN usi.education regexp '专科以下|初中|高中|中专' THEN
            '专科以下'
           WHEN usi.education regexp '专科|大专' THEN
            '专科'
           when usi.education regexp '专升本|大学本科|本科' THEN
            '本科'
           when usi.education regexp '博士|博士研究生' THEN
            '博士'
           when usi.education regexp '研究生|硕士及以上|硕士研究生' THEN
            '硕士'
           ELSE
            '(未知)'
         end mxd_education,
         usi.academy,
         usi.major,
         usi.is_graduate,
         if(usi.campus_approach = 0, null, usi.campus_approach) CAMPUS_APPROACH,
         CASE usi.campus_approach
           WHEN 1 THEN
            '网络搜索'
           WHEN 2 THEN
            '校园大使'
           WHEN 3 THEN
            '朋友介绍'
           WHEN 4 THEN
            '微博'
           WHEN 5 THEN
            '微信'
           WHEN 6 THEN
            '贴吧/论坛'
           WHEN 7 THEN
            'QQ群'
           WHEN 8 THEN
            '海报/宣传品'
           WHEN 9 THEN
            '展柜/活动'
           WHEN 10 THEN
            '其他'
           ELSE
            NULL
         END CAMPUS_APPROACH_DESC,
         usi.student_no,
         usi.campus,
         usi.family_income,
         case usi.family_income
           when 0 then
            '未设置'
           when 1 then
            '5万以下'
           when 3 then
            '10-20万'
           when 4 then
            '20万以上'
         end family_income_desc,
         ss.type SCHOOL_TYPE,
         CASE
           WHEN ss.type = '4' THEN
            '专科'
           WHEN ss.type < '4' THEN
            CONCAT(ss.type, '本')
           ELSE
            ss.type
         END SCHOOL_TYPE_DESC,
         ss.province_id SCHOOL_PROVINCE_ID,
         r1.name SCHOOL_PROVINCE_NAME,
         if(ss.city_id = 0, null, ss.city_id) SCHOOL_CITY_ID,
         r2.name SCHOOL_CITY_NAME,
         usi.address_home
    from ods.t_user_student_info_hist usi
    left join ods.t_student_school_hist ss
      on usi.academy = ss.name
    left join ods.t_region_hist r1
      on ss.province_id = r1.code
    left join ods.t_region_hist r2
      on ss.city_id = r2.code
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=132) SELECT  USER_ID,EDU_START_DATE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=133) SELECT  USER_ID,EDU_GRADUATE_DATE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=169) SELECT  USER_ID,MXD_EDUCATION, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=187) SELECT  USER_ID,ACADEMY, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=188) SELECT  USER_ID,MAJOR, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=189) SELECT  USER_ID,IS_GRADUATE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=190) SELECT  USER_ID,CAMPUS_APPROACH, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=191) SELECT  USER_ID,CAMPUS_APPROACH_DESC, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=192) SELECT  USER_ID,STUDENT_NO, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=193) SELECT  USER_ID,CAMPUS, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=194) SELECT  USER_ID,FAMILY_INCOME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=195) SELECT  USER_ID,FAMILY_INCOME_DESC, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=196) SELECT  USER_ID,SCHOOL_TYPE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=197) SELECT  USER_ID,SCHOOL_TYPE_DESC, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=198) SELECT  USER_ID,SCHOOL_PROVINCE_ID, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=199) SELECT  USER_ID,SCHOOL_PROVINCE_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=200) SELECT  USER_ID,SCHOOL_CITY_ID, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=201) SELECT  USER_ID,SCHOOL_CITY_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=220) SELECT  USER_ID,ADDRESS_HOME, 4
;


set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_26_02;

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
WHERE ((TAG_ID >=132 AND TAG_ID <=133) OR TAG_ID in (169,220) OR (TAG_ID >=187 AND TAG_ID <=201))
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;   