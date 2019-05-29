set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_1_01;

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
  select USER_KEY,
         USER_ID,
         case
           when user_name not like '%&%' then
            user_name
         end USER_NAME,
         REAL_NAME,
         GENDER,
         MOBILE_NUM,
         EMAIL,
         IS_EMAIL,
         REGISTER_TIME,
         IS_AUTHENTICATION,
         IS_PHOTO,
         IS_EDUCATION_AUTH,
         IS_STUDENT_AUTH,
         IS_SPECIAL,
         IS_CHEAT,
         STATUS,
         STATUS_DESC,
         PC_ID,
         PC_ID_DESC,
         RECOMMENDER_ID,
         USER_TYPE,
         if(length(id_num) = 15 or length(id_num) = 18, id_num, null) ID_NUM,
         if(length(id_num) = 15 or length(id_num) = 18, C.COU_ADDRESS, null) COU_ADDRESS,
         FINANCE_ADVISOR,
         from_unixtime(unix_timestamp(case
                                        when length(id_num) = 15 then
                                         concat('19', substr(id_num, 7, 6))
                                        when length(id_num) = 18 then
                                         substr(id_num, 7, 8)
                                      end,
                                      'yyyyMMdd'),
                       'yyyy-MM-dd') BIRTHDAY,
         ms.city MOBILE_ADDRESS,
         REGISTER_BIZ
    from (SELECT A.ID AS USER_KEY,
                 A.ID AS USER_ID,
                 A.USER_NAME AS USER_NAME,
                 A.REAL_NAME AS REAL_NAME,
                 A.GENDER AS GENDER,
                 A.MOBILE_NUM AS MOBILE_NUM,
                 A.EMAIL AS EMAIL,
                 A.IS_EMAIL AS IS_EMAIL,
                 A.REGISTER_TIME AS REGISTER_TIME,
                 A.IS_CARD AS IS_AUTHENTICATION,
                 A.IS_PHOTO AS IS_PHOTO,
                 A.IS_EDUCATION AS IS_EDUCATION_AUTH,
                 A.IS_STUDENT AS IS_STUDENT_AUTH,
                 A.IS_SPECIAL AS IS_SPECIAL,
                 A.IS_CHEAT AS IS_CHEAT,
                 A.STATUS AS STATUS,
                 CASE
                   WHEN A.STATUS = 0 THEN
                    '无效用户'
                   WHEN A.STATUS = 1 THEN
                    '有效用户'
                   WHEN A.STATUS = 2 THEN
                    '锁定用户'
                 END AS STATUS_DESC,
                 A.PC_ID AS PC_ID,
                 B.COMP_NAME AS PC_ID_DESC,
                 A.RECOMMENDER AS RECOMMENDER_ID,
                 A.USER_TYPE,
                 regexp_extract(regexp_replace(id_num, ' ', ''),
                                '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$',
                                1) ID_NUM,
                 A.FINANCE_ADVISOR AS FINANCE_ADVISOR,
                 A.BIZ_CODE REGISTER_BIZ
            FROM ODS.T_USER_INFO_HIST A
            LEFT JOIN ODS.T_PLATFORM_COMPANY_HIST B
              ON A.PC_ID = B.ID) ui
    LEFT JOIN ods.t_county_idnum_list_hist C
      ON id_num = cast(C.cou_idnum_part as string)
    left join odsopr.mobile_site ms
      on SUBSTRING(ui.MOBILE_NUM, 1, 7) = CAST(ms.phone AS string)
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=2) SELECT  USER_ID,USER_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=3) SELECT  USER_ID,REAL_NAME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=4) SELECT  USER_ID,GENDER, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=5) SELECT  USER_ID,MOBILE_NUM, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=6) SELECT  USER_ID,EMAIL, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=7) SELECT  USER_ID,IS_EMAIL, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=8) SELECT  USER_ID,REGISTER_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=9) SELECT  USER_ID,IS_AUTHENTICATION, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=10)SELECT  USER_ID,IS_PHOTO, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=11)SELECT  USER_ID,IS_EDUCATION_AUTH, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=12)SELECT  USER_ID,IS_STUDENT_AUTH, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=13)SELECT  USER_ID,IS_SPECIAL, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=14)SELECT  USER_ID,IS_CHEAT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=15)SELECT  USER_ID,STATUS, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=16)SELECT  USER_ID,STATUS_DESC, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=17)SELECT  USER_ID,PC_ID, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=18)SELECT  USER_ID,PC_ID_DESC, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=46)SELECT  USER_ID,RECOMMENDER_ID, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=83)SELECT  USER_ID,USER_TYPE, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=130)SELECT  USER_ID,ID_NUM, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=168)SELECT  USER_ID,COU_ADDRESS, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=186)SELECT  USER_ID,FINANCE_ADVISOR, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=20)SELECT  USER_ID,BIRTHDAY, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=223)SELECT  USER_ID,MOBILE_ADDRESS, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=185) SELECT  USER_ID,REGISTER_BIZ, 4
;
-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_1_02;

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
   WHERE ((TAG_ID >= 2 AND TAG_ID <= 18) OR
         TAG_ID in (20, 46, 83, 130, 168, 186, 223, 185))
     AND USER_ID IS NOT NULL
     AND TAG_VALUE IS NOT NULL;
