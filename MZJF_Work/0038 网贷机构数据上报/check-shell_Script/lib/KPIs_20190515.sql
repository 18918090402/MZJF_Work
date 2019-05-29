
## 关键指标基于check 中的临时表
## 关键指标表 

drop table if exists report_kpis.`key_target`;

CREATE TABLE IF NOT EXISTS report_kpis.`key_target` (
  `source_code` string,
  `credit_balance` string COMMENT '借贷余额',
  `lend_number` string COMMENT '在投人数',
  `borrowing_number` string COMMENT '在借人数',
  `create_time` string
) ;



#//////////////////////////////////////////////////////////
## setp 1 去重临时表
drop table if exists report_kpis.tmp_creditor;
create table report_kpis.tmp_creditor as 
SELECT sourceCode,finClaimId,sourceProductCode,userIdcardHash,invAmount,invRate,invTime,redpackage,lockTime
FROM pdw_sample.report_05_creditor
GROUP BY sourceCode,finClaimId,sourceProductCode,userIdcardHash,invAmount,invRate,invTime,redpackage,lockTime;



drop table if exists report_kpis.tmp_repayplan;
create table report_kpis.tmp_repayplan as 
SELECT sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge, repayTime,sendTime 
FROM pdw_sample.report_04_repayplan 
GROUP BY sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge,repayTime,sendTime;



drop table if exists report_kpis.tmp_scatterinvest;
create table report_kpis.tmp_scatterinvest as 
SELECT sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount 
FROM pdw_sample.report_02_scatterinvest 
GROUP BY sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount;





drop table if exists report_kpis.tmp_status;
create table report_kpis.tmp_status as 
SELECT sourceCode,sourceProductCode,productStatus,productDate 
FROM pdw_sample.report_03_status 
GROUP BY sourceCode,sourceProductCode,productStatus,productDate;



drop table if exists report_kpis.tmp_transact;
create table report_kpis.tmp_transact as 
SELECT sourceCode,transId,sourceProductCode,finClaimId,transferId,replanId,transType,transMoney,userIdcardHash,transTime
FROM pdw_sample.report_09_transact 
GROUP BY sourceCode,transId,sourceProductCode,finClaimId,transferId,replanId,transType,transMoney,userIdcardHash,transTime;



drop table if exists report_kpis.tmp_transferproject;
create table report_kpis.tmp_transferproject as 
SELECT sourceCode,transferId,fromType,finClaimId,userIdcardHash,sourceProductCode,transferAmount,transferInterestRate,floatMoney,transferDate 
FROM pdw_sample.report_06_transferproject
GROUP BY sourceCode,transferId,fromType,finClaimId,userIdcardHash,sourceProductCode,transferAmount,transferInterestRate,floatMoney,transferDate;




drop table if exists report_kpis.tmp_transferStatus;
create table report_kpis.tmp_transferStatus as 
SELECT sourceCode,transferId,transferStatus,amount,floatMoney,productDate 
FROM pdw_sample.report_07_transferstatus 
GROUP BY sourceCode,transferId,transferStatus,amount,floatMoney,productDate;


drop table if exists report_kpis.tmp_undertakeinfo;
create table report_kpis.tmp_undertakeinfo as 
SELECT sourceCode,unFinClaimId,transferId,finClaimId,userIdcardHash,takeAmount,takeInterest,floatMoney,takeRate,takeTime,redpackage,lockTime 
FROM pdw_sample.report_08_undertakeinfo 
GROUP BY sourceCode,unFinClaimId,transferId,finClaimId,userIdcardHash,takeAmount,takeInterest,floatMoney,takeRate,takeTime,redpackage,lockTime;


drop table if exists report_kpis.tmp_userinfo;
create table report_kpis.tmp_userinfo as 
SELECT sourceCode,userType,userAttr,userCreateTime,userName,countries,userIdcard,userIdcardHash,userPhone,userPhoneHash,userProvince,userAddress,userSex 
FROM pdw_sample.report_01_userinfo 
GROUP BY sourceCode,userType,userAttr,userCreateTime,userName,countries,userIdcard,userIdcardHash,userPhone,userPhoneHash,userProvince,userAddress,userSex;


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






#//////////////////////////////////////////////////////////////////////////////////



#### 关键指标
# 1、借贷余额


--CREATE TEMPORARY TABLE last_status
--SELECT * 
--FROM (SELECT * FROM tmp_status GROUP BY sourceProductCode, productStatus ORDER BY productDate DESC) temp 
--GROUP BY sourceProductCode 
--ORDER BY productDate DESC ;

--修改以上代码 结果如下

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
FROM report_kpis.last_online_status_1 t1 LEFT JOIN report_kpis.tmp_scatterinvest t2 ON t1.sourceProductCode = t2.sourceProductCode WHERE t2.sourceProductCode IS NOT NULL;



drop table if exists report_kpis.loan_all_amount;
create table report_kpis.loan_all_amount as 
select t1.sourceCode,t1.sourceProductCode,t1.userIdcardHash, (cast(t1.amount as decimal(38,6)) + IFNULL(cast(t2.curInterest as decimal(38,6)), 0)) AS amount 
from report_kpis.tmp_lend_amount t1 
left join (select sourceCode, sourceProductCode, userIdcardHash, IFNULL(sum(cast(curInterest as decimal(38,6))), 0) curInterest from report_kpis.tmp_repayplan group by sourceCode,sourceProductCode, userIdcardHash) t2 
on t1.sourceProductCode = t2.sourceProductCode;



drop table if exists report_kpis.loan_all_amount_19;
create table report_kpis.loan_all_amount_19 as 
SELECT t1.sourceCode,IFNULL(SUM(cast(t2.transMoney as decimal(38,6))), 0) transMoney 
FROM report_kpis.loan_all_amount t1 
LEFT JOIN (SELECT * FROM report_kpis.tmp_transact WHERE transType = '19') t2 
ON t1.sourceProductCode = t2.sourceProductCode
group by 1;



drop table if exists report_kpis.loan_all_amount_18;
create table report_kpis.loan_all_amount_18 as 
SELECT t1.sourceCode, IFNULL(SUM(cast(t2.transMoney as decimal(38,6))), 0) transMoney 
FROM report_kpis.loan_all_amount t1 
LEFT JOIN (SELECT * FROM report_kpis.tmp_transact WHERE transType = '18') t2 
ON t1.sourceProductCode = t2.sourceProductCode
group by 1 ;


--
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



CREATE TEMPORARY TABLE key_t 
SELECT t1.sourceCode, SUM(t1.amount) - t2.transmoney - t3.transMoney AS credit_balance
FROM loan_all_amount t1 
LEFT JOIN loan_all_amount_19 t2 
ON t1.sourceCode = t2.sourceCode
LEFT JOIN loan_all_amount_18 t3 
ON t2.sourceCode = t3.sourceCode ;



# 在借人数
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




## 再投人数   /*  无法check   */
drop table if exists report_kpis.creditor_transfer;
create table report_kpis.creditor_transfer as 
SELECT t2.finClaimId, t1.transferId, t2.sourceProductCode, t2.userIdcardHash, t2.invAmount
FROM report_kpis.tmp_creditor t2 LEFT JOIN report_kpis.tmp_transferproject t1
ON t1.sourceCode = t2.sourceCode AND t1.finClaimId = t2.finClaimId AND t1.userIdcardHash = t2.userIdcardHash;



drop table if exists report_kpis.creditor_transfer_status;
create table report_kpis.creditor_transfer_status as 
SELECT t1.*, IFNULL(cast(t2.amount as decimal(38,6)),0) amount FROM report_kpis.creditor_transfer t1 LEFT JOIN (SELECT * FROM report_kpis.tmp_transferStatus WHERE transferStatus = '2') t2
ON t1.transferId = t2.transferId;



drop table if exists report_kpis.creditor_transfer_status_transact;
create table report_kpis.creditor_transfer_status_transact as 
SELECT t1.*, IFNULL(cast(t2.transMoney as decimal(38,6)),0) transMoney FROM report_kpis.creditor_transfer_status t1 LEFT JOIN (SELECT * FROM report_kpis.tmp_transact WHERE transType = '8') t2
ON t1.finClaimId = t2.finClaimId AND t1.userIdcardHash = t2.userIdcardHash;



drop table if exists report_kpis.undertake_transfer;
create table report_kpis.undertake_transfer as 
SELECT t2.unFinClaimId, t1.transferId, t2.userIdcardHash, t2.takeAmount
FROM report_kpis.tmp_undertakeinfo t2 LEFT JOIN report_kpis.tmp_transferproject t1
ON t1.sourceCode = t2.sourceCode AND t1.finClaimId = t2.unFinClaimId AND t1.userIdcardHash = t2.userIdcardHash;



drop table if exists report_kpis.undertake_transfer_status;
create table report_kpis.undertake_transfer_status as 
SELECT t1.*, IFNULL(cast(t2.amount as decimal(38,6)),0) amount FROM report_kpis.undertake_transfer t1 LEFT JOIN (SELECT * FROM report_kpis.tmp_transferStatus WHERE transferStatus = '2') t2
ON t1.transferId = t2.transferId;



drop table if exists report_kpis.undertake_transfer_status_transact;
create table report_kpis.undertake_transfer_status_transact as 
SELECT t1.*, IFNULL(cast(t2.transMoney as decimal(38,6)),0) transMoney FROM report_kpis.undertake_transfer_status t1 LEFT JOIN (SELECT * FROM report_kpis.tmp_transact WHERE transType = '8') t2
ON t1.unFinClaimId = t2.finClaimId AND t1.userIdcardHash = t2.userIdcardHash;



## 关键指标

INSERT overwrite table report_kpis.key_target
SELECT t2.sourceCode AS source_code, cast(t2.credit_balance as string), cast(t3.lend_number as string), cast(t4.num_of_borrowers as string)  AS borrowing_number, to_date(NOW()) AS create_time FROM
(SELECT COUNT(DISTINCT userIdcardHash) lend_number FROM 
(SELECT userIdcardHash FROM report_kpis.undertake_transfer_status_transact WHERE (cast(takeAmount as DECIMAL(38,6)) - cast(amount as DECIMAL(38,6)) - cast(transMoney as DECIMAL(38,6))) > 0.1
UNION 
SELECT userIdcardHash FROM report_kpis.creditor_transfer_status_transact WHERE (cast(invAmount as DECIMAL(38,6)) - cast(amount as DECIMAL(38,6)) - cast(transMoney as DECIMAL(38,6))) > 0.1) AS t1) AS t3, report_kpis.key_t AS t2, report_kpis.num_of_borrowers AS t4;



