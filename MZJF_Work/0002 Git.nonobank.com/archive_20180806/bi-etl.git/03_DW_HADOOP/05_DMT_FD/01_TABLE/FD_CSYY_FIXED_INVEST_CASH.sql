drop table if exists dmt_fd.FD_CSYY_FIXED_INVEST_CASH;
create table if not exists dmt_fd.FD_CSYY_FIXED_INVEST_CASH
(
   SRC_ID               BIGINT COMMENT '源表ID',
   SRC_TAB              string COMMENT '源表名',
   USER_ID              BIGINT COMMENT '用户ID',
   USER_CODE            BIGINT COMMENT '用户编号',
   PRODUCT_CODE         string COMMENT '产品编码',
   ACCEPT_TIME          string COMMENT '收款时间',
   PRICE_PRINCIPAL      DECIMAL(38,10) COMMENT '本金',
   PRICE_INTEREST       DECIMAL(38,10) COMMENT '利息',
   PRICE_AMT            DECIMAL(38,10) COMMENT '金额',
   DW_ORDER_ID          BIGINT COMMENT '订单ID',
   DW_ORDER_TAB         string COMMENT '订单表名',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '财神爷爷定期投资兑付'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");