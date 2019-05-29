set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_DIM_USER_CONTACT_LIST;

set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;


INSERT OVERWRITE TABLE IDW.DIM_USER_CONTACT_LIST
SELECT user_id,
         Contacts_name,
         regexp_replace(phone_no,
         '000',
    CASE
    WHEN SUBSTR(phone_no,1,3)='000' and length(phone_no)>11 THEN
    ''
    ELSE '000'
    END ) phone_no
    ,'SYS' AS DW_CREATE_BY
    ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
    ,'SYS' AS DW_UPDATE_BY
    ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM (
    SELECT user_id,
             Contacts_name,
             regexp_replace(phone_no,
             '86',
        CASE
        WHEN SUBSTR(phone_no,1,2)='86' and length(phone_no)>11 THEN
        ''
        ELSE '86'
        END ) phone_no
    FROM 
      (SELECT user_id,
             Contacts_name,
             regexp_replace(phone_no,
             '17951',
          CASE
          WHEN SUBSTR(phone_no,1,5)='17951' THEN
          ''
          ELSE '17951'
          END ) phone_no
      FROM 
        (SELECT user_id,
             Contacts_name,
             regexp_replace(phone_no,
             '(\\(?\\D{1,}\\)?)', '') phone_no
        FROM 
          (SELECT user_id,
             Contacts_name,
             Split (phone_ARR,
             '","') b
          FROM 
            (SELECT user_id,
             concat(regexp_replace(first_name,
             '无',''),last_name) Contacts_name, phone_ARR
            FROM ODS.T_user_relation_person_info_HIST
            UNION
            all -- 
             SELECT user_id,
             upb_name Contacts_name,
             regexp_replace( regexp_replace(upb_phone,
             '\\+86',''), '#', '","' ) phone_ARR 
             FROM ods.t_user_phone_book_hist ) a1 ) a -- 
             Lateral VIEW Explode (b) Splittab AS phone_no -- 
             GROUP BY user_id, Contacts_name, regexp_replace(phone_no, '(\\(?\\D{1,}\\)?)', '') -- 
             ) d -- 
             ) e --
             ) f --
;