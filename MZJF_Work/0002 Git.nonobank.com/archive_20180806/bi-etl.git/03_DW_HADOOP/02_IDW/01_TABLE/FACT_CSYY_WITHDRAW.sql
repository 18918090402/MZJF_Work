DROP TABLE IF EXISTS IDW.FACT_CSYY_WITHDRAW;
CREATE TABLE IF NOT EXISTS IDW.FACT_CSYY_WITHDRAW
(
   WITHDRAW_SRC_ID      bigint comment '提现源表ID',
   WITHDRAW_SRC_TAB     string comment '提现源表名',
   USER_CODE            bigint comment '用户编号',
   USER_ID              bigint comment '用户ID',
   WITHDRAW_TYPE        int comment '提现类型 2:财神招牌宝提现 3:单独绑卡 6:118活动提现 9:余额提现 13:财神优选宝提现 15:新优选宝提现',
   WITHDRAW_AMT         decimal(38,10) comment '提现金额',
   WITHDRAW_TIME        string comment '提现时间',
   ORDER_ID             string comment '订单号',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '财神爷爷提现记录'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
