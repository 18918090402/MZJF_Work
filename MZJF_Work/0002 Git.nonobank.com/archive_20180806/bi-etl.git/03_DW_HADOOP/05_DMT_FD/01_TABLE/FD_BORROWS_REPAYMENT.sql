drop table if exists dmt_fd.FD_BORROWS_REPAYMENT;
create table if not exists dmt_fd.FD_BORROWS_REPAYMENT
(
   BR_ID                bigint comment '还款ID',
   USER_ID              bigint comment '用户ID',
   BO_ID                bigint comment '借款ID',
   BR_TIME              string comment '计划还款时间',
   BR_REPAY_TIME        string comment '实际还款时间',
   BR_IS_REPAY          int comment '是否还款 0:没有 1:借款人还款 2:担保人还款',
   BR_PRICE             decimal(38,10) comment '还款金额',
   BR_PRICE_B           decimal(38,10) comment '本金',
   BR_PRICE_L           decimal(38,10) comment '利息',
   BR_PRICE_PUNISH      decimal(38,10) comment '罚息',
   BR_SERVICE_FEE       decimal(38,10) comment '平台服务费',
   BR_OVERDUE_TERMS     int comment '当前逾期总数',
   BR_EXPECT_NUM        int comment '当前标的第几期还款数据',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '还款表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");