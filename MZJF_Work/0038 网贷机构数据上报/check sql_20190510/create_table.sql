CREATE TABLE IF NOT EXISTS `creditor` (
  `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `finClaimId` varchar(128) DEFAULT NULL,
  `sourceProductCode` varchar(128) DEFAULT NULL,
  `userIdcardHash` varchar(64) DEFAULT NULL,
  `invAmount` varchar(20) DEFAULT NULL,
  `invRate` varchar(20) DEFAULT NULL,
  `invTime` varchar(32) DEFAULT NULL,
  `redpackage` varchar(20) DEFAULT NULL,
  `lockTime` varchar(32) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `repayplan` (
  `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `sourceProductCode` varchar(128) DEFAULT NULL,
  `userIdcardHash` varchar(64) DEFAULT NULL,
  `totalIssue` int(12) DEFAULT NULL,
  `issue` int(2) DEFAULT NULL,
  `replanId` varchar(128) DEFAULT NULL,
  `curFund` varchar(40) DEFAULT NULL,
  `curInterest` varchar(40) DEFAULT NULL,
  `curServiceCharge` varchar(40) DEFAULT NULL,
  `repayTime` varchar(32) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `scatterinvest` (
 `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `productStartTime` varchar(40) DEFAULT NULL,
  `productName` varchar(256) DEFAULT NULL,
  `sourceProductCode` varchar(128) DEFAULT NULL,
  `userIdcardHash` varchar(64) DEFAULT NULL,
  `loanUse` varchar(10) DEFAULT NULL,
  `loanDescribe` varchar(2000) DEFAULT NULL,
  `loanRate` varchar(32) DEFAULT NULL,
  `amount` varchar(32) DEFAULT NULL,
  `surplusAmount` varchar(32) DEFAULT NULL,
  `term` varchar(5) DEFAULT NULL,
  `payType` varchar(5) DEFAULT NULL,
  `serviceCost` varchar(32) DEFAULT NULL,
  `loanType` varchar(64) DEFAULT NULL,
  `securityType` varchar(50) DEFAULT NULL,
  `securityCompanyAmount` varchar(10) DEFAULT NULL,
  `securityCompanyName` varchar(255) DEFAULT NULL,
  `securityCompanyIdcard` varchar(64) DEFAULT NULL,
  `isFinancingAssure` varchar(1) DEFAULT NULL,
  `securityAmount` varchar(32) DEFAULT NULL,
  `projectSource` varchar(128) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `status` (
  `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `sourceProductCode` varchar(128) DEFAULT NULL,
  `productStatus` varchar(20) DEFAULT NULL,
  `productDate` varchar(40) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `transact` (
  `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `transId` varchar(128) DEFAULT NULL,
  `sourceProductCode` varchar(128) DEFAULT NULL,
  `sourceProductName` varchar(256) DEFAULT NULL,
  `finClaimId` varchar(128) DEFAULT NULL,
  `transferId` varchar(128) DEFAULT NULL,
  `replanId` varchar(128) DEFAULT NULL,
  `transType` varchar(20) DEFAULT NULL,
  `transMoney` varchar(32) DEFAULT NULL,
  `userIdcardHash` varchar(64) DEFAULT NULL,
  `transTime` varchar(80) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL,
  KEY `index_2` (`transId`,`sourceProductCode`,`transferId`),
  KEY `index3` (`transType`,`sourceProductCode`),
  KEY `index_3` (`sourceProductCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS `transferproject` (
  `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `transferId` varchar(128) DEFAULT NULL,
  `fromType` char(1) DEFAULT NULL,
  `finClaimId` varchar(128) DEFAULT NULL,
  `userIdcardHash` varchar(64) DEFAULT NULL,
  `sourceProductCode` varchar(128) DEFAULT NULL,
  `transferAmount` varchar(20) DEFAULT NULL,
  `transferInterestRate` varchar(32) DEFAULT NULL,
  `floatMoney` varchar(20) DEFAULT NULL,
  `transferDate` varchar(32) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `transferstatus` (
  `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `transferId` varchar(128) DEFAULT NULL,
  `transferStatus` varchar(20) DEFAULT NULL,
  `amount` varchar(20) DEFAULT NULL,
  `floatMoney` varchar(20) DEFAULT NULL,
  `productDate` varchar(40) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `undertakeinfo` (
  `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `unFinClaimId` varchar(128) DEFAULT NULL,
  `transferId` varchar(128) DEFAULT NULL,
  `finClaimId` varchar(128) DEFAULT NULL,
  `userIdcardHash` varchar(64) DEFAULT NULL,
  `takeAmount` varchar(20) DEFAULT NULL,
  `takeInterest` varchar(20) DEFAULT NULL,
  `floatMoney` varchar(20) DEFAULT NULL,
  `takeRate` varchar(20) DEFAULT NULL,
  `takeTime` varchar(32) DEFAULT NULL,
  `redpackage` varchar(20) DEFAULT NULL,
  `lockTime` varchar(32) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `userinfo` (
 `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `userType` varchar(20) DEFAULT NULL,
  `userAttr` varchar(20) DEFAULT NULL,
  `userCreateTime` varchar(40) DEFAULT NULL,
  `userName` varchar(256) DEFAULT NULL,
  `countries` varchar(3) DEFAULT NULL,
  `cardType` varchar(2) DEFAULT NULL,
  `userIdcard` varchar(64) DEFAULT NULL,
  `userIdcardHash` varchar(64) DEFAULT NULL,
  `userPhone` varchar(64) DEFAULT NULL,
  `userPhoneHash` varchar(64) DEFAULT NULL,
  `userUuid` varchar(64) DEFAULT NULL,
  `userLawperson` varchar(64) DEFAULT NULL,
  `userFund` varchar(20) DEFAULT NULL,
  `userProvince` varchar(20) DEFAULT NULL,
  `userAddress` varchar(256) DEFAULT NULL,
  `registerDate` varchar(30) DEFAULT NULL,
  `userSex` varchar(3) DEFAULT NULL,
  `userBankAccount` varchar(40) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL,
  KEY `index_1` (`userIdcardHash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# 产品信息
CREATE TABLE IF NOT EXISTS `lendproduct` (
  `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `sourceFinancingCode` varchar(128) DEFAULT NULL,
  `financingStartTime` varchar(40) DEFAULT NULL,
  `productName` varchar(255) DEFAULT NULL,
  `rate` varchar(32) DEFAULT NULL,
  `minRate` varchar(32) DEFAULT NULL,
  `maxRate` varchar(32) DEFAULT NULL,
  `term` varchar(10) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL,
  KEY `sourceFinancingCode` (`sourceFinancingCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `lendproductconfig` (
  `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `configId` varchar(128) DEFAULT NULL,
  `finClaimId` varchar(128) DEFAULT NULL,
  `sourceFinancingCode` varchar(128) DEFAULT NULL,
  `userIdcardHash` varchar(64) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL,
  KEY `finClaimId` (`finClaimId`),
  KEY `sourceFinancingCode` (`sourceFinancingCode`),
  KEY `userIdcardHash` (`userIdcardHash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `lendparticulars` (
  `version` varchar(20) DEFAULT NULL,
  `sourceCode` varchar(64) DEFAULT NULL,
  `transId` varchar(128) DEFAULT NULL,
  `sourceFinancingCode` varchar(128) DEFAULT NULL,
  `transType` varchar(20) DEFAULT NULL,
  `transMoney` varchar(32) DEFAULT NULL,
  `userIdcardHash` varchar(64) DEFAULT NULL,
  `transTime` varchar(80) DEFAULT NULL,
  `batchNum` varchar(256) DEFAULT NULL,
  `sendTime` varchar(40) DEFAULT NULL,
  KEY `sourceFinancingCode` (`sourceFinancingCode`),
  KEY `userIdcardHash` (`userIdcardHash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


