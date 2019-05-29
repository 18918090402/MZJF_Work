DELIMITER $$

USE `risk`$$

DROP PROCEDURE IF EXISTS `SP_FACT_APPLY`$$

CREATE DEFINER=`risk`@`%` PROCEDURE `SP_FACT_APPLY`()
BEGIN
DECLARE t1 DATETIME;
DECLARE t2 DATETIME;
DECLARE t DATETIME;
SET t1=DATE('2010-07-01');
SET t2=DATE_ADD(DATE(SYSDATE()),INTERVAL 1 DAY);
SET t=t1;
TRUNCATE TABLE risk.FACT_APPLY ;
DROP TABLE IF EXISTS risk.TMP_FACT_APPLY_DATE ;
CREATE TABLE risk.TMP_FACT_APPLY_DATE
(APPLY_DATE DATETIME,CREATE_DATE DATETIME);
INSERT INTO risk.xcw_borrows_concat
SELECT bdc.user_id
,MAX(IF(bdc.groupkwd='辅导员' AND kind=1,bdc.value,NULL)) 辅导员
,MAX(IF(bdc.groupkwd='辅导员' AND kind=2,bdc.value,NULL)) 辅导员手机
,MAX(IF(bdc.groupkwd='父母' AND kind=1,bdc.value,NULL)) 父母
,MAX(IF(bdc.groupkwd='父母' AND kind=2,bdc.value,NULL)) 父母手机
,MAX(IF(bdc.groupkwd='好友1' AND kind=1,bdc.value,NULL)) 好友1
,MAX(IF(bdc.groupkwd='好友1' AND kind=2,bdc.value,NULL)) 好友1手机
,MAX(IF(bdc.groupkwd='好友2' AND kind=1,bdc.value,NULL)) 好友2
,MAX(IF(bdc.groupkwd='好友2' AND kind=2,bdc.value,NULL)) 好友2手机
,MAX(IF(bdc.groupkwd='好友3' AND kind=1,bdc.value,NULL)) 好友3
,MAX(IF(bdc.groupkwd='好友3' AND kind=2,bdc.value,NULL)) 好友3手机
,MAX(IF(bdc.groupkwd='辅导员' AND kind=2,bdc.call_state,NULL)) 辅导员手机状态
,MAX(IF(bdc.groupkwd='父母' AND kind=2,bdc.call_state,NULL)) 父母手机状态
,MAX(IF(bdc.groupkwd='好友1' AND kind=2,bdc.call_state,NULL)) 好友1手机状态
,MAX(IF(bdc.groupkwd='好友2' AND kind=2,bdc.call_state,NULL)) 好友2手机状态
,MAX(IF(bdc.groupkwd='好友3' AND kind=2,bdc.call_state,NULL)) 好友3手机状态
,MAX(bdc.create_time) max_time
,NOW() create_time
FROM db_nono.borrows_dunning_contact bdc 
LEFT JOIN risk.xcw_borrows_concat bc ON bc.user_id=bdc.user_id
WHERE 1=1
AND bc.user_id IS NULL
AND bdc.groupkwd IN('辅导员','父母','好友1','好友2','好友3')
GROUP BY 1 ;
WHILE (t<t2)
DO 
INSERT INTO risk.FACT_APPLY
SELECT 
bo.id 申请号,ui.real_name 申请人姓名,
ui.id_num 身份证,
CASE WHEN LENGTH(REPLACE(REPLACE(REPLACE(REPLACE(ui.id_num,CHAR(9) ,''),CHAR(10) ,''),CHAR(13) ,''),' ' ,''))>15
THEN YEAR(bo.publish_time)-SUBSTR( REPLACE(REPLACE(REPLACE(REPLACE(ui.id_num,CHAR(9) ,''),CHAR(10) ,''),CHAR(13) ,''),' ' ,''),7,4) 
ELSE uid.age END 年龄
,CASE WHEN ui.gender=1 THEN '男' WHEN ui.gender=2 THEN '女' ELSE NULL END 性别
,r1.name 户籍省份,r2.name 户籍城市,r0.name 当前省份,CASE WHEN INSTR(r0.name,'市')>0 THEN r0.name ELSE  rr.name END 当前城市
,usi.academy 就读院校,CASE WHEN ss.type=4 THEN '专科' WHEN ss.type<4 THEN CONCAT(ss.type,'本') ELSE ss.type END 学校类别
,NULL 学校城市,r.name 学校省份,usi.major 专业
,CASE WHEN MONTH(bo.publish_time)<9 THEN IFNULL(YEAR(bo.publish_time)-LEFT(usi.edu_start_date,4),usi.student_grade)  
	WHEN MONTH(bo.publish_time)>=9 THEN IFNULL(YEAR(bo.publish_time)-LEFT(usi.edu_start_date,4)+1 ,usi.student_grade) END 年级
,usi.education 学历,CONCAT(CASE WHEN LENGTH(LEFT(edu_start_date,4))=4 AND LEFT(edu_start_date,4)>='1900' AND LEFT(edu_start_date,4)<='2700' THEN LEFT(edu_start_date,4) ELSE NULL END ,'-09-01') 入学时间
,is_graduate 是否已毕业
,usi.edu_graduate_date  预计毕业时间
,ui.mobile_num 手机号码
,辅导员手机,父母手机,好友1手机,好友2手机,好友3手机,uid.qq QQ
,ui.email 邮箱,uwi.job 职业
,uwi.current_job_time 工作年限
,uwi.company_name 公司名称
,uwi.company_business_type 公司类型
,uwi.company_tel 公司电话号码
,DATE(bo.publish_time) 申请日期
,p.p_name 申请产品,bo.bo_price 申请金额,bo.bo_expect 申请期限,bo.bo_expect_cat
,CASE bo.bo_sign_result WHEN 0 THEN '未处理' WHEN 1 THEN '通过'
WHEN 2 THEN '拒绝' WHEN 3 THEN '待处理' WHEN 4 THEN '回退'  WHEN 5 THEN '取消'   ELSE NULL END  签约结果
,CASE
WHEN bo.bo_can_success = 3 AND  bo.bo_is_success = 0  AND bo.bo_is_finish <> 2       THEN '终审通过（还未放款）'
WHEN bo.bo_is_success = 1                                                            THEN '终审通过已放款'
WHEN ba.is_audit = 3 AND bo.bo_is_success = 0 AND bo.bo_is_finish =0                 THEN '初审中'
WHEN ba.is_audit = 1 AND   ba.is_confirm = 3  AND bo.bo_is_success = 0 AND bo.bo_is_finish =0 THEN '终审中'
WHEN ba.is_audit = 4 AND bo.bo_is_success = 0 AND bo.bo_is_finish =0                  THEN '初审回退'
WHEN ba.is_audit = 2                                                                  THEN '初审拒绝'  
WHEN ba.is_audit = 5                                                                  THEN '初审取消'
WHEN ba.is_confirm = 4 AND bo.bo_is_success = 0 AND bo.bo_is_finish =0                THEN '终审回退'
WHEN ba.is_confirm = 2                                                                THEN '终审拒绝' 
WHEN ba.is_confirm = 5                                                                THEN '终审取消'
WHEN bo.bo_is_success = 3  OR bo.bo_is_finish = 2    THEN '自动流标'
ELSE NULL 
END 申请结果
,bp.bp_price_audit 审批金额
,IF(bo_sign_result=2,bo_audit_remark,NULL) 拒绝原因
,NULL  取消原因
,IF(bo_sign_result=4,bo_audit_remark,NULL)  回退原因
,ad.am_name 渠道
,CASE usi.campus_approach WHEN 1 THEN '网络搜索' WHEN  2 THEN '校园大使'WHEN  3 THEN '朋友介绍' WHEN  4
THEN '微博'WHEN  5 THEN '微信' WHEN 6 THEN '贴吧/论坛' WHEN  7 THEN  'QQ群' WHEN  8 THEN '海报/宣传品' WHEN  9 THEN '展柜/活动'
WHEN 10 THEN '其他' ELSE NULL END  来源
,bo.bo_title  借款标题
,msr.score 评分
,msr.risk_level 评级
,CASE WHEN ba.keyword='borrow_video_audit' AND ba.bo_id IS NOT NULL THEN 1 ELSE 0 END 是否提交视频
,NULL 是否电联
,父母手机状态 父母电联状态
,辅导员手机状态 辅导员电联状态
,好友1手机状态 联系人1电联状态
,好友2手机状态 联系人2电联状态
,好友3手机状态 联系人3电联状态
,ual.ip 注册ip地址
,ui.is_student 是否学籍认证
,ui.is_education 是否学历认证
,uid.is_social_security 是否有社保
,usi.family_income 家庭收入
,ui.is_cheat 是否欺诈
,NULL 欺诈类型
,cs.shopName merchant_name 
FROM db_nono.borrows bo
LEFT JOIN db_nono.borrows_prepare bp ON bp.id=bo.bp_id
LEFT JOIN db_nono.user_info ui  ON bo.user_id=ui.id
LEFT JOIN db_nono.user_student_info usi ON usi.user_id=ui.id
LEFT JOIN db_nono.user_work_info uwi ON uwi.user_id=ui.id
LEFT JOIN db_nono.user_info_detail uid ON ui.id=uid.user_id
LEFT JOIN db_nono.user_approach_info uai ON uai.user_id=ui.id
LEFT JOIN (SELECT ss.name,ss.province_id,ss.type FROM db_nono.student_school ss  GROUP BY 1)ss ON usi.academy = ss.name
LEFT JOIN db_nono.region r0 ON r0.code=uid.current_province
LEFT JOIN db_nono.region r ON r.code=ss.province_id
LEFT JOIN db_nono.region rr ON rr.code=uid.current_city
LEFT JOIN db_nono.region r1 ON r1.code=uid.register_province
LEFT JOIN db_nono.region r2 ON r2.code=uid.register_city
LEFT JOIN db_nono.borrows_consulted_fee bcf ON bcf.bo_id=bo.id
LEFT JOIN db_nono.products p ON p.id=bo.p_id
LEFT JOIN db_nono.admin ad ON ad.id=uai.channel_id
LEFT JOIN risk.xcw_borrows_concat bc ON bc.user_id=ui.id
LEFT JOIN db_nono.mxd_score_result msr ON msr.user_id=ui.id AND msr.bo_id=bo.id
LEFT JOIN db_nono.borrows_archive ba ON ba.bo_id=bo.id 
LEFT JOIN db_nono.user_action_log ual ON ual.user_id=bo.user_id  AND ual.action_type=7
LEFT JOIN db_nono.user_csmFinInfo cs ON cs.bo_id=bo.id
WHERE 1=1
AND bo.publish_time>=t
AND bo.publish_time<DATE_ADD(t,INTERVAL 30 DAY)
AND bo.publish_time<CURDATE()
GROUP BY bo.id
;
INSERT INTO  risk.TMP_FACT_APPLY_DATE
VALUE (t,SYSDATE());
SET t=DATE_ADD(t,INTERVAL  30 DAY);
END WHILE;
END$$

DELIMITER ;