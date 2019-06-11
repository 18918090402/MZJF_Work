

--4.1.1-用户信息表： report_01_userinfo
drop table if exists pdw.report_01_userinfo ;

create table pdw.report_01_userinfo
(	
     version             string comment '接口版本号'
    ,sourceCode          string comment '平台编号'
    ,userType            string comment '用户类型'
    ,userAttr            string comment '用户属性'
    ,userCreateTime      string comment '用户注册时间'
    ,userName            string comment '用户姓名/名称'
    ,countries           string comment '国别'
    ,cardType            string comment '证件类型'
    ,userIdcard          string comment '用户证件号'
    ,userIdcardHash      string comment '用户证件号hash值'
    ,userPhone           string comment '用户手机号'
    ,userPhoneHash       string comment '手机号hash值'
    ,userUuid            string comment '用户手机盐值'
    ,userLawperson       string comment '法人代表姓名'
    ,userFund            string comment '注册资本(万元)'
    ,userProvince        string comment '注册省份'
    ,userAddress         string comment '注册地址'
    ,registerDate        string comment '企业注册时间'
    ,userSex             string comment '用户性别'
    ,userBankAccount     string comment '交易银行卡号'
    ,batchNum            string comment '批次号'
    ,sendTime            string comment '发送时间'
    ,id                  bigint comment 'id'
    ,batch_type          string comment '批量类型'
)
comment '4.1.1-用户信息表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;


--4.1.2-散标信息表： report_02_scatterinvest
drop table if exists pdw.report_02_scatterinvest ;

create table pdw.report_02_scatterinvest
(	
     version                    string comment '接口版本号'
    ,sourceCode                 string comment '平台编号'
    ,productStartTime           string comment '开标时间'
    ,productName                string comment '散标名称'
    ,sourceProductCode          string comment '散标信息编号'
    ,userIdcardHash             string comment '借款用户证件号hash值'
    ,loanUse                    string comment '借款用途'
    ,loanDescribe               string comment '借款说明'
    ,loanRate                   string comment '借款年利率'
    ,amount                     string comment '借款金额(元)'
    ,surplusAmount              string comment '剩余借款本金'
    ,term                       string comment '借款期限(天)'
    ,payType                    string comment '还款类型'
    ,serviceCost                string comment '服务费(元)'
    ,loanType                   string comment '借款类型'
    ,securityType               string comment '担保方式'
    ,securityCompanyAmount      string comment '担保公司数量'
    ,securityCompanyName        string comment '第三方担保机构/保险公司的全称'
    ,securityCompanyIdcard      string comment '担保机构或保险公司统一社会信用代码'
    ,isFinancingAssure          string comment '是否具有融资担保业务经营许可证'
    ,securityAmount             string comment '担保手续费(合同金额)(元)'
    ,projectSource              string comment '散标来源'
    ,batchNum                   string comment '批次号'
    ,sendTime                   string comment '发送时间'
    ,id                         bigint comment 'id'
    ,batch_type                 string comment '批量类型'
)
comment '4.1.2-散标信息表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;

--4.1.3-散标状态表： report_03_status
drop table if exists pdw.report_03_status ;

create table pdw.report_03_status
(	
     version            string comment '接口版本号'
    ,sourceCode         string comment '平台编号'
    ,sourceProductCode  string comment '散标信息编号'
    ,productStatus      string comment '状态编码'
    ,productDate        string comment '状态更新时间'
    ,batchNum           string comment '批次号'
    ,sendTime           string comment '发送时间'
    ,id                 bigint comment 'id'    
    ,batch_type         string comment '批量类型'
)
comment '4.1.3-散标状态表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;


--4.1.4-还款计划表： report_04_repayplan
drop table if exists pdw.report_04_repayplan ;

create table pdw.report_04_repayplan
(	
     version                string comment '接口版本号'
    ,sourceCode             string comment '平台编号'
    ,sourceProductCode      string comment '散标信息编号'
    ,userIdcardHash         string comment '借款人用户证件号hash值'
    ,totalIssue             string comment '还款总期数'
    ,issue                  string comment '本条记录(当期)所属期数'
    ,replanId               string comment '还款计划编号'
    ,curFund                string comment '本条记录(当期)应还本金(元)'
    ,curInterest            string comment '本条记录(当期)应还利息(元)'
    ,curServiceCharge       string comment '本条记录(当期)应还服务费(元)'
    ,repayTime              string comment '本条记录(当期)应还款时间点'
    ,batchNum               string comment '批次号'
    ,sendTime               string comment '发送时间'
    ,id                     bigint comment 'id'    
    ,batch_type             string comment '批量类型'
)
comment '4.1.4-还款计划表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;


--4.1.5-初始债权表： report_05_creditor
drop table if exists pdw.report_05_creditor ;

create table pdw.report_05_creditor
(	
     version                string comment '接口版本号'
    ,sourceCode             string comment '平台编号'
    ,finClaimId             string comment '初始债权编号'
    ,sourceProductCode      string comment '散标信息编号'
    ,userIdcardHash         string comment '出借用户证件号hash值'
    ,invAmount              string comment '出借金额(元)'
    ,invRate                string comment '出借预期年化利率'
    ,invTime                string comment '出借计息时间'
    ,redpackage             string comment '出借红包(满减)(元)'
    ,lockTime               string comment '锁定截止时间'
    ,batchNum               string comment '批次号'
    ,sendTime               string comment '发送时间'
    ,id                     bigint comment 'id'    
    ,batch_type             string comment '批量类型'
)
comment '4.1.5-初始债权表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;

--4.1.9-交易流水表： report_09_transact
drop table if exists pdw.report_09_transact ;

create table pdw.report_09_transact
(	
     version            string comment '接口版本号'
    ,sourceCode         string comment '平台编号'
    ,transId            string comment '网贷机构交易流水号'
    ,sourceProductCode  string comment '散标信息编号'
    ,sourceProductName  string comment '散标名称'
    ,finClaimId         string comment '债权编号'
    ,transferId         string comment '转让信息编号'
    ,replanId           string comment '还款计划编号'
    ,transType          string comment '交易类型'
    ,transMoney         string comment '交易金额(元)'
    ,userIdcardHash     string comment '交易主体证件号hash值'
    ,transTime          string comment '交易发生时间'
    ,batchNum           string comment '批次号'
    ,sendTime           string comment '发送时间'
    ,id                 bigint comment 'id'    
    ,batch_type         string comment '批量类型'
)
comment '4.1.9-交易流水表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;


--4.1.10-产品信息表： report_10_lendproduct
drop table if exists pdw.report_10_lendproduct ;

create table pdw.report_10_lendproduct
(	
     version                    string comment '接口版本号'
    ,sourceCode                 string comment '平台编号'
    ,sourceFinancingCode        string comment '产品信息编号'
    ,financingStartTime         string comment '发布时间'
    ,productName                string comment '产品名称'
    ,rate                       string comment '预期年化利率(参考回报率)'
    ,minRate                    string comment '最小预期年化利率'
    ,maxRate                    string comment '最大预期年化利率'
    ,term                       string comment '产品期限(服务期限)(天)'
    ,batchNum                   string comment '批次号'
    ,sendTime                   string comment '发送时间'
    ,id                         bigint comment 'id'    
    ,batch_type                 string comment '批量类型'
)
comment '4.1.10-产品信息表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;


--4.1.11-产品配置表：report_11_lendproductconfig
drop table if exists pdw.report_11_lendproductconfig ;

create table pdw.report_11_lendproductconfig
(	
     version                string comment '接口版本号'
    ,sourceCode             string comment '平台编号'
    ,configId               string comment '产品配置编号'
    ,finClaimId             string comment '债权编号'
    ,sourceFinancingCode    string comment '产品信息编号'
    ,userIdcardHash         string comment '出借用户证件号hash值'
    ,batchNum               string comment '批次号'
    ,sendTime               string comment '发送时间'
    ,id                     bigint comment 'id'    
    ,batch_type             string comment '批量类型'
)
comment '4.1.11-产品配置表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;


--4.1.12-投资明细表：report_12_lendparticulars
drop table if exists pdw.report_12_lendparticulars ;

create table pdw.report_12_lendparticulars
(	
     version                string comment '接口版本号'
    ,sourceCode             string comment '平台编号'
    ,transId                string comment '出借人每笔交易流水的唯一编号'
    ,sourceFinancingCode    string comment '产品信息编号'
    ,transType              string comment '交易类型'
    ,transMoney             string comment '交易金额(元)'
    ,userIdcardHash         string comment '出借用户证件号hash值'
    ,transTime              string comment '交易发生时间'
    ,batchNum               string comment '批次号'
    ,sendTime               string comment '发送时间'
    ,id                     bigint comment 'id'    
    ,batch_type             string comment '批量类型'
)
comment '4.1.12-投资明细表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;



--impala refresh
INVALIDATE METADATA pdw.report_01_userinfo	;
INVALIDATE METADATA pdw.report_02_scatterinvest;	
INVALIDATE METADATA pdw.report_03_status	;
INVALIDATE METADATA pdw.report_04_repayplan	;
INVALIDATE METADATA pdw.report_05_creditor	;
INVALIDATE METADATA pdw.report_09_transact	;
INVALIDATE METADATA pdw.report_10_lendproduct;	
INVALIDATE METADATA pdw.report_11_lendproductconfig;	
INVALIDATE METADATA pdw.report_12_lendparticulars	;




---
--4.1.6 债权转让表： report_06_transferproject
drop table if exists pdw.report_06_transferproject ;

create table pdw.report_06_transferproject
(	
     version                string comment '接口版本号'
    ,sourceCode             string comment '平台编号'
    ,transferId             string comment '转让信息编号'
    ,fromType               string comment '债权来源'
    ,finClaimId             string comment '债权编号'
    ,userIdcardHash         string comment '出借用户证件号hash值'
    ,sourceProductCode      string comment '散标信息编号'
    ,transferAmount         string comment '计划转让本金(元)'
    ,transferInterestRate   string comment '计划转让利率'
    ,floatMoney             string comment '计划浮动金额(元)'
    ,transferDate           string comment '转让项目发布的日期'
    ,batchNum               string comment '批次号'
    ,sendTime               string comment '发送时间'
    ,id                     bigint comment 'id'
    ,batch_type             string comment '批量类型'
)
comment '4.1.6 债权转让表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;

--4.1.7 转让状态表： pdw.report_07_transferstatus
drop table if exists pdw.report_07_transferstatus ;

create table pdw.report_07_transferstatus
(	
     version                string comment '接口版本号'
    ,sourceCode             string comment '平台编号'
    ,transferId             string comment '转让信息编号'
    ,transferStatus         string comment '状态编码'
    ,amount                 string comment '成功转让本金金额(元)'
    ,floatMoney             string comment '成功转让浮动金额(元)'
    ,productDate            string comment '状态更新时间'
    ,batchNum               string comment '批次号'
    ,sendTime               string comment '发送时间'
    ,id                     bigint comment 'id'    
    ,batch_type             string comment '批量类型'
)
comment '4.1.7 转让状态表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;

--4.1.8 承接转让表： pdw.report_08_undertakeinfo
drop table if exists pdw.report_08_undertakeinfo ;

create table pdw.report_08_undertakeinfo
(	
     version                string comment '接口版本号'
    ,sourceCode             string comment '平台编号'
    ,unFinClaimId           string comment '承接转让编号'
    ,transferId             string comment '转让信息编号'
    ,finClaimId             string comment '债权信息编号'
    ,userIdcardHash         string comment '借款用户证件号hash值'
    ,takeAmount             string comment '承接金额(元)'
    ,takeInterest           string comment '承接利息金额(元)'
    ,floatMoney             string comment '承接浮动金额(元)'
    ,takeRate               string comment '承接预期年化利率'
    ,takeTime               string comment '承接时间'
    ,redpackage             string comment '出借红包(元)'
    ,lockTime               string comment '锁定截止时间'
    ,batchNum               string comment '批次号'
    ,sendTime               string comment '发送时间'
    ,id                     bigint comment 'id'    
    ,batch_type             string comment '批量类型'
)
comment '4.1.8 承接转让表'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;



INVALIDATE METADATA pdw.report_06_transferproject;	
INVALIDATE METADATA pdw.report_07_transferstatus;	
INVALIDATE METADATA pdw.report_08_undertakeinfo	;



drop table if exists pdw.user_info ;

CREATE TABLE pdw.user_info  ( 
	id               	bigint COMMENT '主键id' ,
	user_id          	bigint COMMENT '用户id' ,
	user_account_no  	string COMMENT '徽商电子账号' ,
	user_attr        	string COMMENT '用户属性 0:不确定 1:出借方 2:借款方 3:出借方+借款方' ,
	user_type        	string COMMENT '用户类型 1-自然人;2-企业' ,
	user_create_time 	string COMMENT '用户注册时间' ,
	user_name        	string COMMENT '用户姓名/名称' ,
	countries        	string COMMENT '国别 1-中国大陆;2-中国港澳 台;3-国外' ,
	card_type        	string COMMENT '证件类型' ,
	user_idcard      	string COMMENT '用户证件号' ,
	user_idcard_hash 	string COMMENT '用户证件号hash值' ,
	user_phone       	string COMMENT '用户手机号' ,
	user_phonehash   	string COMMENT '手机号hash值' ,
	user_uuid        	string COMMENT '用户手机盐值' ,
	user_lawperson   	string COMMENT '法人代表姓名' ,
	user_fund        	string COMMENT '注册资本' ,
	user_province    	string COMMENT '注册省份' ,
	user_address     	string COMMENT '注册地址' ,
	register_date    	string COMMENT '企业注册时间' ,
	user_sex         	string COMMENT '用户性别 用户类型是企业填写-1 1:男;0:女' ,
	user_bank_account	string COMMENT '交易银行卡号' ,
	biz_date         	string COMMENT '业务日期yyyy-MM-dd' ,
	is_delete        	int COMMENT '是否删除 0:否 1:是' ,
	version          	int COMMENT '版本号' ,
	create_time      	string COMMENT '创建时间' ,
	update_time      	string COMMENT '更新时间' 
)
comment 'user_info'
row format delimited null defined as '' stored as parquet
tblproperties ("orc.compression"="snappy")
;


INVALIDATE METADATA pdw.user_info	;
