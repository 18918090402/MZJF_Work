DROP TABLE IF EXISTS IDW.FACT_CSYY_RECHARGE;
CREATE TABLE IF NOT EXISTS IDW.FACT_CSYY_RECHARGE
(
   RECHARGE_SRC_ID      bigint comment '充值源表ID',
   RECHARGE_SRC_TAB     string comment '充值源表名',
   USER_CODE            bigint comment '用户编号',
   USER_ID              bigint comment '用户ID',
   RECHARGE_TIME        string comment '充值时间',
   PAY_TYPE             int comment '支付类型 1:易联 2:快钱 3:钱方 4:连连 5:宝付 6:盛付通 7:微信直连',
   RECHARGE_AMT         decimal(38,10) comment '充值金额',
   ORDER_ID             string comment '订单号',
   BANK_NAME            string comment '银行名称',
   BANK_CARD_NO         string comment '银行卡号',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '财神爷爷充值记录'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
