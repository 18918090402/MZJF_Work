drop table if exists idw.FACT_MONTH_REPAY_STAT_DAILY;
create table if not exists idw.FACT_MONTH_REPAY_STAT_DAILY
(
   BO_ID                bigint comment '借款ID',
   P_ID                 bigint comment '产品ID',
   BUSI_LINE            string comment '所属业务线',
   USER_ID              bigint comment '用户ID',
   BO_RATE              decimal(38,10) comment '借款年利率',
   INTEREST_RATE_CUT    decimal(38,10) comment '减息',
   BO_AUDIT_TIME        string comment '审核时间',
   BO_AGREE_TIME        string comment '协议生效时间',
   SHOULD_REPAY_PRICE_THIS_MONTH decimal(38,10) comment '当月应还金额',
   SHOULD_REPAY_PRICE_B_THIS_MONTH decimal(38,10) comment '当月应还本金',
   SHOULD_REPAY_PRICE_L_THIS_MONTH decimal(38,10) comment '当月应还利息',
   SHOULD_REPAY_PRICE_PUNISH_THIS_MONTH decimal(38,10) comment '当月应还罚息',
   SHOULD_REPAY_SERVICE_FEE_THIS_MONTH decimal(38,10) comment '当月应还平台服务费',
   SHOULD_RETURN_PRICE_THIS_MONTH decimal(38,10) comment '当月应返还金额',
   REPAYED_PRICE_THIS_MONTH decimal(38,10) comment '当月已还金额',
   REPAYED_PRICE_B_THIS_MONTH decimal(38,10) comment '当月已还本金',
   REPAYED_PRICE_L_THIS_MONTH decimal(38,10) comment '当月已还利息',
   REPAYED_PRICE_PUNISH_THIS_MONTH decimal(38,10) comment '当月已还罚息',
   REPAYED_SERVICE_FEE_THIS_MONTH decimal(38,10) comment '当月已还平台服务费',
   RETURNED_PRICE_THIS_MONTH decimal(38,10) comment '当月已返还金额',
   SHOULD_REPAY_PRICE_TO_END_MONTH decimal(38,10) comment '当前至月底应还金额',
   SHOULD_REPAY_PRICE_B_TO_END_MONTH decimal(38,10) comment '当前至月底应还本金',
   SHOULD_REPAY_PRICE_L_TO_END_MONTH decimal(38,10) comment '当前至月底应还利息',
   SHOULD_REPAY_PRICE_PUNISH_TO_END_MONTH decimal(38,10) comment '当前至月底应还罚息',
   SHOULD_REPAY_SERVICE_FEE_TO_END_MONTH decimal(38,10) comment '当前至月底应还平台服务费',
   SHOULD_RETURN_PRICE_TO_END_MONTH decimal(38,10) comment '当前至月底应返还金额',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   CATEGORY_NAME_01     string comment '产品分类01',
   BIZ_CODE_01          string comment '业务线编码01',
   BIZ_NAME_01          string comment '业务线名称01',
   DEPOSITORY_FLAG      int comment '存管标记 0:初始 1:走存管 2:不走存管',
   TRANSFER_ACCOUNT_TIME string comment '实际划转成功时间',
   P_NAME               string comment '产品名称',
   REPAYED_NORMAL_PRICE_THIS_MONTH decimal(38,10) comment '当月正常还款金额',
   REPAYED_OVERDUE_PRICE_THIS_MONTH decimal(38,10) comment '当月逾期还款金额',
   LAST_REPAYED_TIME_THIS_MONTH string comment '当月最近还款时间')
COMMENT '月还款情况日统计'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");