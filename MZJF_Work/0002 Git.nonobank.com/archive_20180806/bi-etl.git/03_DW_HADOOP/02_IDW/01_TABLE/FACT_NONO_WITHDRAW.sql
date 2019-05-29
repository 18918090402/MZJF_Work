DROP TABLE IF EXISTS IDW.FACT_NONO_WITHDRAW;
CREATE TABLE IF NOT EXISTS IDW.FACT_NONO_WITHDRAW
(
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   WITHDRAW_SRC_ID      bigint comment '提现源表ID',
   WITHDRAW_SRC_TAB     string comment '提现源表名',
   USER_ID              bigint comment '用户ID',
   WITHDRAW_CHANNEL     int comment '提现途径 1:支付宝 2:盛付通 3:新生支付 4:易联支付 5:快钱前台自动提现 6.:快钱后台自动提现 7:自动审批通过 8:微商存管',
   WITHDRAW_AMT         decimal(38,10) comment '提现金额',
   WITHDRAW_TIME        string comment '提现时间',
   FEE                  decimal(38,10) comment '网站提现费用',
   BANK_NAME            string comment '银行名称',
   BANK_CARD_NO         string comment '银行卡号',
   PROVINCE_NAME        string comment '省名',
   CITY_NAME            string comment '市名',
   ALIPAY_NO            string comment '支付宝账号',
   TERMINAL             int comment '终端',
   BO_ID                bigint comment '借款ID',
   SYSTEM_ID            string comment '系统ID')
COMMENT '诺诺提现记录'
PARTITIONED BY (DATA_STATE STRING COMMENT '数据状态')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
