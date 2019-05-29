
## 关键指标基于check 中的临时表
## 关键指标表 
CREATE TABLE IF NOT EXISTS `key_target` (
  `source_code` varchar(255) DEFAULT NULL,
  `credit_balance` varchar(255) DEFAULT NULL COMMENT '借贷余额',
  `lend_number` varchar(50) DEFAULT NULL COMMENT '在投人数',
  `borrowing_number` varchar(50) DEFAULT NULL COMMENT '在借人数',
  `create_time` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


#//////////////////////////////////////////////////////////
## setp 1 去重临时表
CREATE TEMPORARY TABLE tmp_creditor
SELECT sourceCode,finClaimId,sourceProductCode,userIdcardHash,invAmount,invRate,invTime,redpackage,lockTime
FROM creditor
GROUP BY sourceCode,finClaimId,sourceProductCode,userIdcardHash,invAmount,invRate,invTime,redpackage,lockTime;

CREATE TEMPORARY TABLE tmp_repayplan
SELECT sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge, repayTime,sendTime
FROM repayplan
GROUP BY sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge,repayTime,sendTime;

CREATE TEMPORARY TABLE tmp_repayplan_init
SELECT sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge, repayTime,sendTime
FROM repayplan
GROUP BY sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge,repayTime,sendTime;

CREATE TEMPORARY TABLE tmp_repayplan_init_new
SELECT t1.* from tmp_repayplan t1,
(select sourceProductCode, totalIssue, sendTime from tmp_repayplan_init GROUP BY sourceProductCode ORDER BY sendTime DESC) t2
WHERE t1.sourceProductCode = t2.sourceProductCode and t1.totalIssue = t2.totalIssue;

DROP TABLE tmp_repayplan;
CREATE TEMPORARY TABLE tmp_repayplan
SELECT * FROM tmp_repayplan_init_new;

DROP TABLE tmp_repayplan_init;


CREATE TEMPORARY TABLE tmp_scatterinvest
SELECT sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount,sendTime
FROM scatterinvest
GROUP BY sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount,sendTime;

CREATE TEMPORARY TABLE tmp_scatterinvest_init
SELECT *
FROM (SELECT * FROM tmp_scatterinvest GROUP BY sourceProductCode ORDER BY sendTime DESC) temp
GROUP BY sourceProductCode
ORDER BY sendTime DESC;

CREATE TEMPORARY TABLE tmp_scatterinvest_init_1
SELECT * FROM tmp_scatterinvest_init;

DROP TABLE tmp_scatterinvest;

CREATE TEMPORARY TABLE tmp_scatterinvest
SELECT sourceCode,sourceProductCode,userIdcardHash,loanUse,loanRate,amount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount,sendTime
FROM tmp_scatterinvest_init
WHERE CAST(surplusAmount AS DECIMAL(32,16)) <= 0.00 OR surplusAmount IS NULL OR surplusAmount = ''
UNION
SELECT sourceCode,sourceProductCode,userIdcardHash,loanUse,loanRate,surplusAmount AS amount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount,sendTime
FROM tmp_scatterinvest_init_1
WHERE CAST(surplusAmount AS DECIMAL(32,16)) > 0.00;

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

ALTER TABLE tmp_creditor ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_creditor ADD INDEX index_2(finClaimId);
ALTER TABLE tmp_scatterinvest ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_scatterinvest ADD INDEX index_2(sourceProductCode);
ALTER TABLE tmp_repayplan ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_repayplan ADD INDEX index_2(sourceProductCode,issue,sendTime);
ALTER TABLE tmp_transact ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_transact ADD INDEX index_2(sourceProductCode);
ALTER TABLE tmp_transact ADD INDEX index_3(finClaimId);
ALTER TABLE tmp_transferproject ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_transferproject ADD INDEX index_2(transferId, fromType);
ALTER TABLE tmp_undertakeinfo ADD INDEX index_1(userIdcardHash);
ALTER TABLE tmp_undertakeinfo ADD INDEX index_2(unFinClaimId);
ALTER TABLE tmp_status ADD INDEX index_1(sourceProductCode,productStatus);
ALTER TABLE tmp_transferStatus ADD INDEX index_1(transferId);



CREATE TEMPORARY TABLE last_status
SELECT * 
FROM (SELECT * FROM tmp_status GROUP BY sourceProductCode, productStatus ORDER BY productDate DESC) temp 
GROUP BY sourceProductCode 
ORDER BY productDate DESC;

#//////////////////////////////////////////////////////////////////////////////////


#### 关键指标
# 1: 借贷余额
CREATE TEMPORARY TABLE last_online_status_1
SELECT * FROM last_status WHERE productstatus IN ('1','4','5','8','9');
ALTER TABLE last_online_status_1 ADD INDEX index_1(sourceProductCode);

CREATE TEMPORARY TABLE tmp_lend_amount
SELECT t2.sourceCode, t2.sourceProductCode, t2.userIdcardHash, t2.amount
FROM last_online_status_1 t1 LEFT JOIN tmp_scatterinvest t2
ON t1.sourceProductCode = t2.sourceProductCode WHERE t2.sourceProductCode IS NOT NULL;

CREATE TEMPORARY TABLE loan_all_amount
SELECT t1.sourceCode,t1.sourceProductCode,t1.userIdcardHash, CAST((t1.amount + IFNULL(t2.curInterest, 0)) AS DECIMAL(32,16)) AS amount
FROM tmp_lend_amount t1 LEFT JOIN (SELECT sourceCode, sourceProductCode, userIdcardHash, CAST(IFNULL(SUM(curInterest), 0) AS DECIMAL(32,16)) curInterest FROM tmp_repayplan GROUP BY sourceCode,sourceProductCode, userIdcardHash) t2
ON t1.sourceProductCode = t2.sourceProductCode;

CREATE TEMPORARY TABLE loan_all_amount_19
SELECT t1.sourceCode,CAST(IFNULL(SUM(t2.transMoney), 0) AS DECIMAL(32,16)) transMoney FROM loan_all_amount t1 LEFT JOIN (SELECT * FROM tmp_transact WHERE transType = '19') t2 ON t1.sourceProductCode = t2.sourceProductCode;

CREATE TEMPORARY TABLE loan_all_amount_18
SELECT t1.sourceCode, CAST(IFNULL(SUM(t2.transMoney), 0) AS DECIMAL(32,16)) transMoney FROM loan_all_amount t1 LEFT JOIN (SELECT * FROM tmp_transact WHERE transType = '18') t2 ON t1.sourceProductCode = t2.sourceProductCode;


CREATE TEMPORARY TABLE key_t
SELECT t1.sourceCode, CAST(SUM(t1.amount) - t2.transmoney - t3.transMoney AS DECIMAL(32,16)) AS credit_balance
FROM loan_all_amount t1 LEFT JOIN loan_all_amount_19 t2 ON t1.sourceCode = t2.sourceCode
LEFT JOIN loan_all_amount_18 t3 ON t2.sourceCode = t3.sourceCode;

# 在借人数
CREATE TEMPORARY TABLE tmp_num_of_borrowers
SELECT DISTINCT t1.sourceproductcode FROM (SELECT sourceCode, sourceproductcode FROM tmp_scatterinvest) t1 
LEFT JOIN (SELECT DISTINCT sourceproductcode FROM tmp_status WHERE productStatus IN ('2', '3')) t2
ON t1.sourceproductcode = t2.sourceproductcode WHERE t2.sourceproductcode IS NULL;

CREATE TEMPORARY TABLE num_of_borrowers
select t4.sourceCode, COUNT(DISTINCT t4.useridcardhash) num_of_borrowers 
FROM tmp_num_of_borrowers AS t3 
LEFT JOIN tmp_scatterinvest t4 ON t3.sourceproductcode = t4.sourceproductcode;


## 在投人数
## 债权
CREATE TEMPORARY TABLE creditor_transfer
SELECT t2.finClaimId, t1.transferId, t2.sourceProductCode, t2.userIdcardHash, t2.invAmount
FROM tmp_creditor t2 LEFT JOIN tmp_transferproject t1
ON t1.sourceCode = t2.sourceCode AND t1.finClaimId = t2.finClaimId AND t1.userIdcardHash = t2.userIdcardHash;

CREATE TEMPORARY TABLE creditor_transfer_status
SELECT t1.*, IFNULL(t2.amount,0) amount FROM creditor_transfer t1
LEFT JOIN (SELECT * FROM tmp_transferStatus WHERE transferStatus = '2') t2
ON t1.transferId = t2.transferId;

CREATE TEMPORARY TABLE creditor_transfer_status_transact
SELECT t1.*, IFNULL(t2.transMoney,0) transMoney FROM creditor_transfer_status t1
LEFT JOIN (SELECT finClaimId, userIdcardHash,CAST(SUM(transMoney) AS DECIMAL(32,16)) transMoney FROM tmp_transact WHERE transType = '8' GROUP BY finClaimId, userIdcardHash) t2
ON t1.finClaimId = t2.finClaimId AND t1.userIdcardHash = t2.userIdcardHash;

## 承接
CREATE TEMPORARY TABLE undertake_transfer
SELECT t2.unFinClaimId, t1.transferId, t2.userIdcardHash, t2.takeAmount
FROM tmp_undertakeinfo t2 LEFT JOIN tmp_transferproject t1
ON t1.sourceCode = t2.sourceCode AND t1.finClaimId = t2.unFinClaimId AND t1.userIdcardHash = t2.userIdcardHash;

CREATE TEMPORARY TABLE undertake_transfer_status
SELECT t1.*, IFNULL(t2.amount,0) amount FROM undertake_transfer t1
LEFT JOIN (SELECT * FROM tmp_transferStatus WHERE transferStatus = '2') t2
ON t1.transferId = t2.transferId;

CREATE TEMPORARY TABLE undertake_transfer_status_transact
SELECT t1.*, IFNULL(t2.transMoney,0) transMoney FROM undertake_transfer_status t1
LEFT JOIN (SELECT finClaimId, userIdcardHash,CAST(SUM(transMoney) AS DECIMAL(32,16)) transMoney FROM tmp_transact WHERE transType = '8' GROUP BY finClaimId, userIdcardHash) t2
ON t1.unFinClaimId = t2.finClaimId AND t1.userIdcardHash = t2.userIdcardHash;

## 关键指标
INSERT INTO key_target
SELECT t2.sourceCode AS source_code, t2.credit_balance, t3.lend_number, t4.num_of_borrowers  AS borrowing_number, NOW() AS create_time FROM
(SELECT COUNT(DISTINCT userIdcardHash) lend_number FROM 
(SELECT userIdcardHash FROM undertake_transfer_status_transact WHERE (takeAmount - amount - transMoney) > 0.0
UNION 
SELECT userIdcardHash FROM creditor_transfer_status_transact WHERE (invAmount - amount - transMoney) > 0.0) AS t1) AS t3, key_t AS t2, num_of_borrowers AS t4;
