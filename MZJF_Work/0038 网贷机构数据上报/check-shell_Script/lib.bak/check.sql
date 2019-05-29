## 此处传入平台编号
SET @source_code = 'CERT20181126001';

# 去重统计
CREATE TABLE IF NOT EXISTS `duplicate_removal` (
  `sourceCode` VARCHAR(20),
  `intface_type` VARCHAR(20) NOT NULL,
  `duplicate_removal_before` bigint(20) NOT NULL,
  `duplicate_removal_after` bigint(20) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# 用户关联check
CREATE TABLE IF NOT EXISTS `leak_user` (
  `sourceCode` varchar(255) DEFAULT NULL COMMENT '平台',
  `intface_type` varchar(255) DEFAULT NULL COMMENT '接口类型',
  `leak_user_data` bigint(20) DEFAULT NULL COMMENT '漏传用户数',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='漏传用户数';

# check表
CREATE TABLE IF NOT EXISTS `norm` (
  `sourceCode` varchar(255) DEFAULT NULL COMMENT '平台',
  `norm_name` varchar(255) DEFAULT NULL,
  `count` bigint(20) DEFAULT NULL COMMENT '数据量',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='去重表';



## setp 1 去重临时表
CREATE TEMPORARY TABLE tmp_creditor
SELECT sourceCode,finClaimId,sourceProductCode,userIdcardHash,invAmount,invRate,invTime,redpackage,lockTime
FROM creditor
GROUP BY sourceCode,finClaimId,sourceProductCode,userIdcardHash,invAmount,invRate,invTime,redpackage,lockTime;

CREATE TEMPORARY TABLE tmp_repayplan
SELECT sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge, repayTime,sendTime 
FROM repayplan 
GROUP BY sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge,repayTime,sendTime;

CREATE TEMPORARY TABLE tmp_scatterinvest
SELECT sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount 
FROM scatterinvest 
GROUP BY sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount;

CREATE TEMPORARY TABLE tmp_status
SELECT sourceCode,sourceProductCode,productStatus,productDate 
FROM status 
GROUP BY sourceCode,sourceProductCode,productStatus,productDate;

CREATE TEMPORARY TABLE tmp_transact
SELECT sourceCode,transId,sourceProductCode,finClaimId,transferId,replanId,transType,transMoney,userIdcardHash,transTime
FROM transact 
GROUP BY sourceCode,transId,sourceProductCode,finClaimId,transferId,replanId,transType,transMoney,userIdcardHash,transTime;

CREATE TEMPORARY TABLE tmp_transferproject
SELECT sourceCode,transferId,fromType,finClaimId,userIdcardHash,sourceProductCode,transferAmount,transferInterestRate,floatMoney,transferDate 
FROM transferproject
GROUP BY sourceCode,transferId,fromType,finClaimId,userIdcardHash,sourceProductCode,transferAmount,transferInterestRate,floatMoney,transferDate;

CREATE TEMPORARY TABLE tmp_transferStatus
SELECT sourceCode,transferId,transferStatus,amount,floatMoney,productDate 
FROM transferstatus 
GROUP BY sourceCode,transferId,transferStatus,amount,floatMoney,productDate;

CREATE TEMPORARY TABLE tmp_undertakeinfo
SELECT sourceCode,unFinClaimId,transferId,finClaimId,userIdcardHash,takeAmount,takeInterest,floatMoney,takeRate,takeTime,redpackage,lockTime 
FROM undertakeinfo 
GROUP BY sourceCode,unFinClaimId,transferId,finClaimId,userIdcardHash,takeAmount,takeInterest,floatMoney,takeRate,takeTime,redpackage,lockTime;

CREATE TEMPORARY TABLE tmp_userinfo
SELECT sourceCode,userType,userAttr,userCreateTime,userName,countries,userIdcard,userIdcardHash,userPhone,userPhoneHash,userProvince,userAddress,userSex 
FROM userinfo 
GROUP BY sourceCode,userType,userAttr,userCreateTime,userName,countries,userIdcard,userIdcardHash,userPhone,userPhoneHash,userProvince,userAddress,userSex;

##产品临时表
CREATE TEMPORARY TABLE tmp_lendproduct
SELECT sourceCode,sourceFinancingCode,financingStartTime,productName,rate,minRate,maxRate,term 
FROM lendproduct
GROUP BY sourceCode,sourceFinancingCode,financingStartTime,productName,rate,minRate,maxRate,term;

CREATE TEMPORARY TABLE tmp_lendproductconfig
SELECT sourceCode,configId,finClaimId,sourceFinancingCode,userIdcardHash 
FROM lendproductconfig 
GROUP BY sourceCode,configId,finClaimId,sourceFinancingCode,userIdcardHash;

CREATE TEMPORARY TABLE tmp_lendparticulars
SELECT sourceCode,transId,sourceFinancingCode,transType,transMoney,userIdcardHash,transTime 
FROM lendparticulars
GROUP BY sourceCode,transId,sourceFinancingCode,transType,transMoney,userIdcardHash,transTime;

ALTER TABLE tmp_creditor ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_creditor ADD INDEX index_2(finClaimId);
ALTER TABLE tmp_scatterinvest ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_scatterinvest ADD INDEX index_2(sourceProductCode);
ALTER TABLE tmp_repayplan ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_repayplan ADD INDEX index_2(sourceProductCode,issue,sendTime);
ALTER TABLE tmp_transact ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_transact ADD INDEX index_2(sourceProductCode);
ALTER TABLE tmp_transact ADD INDEX index_3(finClaimId);
ALTER TABLE tmp_userinfo ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_transferproject ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_transferproject ADD INDEX index_2(transferId, fromType);
ALTER TABLE tmp_undertakeinfo ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_undertakeinfo ADD INDEX index_2(unFinClaimId);
ALTER TABLE tmp_status ADD INDEX index_1(sourceProductCode,productStatus);
ALTER TABLE tmp_transferStatus ADD INDEX index_1(transferId);
# 增加产品索引
ALTER TABLE tmp_lendproduct ADD INDEX index_1(sourceFinancingCode);
ALTER TABLE tmp_lendproductconfig ADD INDEX index_1(finClaimId);
ALTER TABLE tmp_lendproductconfig ADD INDEX index_2(sourceFinancingCode);
ALTER TABLE tmp_lendproductconfig ADD INDEX index_3(userIdcardHash);
ALTER TABLE tmp_lendparticulars ADD INDEX index_1(sourceFinancingCode);
ALTER TABLE tmp_lendparticulars ADD INDEX index_2(userIdcardHash);


## step 2: 不去重统计
CREATE TEMPORARY TABLE userinfo_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM userinfo;

CREATE TEMPORARY TABLE scatterinvest_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM scatterinvest;

CREATE TEMPORARY TABLE status_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM status;

CREATE TEMPORARY TABLE creditor_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM creditor;

CREATE TEMPORARY TABLE repayplan_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM repayplan;

CREATE TEMPORARY TABLE transact_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM transact;

CREATE TEMPORARY TABLE transferproject_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM transferproject;

CREATE TEMPORARY TABLE transferstatus_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM transferstatus;

CREATE TEMPORARY TABLE undertakeinfo_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM undertakeinfo;

## 产品不去重统计
CREATE TEMPORARY TABLE lendproduct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM lendproduct;
CREATE TEMPORARY TABLE lendproductconfig_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM lendproductconfig;
CREATE TEMPORARY TABLE lendparticulars_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM lendparticulars;


## step 3：去重统计
CREATE TEMPORARY TABLE creditor_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_creditor;

CREATE TEMPORARY TABLE repayplan_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_repayplan;

CREATE TEMPORARY TABLE scatterinvest_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_scatterinvest;

CREATE TEMPORARY TABLE status_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_status;

CREATE TEMPORARY TABLE transact_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_transact;

CREATE TEMPORARY TABLE transferproject_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_transferproject;

CREATE TEMPORARY TABLE transferStatus_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_transferStatus;

CREATE TEMPORARY TABLE undertakeinfo_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_undertakeinfo;

CREATE TEMPORARY TABLE userinfo_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_userinfo;

## 产品去重统计
CREATE TEMPORARY TABLE lendproduct_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_lendproduct;
CREATE TEMPORARY TABLE lendproductconfig_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_lendproductconfig;
CREATE TEMPORARY TABLE lendparticulars_distinct_count
SELECT IFNULL(sourceCode,@source_code) sourceCode, COUNT(1) AS count FROM tmp_lendparticulars;


## insert
INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'userinfo' AS intface_type, a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM userinfo_count a, userinfo_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'scatterinvest' AS intface_type ,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time2 
FROM scatterinvest_count a,scatterinvest_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'status' AS intface_type ,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM status_count a,status_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'creditor' AS intface_type ,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM creditor_count a,creditor_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'repayplan' AS intface_type ,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM repayplan_count a,repayplan_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'transact' AS intface_type ,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM transact_count a,transact_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'transferproject' AS intface_type,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM transferproject_count a,transferproject_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'transferstatus' AS intface_type ,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM transferstatus_count a,transferStatus_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'undertakeinfo' AS intface_type ,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM undertakeinfo_count a,undertakeinfo_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

### insert产品
INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'lendproduct' AS intface_type ,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM lendproduct_count a,lendproduct_distinct_count b 
WHERE a.sourceCode=b.sourceCode;
INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'lendproductconfig' AS intface_type ,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM lendproductconfig_count a,lendproductconfig_distinct_count b 
WHERE a.sourceCode=b.sourceCode;
INSERT INTO duplicate_removal
SELECT a.sourceCode AS sourceCode,'lendparticulars' AS intface_type ,a.count AS duplicate_removal_before,b.count AS duplicate_removal_after, NOW() AS create_time 
FROM lendparticulars_count a,lendparticulars_distinct_count b 
WHERE a.sourceCode=b.sourceCode;


## 用户check
INSERT INTO leak_user
SELECT IFNULL(st.sourceCode,@source_code) AS sourceCode, 'scatterinvest' AS intface_type, COUNT(DISTINCT st.userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_scatterinvest st LEFT JOIN tmp_userinfo u 
ON st.userIdcardHash = u.userIdcardHash AND st.sourceCode=u.sourceCode 
WHERE u.userIdcardHash IS NULL;


INSERT INTO leak_user 
SELECT IFNULL(tp.sourceCode,@source_code) AS sourceCode, 'transact' AS intface_type, COUNT(DISTINCT tp.userIdcardHash) AS leak_user_data, NOW() AS create_time 
from (SELECT * FROM tmp_transact WHERE transType IN ('2','6','7','8','9','10','11','17','41','44','23','40','46','48','1','3','18','19','39','32','45','29','27','37','30')) tp 
LEFT JOIN tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode=u.sourceCode 
where u.userIdcardHash IS NULL ; 


INSERT INTO leak_user
SELECT IFNULL(tp.sourceCode,@source_code) AS sourceCode, 'transferproject' AS intface_type, COUNT(DISTINCT tp.userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_transferproject tp LEFT JOIN tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode=u.sourceCode 
WHERE u.userIdcardHash IS NULL;

INSERT INTO leak_user
SELECT IFNULL(tp.sourceCode,@source_code) AS sourceCode, 'undertakeinfo' AS intface_type, COUNT(DISTINCT tp.userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_undertakeinfo tp LEFT JOIN tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode = u.sourceCode 
WHERE u.userIdcardHash IS NULL;

INSERT INTO leak_user
SELECT IFNULL(tp.sourceCode,@source_code) AS sourceCode, 'creditor' AS intface_type, COUNT(DISTINCT tp.userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_creditor tp LEFT JOIN tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode=u.sourceCode 
WHERE u.userIdcardHash IS NULL;

INSERT INTO leak_user
SELECT IFNULL(tp.sourceCode,@source_code) AS sourceCode, 'repayplan' AS intface_type, COUNT(DISTINCT tp.userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_repayplan tp LEFT JOIN tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode = u.sourceCode 
WHERE u.userIdcardHash IS NULL;

INSERT INTO leak_user
SELECT IFNULL(sourceCode,@source_code) sourceCode, 'userinfo_leakypush' AS intface_type, COUNT(userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_userinfo 
WHERE userIdcardHash IN ('-1', '0', '-');

INSERT INTO leak_user
SELECT IFNULL(sourceCode,@source_code) AS sourceCode, 'creditor_leakypush' AS intface_type, COUNT(userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_creditor 
WHERE userIdcardHash IN ('-1', '0', '-');

INSERT INTO leak_user
SELECT IFNULL(sourceCode,@source_code) AS sourceCode, 'repayplan_leakypush' AS intface_type, COUNT(userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_repayplan WHERE userIdcardHash IN ('-1', '0', '-');

INSERT INTO leak_user
SELECT IFNULL(sourceCode,@source_code) AS sourceCode, 'scatterinvest_leakypush' AS intface_type, COUNT(userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_scatterinvest WHERE userIdcardHash IN ('-1', '0', '-');

INSERT INTO leak_user
SELECT IFNULL(sourceCode,@source_code) AS sourceCode, 'transact_leakypush' AS intface_type, COUNT(userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_transact WHERE transtype NOT IN ('3', '13', '27', '30') AND userIdcardHash IN ('-1', '0', '-');

INSERT INTO leak_user
SELECT IFNULL(sourceCode,@source_code) AS sourceCode, 'transferproject_leakypush' AS intface_type, COUNT(userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_transferproject WHERE userIdcardHash IN ('-1', '0', '-');

INSERT INTO leak_user
SELECT IFNULL(sourceCode,@source_code) AS sourceCode, 'undertakeinfo_leakypush' AS intface_type, COUNT(userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_undertakeinfo WHERE userIdcardHash in ('-1', '0', '-');


## 产品用户check
INSERT INTO leak_user
SELECT IFNULL(tp.sourceCode,@source_code) AS sourceCode, 'lendproductconfig' AS intface_type, COUNT(DISTINCT tp.userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_lendproductconfig tp LEFT JOIN tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode=u.sourceCode 
WHERE u.userIdcardHash IS NULL;

INSERT INTO leak_user
SELECT IFNULL(tp.sourceCode,@source_code) AS sourceCode, 'lendparticulars' AS intface_type, COUNT(DISTINCT tp.userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_lendparticulars tp LEFT JOIN tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode=u.sourceCode 
WHERE u.userIdcardHash IS NULL;

INSERT INTO leak_user
SELECT IFNULL(sourceCode,@source_code) AS sourceCode, 'lendproductconfig_leakypush' AS intface_type, COUNT(userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_lendproductconfig WHERE userIdcardHash IN ('-1', '0', '-');

INSERT INTO leak_user
SELECT IFNULL(sourceCode,@source_code) AS sourceCode, 'lendparticulars_leakypush' AS intface_type, COUNT(userIdcardHash) AS leak_user_data, NOW() AS create_time 
FROM tmp_lendparticulars WHERE userIdcardHash in ('-1', '0', '-');


## 3 根据状态过滤散标编号, 去掉流标，初始公布，募集中的散标数据
CREATE TEMPORARY TABLE last_status
SELECT * 
FROM (SELECT * FROM tmp_status GROUP BY sourceProductCode, productStatus ORDER BY productDate DESC) temp 
GROUP BY sourceProductCode 
ORDER BY productDate DESC;

CREATE TEMPORARY TABLE last_online_status
SELECT * FROM last_status WHERE productstatus IN ('1','3','4','5','8','9');

CREATE TEMPORARY TABLE tmp_scatterinvest_3_status
SELECT t2.*,t1.productStatus 
FROM tmp_scatterinvest t2  LEFT JOIN  last_online_status t1 
ON t1.sourceProductCode = t2.sourceProductCode 
WHERE t1.productstatus IS NOT NULL;

ALTER TABLE tmp_scatterinvest_3_status ADD INDEX index_1(sourceProductCode);
ALTER TABLE last_online_status ADD INDEX index_1(sourceProductCode,productStatus);

CREATE TEMPORARY TABLE tmp_loan_money
SELECT sourceCode, sourceProductCode, SUM(transMoney) transMoney 
FROM tmp_transact 
WHERE transType = '1' GROUP BY sourceProductCode;

INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) AS sourceCode, 
'3.1、每个散标的流水类型为：1(放款)的流水是否存在。散标状态为【0-初始公布】、【2-流标（弃标）】、【6-筹标中】的散标不做该check。' AS norm_name, 
COUNT(1) count, NOW() AS create_time 
FROM tmp_scatterinvest_3_status t1 LEFT JOIN tmp_transact t2 on t1.sourceProductCode = t2.sourceProductCode and t1.sourceCode = t2.sourceCode and t2.transType = '1' 
WHERE t2.sourceProductCode IS NULL;

# 3.1 抽样
DROP TABLE IF EXISTS 3_1_problematic_data_sampling;
CREATE TABLE 3_1_problematic_data_sampling
SELECT t1.*
FROM tmp_scatterinvest_3_status t1  LEFT JOIN tmp_transact t2 on t1.sourceProductCode = t2.sourceProductCode and  t1.sourceCode = t2.sourceCode and t2.transType = '1' 
WHERE t2.sourceProductCode IS NULL LIMIT 10;

# 3.2 
CREATE TEMPORARY TABLE last_repayplan
SELECT * 
FROM (SELECT * FROM tmp_repayplan GROUP BY sourceProductCode, issue ORDER BY sendTime DESC) temp 
GROUP BY sourceProductCode, issue 
ORDER BY sendTime DESC;

ALTER TABLE last_repayplan ADD INDEX index_1(sourceProductCode);

CREATE TEMPORARY TABLE repayplan_uptoday_money
SELECT sourceCode, sourceProductCode, SUM(curFund) + sum(curInterest) AS total_sum 
FROM last_repayplan where repayTime < NOW() 
group by sourceProductCode;


CREATE TEMPORARY TABLE transact_repay
SELECT sourceCode, sourceProductCode, SUM(transMoney) AS total_repay, MAX(SUBSTR(transTime, 1 ,10)) AS last_day 
FROM transact WHERE transType IN ('18','19') GROUP BY sourceProductCode;

ALTER TABLE transact_repay ADD INDEX index_1(sourceProductCode, total_repay, last_day);
ALTER TABLE repayplan_uptoday_money ADD INDEX index_1(sourceProductCode, total_sum);

CREATE TEMPORARY TABLE overdue_record
SELECT a.sourceCode, a.sourceProductCode, SUM(a.total_sum) AS replan_money,SUM(b.total_repay) AS transact_money,b.last_day AS last_day 
FROM repayplan_uptoday_money a JOIN transact_repay b ON a.sourceProductCode= b.sourceProductCode 
WHERE a.total_sum > b.total_repay GROUP BY a.sourceProductCode,b.last_day;

CREATE TEMPORARY TABLE transact_repay_time
SELECT sourceProductCode, MAX(transTime) transTime, replanId 
FROM transact 
WHERE transType IN ('18', '19') GROUP BY sourceProductCode;

CREATE TEMPORARY TABLE repay_nomoal
SELECT t1.sourceProductCode 
FROM tmp_repayplan t1, transact_repay_time t2 
WHERE t1.replanId = t2.replanId AND t1.repayTime >= t2.transTime 
AND t1.sourceProductCode = t2.sourceProductCode;


CREATE TEMPORARY TABLE repay_nomoal_1
SELECT t1.sourceProductCode 
FROM tmp_repayplan t1, transact_repay_time t2 
WHERE t1.replanId = CONCAT(substring_index(t2.replanId,'-', 1), '-', substring_index(t2.replanId,'-', -1) - 1) 
AND t2.transTime > t1.repayTime AND t1.sourceProductCode = t2.sourceProductCode;


INSERT INTO norm
SELECT IFNULL(l.sourceCode, @source_code) AS sourceCode, 
'3.2.1、统计所有没有推送【还款计划】的散标的数量。散标状态为【0-初始公布】、【2-流标（弃标）】、【6-筹标中】的散标不做该check。' AS norm_name, 
COUNT(DISTINCT l.sourceProductCode) AS count, NOW() AS create_time 
FROM (SELECT t1.sourceCode, t1.sourceProductCode FROM tmp_scatterinvest t1 LEFT JOIN last_online_status t2 
ON t1.sourceProductCode = t2.sourceProductCode WHERE t2.sourceProductCode IS NOT NULL GROUP BY t1.sourceProductCode) AS `l` LEFT JOIN tmp_repayplan r ON l.sourceProductCode = r.sourceProductCode 
WHERE r.sourceProductCode IS NULL;

## 抽样
DROP TABLE IF EXISTS 3_2_1_problematic_data_sampling;
CREATE TABLE 3_2_1_problematic_data_sampling
SELECT l.*
FROM (SELECT t1.sourceCode, t1.sourceProductCode FROM tmp_scatterinvest t1 LEFT JOIN last_online_status t2 
ON t1.sourceProductCode = t2.sourceProductCode WHERE t2.sourceProductCode IS NOT NULL GROUP BY t1.sourceProductCode) AS `l` LEFT JOIN tmp_repayplan r ON l.sourceProductCode = r.sourceProductCode 
WHERE r.sourceProductCode IS NULL LIMIT 10;

INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) AS sourceCode, 
'3.2.1.1、check往期还款流水中，同一散标的还款流水中，还款月份呈不连续状态，视为大概率流水漏传的散标， 统计并记录散标的数量 ' AS norm_name, 
COUNT(t1.sourceProductCode) count, NOW() AS create_time 
FROM overdue_record t1, transact_repay_time t2, repay_nomoal t3, repay_nomoal_1 t4 
WHERE t1.sourceProductCode = t2.sourceProductCode AND t1.sourceProductCode =  t3.sourceProductCode AND t2.sourceProductCode = t3.sourceProductCode AND t1.sourceProductCode =  t4.sourceProductCode;

## 抽样
DROP TABLE IF EXISTS 3_2_1_1_problematic_data_sampling;
CREATE TABLE 3_2_1_1_problematic_data_sampling
SELECT t1.*
FROM overdue_record t1, transact_repay_time t2, repay_nomoal t3, repay_nomoal_1 t4 
WHERE t1.sourceProductCode = t2.sourceProductCode AND t1.sourceProductCode =  t3.sourceProductCode AND t2.sourceProductCode = t3.sourceProductCode AND t1.sourceProductCode =  t4.sourceProductCode LIMIT 10;

CREATE TEMPORARY TABLE tmp_1
SELECT t1.sourceCode, t1.sourceProductCode FROM tmp_transact AS t1 LEFT JOIN tmp_repayplan AS t2 on t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode IS NOT NULL AND t1.transType = '18' AND t2.curFund > 0 AND t2.curInterest > 0 GROUP BY t1.sourceProductCode;

INSERT INTO norm
SELECT IFNULL(t3.sourceCode, @source_code) AS sourceCode, 
'3.2.1.2、流水数据中，存在往期已还款流水，并且对应的该散标的流水数据中，有 流水类型：18【还款本金】的流水数据，但是 没有 流水类型：19【还款利息】，视为流水不完整的散标， 统计并记录这种散标数量' AS norm_name, 
COUNT(1) AS count, NOW() AS create_time 
FROM tmp_1 AS t3 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM tmp_transact WHERE transType = '19' or transType =  '4' 
GROUP BY sourceProductCode) AS t4 ON t3.sourceProductCode = t4.sourceProductCode WHERE t4.sourceProductCode IS NULL;

## 抽样
DROP TABLE IF EXISTS 3_2_1_2_problematic_data_sampling;
CREATE TABLE 3_2_1_2_problematic_data_sampling
SELECT t3.* 
FROM tmp_1 AS t3 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM tmp_transact WHERE transType = '19' or transType =  '4' 
GROUP BY sourceProductCode) AS t4 ON t3.sourceProductCode = t4.sourceProductCode WHERE t4.sourceProductCode IS NULL LIMIT 10;


CREATE TEMPORARY TABLE tmp_2
SELECT sourceCode, sourceProductCode FROM tmp_transact WHERE transType = '18' GROUP BY sourceProductCode;

INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) as sourceCode, 
'3.2.1.3、流水数据中，存在往期已还款流水，但是对应的该散标的流水数据中，没有 流水类型：8【赎回本金】的流水数据，视为流水不完整的散标， 统计并记录这种散标数量 ' as norm_name, 
COUNT(1) as count, NOW() as create_time 
FROM tmp_2 as t1 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM tmp_transact WHERE transType = '8' GROUP BY sourceProductCode) AS t2 
ON t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode IS NULL;

# 抽样
DROP TABLE IF EXISTS 3_2_1_3_problematic_data_sampling;
CREATE TABLE 3_2_1_3_problematic_data_sampling
SELECT t1.*
FROM tmp_2 as t1 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM tmp_transact WHERE transType = '8' GROUP BY sourceProductCode) AS t2 
ON t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode IS NULL LIMIT 10;


CREATE TEMPORARY TABLE tmp_3
SELECT sourceCode, sourceProductCode FROM tmp_transact WHERE transType = '8' GROUP BY sourceProductCode;

INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) as sourceCode, 
'3.2.1.4、对于往期还款流水，存在流水类型为【18-还款本金】的流水，并且该项目有流水类型为【8-赎回本金】，但是没有类型为【9-赎回利息】的流水，视为流水数据漏推，请检查本地库的流水 ' as norm_name, 
COUNT(1) as count, NOW() as create_time 
FROM tmp_3 as t1 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM tmp_transact WHERE transType = '9' GROUP BY sourceProductCode) AS t2 
ON t1.sourceProductCode = t2.sourceProductCode WHERE t2.sourceProductCode IS NULL;

# 抽样
DROP TABLE IF EXISTS 3_2_1_4_problematic_data_sampling;
CREATE TABLE 3_2_1_4_problematic_data_sampling
SELECT t1.*
FROM tmp_3 as t1 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM tmp_transact WHERE transType = '9' GROUP BY sourceProductCode) AS t2 
ON t1.sourceProductCode = t2.sourceProductCode WHERE t2.sourceProductCode IS NULL LIMIT 10;

CREATE TEMPORARY TABLE tmp_4
SELECT sourceCode, sourceProductCode, totalIssue FROM tmp_repayplan GROUP BY sourceProductCode;

INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) as sourceCode, 
'3.2.1.5、已推送的【还款计划】的完整性check：每个散标还款计划的记录数=该散标还款计划的总期数，如果不相等，视为不完整， 统计并记录散标的数据量 ' as norm_name, 
COUNT(1) count, NOW() create_time 
FROM tmp_4 AS t1, (SELECT sourceCode, sourceProductCode, COUNT(1) count FROM tmp_repayplan GROUP BY sourceProductCode ) AS t2 
WHERE t1.sourceProductCode = t2.sourceProductCode AND t1.totalIssue != t2.count;

# 抽样
DROP TABLE IF EXISTS 3_2_1_5_problematic_data_sampling;
CREATE TABLE 3_2_1_5_problematic_data_sampling
SELECT t1.*
FROM tmp_4 AS t1, (SELECT sourceCode, sourceProductCode, COUNT(1) count FROM tmp_repayplan GROUP BY sourceProductCode ) AS t2 
WHERE t1.sourceProductCode = t2.sourceProductCode AND t1.totalIssue != t2.count LIMIT 10;

CREATE TEMPORARY TABLE temp_scat_cred
SELECT t1.sourceCode, t1.sourceProductCode, t1.amount, sum(t2.invAmount) invAmount, sum(t2.redpackage) redpackage, COUNT(1) count 
FROM tmp_scatterinvest_3_status t1, tmp_creditor t2 
WHERE t1.sourceCode=t2.sourceCode AND t1.sourceProductCode=t2.sourceProductCode GROUP BY t1.sourceProductCode;


INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) as sourceCode, 
'3.3.1、check每个散标的初始债权是否完整推送，即：散标金额=该散标对应的所有的债权金额(投资金额+红包)求和,误差考虑5元以内, 统计并记录漏推散标的数据量。散标状态为【0-初始公布】、【2-流标（弃标）】、【6-筹标中】的散标不做该check。' as norm_name, 
COUNT(1) as count, NOW() as create_time 
FROM temp_scat_cred t1 WHERE (amount - (invAmount + redpackage)) > 5;

# 抽样
DROP TABLE IF EXISTS 3_3_1_problematic_data_sampling;
CREATE TABLE 3_3_1_problematic_data_sampling
SELECT *
FROM temp_scat_cred t1 WHERE (amount - (invAmount + redpackage)) > 5 LIMIT 10;


INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) as sourceCode, 
'3.3.2、统计所有初始债权对应的投资流水（流水类型为：2）没有推送过来的债权数量 ' as norm_name, 
COUNT(1) as count, NOW() as create_time 
FROM tmp_creditor t1 LEFT JOIN tmp_transact t2 ON t1.finClaimId = t2.finClaimId 
WHERE t2.transType = '2' AND t2.finClaimId IS NULL;

## 抽样
DROP TABLE IF EXISTS 3_3_2_problematic_data_sampling;
CREATE TABLE 3_3_2_problematic_data_sampling
SELECT t1.*
FROM tmp_creditor t1 LEFT JOIN tmp_transact t2 ON t1.finClaimId = t2.finClaimId 
WHERE t2.transType = '2' AND t2.finClaimId IS NULL LIMIT 10;

INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) as sourceCode, 
'3.4.1、check每个散标的散标状态是否存在, 统计并记录漏推状态的散标数据量 ' as norm_name,
COUNT(1) AS count, NOW() as create_time 
FROM (SELECT sourceCode, sourceProductCode FROM tmp_scatterinvest) AS t1 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM tmp_status GROUP BY sourceProductCode) t2 ON t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode is NULL;


## 抽样
DROP TABLE IF EXISTS 3_4_1_problematic_data_sampling;
CREATE TABLE 3_4_1_problematic_data_sampling
SELECT t1.*
FROM (SELECT sourceCode, sourceProductCode FROM tmp_scatterinvest) AS t1 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM tmp_status GROUP BY sourceProductCode) t2 ON t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode is NULL LIMIT 10;

CREATE TEMPORARY TABLE tmp_productStatus
SELECT sourceCode, productStatus, COUNT(1) count FROM tmp_status GROUP BY productStatus;

CREATE TEMPORARY TABLE tmp_5
SELECT * FROM tmp_productStatus WHERE productStatus = '1' or productStatus = '5' or productStatus = '9';

INSERT INTO norm
SELECT IFNULL(sourceCode, @source_code) as sourceCode, 
'3.4.2、check散标状态表中，是否存在标识满标状态的数据，如果没有，请检查散标状态值是否有问题' as norm_name,
IF(SUM(count) > 0, 0, (SELECT SUM(count) FROM tmp_productStatus)) AS count, now() AS create_time 
FROM tmp_5 AS t1;


CREATE TEMPORARY TABLE tmp_6
SELECT sourceProductCode, transMoney AS loan FROM tmp_transact WHERE transType = '1' GROUP BY sourceProductCode;

CREATE TEMPORARY TABLE loan_money
SELECT t1.sourceProductCode, (t1.loan + t2.loan_cast) AS loan_money 
FROM tmp_6 AS t1, 
(SELECT sourceProductCode,transMoney AS loan_cast FROM tmp_transact WHERE transType = '4' GROUP BY sourceProductCode) AS t2 
WHERE t1.sourceProductCode = t2.sourceProductCode;

CREATE TEMPORARY TABLE tmp_7
SELECT sourceProductCode, transMoney AS invMoney FROM tmp_transact WHERE transType = '2' GROUP BY sourceProductCode;

CREATE TEMPORARY TABLE ivs_money
SELECT t1.sourceProductCode, (t1.invMoney + t2.redpackage) AS money 
FROM tmp_7 AS t1, 
(SELECT sourceProductCode, transMoney AS redpackage FROM tmp_transact WHERE transType = '10' GROUP BY sourceProductCode) AS t2 
WHERE t1.sourceProductCode = t2.sourceProductCode;

INSERT INTO norm
select IFNULL(sourceCode, @source_code) AS sourceCode, 
'3.5.2、各种类型流水的transmony=0的流水，统计出对应的流水数量' AS norm_name, 
COUNT(1) AS count, NOW() AS create_time 
FROM tmp_transact WHERE transMoney= 0;

## 抽样
DROP TABLE IF EXISTS 3_5_2_problematic_data_sampling;
CREATE TABLE 3_5_2_problematic_data_sampling
select * 
FROM tmp_transact WHERE transMoney = 0 LIMIT 10;

CREATE TEMPORARY TABLE tmp_success_transferStatus 
SELECT t1.*, t2.transferStatus, t2.amount
FROM tmp_transferproject t1, tmp_transferStatus t2 
WHERE t1.transferId = t2.transferId AND t2.transferStatus = '2' AND t1.fromType = '2';

INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) as sourceCode, 
'5.1、check每个【债权转让项目】的【债权转让状态】是否存在，统计并记录漏推状态的散标数据量 ' AS norm_name, 
COUNT(1) count, NOW() AS create_time 
FROM tmp_transferproject t1 LEFT JOIN tmp_transferStatus t2 
ON t1.transferId = t2.transferId WHERE t2.transferId IS NULL;

## 抽样
DROP TABLE IF EXISTS 5_2_problematic_data_sampling;
CREATE TABLE 5_2_problematic_data_sampling
SELECT t1.*
FROM tmp_transferproject t1 LEFT JOIN tmp_transferStatus t2 
ON t1.transferId = t2.transferId WHERE t2.transferId IS NULL LIMIT 10;

INSERT INTO norm
SELECT IFNULL(sourceCode, @source_code) AS sourceCode, 
'5.2、债权来源为：【1-债权信息】的时候，该转让的【债权信息编号】在【初始债权表】中是否存在，如果不存在，统计并记录转让数量 ' as norm_name, 
COUNT(1) AS count, NOW() create_time 
FROM (SELECT t1.sourceCode, t1.finClaimId FROM tmp_transferproject t1 LEFT JOIN tmp_creditor t2 ON t1.finClaimId = t2.finClaimId 
WHERE  t1.fromType = '1' AND t2.finClaimId IS NULL GROUP BY t1.finClaimId) AS t3;

## 抽样
DROP TABLE IF EXISTS 5_2_problematic_data_sampling;
CREATE TABLE 5_2_problematic_data_sampling
SELECT t3.* 
FROM (SELECT t1.sourceCode, t1.finClaimId FROM tmp_transferproject t1 LEFT JOIN tmp_creditor t2 ON t1.finClaimId = t2.finClaimId 
WHERE  t1.fromType = '1' AND t2.finClaimId IS NULL GROUP BY t1.finClaimId) AS t3 LIMIT 10;   

INSERT INTO norm
SELECT IFNULL(sourceCode, @source_code) AS sourceCode, 
'5.3、债权来源为：【2-承接转让信息】的时候，该转让的【债权信息编号】在【承接债权表】中是否存在，如果不存在，统计并记录转让数量 ' as norm_name, 
COUNT(1) AS count, NOW() AS create_time 
FROM (SELECT t1.sourceCode, t1.finClaimId, t1.fromType, t2.unFinClaimId 
FROM tmp_success_transferStatus t1 LEFT JOIN tmp_undertakeinfo t2 ON t1.finClaimId = t2.unFinClaimId WHERE t1.fromType = '2' AND t2.unFinClaimId IS NULL GROUP BY t1.finClaimId) as t1;

## 抽样
DROP TABLE IF EXISTS 5_3_problematic_data_sampling;
CREATE TABLE 5_3_problematic_data_sampling
SELECT t1.*
FROM (SELECT t1.sourceCode, t1.finClaimId, t1.fromType, t2.unFinClaimId 
FROM tmp_success_transferStatus t1 LEFT JOIN tmp_undertakeinfo t2 ON t1.finClaimId = t2.unFinClaimId WHERE t1.fromType = '2' AND t2.unFinClaimId IS NULL GROUP BY t1.finClaimId) as t1 LIMIT 10;

### 产品信息check
INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) AS sourceCode, 
'6.1 check 每个【产品】的【产品配置信息】是否存在，统计并记录产品数据量' as norm_name, 
count(1) count, now() as create_time 
FROM tmp_lendproduct t1 LEFT JOIN tmp_lendproductconfig t2 ON t1.sourceFinancingCode = t2.sourceFinancingCode 
WHERE t2.sourceFinancingCode IS NULL;

## 抽样
DROP TABLE IF EXISTS 6_1_problematic_data_sampling;
CREATE TABLE 6_1_problematic_data_sampling
SELECT t1.*
FROM tmp_lendproduct t1 LEFT JOIN tmp_lendproductconfig t2 ON t1.sourceFinancingCode = t2.sourceFinancingCode 
WHERE t2.sourceFinancingCode IS NULL;

INSERT INTO norm
SELECT IFNULL(t1.sourceCode, @source_code) AS sourceCode,
'6.2 check 每个【产品】的【投资明细】是否存在，统计并记录产品数据量' as norm_name, 
count(1) count, now() as create_time FROM tmp_lendproduct t1 LEFT JOIN tmp_lendparticulars t2 
ON t1.sourceFinancingCode = t2.sourceFinancingCode 
WHERE t2.sourceFinancingCode IS NULL;

## 抽样
DROP TABLE IF EXISTS 6_2_problematic_data_sampling;
CREATE TABLE 6_2_problematic_data_sampling
SELECT t1.*
FROM tmp_lendproduct t1 LEFT JOIN tmp_lendparticulars t2 
ON t1.sourceFinancingCode = t2.sourceFinancingCode 
WHERE t2.sourceFinancingCode IS NULL;

INSERT INTO norm
SELECT IFNULL(t3.sourceCode, @source_code) AS sourceCode, 
'6.3 check 该产品的【产品配置信息】是否在【初始债权表/承接转让表】中是否存在，如果不存在，统计并记录数量' as norm_name, 
COUNT(1) as count, now() create_time 
FROM (SELECT t1.sourceCode, t1.finClaimId FROM tmp_lendproductconfig t1 LEFT JOIN (SELECT finClaimId FROM tmp_creditor UNION SELECT unFinClaimId AS finClaimId FROM tmp_undertakeinfo) t2 ON t1.finClaimId = t2.finClaimId 
WHERE t2.finClaimId IS NULL GROUP BY t1.finClaimId) as t3;

## 抽样
DROP TABLE IF EXISTS 6_3_problematic_data_sampling;
CREATE TABLE 6_3_problematic_data_sampling
SELECT t3.sourceCode, t3.finClaimId
FROM (SELECT t1.sourceCode, t1.finClaimId FROM tmp_lendproductconfig t1 LEFT JOIN (SELECT finClaimId FROM tmp_creditor UNION SELECT unFinClaimId AS finClaimId FROM tmp_undertakeinfo) t2 ON t1.finClaimId = t2.finClaimId 
WHERE t2.finClaimId IS NULL GROUP BY t1.finClaimId) as t3;