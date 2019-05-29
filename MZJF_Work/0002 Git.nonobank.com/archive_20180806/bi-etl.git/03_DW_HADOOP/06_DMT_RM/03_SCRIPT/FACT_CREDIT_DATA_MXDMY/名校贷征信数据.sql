INSERT OVERWRITE TABLE dmt_rm.FACT_CREDIT_DATA_MXDMY_02 partition (STAT_DATE)
SELECT 

'-1' AS ORDER_NO,
bo.`id` AS APPLY_NO,
a.ZM AS CREDIT_ZM,
 CAST(td.final_score AS int) AS CREDIT_TD,
b.z1 AS MULT_INVEST_1M,
'-1' AS MULT_INVEST_3M,
c.z3 AS MULT_INVEST_6M,
'-1' AS CREDIT_JXL,
'-1' AS CREDIT_MY,
d.face_s AS 'FACE_S',
e.idcard_s AS 'IDCARD_S',
  'SYS'              AS DW_CREATE_BY,
  FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')         AS DW_CREATE_TIME,
  'SYS'              AS DW_UPDATE_BY,
 FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')         AS DW_UPDATE_TIME,
     '{TSUB1}' AS 'STAT_DATE'
FROM ods.t_borrows_hist bo 
LEFT JOIN 
(SELECT 
dm.`bp_id`,
dm.`data_value` AS 'final_score'
FROM ods.t_des_main_hist dm
WHERE dm.data_no='tongdunFinalScore')td ON td.bp_id=bo.`bp_id`
LEFT JOIN (
 SELECT 
dm.`bp_id`,
dm.`data_value` AS 'ZM'
FROM ods.t_des_main_hist dm
WHERE dm.data_no='zhiMaScore')a ON a.bp_id=bo.`bp_id`
LEFT JOIN (
 SELECT 
dm.`bp_id`,
dm.`data_value` AS 'z1'
FROM ods.t_des_main_hist dm
WHERE dm.data_no='hitTongDunRepeateLoanOneMonth' )b ON b.bp_id=bo.`bp_id`
LEFT JOIN (
 SELECT 
dm.`bp_id`,
dm.`data_value`  AS 'z3'
FROM ods.t_des_main_hist dm
WHERE 
dm.data_no='hitTongDunRepeateLoansixMonth' )c ON c.bp_id=bo.`bp_id`
LEFT JOIN (
SELECT 
dm.`bp_id`,
dm.`data_value` AS 'face_s'
FROM ods.t_des_main_hist dm
WHERE dm.data_no='faceSimilarPercent')d ON d.bp_id=bo.`bp_id`
LEFT JOIN (
SELECT 
dm.`bp_id`,
dm.`data_value` AS 'idcard_s'
FROM ods.t_des_main_hist dm
WHERE dm.data_no='idCardSimilarPercent')e ON e.bp_id=bo.`bp_id`
WHERE bo.bo_is_success=1
and bo.p_id in (87,77)
group by bo.id,
a.ZM,
td.final_score,
b.z1,
c.z3,
d.face_s,
e.idcard_s
