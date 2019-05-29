CREATE TABLE IF NOT EXISTS IDW.FACT_BORROWS_REPAYMENT
    (
   BR_ID                bigint comment '还款ID',
   USER_ID              bigint comment '用户ID',
   BO_ID                bigint comment '借款ID',
   BR_PRICE             decimal(38,10) comment '还款金额',
   BR_PRICE_B           decimal(38,10) comment '本金',
   BR_PRICE_L           decimal(38,10) comment '利息',
   BR_PRICE_PUNISH      decimal(38,10) comment '罚息和违约金',
   BR_PRICE_PUNISH_LENDER decimal(38,10) comment '罚金借出者收取',
   BR_PRICE_PUNISH_PC   decimal(38,10) comment '罚金机构收取',
   BR_TIME              string comment '计划还款时间',
   BR_REPAY_TIME        string comment '实际还款时间',
   BR_IS_REPAY          int comment '是否还款',
   BR_REPAY_STATUS      int comment '还款状态',
   BR_TRANSFER_FA_ID    bigint comment '债转对应的fa_id',
   BR_CALL_RECORD       string comment '电话记录',
   BR_REPAYED_TECH_FEE  decimal(38,10) comment '当期归还的技术的服务费',
   DUNNING_WAY          string comment '催收方式',
   BR_LOCKED            int comment '是否锁定',
   BR_OVERDUE_TERMS     int comment '当前逾期总数',
   BR_IS_HNAPAY_DEDUCT  int comment '是否代划扣',
   BR_SERVICE_FEE       decimal(38,10) comment '平台服务费',
   BR_IS_SEND_SMS       int comment '是否已发送短信通知',
   BR_EXPECT_NUM        int comment '当前标的第几期还款数据',
   PRICE_RETURN         decimal(38,10) comment '使用减息券之后平台返回给借入者的资金',
   BO_AUDIT_TIME        string comment '放款时间',
   IS_FIRST_REPAY_OVERDUE int comment '是否首还逾期',
   IS_FIRST_OVERDUE     int comment '是否首次逾期',
   CREATOR              bigint comment '创建人',
   UPDATOR              bigint comment '更新人',
   CREATE_TIME          string comment '创建时间',
   UPDATE_TIME          string comment '更新时间',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间'
    )
    COMMENT '借入者还款表'
    PARTITIONED BY (PD STRING COMMENT '分区键:日期')
    ROW FORMAT DELIMITED
      NULL DEFINED AS ''
    STORED AS PARQUET TBLPROPERTIES ("parquet.compression"="SNAPPY");