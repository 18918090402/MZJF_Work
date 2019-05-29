DROP TABLE IF EXISTS IDW.FACT_BIZ_NONO_INVEST_CASH;
CREATE TABLE IF NOT EXISTS IDW.FACT_BIZ_NONO_INVEST_CASH
(
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   CASH_SRC_ID          bigint comment '兑付源表ID',
   CASH_SRC_TAB         string comment '兑付源表名',
   USER_ID              bigint comment '用户ID',
   PRODUCT_CATEGORY     string comment '产品',
   FP_ID                bigint comment '计划ID',
   PLAN_CASH_TIME       string comment '计划兑付时间',
   ACTUAL_CASH_TIME     string comment '实际兑付时间',
   CASH_STATUS          int comment '兑付状态',
   PRICE_PRINCIPAL      decimal(38,10) comment '本金',
   PRICE_INTEREST       decimal(38,10) comment '利息',
   PRICE_AMT            decimal(38,10) comment '金额',
   PRICE_PUNISH         decimal(38,10) comment '罚息和违约金',
   CASH_TYPE_CODE       int comment '兑付类型 1:正常兑付 2:债转')
COMMENT '诺诺业务线兑付'
PARTITIONED BY (DATA_STATE STRING COMMENT '数据状态')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
