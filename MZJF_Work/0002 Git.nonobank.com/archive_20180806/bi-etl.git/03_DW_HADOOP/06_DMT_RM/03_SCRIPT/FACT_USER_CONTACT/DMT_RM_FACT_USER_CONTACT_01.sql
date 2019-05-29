set mapreduce.job.name=DMT_RM_FACT_USER_CONTACT_01; 
set mapreduce.job.queuename = etl-dw;  

set hive.exec.parallel=true ;
set hive.map.aggr = true ; 

set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict; 
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

DROP TABLE IF EXISTS TMP.DMT_RM_FACT_USER_CONTACT_01;


CREATE TABLE TMP.DMT_RM_FACT_USER_CONTACT_01
-- 所有标的情况（标的号，用户ID，通讯录号码个数，联系人是否在通讯录里）
as 
SELECT 
  ui.id user_id, -- 用户ID 
  -- FD_NO,
  max(CASE WHEN dl.phone_no=FD_NO THEN 1 ELSE 0 END) PHONE_COUNSELLOR_NO_FLAG,
  -- P_NO,dl_1.phone_no,
  max(CASE WHEN dl.phone_no=P_NO THEN 1 ELSE 0 END) PHONE_PARENTS_NO_FLAG,
  -- F_1_NO,
  max(CASE WHEN dl.phone_no=F_1_NO THEN 1 ELSE 0 END) PHONE_CONTACT1_NO_FLAG,  
  -- F_2_NO,
  max(CASE WHEN dl.phone_no=F_2_NO THEN 1 ELSE 0 END) PHONE_CONTACT2_NO_FLAG,
  -- F_3_NO,
  max(CASE WHEN dl.phone_no= F_3_NO THEN 1 ELSE 0 END) PHONE_CONTACT3_NO_FLAG,   
  count(DISTINCT dl.phone_no) as PHONE_NO_CNT  -- 通讯录电话号码个数
FROM
ODS.T_user_info_hist  ui 
  INNER JOIN (  
              SELECT user_id
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='辅导员' AND kind=1,VALUE,NULL)) FD
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='辅导员' AND kind=2,VALUE,NULL)) FD_NO
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='父母' AND kind=1,VALUE,NULL)) P
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='父母' AND kind=2,VALUE,NULL)) P_NO
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='好友1' AND kind=1,VALUE,NULL)) F_1
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='好友1' AND kind=2,VALUE,NULL)) F_1_NO
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='好友2' AND kind=1,VALUE,NULL)) F_2
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='好友2' AND kind=2,VALUE,NULL)) F_2_NO
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='好友3' AND kind=1,VALUE,NULL)) F_3
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='好友3' AND kind=2,VALUE,NULL)) F_3_NO
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='辅导员' AND kind=2,call_state,NULL)) FD_NO_S
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='父母' AND kind=2,call_state,NULL)) P_NO_S
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='好友1' AND kind=2,call_state,NULL)) F_1_NO_S
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='好友2' AND kind=2,call_state,NULL)) F_2_NO_S
              ,MAX(IF(regexp_REPLACE(groupkwd,' ','')='好友3' AND kind=2,call_state,NULL)) F_3_NO_S
              ,MAX(create_time) max_time
              FROM ODS.T_borrows_dunning_contact_hist 
              WHERE  regexp_REPLACE(groupkwd,' ','') IN('辅导员','父母','好友1','好友2','好友3')
              GROUP BY user_id  
  ) bc 
    ON bc.user_id = ui.id 
left join idw.dim_user_contact_list dl
on ui.id=dl.user_id
group by   
ui.id;
