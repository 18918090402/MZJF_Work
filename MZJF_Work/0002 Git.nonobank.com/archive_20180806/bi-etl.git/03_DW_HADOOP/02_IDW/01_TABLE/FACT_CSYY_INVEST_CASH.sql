drop table if exists IDW.FACT_CSYY_INVEST_CASH;

create table if not exists IDW.FACT_CSYY_INVEST_CASH
(
   CASH_SRC_ID          bigint comment '兑付源表ID',
   CASH_SRC_TAB         string comment '兑付源表名',
   USER_CODE            bigint comment '用户编号',
   USER_ID              bigint comment '用户ID',
   PRODUCT_KEY          string comment '产品代理键',
   PRODUCT_CODE         string comment '产品编码',
   CASH_TIME            string comment '兑付时间',
   PRICE_PRINCIPAL      decimal(38,10) comment '本金',
   PRICE_INTEREST       decimal(38,10) comment '利息',
   PRICE_AMT            decimal(38,10) comment '金额',
   INVEST_SRC_ID        bigint comment '投资源表ID',
   INVEST_SRC_TAB       string comment '投资源表名',
   INVEST_TYPE_CODE     int comment '投资类型 1:定期 2:活期',
   CASH_TYPE_CODE       int comment '兑付类型 1:活期提现 2:活转定 3:定期兑付',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间'
)
comment '财神爷爷投资兑付'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");