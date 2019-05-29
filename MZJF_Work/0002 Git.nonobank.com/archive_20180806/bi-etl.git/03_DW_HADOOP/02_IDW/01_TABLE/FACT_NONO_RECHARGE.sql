DROP TABLE IF EXISTS IDW.FACT_NONO_RECHARGE;
CREATE TABLE IF NOT EXISTS IDW.FACT_NONO_RECHARGE
(
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   RECHARGE_SRC_ID      bigint comment '充值源表ID',
   RECHARGE_SRC_TAB     string comment '充值源表名',
   USER_ID              bigint comment '用户ID',
   RECHARGE_TIME        string comment '充值时间',
   PAY_TYPE             int comment '支付类型 1:易联 2:快钱 3:钱方 4:连连 5:宝付 6:盛付通 7:微信直连 8:微商存管',
   RECHARGE_TYPE        string comment '充值类型',
   RECHARGE_AMT         decimal(38,10) comment '充值金额',
   ORDER_NO             string comment '订单号',
   ORDER_SN             string comment '流水号',
   BANK_NAME            string comment '银行名称',
   BANK_CARD_NO         string comment '银行卡号',
   TERMINAL             string comment '终端',
   SYSTEM_ID            string comment '系统ID')
COMMENT '诺诺充值记录'
PARTITIONED BY (DATA_STATE STRING COMMENT '数据状态')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
