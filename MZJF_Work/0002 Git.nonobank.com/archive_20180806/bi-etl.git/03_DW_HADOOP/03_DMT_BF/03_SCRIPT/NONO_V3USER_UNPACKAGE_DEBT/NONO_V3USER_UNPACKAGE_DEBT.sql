set mapreduce.job.name=DMT_BF_NONO_V3USER_UNPACKAGE_DEBT; 
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT overwrite table DMT_BF.NONO_V3USER_UNPACKAGE_DEBT  partition(STAT_DATE)
SELECT
A.bo_id -- 标的
,A.ba_price as Total_price -- 本金合计
,bo.bo_expect -- 借款期限
,bo.bo_sign_time -- 签约时间
,A.remainingperiod -- 债权数
,bo.bo_extno -- 协议号
,bo.bo_aim -- 借款目的
,BR.br_price as per_price -- 每期本金
,BR.last_plan_time --最后计划还款日
,ui.real_name -- 真实姓名
,ui.user_name -- 用户名
,ui.id_num -- 身份证
,SUBSTRING(ui.id_num, 7, 8) AS brithday -- 出生年月
,ui.mobile_num --手机号
,nvl(us.academy, '大房东') as academy -- 学校
,us.major -- 专业
,us.education -- 学历
,us.edu_start_date  --入学年份
,us.campus -- 校区
,CASE WHEN ui.gender = 1 THEN '男' ELSE '女' END AS gender
,BDC.emergency_parent -- 父母
,BDC.emergency_counselor --辅导员
,BDC.emergency_other --好友
,BDC.address -- 住址
,'SYS' AS DW_CREATE_BY
,FROM_UNIXTIME( UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss' ) AS DW_CREATE_TIME
,'SYS' AS DW_UPDATE_BY, FROM_UNIXTIME( UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss' ) AS DW_UPDATE_TIME
,FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') STAT_DATE
FROM 
(SELECT
ba.bo_id,
COUNT(DISTINCT ba.plan_time) AS remainingperiod,
SUM(ba.price_principal) AS ba_price
FROM
ODS.T_borrows_accept_HIST ba
LEFT JOIN ODS.T_debt_package_borrows_HIST dpb
ON dpb.bo_id = ba.bo_id
WHERE ba.is_pay = 0
AND dpb.bo_id IS NULL
AND ba.va_id = 23665 
GROUP BY ba.bo_id
HAVING SUM(ba.price_principal) > 0) A
LEFT JOIN ODS.T_borrows_HIST BO
ON A.bo_id=BO.ID
LEFT JOIN (
SELECT user_id,
MAX(CASE WHEN NAME = '父亲或母亲手机号' THEN VALUE END) AS emergency_parent,
MAX(CASE WHEN NAME = '辅导员手机号' THEN VALUE END) AS emergency_counselor,
MAX(CASE WHEN NAME = '好友1手机号' THEN VALUE END) AS emergency_other,
MAX(CASE WHEN NAME = '家庭住址' THEN VALUE END) AS address 
FROM ODS.T_borrows_dunning_contact_HIST
GROUP BY user_id
) BDC
ON BDC.user_id = bo.user_id
LEFT JOIN ODS.T_user_info_HIST ui
ON ui.id = bo.user_id
LEFT JOIN ODS.T_user_student_info_HIST us
ON us.user_id = bo.user_id
LEFT JOIN (
SELECT bo_id 
,MAX(CASE WHEN br_expect_num = 1 THEN br_price END ) br_price -- 每期本金
,MAX(br_time) last_plan_time
FROM ODS.T_borrows_repayment_HIST
GROUP BY bo_id) BR
ON A.bo_id=BR.bo_id