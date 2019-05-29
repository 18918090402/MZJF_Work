set mapreduce.job.name=DMT_RM_FACT_CREDIT_DATA_MXDMY_01; 
set mapreduce.job.queuename = etl-dw;  

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 

set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict; 
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;


INSERT OVERWRITE TABLE dmt_rm.FACT_CREDIT_DATA_MXDMY partition (STAT_DATE)
SELECT 
  ORDER_NO,
  APPLY_NO,
  MAX(CREDIT_ZM) AS CREDIT_ZM,
  MAX(CREDIT_TD) AS CREDIT_TD,
  MAX(MULT_INVEST_1M) AS MULT_INVEST_1M,
  MAX(MULT_INVEST_3M) AS MULT_INVEST_3M,
  MAX(MULT_INVEST_6M) AS MULT_INVEST_6M,
  MAX(CREDIT_JXL) AS CREDIT_JXL,
  MAX(CREDIT_MY) AS CREDIT_MY,
  MAX(FACE_S) AS FACE_S,
  MAX(IDCARD_S) AS IDCARD_S,
  max(ID_HIT) as ID_HIT ,-- '身份证号是否命中'
  max(ID_HIT_CONTENT) as ID_HIT_CONTENT,--'身份证号命中内容'
  max(PHONE_HIT) as PHONE_HIT, --'手机号是否命中'
  max(PHONE_HIT_CONTENT) as PHONE_HIT_CONTENT, --'手机号命中内容'
  'SYS' AS DW_CREATE_BY,
  FROM_UNIXTIME(
    UNIX_TIMESTAMP(),
    'yyyy-MM-dd HH:mm:ss'
  ) AS DW_CREATE_TIME,
  'SYS' AS DW_UPDATE_BY,
  FROM_UNIXTIME(
    UNIX_TIMESTAMP(),
    'yyyy-MM-dd HH:mm:ss'
  ) AS DW_UPDATE_TIME,
  STAT_DATE 
FROM(
-- --------------
-- --------------
SELECT 
    f.order_no as ORDER_NO,
    nvl(f.bo_id,-1) AS APPLY_NO, 
    a.ZM CREDIT_ZM,
    CAST(td.final_score AS int) AS CREDIT_TD,
    (CASE WHEN b.z1='nu' THEN NULL ELSE b.z1 END) MULT_INVEST_1M,
    (CASE WHEN b.z2='nu' THEN NULL ELSE b.z2 END) MULT_INVEST_3M,
    (CASE WHEN b.z3='nu' THEN NULL ELSE b.z3 END) MULT_INVEST_6M,
    (CASE  WHEN e.order_id IS NULL THEN -1 WHEN e.JXL>=0  THEN e.JXL 
      ELSE NULL  END) AS CREDIT_JXL ,
    f.credit_level as CREDIT_MY,

    '-1' AS FACE_S,
     '-1' AS IDCARD_S,
     null as ID_HIT ,-- '身份证号是否命中'
  null as ID_HIT_CONTENT,--'身份证号命中内容'
  null as PHONE_HIT, --'手机号是否命中'
  null as PHONE_HIT_CONTENT, --'手机号命中内容'
     'SYS'  AS DW_CREATE_BY,
    FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
  'SYS' AS DW_UPDATE_BY,
     FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
 
 '{TSUB1}' AS STAT_DATE
  FROM 
   ods.t_ord_order_hist f
    LEFT JOIN 
    (
        SELECT order_id,
  regexp_extract(cast(DATA as string),'zmScore\\"(:)?"([0-9]+)',2) as ZM
        FROM ods.t_ORD_USER_HONOR_hist
        WHERE honor_type ='ZHIMA' AND INSTR(UPPER(DATA),UPPER('zmScore'))>0   
    ) a 
    ON a.order_id=f.id 
    LEFT JOIN
    (
          SELECT order_id,
   regexp_extract(cast(DATA as string),'finalScore\\"(:)?([0-9]+)',2) as final_score
        FROM ods.t_ORD_USER_HONOR_hist
        WHERE honor_type ='TONGDUN'  AND data LIKE '%finalScore%'  
    ) td 
    ON a.order_id=td.order_id 
    LEFT JOIN
    (
        SELECT order_id,
 regexp_extract(cast(DATA as string),'1个月内申请人在多个平台申请借款.*platform_count\\"(:)?([0-9]+)',2) as z1,
      regexp_extract(cast(DATA as string),'3个月内申请人在多个平台申请借款.*platform_count\\"(:)?([0-9]+)',2) as z2,
       regexp_extract(cast(DATA as string),'6个月内申请人在多个平台申请借款.*platform_count\\"(:)?([0-9]+)',2) as z3
        FROM ods.t_ORD_USER_HONOR_hist
        WHERE honor_type ='TONGDUN'
        AND (
              DATA LIKE '%1个月内申请人在多个平台申请借款%' 
              OR 
              DATA LIKE '%3个月内申请人在多个平台申请借款%' 
              OR
              DATA LIKE '%6个月内申请人在多个平台申请借款%' 
              )
    ) b 
    ON a.order_id=b.order_id    
    LEFT JOIN 
    (
         SELECT order_id ,
        MAX(CASE WHEN  
         regexp_replace(cast(DATA as string),"与电商","") LIKE  '%根据运营商数据%'
        THEN         
        regexp_extract(cast(DATA as string),'根据运营商.*数据(,)?\\[([0-9]+)\\]号码使用了([0-9]+)个月',3)
        ELSE NULL END) AS JXL
        FROM ods.t_ORD_USER_HONOR_hist  a
        WHERE honor_type LIKE '%JUXINLI_MOBILE%'
        GROUP BY order_id 
    ) e ON a.order_id=e.order_id    
-- ---------------------------------------------
-- ---------------------------------------------
-- ---------------------------------------------
-- ---------------------------------------------
union all 
SELECT 
'-1' AS ORDER_NO,
bo.id AS APPLY_NO,
--a.ZM AS CREDIT_ZM,
max(if(td.data_no='zhiMaScore',td.data_value,NULL)) as CREDIT_ZM,
--CAST(td.final_score AS int) AS CREDIT_TD,
max(cast(if(td.data_no='tongdunFinalScore',td.data_value,NULL) as int)) as CREDIT_TD,
--b.z1 AS MULT_INVEST_1M,
max(if(td.data_no='hitTongDunRepeateLoanOneMonth',td.data_value,NULL) ) as MULT_INVEST_1M,
'-1' AS MULT_INVEST_3M,
--c.z3 AS MULT_INVEST_6M,
max(if(td.data_no='hitTongDunRepeateLoansixMonth',td.data_value,NULL) ) as MULT_INVEST_6M,
'-1' AS CREDIT_JXL,
'-1' AS CREDIT_MY,
--d.face_s AS FACE_S,
max(if(td.data_no='faceSimilarPercent',td.data_value,NULL)) as FACE_S,
--e.idcard_s AS IDCARD_S,
max(if(td.data_no='idCardSimilarPercent',td.data_value,NULL) ) as IDCARD_S,
max(if(td.data_no in ('idHitOurBlackList','idHitTongDunLoanBlackList','idHitTongDunCourtBlackList','idHitTongDunCourtExecuteList','idHitTongDunCrimeBlackList'
 ,'idNameHitTongDunFuzzyCourtBlackList','idNameHitTongDunFuzzyCourtExecuteList','idHitTongDunLegalPersonBlackList','idHitTongDunLostContactList','idNameHitTongDunFuzzyLoanBlackList'),1,0))  as ID_HIT ,--'身份证号是否命中'
concat_ws(',',collect_set(if(td.data_no in ('idHitOurBlackList','idHitTongDunLoanBlackList','idHitTongDunCourtBlackList','idHitTongDunCourtExecuteList','idHitTongDunCrimeBlackList'
 ,'idNameHitTongDunFuzzyCourtBlackList','idNameHitTongDunFuzzyCourtExecuteList','idHitTongDunLegalPersonBlackList','idHitTongDunLostContactList','idNameHitTongDunFuzzyLoanBlackList'),td.remark,NULL)) ) as ID_HIT_CONTENT ,--'身份证号是否命中'
 --ID_HIT_CONTENT,--'身份证号命中内容'
 max(if(td.data_no in ('mobileHitOurBlackList','mobileHitTongDunLegalPersonBlackList','mobileHitTongDunLoanBlackIntermediary','mobileHitTongDunLoanBlackList'
   ,'mobileHitTongDunLostContactList','contactMobileHitTongDunLoanBlackIntermediary'),1,0))  as PHONE_HIT ,--'手机号是否命中'
  concat_ws(',',collect_set(if(td.data_no in ('mobileHitOurBlackList','mobileHitTongDunLegalPersonBlackList','mobileHitTongDunLoanBlackIntermediary','mobileHitTongDunLoanBlackList'
   ,'mobileHitTongDunLostContactList','contactMobileHitTongDunLoanBlackIntermediary'),td.remark,NULL)) ) as PHONE_HIT_CONTENT,--'手机号命中内容'
  'SYS'              AS DW_CREATE_BY,
  FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')         AS DW_CREATE_TIME,
  'SYS'              AS DW_UPDATE_BY,
 FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')         AS DW_UPDATE_TIME,
 '{TSUB1}' AS STAT_DATE
FROM ods.t_borrows_hist bo 
LEFT JOIN ods.t_des_main_hist td ON td.bp_id=bo.bp_id
group by bo.id
) A 
GROUP BY 
STAT_DATE,
ORDER_NO,
APPLY_NO
;