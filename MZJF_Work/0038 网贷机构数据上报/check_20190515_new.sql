## 此处传入平台编号
--SET --"CERT20190411026" = 'CERT20181126001'; 




-- 去重统计
drop table if exists report_check.`duplicate_removal`;

CREATE TABLE IF NOT EXISTS report_check.`duplicate_removal` (
  `sourceCode` string,
  `intface_type` string,
  `duplicate_removal_before` string,
  `duplicate_removal_after` string,
  `create_time` string
) ; 



-- 用户关联check
drop table if exists report_check.`leak_user`;

CREATE TABLE IF NOT EXISTS report_check.`leak_user` (
  `sourceCode` string COMMENT '平台',
  `intface_type` string COMMENT '接口类型',
  `leak_user_data` string COMMENT '漏传用户数',
  `create_time` string COMMENT '创建时间'
) ;




-- check表
drop table if exists report_check.`norm`;

CREATE TABLE IF NOT EXISTS report_check.`norm` (
  `sourceCode` string COMMENT '平台',
  `norm_name` string,
  `count` string COMMENT '数据量',
  `create_time` string COMMENT '创建时间'
) ;




-- setp 1 去重临时表
drop table if exists report_check.tmp_creditor ;

create table report_check.tmp_creditor as 
SELECT sourceCode,finClaimId,sourceProductCode,userIdcardHash,invAmount,invRate,invTime,redpackage,lockTime
FROM pdw.report_05_creditor
GROUP BY sourceCode,finClaimId,sourceProductCode,userIdcardHash,invAmount,invRate,invTime,redpackage,lockTime;


drop table if exists report_check.tmp_repayplan ;

create table report_check.tmp_repayplan as 
SELECT sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge, repayTime,sendTime 
FROM pdw.report_04_repayplan 
GROUP BY sourceCode,sourceProductCode,userIdcardHash,totalIssue,issue,replanId,curFund,curInterest,curServiceCharge,repayTime,sendTime;


drop table if exists report_check.tmp_scatterinvest ;
create table report_check.tmp_scatterinvest as 
SELECT sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount 
FROM pdw.report_02_scatterinvest 
GROUP BY sourceCode,sourceproductcode,userIdcardHash,loanUse,loanRate,amount,surplusAmount,term,serviceCost,loanType,securityType,securityCompanyIdcard,isFinancingAssure,securityAmount;



drop table if exists report_check.tmp_status ;
create table report_check.tmp_status as 
SELECT sourceCode,sourceProductCode,productStatus,productDate 
FROM pdw.report_03_status 
GROUP BY sourceCode,sourceProductCode,productStatus,productDate;



drop table if exists report_check.tmp_transact ;
create table report_check.tmp_transact as 
SELECT sourceCode,transId,sourceProductCode,finClaimId,transferId,replanId,transType,transMoney,userIdcardHash,transTime
FROM pdw.report_09_transact 
GROUP BY sourceCode,transId,sourceProductCode,finClaimId,transferId,replanId,transType,transMoney,userIdcardHash,transTime;



--??
drop table if exists report_check.tmp_transferproject ;
create table report_check.tmp_transferproject as 
SELECT sourceCode,transferId,fromType,finClaimId,userIdcardHash,sourceProductCode,transferAmount,transferInterestRate,floatMoney,transferDate 
FROM pdw.report_06_transferproject
GROUP BY sourceCode,transferId,fromType,finClaimId,userIdcardHash,sourceProductCode,transferAmount,transferInterestRate,floatMoney,transferDate;



--？
drop table if exists report_check.tmp_transferStatus ;
create table report_check.tmp_transferStatus as 
SELECT sourceCode,transferId,transferStatus,amount,floatMoney,productDate 
FROM pdw.report_07_transferstatus 
GROUP BY sourceCode,transferId,transferStatus,amount,floatMoney,productDate;



--?
drop table if exists report_check.tmp_undertakeinfo ;
create table report_check.tmp_undertakeinfo as 
SELECT sourceCode,unFinClaimId,transferId,finClaimId,userIdcardHash,takeAmount,takeInterest,floatMoney,takeRate,takeTime,redpackage,lockTime 
FROM pdw.report_08_undertakeinfo 
GROUP BY sourceCode,unFinClaimId,transferId,finClaimId,userIdcardHash,takeAmount,takeInterest,floatMoney,takeRate,takeTime,redpackage,lockTime;



drop table if exists report_check.tmp_userinfo ;
create table report_check.tmp_userinfo as 
SELECT sourceCode,userType,userAttr,userCreateTime,userName,countries,userIdcard,userIdcardHash,userPhone,userPhoneHash,userProvince,userAddress,userSex 
FROM pdw.report_01_userinfo 
GROUP BY sourceCode,userType,userAttr,userCreateTime,userName,countries,userIdcard,userIdcardHash,userPhone,userPhoneHash,userProvince,userAddress,userSex;




--产品临时表
drop table if exists report_check.tmp_lendproduct ;
create table report_check.tmp_lendproduct as 
SELECT sourceCode,sourceFinancingCode,financingStartTime,productName,rate,minRate,maxRate,term 
FROM pdw.report_10_lendproduct
GROUP BY sourceCode,sourceFinancingCode,financingStartTime,productName,rate,minRate,maxRate,term;




drop table if exists report_check.tmp_lendproductconfig ;
create table report_check.tmp_lendproductconfig as 
SELECT sourceCode,configId,finClaimId,sourceFinancingCode,userIdcardHash 
FROM pdw.report_11_lendproductconfig 
GROUP BY sourceCode,configId,finClaimId,sourceFinancingCode,userIdcardHash;



drop table if exists report_check.tmp_lendparticulars ;
create table report_check.tmp_lendparticulars as 
SELECT sourceCode,transId,sourceFinancingCode,transType,transMoney,userIdcardHash,transTime 
FROM pdw.report_12_lendparticulars
GROUP BY sourceCode,transId,sourceFinancingCode,transType,transMoney,userIdcardHash,transTime;



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


-- 增加产品索引
--ALTER TABLE tmp_lendproduct ADD INDEX index_1(sourceFinancingCode);
--ALTER TABLE tmp_lendproductconfig ADD INDEX index_1(finClaimId);
--ALTER TABLE tmp_lendproductconfig ADD INDEX index_2(sourceFinancingCode);
--ALTER TABLE tmp_lendproductconfig ADD INDEX index_3(userIdcardHash);
--ALTER TABLE tmp_lendparticulars ADD INDEX index_1(sourceFinancingCode);
--ALTER TABLE tmp_lendparticulars ADD INDEX index_2(userIdcardHash);


-- step 2: 不去重统计
drop table if exists report_check.userinfo_count ;
create table report_check.userinfo_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_01_userinfo group by 1 ;


drop table if exists report_check.scatterinvest_count ;
create table report_check.scatterinvest_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_02_scatterinvest group by 1 ;


drop table if exists report_check.status_count ;
create table report_check.status_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_03_status group by 1 ;


drop table if exists report_check.creditor_count ;
create table report_check.creditor_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_05_creditor group by 1 ;


drop table if exists report_check.repayplan_count ;
create table report_check.repayplan_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_04_repayplan group by 1 ;


drop table if exists report_check.transact_count ;
create table report_check.transact_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_09_transact group by 1 ;


--?
drop table if exists report_check.transferproject_count ;
create table report_check.transferproject_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_06_transferproject group by 1 ;

--?
drop table if exists report_check.transferstatus_count ;
create table report_check.transferstatus_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_07_transferstatus group by 1 ;

--?
drop table if exists report_check.undertakeinfo_count ;
create table report_check.undertakeinfo_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_08_undertakeinfo group by 1 ;


-- 产品不去重统计
drop table if exists report_check.lendproduct_count ;
create table report_check.lendproduct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_10_lendproduct group by 1 ;

drop table if exists report_check.lendproductconfig_count ;
create table report_check.lendproductconfig_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_11_lendproductconfig group by 1 ;

drop table if exists report_check.lendparticulars_count ;
create table report_check.lendparticulars_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM pdw.report_12_lendparticulars group by 1 ;


-- step 3：去重统计
drop table if exists report_check.creditor_distinct_count ;
create table report_check.creditor_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_creditor group by 1 ;

drop table if exists report_check.repayplan_distinct_count ;
create table report_check.repayplan_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_repayplan group by 1 ;

drop table if exists report_check.scatterinvest_distinct_count ;
create table report_check.scatterinvest_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_scatterinvest group by 1 ;

drop table if exists report_check.status_distinct_count ;
create table report_check.status_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_status group by 1 ;

drop table if exists report_check.transact_distinct_count ;
create table report_check.transact_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_transact group by 1 ;

--?
drop table if exists report_check.transferproject_distinct_count ;
create table report_check.transferproject_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_transferproject group by 1 ;

--?
drop table if exists report_check.transferStatus_distinct_count ;
create table report_check.transferStatus_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_transferStatus group by 1 ;

--?
drop table if exists report_check.undertakeinfo_distinct_count ;
create table report_check.undertakeinfo_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_undertakeinfo group by 1 ;

drop table if exists report_check.userinfo_distinct_count ;
create table report_check.userinfo_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_userinfo group by 1 ;

-- 产品去重统计
drop table if exists report_check.lendproduct_distinct_count ;
create table report_check.lendproduct_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_lendproduct group by 1 ;


drop table if exists report_check.lendproductconfig_distinct_count ;
create table report_check.lendproductconfig_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_lendproductconfig group by 1 ;


drop table if exists report_check.lendparticulars_distinct_count ;
create table report_check.lendparticulars_distinct_count as 
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, COUNT(1) AS count FROM report_check.tmp_lendparticulars group by 1 ;



-- insert
INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'userinfo' AS intface_type, cast(a.count as string) AS duplicate_removal_before, cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.userinfo_count a, report_check.userinfo_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'scatterinvest' AS intface_type ,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time2 
FROM report_check.scatterinvest_count a, report_check.scatterinvest_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'status' AS intface_type ,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.status_count a, report_check.status_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'creditor' AS intface_type ,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.creditor_count a, report_check.creditor_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'repayplan' AS intface_type ,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.repayplan_count a, report_check.repayplan_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'transact' AS intface_type ,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.transact_count a, report_check.transact_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'transferproject' AS intface_type,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.transferproject_count a, report_check.transferproject_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'transferstatus' AS intface_type ,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.transferstatus_count a, report_check.transferStatus_distinct_count b 
WHERE a.sourceCode=b.sourceCode;

INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'undertakeinfo' AS intface_type ,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.undertakeinfo_count a, report_check.undertakeinfo_distinct_count b 
WHERE a.sourceCode=b.sourceCode;





-- insert产品
INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'lendproduct' AS intface_type ,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.lendproduct_count a, report_check.lendproduct_distinct_count b 
WHERE a.sourceCode=b.sourceCode;


INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'lendproductconfig' AS intface_type ,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.lendproductconfig_count a, report_check.lendproductconfig_distinct_count b 
WHERE a.sourceCode=b.sourceCode;


INSERT INTO report_check.duplicate_removal
SELECT a.sourceCode AS sourceCode,'lendparticulars' AS intface_type ,cast(a.count as string) AS duplicate_removal_before,cast(b.count as string) AS duplicate_removal_after, to_date(NOW()) AS create_time 
FROM report_check.lendparticulars_count a, report_check.lendparticulars_distinct_count b 
WHERE a.sourceCode=b.sourceCode;







-- 用户check
INSERT INTO report_check.leak_user
SELECT IFNULL(st.sourceCode,"CERT20190411026") AS sourceCode, 'scatterinvest' AS intface_type, cast(COUNT(DISTINCT st.userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_scatterinvest st LEFT JOIN report_check.tmp_userinfo u 
ON st.userIdcardHash = u.userIdcardHash AND st.sourceCode=u.sourceCode 
WHERE u.userIdcardHash IS NULL
GROUP BY 1,2,4;


INSERT INTO report_check.leak_user
SELECT IFNULL(tp.sourceCode,"CERT20190411026") AS sourceCode, 'transact' AS intface_type, cast(COUNT(DISTINCT tp.userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
from (SELECT * FROM report_check.tmp_transact WHERE transType IN ('2','6','7','8','9','10','11','17','41','44','23','40','46','48','1','3','18','19','39','32','45','29','27','37','30')) tp 
LEFT JOIN report_check.tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode=u.sourceCode 
where u.userIdcardHash IS NULL
GROUP BY 1,2,4;



INSERT INTO report_check.leak_user
SELECT IFNULL(tp.sourceCode,"CERT20190411026") AS sourceCode, 'transferproject' AS intface_type, cast(COUNT(DISTINCT tp.userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_transferproject tp LEFT JOIN report_check.tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode=u.sourceCode 
WHERE u.userIdcardHash IS NULL
GROUP BY 1,2,4;


INSERT INTO report_check.leak_user
SELECT IFNULL(tp.sourceCode,"CERT20190411026") AS sourceCode, 'undertakeinfo' AS intface_type, cast(COUNT(DISTINCT tp.userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_undertakeinfo tp LEFT JOIN report_check.tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode = u.sourceCode 
WHERE u.userIdcardHash IS NULL
GROUP BY 1,2,4;

INSERT INTO report_check.leak_user
SELECT IFNULL(tp.sourceCode,"CERT20190411026") AS sourceCode, 'creditor' AS intface_type, cast(COUNT(DISTINCT tp.userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_creditor tp LEFT JOIN report_check.tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode=u.sourceCode 
WHERE u.userIdcardHash IS NULL
GROUP BY 1,2,4;

INSERT INTO report_check.leak_user
SELECT IFNULL(tp.sourceCode,"CERT20190411026") AS sourceCode, 'repayplan' AS intface_type, cast(COUNT(DISTINCT tp.userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_repayplan tp LEFT JOIN report_check.tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode = u.sourceCode 
WHERE u.userIdcardHash IS NULL
GROUP BY 1,2,4;




INSERT INTO report_check.leak_user
SELECT IFNULL(sourceCode,"CERT20190411026") sourceCode, 'userinfo_leakypush' AS intface_type, cast(COUNT(userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_userinfo 
WHERE userIdcardHash IN ('-1', '0', '-')
GROUP BY 1,2,4;


INSERT INTO report_check.leak_user
SELECT IFNULL(sourceCode,"CERT20190411026") AS sourceCode, 'creditor_leakypush' AS intface_type, cast(COUNT(userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_creditor 
WHERE userIdcardHash IN ('-1', '0', '-')
GROUP BY 1,2,4;

INSERT INTO report_check.leak_user
SELECT IFNULL(sourceCode,"CERT20190411026") AS sourceCode, 'repayplan_leakypush' AS intface_type, cast(COUNT(userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_repayplan WHERE userIdcardHash IN ('-1', '0', '-')
GROUP BY 1,2,4;

INSERT INTO report_check.leak_user
SELECT IFNULL(sourceCode,"CERT20190411026") AS sourceCode, 'scatterinvest_leakypush' AS intface_type, cast(COUNT(userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_scatterinvest WHERE userIdcardHash IN ('-1', '0', '-')
GROUP BY 1,2,4;

INSERT INTO report_check.leak_user
SELECT IFNULL(sourceCode,"CERT20190411026") AS sourceCode, 'transact_leakypush' AS intface_type, cast(COUNT(userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_transact WHERE transtype NOT IN ('3', '13', '27', '30') AND userIdcardHash IN ('-1', '0', '-')
GROUP BY 1,2,4;

INSERT INTO report_check.leak_user
SELECT IFNULL(sourceCode,"CERT20190411026") AS sourceCode, 'transferproject_leakypush' AS intface_type, cast(COUNT(userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_transferproject WHERE userIdcardHash IN ('-1', '0', '-')
GROUP BY 1,2,4;

INSERT INTO report_check.leak_user
SELECT IFNULL(sourceCode,"CERT20190411026") AS sourceCode, 'undertakeinfo_leakypush' AS intface_type, cast(COUNT(userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_undertakeinfo WHERE userIdcardHash in ('-1', '0', '-')
GROUP BY 1,2,4;




-------------------------

-- 产品用户check
INSERT INTO report_check.leak_user
SELECT IFNULL(tp.sourceCode,"CERT20190411026") AS sourceCode, 'lendproductconfig' AS intface_type, cast(COUNT(DISTINCT tp.userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_lendproductconfig tp LEFT JOIN report_check.tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode=u.sourceCode 
WHERE u.userIdcardHash IS NULL
GROUP BY 1,2,4;

INSERT INTO report_check.leak_user
SELECT IFNULL(tp.sourceCode,"CERT20190411026") AS sourceCode, 'lendparticulars' AS intface_type, cast(COUNT(DISTINCT tp.userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_lendparticulars tp LEFT JOIN report_check.tmp_userinfo u ON tp.userIdcardHash = u.userIdcardHash AND tp.sourceCode=u.sourceCode 
WHERE u.userIdcardHash IS NULL
GROUP BY 1,2,4;

INSERT INTO report_check.leak_user
SELECT IFNULL(sourceCode,"CERT20190411026") AS sourceCode, 'lendproductconfig_leakypush' AS intface_type, cast(COUNT(userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_lendproductconfig WHERE userIdcardHash IN ('-1', '0', '-')
GROUP BY 1,2,4;

INSERT INTO report_check.leak_user
SELECT IFNULL(sourceCode,"CERT20190411026") AS sourceCode, 'lendparticulars_leakypush' AS intface_type, cast(COUNT(userIdcardHash) as string) AS leak_user_data, to_date(NOW()) AS create_time 
FROM report_check.tmp_lendparticulars WHERE userIdcardHash in ('-1', '0', '-')
GROUP BY 1,2,4;


------------------------------注意-------------------------------------
-- 3 根据状态过滤散标编号, 去掉流标，初始公布，募集中的散标数据

DROP TABLE IF EXISTS db_check.last_online_status ;

--CREATE TABLE db_check.last_status
--SELECT * 
--FROM (SELECT * FROM report_check.tmp_status GROUP BY sourceProductCode, productStatus ORDER BY productDate DESC) temp 
--GROUP BY sourceProductCode 
--ORDER BY productDate DESC;


--DROP TABLE IF EXISTS report_check.last_online_status ;

--create table report_check.last_online_status as 
--SELECT * FROM report_check.last_status WHERE productstatus IN ('1','3','4','5','8','9');


--以上2段改写成一段   ************** 

DROP TABLE IF EXISTS report_check.last_online_status ;
create table report_check.last_online_status 
as 
SELECT sourceCode, sourceProductCode FROM report_check.tmp_status 
where productstatus IN ('1','3','4','5','8','9') 
GROUP BY sourceCode, sourceProductCode ;



--DROP TABLE IF EXISTS report_check.tmp_scatterinvest_3_status ;
--create table report_check.tmp_scatterinvest_3_status as 
--SELECT t2.*,t1.productStatus 
--FROM report_check.tmp_scatterinvest t2  LEFT JOIN  report_check.last_online_status t1 
--ON t1.sourceProductCode = t2.sourceProductCode 
--WHERE t1.productstatus IS NOT NULL;


--以上代码改成 inner join  ******************

DROP TABLE IF EXISTS db_check.tmp_scatterinvest_3_status ;

create table report_check.tmp_scatterinvest_3_status 
as 
SELECT t2.*
FROM report_check.tmp_scatterinvest t2  
JOIN  report_check.last_online_status t1 
ON t1.sourceProductCode = t2.sourceProductCode 
;



--ALTER TABLE tmp_scatterinvest_3_status ADD INDEX index_1(sourceProductCode);
--ALTER TABLE last_online_status ADD INDEX index_1(sourceProductCode,productStatus);


DROP TABLE IF EXISTS report_check.tmp_loan_money ;
create table report_check.tmp_loan_money as 
SELECT sourceCode, sourceProductCode, SUM(cast(transMoney as decimal(38,6))) transMoney 
FROM report_check.tmp_transact 
WHERE transType = '1' GROUP BY sourceCode, sourceProductCode ;



INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") AS sourceCode, 
       '3.1、每个散标的流水类型为：1(放款)的流水是否存在。散标状态为【0-初始公布】、【2-流标（弃标）】、【6-筹标中】的散标不做该check。' AS norm_name, 
       cast(COUNT(1) as string) count, 
       to_date(NOW()) AS create_time 
FROM report_check.tmp_scatterinvest_3_status t1 
LEFT JOIN report_check.tmp_transact t2 
on t1.sourceProductCode = t2.sourceProductCode 
and t1.sourceCode = t2.sourceCode 
and t2.transType = '1' 
WHERE t2.sourceProductCode IS NULL
group by 1,2,4 ;



-- 3.1 抽样
DROP TABLE IF EXISTS report_check.tmp_3_1_problematic_data_sampling;
CREATE TABLE report_check.tmp_3_1_problematic_data_sampling as 
SELECT t1.*
FROM report_check.tmp_scatterinvest_3_status t1  LEFT JOIN report_check.tmp_transact t2 on t1.sourceProductCode = t2.sourceProductCode and  t1.sourceCode = t2.sourceCode and t2.transType = '1' 
WHERE t2.sourceProductCode IS NULL LIMIT 10;




-- 3.2 
DROP TABLE IF EXISTS report_check.last_repayplan;

--CREATE TEMPORARY TABLE report_check.last_repayplan
--SELECT * 
--FROM (SELECT * FROM report_check.tmp_repayplan GROUP BY sourceProductCode, issue ORDER BY sendTime DESC) temp 
--GROUP BY sourceProductCode, issue 
--ORDER BY sendTime DESC;

--以上代码修改为 
DROP TABLE IF EXISTS report_check.last_repayplan;

CREATE TABLE report_check.last_repayplan
as 
SELECT sourceCode, sourceProductCode, issue, repayTime, curFund, curInterest
FROM report_check.tmp_repayplan 
GROUP BY sourceCode, sourceProductCode, issue, repayTime, curFund, curInterest
;


--ALTER TABLE last_repayplan ADD INDEX index_1(sourceProductCode);


DROP TABLE IF EXISTS report_check.repayplan_uptoday_money;
create table report_check.repayplan_uptoday_money as 
SELECT sourceCode, sourceProductCode, SUM(cast(curFund as decimal(38,6))) + sum(cast(curInterest as decimal(38,6))) AS total_sum 
FROM report_check.last_repayplan where repayTime < to_date(NOW())  
group by sourceCode, sourceProductCode;


DROP TABLE IF EXISTS report_check.transact_repay;
create table report_check.transact_repay as 
SELECT sourceCode, sourceProductCode, SUM(cast(transMoney as decimal(38,6))) AS total_repay, MAX(SUBSTR(transTime, 1 ,10)) AS last_day 
FROM pdw.report_09_transact WHERE transType IN ('18','19') GROUP BY sourceCode, sourceProductCode;


--ALTER TABLE transact_repay ADD INDEX index_1(sourceProductCode, total_repay, last_day);
--ALTER TABLE repayplan_uptoday_money ADD INDEX index_1(sourceProductCode, total_sum);

DROP TABLE IF EXISTS report_check.overdue_record;
create table report_check.overdue_record as 
SELECT a.sourceCode, a.sourceProductCode, SUM(a.total_sum) AS replan_money,SUM(b.total_repay) AS transact_money,b.last_day AS last_day 
FROM report_check.repayplan_uptoday_money a JOIN report_check.transact_repay b ON a.sourceProductCode= b.sourceProductCode 
WHERE a.total_sum > b.total_repay GROUP BY a.sourceCode, a.sourceProductCode, b.last_day;



-- 无 18-还款本金、19-还款利息 类型的数据, 初始债权没有
DROP TABLE IF EXISTS report_check.transact_repay_time;
create table report_check.transact_repay_time as 
SELECT sourceProductCode, MAX(transTime) transTime, replanId 
FROM pdw.report_09_transact 
WHERE transType IN ('18', '19') GROUP BY sourceProductCode, replanId;



DROP TABLE IF EXISTS report_check.repay_nomoal;
create table report_check.repay_nomoal as 
SELECT t1.sourceProductCode 
FROM report_check.tmp_repayplan t1, report_check.transact_repay_time t2 
WHERE t1.replanId = t2.replanId AND t1.repayTime >= t2.transTime 
AND t1.sourceProductCode = t2.sourceProductCode;



--
--语法未转  ??  未执行   ******************
--
DROP TABLE IF EXISTS report_check.repay_nomoal_1;
create table report_check.repay_nomoal_1
SELECT t1.sourceProductCode 
FROM report_check.tmp_repayplan t1, report_check.transact_repay_time t2 
WHERE t1.replanId = CONCAT(substring_index(t2.replanId,'-', 1), '-', substring_index(t2.replanId,'-', -1) - 1) 
AND t2.transTime > t1.repayTime AND t1.sourceProductCode = t2.sourceProductCode;

-- select split_part('1,2',',',1) 
-- reverse(string a)


INSERT INTO report_check.norm
SELECT IFNULL(l.sourceCode, "CERT20190411026") AS sourceCode, 
'3.2.1、统计所有没有推送【还款计划】的散标的数量。散标状态为【0-初始公布】、【2-流标（弃标）】、【6-筹标中】的散标不做该check。' AS norm_name, 
cast(COUNT(DISTINCT l.sourceProductCode) as string) AS count, 
to_date(NOW()) AS create_time 
FROM (SELECT t1.sourceCode, t1.sourceProductCode FROM report_check.tmp_scatterinvest t1 LEFT JOIN report_check.last_online_status t2 
ON t1.sourceProductCode = t2.sourceProductCode WHERE t2.sourceProductCode IS NOT NULL GROUP BY t1.sourceCode, t1.sourceProductCode) AS `l` 
LEFT JOIN report_check.tmp_repayplan r ON l.sourceProductCode = r.sourceProductCode 
WHERE r.sourceProductCode IS NULL
group by 1,2,4;



-- 抽样
DROP TABLE IF EXISTS report_check.tmp_3_2_1_problematic_data_sampling;
CREATE TABLE report_check.tmp_3_2_1_problematic_data_sampling as 
SELECT l.*
FROM (SELECT t1.sourceCode, t1.sourceProductCode FROM report_check.tmp_scatterinvest t1 LEFT JOIN report_check.last_online_status t2 
ON t1.sourceProductCode = t2.sourceProductCode WHERE t2.sourceProductCode IS NOT NULL GROUP BY t1.sourceCode,t1.sourceProductCode) AS `l` 
LEFT JOIN report_check.tmp_repayplan r ON l.sourceProductCode = r.sourceProductCode 
WHERE r.sourceProductCode IS NULL LIMIT 10;



--无 report_check.repay_nomoal_1  ， 未成功执行    ***************
INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") AS sourceCode, 
'3.2.1.1、check往期还款流水中，同一散标的还款流水中，还款月份呈不连续状态，视为大概率流水漏传的散标， 统计并记录散标的数量 ' AS norm_name, 
COUNT(t1.sourceProductCode) count, NOW() AS create_time 
FROM report_check.overdue_record t1, report_check.transact_repay_time t2, report_check.repay_nomoal t3, report_check.report_check.repay_nomoal_1 t4 
WHERE t1.sourceProductCode = t2.sourceProductCode AND t1.sourceProductCode =  t3.sourceProductCode AND t2.sourceProductCode = t3.sourceProductCode AND t1.sourceProductCode =  t4.sourceProductCode ;




-- 抽样
--无 report_check.repay_nomoal_1  ， 未成功执行     *************
DROP TABLE IF EXISTS report_check.tmp_3_2_1_1_problematic_data_sampling;
CREATE TABLE report_check.tmp_3_2_1_1_problematic_data_sampling as 
SELECT t1.*
FROM report_check.overdue_record t1, report_check.transact_repay_time t2, report_check.repay_nomoal t3, report_check.repay_nomoal_1 t4 
WHERE t1.sourceProductCode = t2.sourceProductCode AND t1.sourceProductCode =  t3.sourceProductCode AND t2.sourceProductCode = t3.sourceProductCode AND t1.sourceProductCode =  t4.sourceProductCode LIMIT 10;







DROP TABLE IF EXISTS report_check.tmp_1;
create table report_check.tmp_1 as 
SELECT t1.sourceCode, t1.sourceProductCode FROM report_check.tmp_transact AS t1 
LEFT JOIN report_check.tmp_repayplan AS t2 on t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode IS NOT NULL AND t1.transType = '18' AND cast(t2.curFund as decimal(38,6)) > 0 AND cast(t2.curInterest as decimal(38,6)) > 0 
GROUP BY t1.sourceCode, t1.sourceProductCode;


INSERT INTO report_check.norm
SELECT IFNULL(t3.sourceCode, "CERT20190411026") AS sourceCode, 
'3.2.1.2、流水数据中，存在往期已还款流水，并且对应的该散标的流水数据中，有 流水类型：18【还款本金】的流水数据，但是 没有 流水类型：19【还款利息】，视为流水不完整的散标， 统计并记录这种散标数量' AS norm_name, 
cast(COUNT(1) as STRING) AS count, to_date(NOW()) AS create_time 
FROM report_check.tmp_1 AS t3 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM report_check.tmp_transact WHERE transType = '19' or transType =  '4' 
GROUP BY sourceCode, sourceProductCode) AS t4 ON t3.sourceProductCode = t4.sourceProductCode WHERE t4.sourceProductCode IS NULL
GROUP BY 1,2,4 ;


-- 抽样
DROP TABLE IF EXISTS report_check.tmp_3_2_1_2_problematic_data_sampling;

CREATE TABLE report_check.tmp_3_2_1_2_problematic_data_sampling as 
SELECT t3.* 
FROM report_check.tmp_1 AS t3 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM report_check.tmp_transact WHERE transType = '19' or transType =  '4' 
GROUP BY sourceCode,sourceProductCode) AS t4 ON t3.sourceProductCode = t4.sourceProductCode WHERE t4.sourceProductCode IS NULL LIMIT 10;







DROP TABLE IF EXISTS report_check.tmp_2;
create table report_check.tmp_2 as 
SELECT sourceCode, sourceProductCode FROM report_check.tmp_transact WHERE transType = '18' GROUP BY sourceCode, sourceProductCode;




INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") as sourceCode, 
'3.2.1.3、流水数据中，存在往期已还款流水，但是对应的该散标的流水数据中，没有 流水类型：8【赎回本金】的流水数据，视为流水不完整的散标， 统计并记录这种散标数量 ' as norm_name, 
cast(COUNT(1) as STRING) as count, 
to_date(NOW()) as create_time 
FROM report_check.tmp_2 as t1 
LEFT JOIN (SELECT sourceCode, sourceProductCode FROM report_check.tmp_transact WHERE transType = '8' GROUP BY sourceCode,sourceProductCode) AS t2 
ON t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode IS NULL
group by 1,2,4;




-- 抽样

DROP TABLE IF EXISTS report_check.tmp_3_2_1_3_problematic_data_sampling;

CREATE TABLE report_check.tmp_3_2_1_3_problematic_data_sampling as 
SELECT t1.*
FROM report_check.tmp_2 as t1 
LEFT JOIN (SELECT sourceCode, sourceProductCode FROM report_check.tmp_transact WHERE transType = '8' GROUP BY sourceCode,sourceProductCode) AS t2 
ON t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode IS NULL LIMIT 10;







DROP TABLE IF EXISTS report_check.tmp_3;

create table report_check.tmp_3 as 
SELECT sourceCode, sourceProductCode FROM report_check.tmp_transact WHERE transType = '8' GROUP BY sourceCode, sourceProductCode;



INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") as sourceCode, 
'3.2.1.4、对于往期还款流水，存在流水类型为【18-还款本金】的流水，并且该项目有流水类型为【8-赎回本金】，但是没有类型为【9-赎回利息】的流水，视为流水数据漏推，请检查本地库的流水 ' as norm_name, 
cast(COUNT(1) as STRING) as count, to_date(NOW()) as create_time 
FROM report_check.tmp_3 as t1 LEFT JOIN (SELECT sourceCode, sourceProductCode FROM report_check.tmp_transact WHERE transType = '9' GROUP BY sourceCode,sourceProductCode) AS t2 
ON t1.sourceProductCode = t2.sourceProductCode WHERE t2.sourceProductCode IS NULL
group by 1,2,4;




-- 抽样
DROP TABLE IF EXISTS report_check.tmp_3_2_1_4_problematic_data_sampling;
CREATE TABLE report_check.tmp_3_2_1_4_problematic_data_sampling as 
SELECT t1.*
FROM report_check.tmp_3 as t1 
LEFT JOIN (SELECT sourceCode, sourceProductCode FROM report_check.tmp_transact WHERE transType = '9' GROUP BY sourceCode, sourceProductCode) AS t2 
ON t1.sourceProductCode = t2.sourceProductCode WHERE t2.sourceProductCode IS NULL LIMIT 10;




DROP TABLE IF EXISTS report_check.tmp_4;

create table report_check.tmp_4 as 
SELECT sourceCode, sourceProductCode, totalIssue FROM report_check.tmp_repayplan GROUP BY sourceCode, sourceProductCode, totalIssue;



INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") as sourceCode, 
'3.2.1.5、已推送的【还款计划】的完整性check：每个散标还款计划的记录数=该散标还款计划的总期数，如果不相等，视为不完整， 统计并记录散标的数据量 ' as norm_name, 
cast(COUNT(1) as STRING) count, 
to_date(NOW()) create_time 
FROM report_check.tmp_4 AS t1, (SELECT sourceCode, sourceProductCode, COUNT(1) count FROM report_check.tmp_repayplan GROUP BY sourceCode, sourceProductCode ) AS t2 
WHERE t1.sourceProductCode = t2.sourceProductCode AND cast(t1.totalIssue as bigint) != t2.count
GROUP BY 1,2,4;



-- 抽样
DROP TABLE IF EXISTS report_check.tmp_3_2_1_5_problematic_data_sampling;
CREATE TABLE report_check.tmp_3_2_1_5_problematic_data_sampling as 
SELECT t1.*
FROM report_check.tmp_4 AS t1, (SELECT sourceCode, sourceProductCode, COUNT(1) count FROM report_check.tmp_repayplan GROUP BY sourceCode, sourceProductCode ) AS t2 
WHERE t1.sourceProductCode = t2.sourceProductCode AND cast(t1.totalIssue as bigint) != t2.count LIMIT 10;




DROP TABLE IF EXISTS report_check.temp_scat_cred;
create table report_check.temp_scat_cred as 
SELECT t1.sourceCode, t1.sourceProductCode, t1.amount, sum(cast(t2.invAmount as decimal(38,6))) invAmount, sum(cast(t2.redpackage as decimal(38,6))) redpackage, COUNT(1) count 
FROM report_check.tmp_scatterinvest_3_status t1, report_check.tmp_creditor t2 
WHERE t1.sourceCode=t2.sourceCode AND t1.sourceProductCode=t2.sourceProductCode GROUP BY t1.sourceCode, t1.sourceProductCode, t1.amount;




INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") as sourceCode, 
       '3.3.1、check每个散标的初始债权是否完整推送，即：散标金额=该散标对应的所有的债权金额(投资金额+红包)求和,误差考虑5元以内, 统计并记录漏推散标的数据量。散标状态为【0-初始公布】、【2-流标（弃标）】、【6-筹标中】的散标不做该check。' as norm_name, 
       cast(COUNT(1) as string) as count, 
       to_date(NOW()) as create_time 
FROM report_check.temp_scat_cred t1 WHERE (cast(amount as decimal(38,6)) - (cast(invAmount as decimal(38,6)) + cast(redpackage as decimal(38,6)))) > 5 
group by 1,2,4;




-- 抽样
DROP TABLE IF EXISTS report_check.tmp_3_3_1_problematic_data_sampling;
CREATE TABLE report_check.tmp_3_3_1_problematic_data_sampling as 
SELECT *
FROM report_check.temp_scat_cred t1 WHERE (cast(amount as decimal(38,6)) - (cast(invAmount as decimal(38,6)) + cast(redpackage as decimal(38,6)))) > 5 LIMIT 10;




INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") as sourceCode, 
'3.3.2、统计所有初始债权对应的投资流水（流水类型为：2）没有推送过来的债权数量 ' as norm_name, 
cast(COUNT(1) as string) as count, 
to_date(NOW()) as create_time 
FROM report_check.tmp_creditor t1 LEFT JOIN report_check.tmp_transact t2 ON t1.finClaimId = t2.finClaimId 
WHERE t2.transType = '2' AND t2.finClaimId IS NULL
group by 1,2,4 ;




-- 抽样

DROP TABLE IF EXISTS report_check.tmp_3_3_2_problematic_data_sampling;

CREATE TABLE report_check.tmp_3_3_2_problematic_data_sampling as 
SELECT t1.*
FROM report_check.tmp_creditor t1 LEFT JOIN report_check.tmp_transact t2 ON t1.finClaimId = t2.finClaimId 
WHERE t2.transType = '2' AND t2.finClaimId IS NULL LIMIT 10;





INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") as sourceCode, 
       '3.4.1、check每个散标的散标状态是否存在, 统计并记录漏推状态的散标数据量 ' as norm_name,
       cast(COUNT(1) as string) as count, 
       to_date(NOW()) as create_time 
FROM (SELECT sourceCode, sourceProductCode FROM report_check.tmp_scatterinvest) AS t1 
LEFT JOIN (SELECT sourceCode, sourceProductCode FROM report_check.tmp_status GROUP BY sourceCode, sourceProductCode) t2 ON t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode is NULL
GROUP BY 1,2,4;




-- 抽样

DROP TABLE IF EXISTS report_check.tmp_3_4_1_problematic_data_sampling;

CREATE TABLE report_check.tmp_3_4_1_problematic_data_sampling as 
SELECT t1.*
FROM (SELECT sourceCode, sourceProductCode FROM report_check.tmp_scatterinvest) AS t1 
LEFT JOIN (SELECT sourceCode, sourceProductCode FROM report_check.tmp_status GROUP BY sourceCode, sourceProductCode) t2 ON t1.sourceProductCode = t2.sourceProductCode 
WHERE t2.sourceProductCode is NULL LIMIT 10;




DROP TABLE IF EXISTS report_check.tmp_productStatus;
create table report_check.tmp_productStatus as 
SELECT sourceCode, productStatus, COUNT(1) count FROM report_check.tmp_status GROUP BY sourceCode,productStatus;


DROP TABLE IF EXISTS report_check.tmp_5;
create table report_check.tmp_5 as 
SELECT * FROM report_check.tmp_productStatus WHERE productStatus = '1' or productStatus = '5' or productStatus = '9';



-- 替换后的语法
INSERT INTO report_check.norm
SELECT IFNULL(sourceCode, "CERT20190411026") as sourceCode, 
       '3.4.2、check散标状态表中，是否存在标识满标状态的数据，如果没有，请检查散标状态值是否有问题' as norm_name,
       0 AS count, now() AS create_time 
FROM report_check.tmp_5 AS t1 ;


--**原始语法
--??? 子查询报错  未修改     ******************
--INSERT INTO report_check.norm
--SELECT IFNULL(sourceCode, "CERT20190411026") as sourceCode, 
--       '3.4.2、check散标状态表中，是否存在标识满标状态的数据，如果没有，请检查散标状态值是ç' as norm_name,
--       IF(SUM(count) > 0, 0, (SELECT SUM(count) FROM report_check.tmp_productStatus)) AS count, now() AS create_time 
--FROM report_check.tmp_5 AS t1 ;


--替换语法
----- create table t1 a
----- select 
----- sourceCode,
----- norm_name,
----- sum(cnt) as sum_cnt
----- from 
----- (select IFNULL(sourceCode, "CERT20190411026") as sourceCode, 
-----        '3.4.2、check散标状态表中，是否存在标识满标状态的数据，如果没有，请检查散标状态值是ç' as norm_name,
-----        count as cnt
-----     from report_check.tmp_5)a
----- group by 
----- sourceCode,
----- norm_name
----- 
----- create table t2
-----   select SUM(count) as sum_cnt FROM report_check.tmp_productStatus;
----- 
----- 
----- SELECT sourceCode, 
-----        norm_name,
-----        IF(t1.sum_cnt> 0, 0, t2.sum_cnt) AS count,
-----         now() AS create_time 
----- from t1 , t2
----- 

-----以下05/15修改


DROP TABLE IF EXISTS report_check.tmp_6;
create table report_check.tmp_6 as 
SELECT sourceProductCode, transMoney AS loan FROM report_check.tmp_transact WHERE transType = '1' GROUP BY 1,2;


DROP TABLE IF EXISTS report_check.loan_money;

create table report_check.loan_money as 
SELECT t1.sourceProductCode, (cast(t1.loan as decimal(38,6)) + cast(t2.loan_cast as decimal(38,6))) AS loan_money 
FROM report_check.tmp_6 AS t1, 
(SELECT sourceProductCode,transMoney AS loan_cast FROM report_check.tmp_transact WHERE transType = '4' GROUP BY sourceProductCode, transMoney) AS t2 
WHERE t1.sourceProductCode = t2.sourceProductCode;


DROP TABLE IF EXISTS report_check.tmp_7;
create table report_check.tmp_7 as 
SELECT sourceProductCode, transMoney AS invMoney FROM report_check.tmp_transact WHERE transType = '2' GROUP BY sourceProductCode, transMoney;



DROP TABLE IF EXISTS report_check.ivs_money;
create table report_check.ivs_money as 
SELECT t1.sourceProductCode, (cast(t1.invMoney as decimal(38,6)) + cast(t2.redpackage as decimal(38,6))) AS money 
FROM report_check.tmp_7 AS t1, 
(SELECT sourceProductCode, transMoney AS redpackage FROM report_check.tmp_transact WHERE transType = '10' GROUP BY sourceProductCode, transMoney) AS t2 
WHERE t1.sourceProductCode = t2.sourceProductCode ;



INSERT INTO report_check.norm
select IFNULL(sourceCode, "CERT20190411026") AS sourceCode, 
       '3.5.2、各种类型流水的transmony=0的流水，统计出对应的流水数量' AS norm_name, 
       cast(COUNT(1) as string) as count, 
       to_date(NOW()) as create_time 
FROM report_check.tmp_transact WHERE cast(transMoney as DECIMAL(38,6)) = 0
GROUP BY 1,2,4;



-- 抽样
DROP TABLE IF EXISTS report_check.tmp_3_5_2_problematic_data_sampling;
CREATE TABLE report_check.tmp_3_5_2_problematic_data_sampling as 
select * 
FROM report_check.tmp_transact WHERE cast(transMoney as DECIMAL(38,6)) = 0 LIMIT 10;


DROP TABLE IF EXISTS report_check.tmp_6;
create table report_check.tmp_success_transferStatus as 
SELECT t1.*, t2.transferStatus, t2.amount
FROM report_check.tmp_transferproject t1, report_check.tmp_transferStatus t2 
WHERE t1.transferId = t2.transferId AND t2.transferStatus = '2' AND t1.fromType = '2';


INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") as sourceCode, 
'5.1、check每个【债权转让项目】的【债权转让状态】是否存在，统计并记录漏推状态的散标数据量 ' AS norm_name, 
       cast(COUNT(1) as string) as count, 
       to_date(NOW()) as create_time 
FROM report_check.tmp_transferproject t1 LEFT JOIN report_check.tmp_transferStatus t2 
ON t1.transferId = t2.transferId WHERE t2.transferId IS NULL
GROUP BY 1,2,4;



-- 抽样

DROP TABLE IF EXISTS report_check.tmp_5_2_problematic_data_sampling;
CREATE TABLE report_check.tmp_5_2_problematic_data_sampling as 
SELECT t1.*
FROM report_check.tmp_transferproject t1 
LEFT JOIN report_check.tmp_transferStatus t2 
ON t1.transferId = t2.transferId WHERE t2.transferId IS NULL LIMIT 10;



INSERT INTO report_check.norm
SELECT IFNULL(sourceCode, "CERT20190411026") AS sourceCode, 
'5.2、债权来源为：【1-债权信息】的时候，该转让的【债权信息编号】在【初始债权表】中是否存在，如果不存在，统计并记录转让数量 ' as norm_name, 
       cast(COUNT(1) as string) as count, 
       to_date(NOW()) as create_time 
FROM (SELECT t1.sourceCode, t1.finClaimId FROM report_check.tmp_transferproject t1 LEFT JOIN report_check.tmp_creditor t2 ON t1.finClaimId = t2.finClaimId 
WHERE  t1.fromType = '1' AND t2.finClaimId IS NULL GROUP BY t1.sourceCode, t1.finClaimId) AS t3
GROUP BY 1,2,4;




-- 抽样
DROP TABLE IF EXISTS report_check.tmp_5_2_problematic_data_sampling;

CREATE TABLE report_check.tmp_5_2_problematic_data_sampling as 
SELECT t3.* 
FROM (SELECT t1.sourceCode, t1.finClaimId FROM report_check.tmp_transferproject t1 LEFT JOIN report_check.tmp_creditor t2 ON t1.finClaimId = t2.finClaimId 
WHERE  t1.fromType = '1' AND t2.finClaimId IS NULL GROUP BY t1.sourceCode, t1.finClaimId) AS t3 LIMIT 10;  
 



INSERT INTO report_check.norm
SELECT IFNULL(sourceCode, "CERT20190411026") AS sourceCode, 
'5.3、债权来源为：【2-承接转让信息】的时候，该转让的【债权信息编号】在【承接债权表】中是否存在，如果不存在，统计并记录转让数量 ' as norm_name, 
       cast(COUNT(1) as string) as count, 
       to_date(NOW()) as create_time 
FROM (
    SELECT t1.sourceCode, t1.finClaimId, t1.fromType, t2.unFinClaimId 
    FROM report_check.tmp_success_transferStatus t1 
    LEFT JOIN report_check.tmp_undertakeinfo t2 ON t1.finClaimId = t2.unFinClaimId 
    WHERE t1.fromType = '2' AND t2.unFinClaimId IS NULL 
    GROUP BY t1.sourceCode, t1.finClaimId, t1.fromType, t2.unFinClaimId
) as t1
GROUP BY 1,2,4;




-- 抽样
DROP TABLE IF EXISTS report_check.tmp_5_3_problematic_data_sampling;
CREATE TABLE report_check.tmp_5_3_problematic_data_sampling as 
SELECT t1.*
FROM (SELECT t1.sourceCode, t1.finClaimId, t1.fromType, t2.unFinClaimId 
FROM report_check.tmp_success_transferStatus t1 
LEFT JOIN report_check.tmp_undertakeinfo t2 
ON t1.finClaimId = t2.unFinClaimId 
WHERE t1.fromType = '2' AND t2.unFinClaimId IS NULL 
GROUP BY t1.sourceCode, t1.finClaimId, t1.fromType, t2.unFinClaimId
) as t1 LIMIT 10;




-- 产品信息check
INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") AS sourceCode, 
'6.1 check 每个【产品】的【产品配置信息】是否存在，统计并记录产品数据量' as norm_name, 
       cast(COUNT(1) as string) as count, 
       to_date(NOW()) as create_time 
FROM report_check.tmp_lendproduct t1 LEFT JOIN report_check.tmp_lendproductconfig t2 ON t1.sourceFinancingCode = t2.sourceFinancingCode 
WHERE t2.sourceFinancingCode IS NULL
GROUP BY 1,2,4;


-- 抽样
DROP TABLE IF EXISTS report_check.tmp_6_1_problematic_data_sampling;
CREATE TABLE report_check.tmp_6_1_problematic_data_sampling as 
SELECT t1.*
FROM report_check.tmp_lendproduct t1 LEFT JOIN report_check.tmp_lendproductconfig t2 ON t1.sourceFinancingCode = t2.sourceFinancingCode 
WHERE t2.sourceFinancingCode IS NULL
limit 100
;




INSERT INTO report_check.norm
SELECT IFNULL(t1.sourceCode, "CERT20190411026") AS sourceCode,
'6.2 check 每个【产品】的【投资明细】是否存在，统计并记录产品数据量' as norm_name, 
       cast(COUNT(1) as string) as count, 
       to_date(NOW()) as create_time 
FROM report_check.tmp_lendproduct t1 LEFT JOIN report_check.tmp_lendparticulars t2 
ON t1.sourceFinancingCode = t2.sourceFinancingCode 
WHERE t2.sourceFinancingCode IS NULL
GROUP BY 1,2,4;



-- 抽样
DROP TABLE IF EXISTS report_check.tmp_6_2_problematic_data_sampling;
CREATE TABLE report_check.tmp_6_2_problematic_data_sampling as 
SELECT t1.*
FROM report_check.tmp_lendproduct t1 LEFT JOIN report_check.tmp_lendparticulars t2 
ON t1.sourceFinancingCode = t2.sourceFinancingCode 
WHERE t2.sourceFinancingCode IS NULL
limit 100
;



INSERT INTO report_check.norm
SELECT IFNULL(t3.sourceCode, "CERT20190411026") AS sourceCode, 
'6.3 check 该产品的【产品配置信息】是否在【初始债权表/承接转让表】中是否存在，如果不存在，统计并记录数量' as norm_name, 
       cast(COUNT(1) as string) as count, 
       to_date(NOW()) as create_time 
FROM (SELECT t1.sourceCode, t1.finClaimId FROM report_check.tmp_lendproductconfig t1 
LEFT JOIN (SELECT finClaimId FROM report_check.tmp_creditor 
UNION 
SELECT unFinClaimId AS finClaimId FROM report_check.tmp_undertakeinfo) t2 ON t1.finClaimId = t2.finClaimId 
WHERE t2.finClaimId IS NULL GROUP BY t1.sourceCode, t1.finClaimId) as t3
GROUP BY 1,2,4;




-- 抽样
DROP TABLE IF EXISTS report_check.tmp_6_3_problematic_data_sampling;
CREATE TABLE report_check.tmp_6_3_problematic_data_sampling as 
SELECT t3.sourceCode, t3.finClaimId
FROM (SELECT t1.sourceCode, t1.finClaimId FROM report_check.tmp_lendproductconfig t1 
LEFT JOIN (SELECT finClaimId FROM report_check.tmp_creditor 
UNION 
SELECT unFinClaimId AS finClaimId FROM report_check.tmp_undertakeinfo) t2 ON t1.finClaimId = t2.finClaimId 
WHERE t2.finClaimId IS NULL GROUP BY t1.sourceCode,t1.finClaimId) as t3
limit 100
;


