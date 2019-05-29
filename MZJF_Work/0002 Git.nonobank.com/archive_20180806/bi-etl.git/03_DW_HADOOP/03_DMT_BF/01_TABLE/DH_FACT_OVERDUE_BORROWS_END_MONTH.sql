drop table if exists DMT_BF.DH_FACT_OVERDUE_BORROWS_END_MONTH;

create table if not exists DMT_BF.DH_FACT_OVERDUE_BORROWS_END_MONTH
(
   BO_ID                bigint comment '借款ID',
   BUSI_LINE            string comment '所属业务线',
   USER_ID              bigint comment '用户ID',
   AGING                string comment '账龄',
   REPAY_DAY            string comment '还款日',
   BO_FINISH_PRICE      decimal(38,10) comment '完成金额',
   OVERDUE_UNREPAY_PRICE_B DECIMAL(38,10) COMMENT '逾期未还本金',
   OVERDUE_UNREPAY_PRICE_L DECIMAL(38,10) COMMENT '逾期未还利息',
   OVERDUE_UNREPAY_PRICE_PUNISH DECIMAL(38,10) COMMENT '逾期未还罚息',
   OVERDUE_UNREPAY_SERVICE_FEE DECIMAL(38,10) COMMENT '逾期未还服务费',
   UNREPAY_PRICE_B DECIMAL(38,10) COMMENT '未还本金',
   UNREPAY_PRICE_L DECIMAL(38,10) COMMENT '未还利息',
   UNREPAY_PRICE_PUNISH DECIMAL(38,10) COMMENT '未还罚息',
   UNREPAY_SERVICE_FEE DECIMAL(38,10) COMMENT '未还服务费',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间'
)
comment '逾期案件月末统计'
PARTITIONED BY (STAT_MONTH STRING COMMENT '统计日期 年-月')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;