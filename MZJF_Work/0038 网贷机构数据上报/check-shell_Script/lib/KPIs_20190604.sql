use report_kpis;

-- 关键指标基于check 中的临时表
-- 关键指标表
drop table if exists report_kpis.`key_target`;
CREATE TABLE IF NOT EXISTS report_kpis.`key_target` (
  `source_code` string,
  `type` string,
  `credit_balance` string COMMENT '借贷余额',
  `lend_number` string COMMENT '在投人数',
  `borrowing_number` string COMMENT '在借人数',
  `create_time` string
) ;



--//////////////////////////////////////////////////////////
-- setp 1 去重临时表
drop table if exists report_kpis.tmp_creditor;
create table report_kpis.tmp_creditor as 
SELECT sourceCode,finClaimId,sourceProductCode,userIdcardHash,invAmount,invRate,invTime,redpackage,lockTime
FROM pdw.report_05_creditor
GROUP BY sourceCode,finClaimId,sourceProductCode,userIdcardHash,invAmount,invRate,invTime,redpackage,lockTime;


drop table if exists report_kpis.tmp_repayplan;
create table report_kpis.tmp_repayplan as
SELECT sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge, repayTime,sendTime 
FROM pdw.report_04_repayplan 
GROUP BY sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge,repayTime,sendTime;






--drop table if exists report_kpis.tmp_scatterinvest;
--create table report_kpis.tmp_scatterinvest as 
--SELECT sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount 
--FROM pdw.report_02_scatterinvest 
--GROUP BY sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount;









drop table if exists report_kpis.tmp_scatterinvest_1;
create table report_kpis.tmp_scatterinvest_1 as
SELECT sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount
FROM pdw.report_02_scatterinvest 
GROUP BY sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount;


drop table if exists report_kpis.tmp_scatterinvest;
create table report_kpis.tmp_scatterinvest as
SELECT sourceCode,sourceProductCode,userIdcardHash,loanUse,loanRate,surplusAmount AS amount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount
FROM report_kpis.tmp_scatterinvest_1
WHERE CAST(surplusAmount AS DECIMAL(32,16)) > 0.00;


















drop table if exists report_kpis.tmp_status;
create table report_kpis.tmp_status as 
SELECT sourceCode,sourceProductCode,productStatus,productDate 
FROM pdw.report_03_status 
GROUP BY sourceCode,sourceProductCode,productStatus,productDate;


drop table if exists report_kpis.tmp_transact;
create table report_kpis.tmp_transact as 
SELECT sourceCode,transId,sourceProductCode,finClaimId,transferId,replanId,transType,transMoney,userIdcardHash,transTime
FROM pdw.report_09_transact 
GROUP BY sourceCode,transId,sourceProductCode,finClaimId,transferId,replanId,transType,transMoney,userIdcardHash,transTime;

drop table if exists report_kpis.tmp_transferproject;
create table report_kpis.tmp_transferproject as 
SELECT sourceCode,transferId,fromType,finClaimId,userIdcardHash,sourceProductCode,transferAmount,transferInterestRate,floatMoney,transferDate 
FROM pdw.report_06_transferproject
GROUP BY sourceCode,transferId,fromType,finClaimId,userIdcardHash,sourceProductCode,transferAmount,transferInterestRate,floatMoney,transferDate;

drop table if exists report_kpis.tmp_transferStatus;
create table report_kpis.tmp_transferStatus as 
SELECT sourceCode,transferId,transferStatus,amount,floatMoney,productDate 
FROM pdw.report_07_transferstatus 
GROUP BY sourceCode,transferId,transferStatus,amount,floatMoney,productDate;

drop table if exists report_kpis.tmp_undertakeinfo;
create table report_kpis.tmp_undertakeinfo as 
SELECT sourceCode,unFinClaimId,transferId,finClaimId,userIdcardHash,takeAmount,takeInterest,floatMoney,takeRate,takeTime,redpackage,lockTime 
FROM pdw.report_08_undertakeinfo 
GROUP BY sourceCode,unFinClaimId,transferId,finClaimId,userIdcardHash,takeAmount,takeInterest,floatMoney,takeRate,takeTime,redpackage,lockTime;


--ALTER TABLE tmp_creditor ADD INDEX index_1(userIdcardHash);
--ALTER TABLE tmp_creditor ADD INDEX index_2(finClaimId);
--ALTER TABLE tmp_scatterinvest ADD INDEX index_1(userIdcardHash);
--ALTER TABLE tmp_scatterinvest ADD INDEX index_2(sourceProductCode);
--ALTER TABLE tmp_repayplan ADD INDEX index_1(userIdcardHash);
--ALTER TABLE tmp_repayplan ADD INDEX index_2(sourceProductCode,issue,sendTime);
--ALTER TABLE tmp_transact ADD INDEX index_1(userIdcardHash);
--ALTER TABLE tmp_transact ADD INDEX index_2(sourceProductCode);
--ALTER TABLE tmp_transact ADD INDEX index_3(finClaimId);
--ALTER TABLE tmp_userinfo ADD INDEX index_1(userIdcardHash);
--ALTER TABLE tmp_transferproject ADD INDEX index_1(userIdcardHash);
--ALTER TABLE tmp_transferproject ADD INDEX index_2(transferId, fromType);
--ALTER TABLE tmp_undertakeinfo ADD INDEX index_1(userIdcardHash);
--ALTER TABLE tmp_undertakeinfo ADD INDEX index_2(unFinClaimId);
--ALTER TABLE tmp_status ADD INDEX index_1(sourceProductCode,productStatus);
--ALTER TABLE tmp_transferStatus ADD INDEX index_1(transferId);



--CREATE TEMPORARY TABLE last_status
--SELECT * 
--FROM (SELECT * FROM tmp_status GROUP BY sourceProductCode, productStatus ORDER BY productDate DESC) temp 
--GROUP BY sourceProductCode 
--ORDER BY productDate DESC ;







--//////////////////////////////////////////////////////////////////////////////////












---- 关键指标
-- 1、借贷余额
drop table if exists report_kpis.last_online_status_1;
create table report_kpis.last_online_status_1 as 
SELECT sourceProductCode 
FROM (SELECT sourceProductCode,productStatus
FROM (select * from report_kpis.tmp_status ORDER BY productDate DESC) temp1  GROUP BY sourceProductCode, productStatus
 ) temp where productstatus IN ('1','4','5','8','9')
GROUP BY sourceProductCode;

--ALTER TABLE last_online_status_1 ADD INDEX index_1(sourceProductCode);



drop table if exists report_kpis.tmp_lend_amount;
create table report_kpis.tmp_lend_amount as 
SELECT t2.sourceCode, t2.sourceProductCode, t2.userIdcardHash, t2.amount 
FROM report_kpis.last_online_status_1 t1 LEFT JOIN report_kpis.tmp_scatterinvest t2 ON t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode IS NOT NULL;


drop table if exists report_kpis.loan_all_amount;
create table report_kpis.loan_all_amount as 
select t1.sourceCode,t1.sourceProductCode,t1.userIdcardHash, (cast(t1.amount as decimal(32,16)) + IFNULL(cast(t2.curInterest as decimal(32,16)), 0)) AS amount 
from report_kpis.tmp_lend_amount t1 
left join (select sourceCode, sourceProductCode, userIdcardHash, IFNULL(sum(cast(curInterest as decimal(32,16))), 0) curInterest from report_kpis.tmp_repayplan group by sourceCode,sourceProductCode, userIdcardHash) t2 
on t1.sourceProductCode = t2.sourceProductCode;







drop table if exists report_kpis.loan_all_amount_19;
create table report_kpis.loan_all_amount_19 as 
SELECT t1.sourceCode,IFNULL(SUM(cast(t2.transMoney as decimal(32,16))), 0) transMoney 
FROM report_kpis.loan_all_amount t1 
LEFT JOIN (SELECT * FROM report_kpis.tmp_transact WHERE transType = '19') t2 
ON t1.sourceProductCode = t2.sourceProductCode
group by 1;





drop table if exists report_kpis.loan_all_amount_18;
create table report_kpis.loan_all_amount_18 as 
SELECT t1.sourceCode, IFNULL(SUM(cast(t2.transMoney as decimal(32,16))), 0) transMoney 
FROM report_kpis.loan_all_amount t1 
LEFT JOIN (SELECT * FROM report_kpis.tmp_transact WHERE transType = '18') t2 
ON t1.sourceProductCode = t2.sourceProductCode
group by 1 ;




drop table if exists report_kpis.key_t;
create table report_kpis.key_t as 
SELECT t1.sourceCode, amount - t2.transmoney - t3.transMoney AS credit_balance
FROM (
        select t1.sourceCode, SUM(t1.amount) amount
          from report_kpis.loan_all_amount t1 
        group by 1
     ) t1 
LEFT JOIN report_kpis.loan_all_amount_19 t2 
ON t1.sourceCode = t2.sourceCode
LEFT JOIN report_kpis.loan_all_amount_18 t3 
ON t2.sourceCode = t3.sourceCode;



-- 在借人数
drop table if exists report_kpis.tmp_num_of_borrowers;
create table report_kpis.tmp_num_of_borrowers as 
SELECT DISTINCT t1.sourceproductcode FROM (SELECT sourceCode, sourceproductcode FROM report_kpis.tmp_scatterinvest) t1 
	LEFT JOIN (SELECT DISTINCT sourceproductcode FROM report_kpis.tmp_status WHERE productStatus IN ('2', '3')) t2 
	ON t1.sourceproductcode = t2.sourceproductcode WHERE t2.sourceproductcode IS NULL;


drop table if exists report_kpis.num_of_borrowers;
create table report_kpis.num_of_borrowers as 
select t4.sourceCode, COUNT(DISTINCT t4.useridcardhash) num_of_borrowers 
FROM report_kpis.tmp_num_of_borrowers AS t3 
LEFT JOIN report_kpis.tmp_scatterinvest t4 ON t3.sourceproductcode = t4.sourceproductcode
group by 1 ;



-- 再投人数   /*  无法check   */
drop table if exists report_kpis.creditor_transfer;
create table report_kpis.creditor_transfer as 
SELECT t2.finClaimId, t1.transferId, t2.sourceProductCode, t2.userIdcardHash, t2.invAmount
FROM report_kpis.tmp_creditor t2 LEFT JOIN report_kpis.tmp_transferproject t1
ON t1.sourceCode = t2.sourceCode AND t1.finClaimId = t2.finClaimId AND t1.userIdcardHash = t2.userIdcardHash;



drop table if exists report_kpis.creditor_transfer_status;
create table report_kpis.creditor_transfer_status as 
SELECT t1.*, IFNULL(cast(t2.amount as decimal(32,16)),0) amount FROM report_kpis.creditor_transfer t1
LEFT JOIN (SELECT * FROM report_kpis.tmp_transferStatus WHERE transferStatus = '2') t2
ON t1.transferId = t2.transferId;



drop table if exists report_kpis.creditor_transfer_status_transact;
create table report_kpis.creditor_transfer_status_transact as 
SELECT t1.*, IFNULL(cast(t2.transMoney as decimal(32,16)),0) transMoney FROM report_kpis.creditor_transfer_status t1 LEFT JOIN (SELECT * FROM report_kpis.tmp_transact WHERE transType = '8') t2
ON t1.finClaimId = t2.finClaimId AND t1.userIdcardHash = t2.userIdcardHash;



drop table if exists report_kpis.undertake_transfer;
create table report_kpis.undertake_transfer as 
SELECT t2.unFinClaimId, t1.transferId, t2.userIdcardHash, t2.takeAmount
FROM report_kpis.tmp_undertakeinfo t2 LEFT JOIN report_kpis.tmp_transferproject t1
ON t1.sourceCode = t2.sourceCode AND t1.finClaimId = t2.unFinClaimId AND t1.userIdcardHash = t2.userIdcardHash;



drop table if exists report_kpis.undertake_transfer_status;
create table report_kpis.undertake_transfer_status as 
SELECT t1.*, IFNULL(cast(t2.amount as decimal(32,16)),0) amount FROM report_kpis.undertake_transfer t1 LEFT JOIN (SELECT * FROM report_kpis.tmp_transferStatus WHERE transferStatus = '2') t2
ON t1.transferId = t2.transferId;



drop table if exists report_kpis.undertake_transfer_status_transact;
create table report_kpis.undertake_transfer_status_transact as 
SELECT t1.*, IFNULL(cast(t2.transMoney as decimal(32,16)),0) transMoney FROM report_kpis.undertake_transfer_status t1 LEFT JOIN (SELECT * FROM report_kpis.tmp_transact WHERE transType = '8') t2
ON t1.unFinClaimId = t2.finClaimId AND t1.userIdcardHash = t2.userIdcardHash;







-- 关键指标
INSERT overwrite table report_kpis.key_target
SELECT t2.sourceCode AS source_code, '通过项目统计' AS type, cast(t2.credit_balance as string), cast(t3.lend_number as string), cast(t4.num_of_borrowers as string)  AS borrowing_number, to_date(NOW()) AS create_time FROM
(SELECT COUNT(DISTINCT userIdcardHash) lend_number FROM 
(SELECT userIdcardHash FROM report_kpis.undertake_transfer_status_transact WHERE (cast(takeAmount as DECIMAL(32,16)) - cast(amount as DECIMAL(32,16)) - cast(transMoney as DECIMAL(32,16))) > 0.1
UNION 
SELECT userIdcardHash FROM report_kpis.creditor_transfer_status_transact WHERE (cast(invAmount as DECIMAL(32,16)) - cast(amount as DECIMAL(32,16)) - cast(transMoney as DECIMAL(32,16))) > 0.1) AS t1) AS t3, report_kpis.key_t AS t2, report_kpis.num_of_borrowers AS t4;



-- 关键指标流水
-- 投资

drop table if exists report_kpis.total_invest_uid;
create table report_kpis.total_invest_uid as
SELECT sourceCode,userIdcardHash,SUM(CAST(transMoney AS DECIMAL(32,16))) AS invamount
FROM report_kpis.tmp_transact
WHERE transType IN ('2', '17')
GROUP BY sourceCode,userIdcardHash;




-- 投资人的赎回和转让  8.赎回 11.全部转让 26.部分转让
drop table if exists report_kpis.redemption;
create table report_kpis.redemption as
SELECT sourceCode, userIdcardHash, sum(CAST(transMoney AS DECIMAL(32,16))) AS amount
FROM report_kpis.tmp_transact
WHERE transtype IN ('8', '11', '26')
GROUP BY sourceCode, userIdcardHash;



-- 在投人
drop table if exists report_kpis.online_invest_uid;
create table report_kpis.online_invest_uid as
SELECT t1.sourceCode, t1.userIdcardHash, t1.invamount AS total_amount, t1.invamount - IFNULL(t2.amount,0) AS amount
FROM
	total_invest_uid t1
LEFT JOIN report_kpis.redemption t2 ON t1.userIdcardHash = t2.userIdcardHash
WHERE t1.invamount > IFNULL(t2.amount,0) + 0.1;



-- 借款
drop table if exists report_kpis.total_loan_uid;
create table report_kpis.total_loan_uid as
SELECT t1.sourceCode, t1.userIdcardHash, t1.sourceProductCode, CAST(t2.amount AS DECIMAL(32,16)) amount
FROM
	(SELECT sourceCode, userIdcardHash, sourceProductCode FROM report_kpis.tmp_transact WHERE transtype = '1'
GROUP BY sourceCode, userIdcardHash, sourceProductCode) t1
LEFT JOIN tmp_scatterinvest t2 ON t1.userIdcardHash = t2.userIdcardHash
AND t1.sourceProductCode = t2.sourceProductCode;



drop table if exists report_kpis.repayMoney;
create table report_kpis.repayMoney as
SELECT sourceCode, userIdcardHash, sourceProductCode, SUM(CAST(transmoney AS DECIMAL(32,16))) AS amount
FROM report_kpis.tmp_transact
WHERE transtype = '18' GROUP BY sourceCode, userIdcardHash, sourceProductCode;



drop table if exists report_kpis.online_loan_uid;
create table report_kpis.online_loan_uid as
SELECT t1.sourceCode, t1.userIdcardHash, t1.sourceProductCode,(t1.amount - IFNULL(t2.amount,0)) AS amount
FROM (SELECT sourceCode, userIdcardHash, sourceProductCode, SUM(amount) amount from report_kpis.total_loan_uid GROUP BY sourceProductCode,sourceCode, userIdcardHash) t1
LEFT JOIN (SELECT sourceCode, userIdcardHash, sourceProductCode, SUM(amount) amount FROM report_kpis.repayMoney GROUP BY sourceProductCode,sourceCode, userIdcardHash) t2 ON  t1.sourceProductCode = t2.sourceProductCode
WHERE t1.amount - IFNULL(t2.amount,0) > 0.1;


---- 关键指标 流水
INSERT INTO report_kpis.key_target
SELECT t1.sourceCode AS source_code, '通过流水统计' AS type, cast(t1.credit_balance as string), cast(t2.lend_number as string), cast(t1.borrowing_number as string), cast(NOW() as string) AS create_time
FROM (SELECT sourceCode,SUM(amount) credit_balance, COUNT(DISTINCT userIdcardHash) borrowing_number FROM report_kpis.online_loan_uid group by sourceCode) t1
LEFT JOIN (SELECT sourceCode,COUNT(DISTINCT userIdcardHash) lend_number FROM report_kpis.online_invest_uid group by sourceCode ) t2
ON t1.sourceCode = t2.sourceCode;

