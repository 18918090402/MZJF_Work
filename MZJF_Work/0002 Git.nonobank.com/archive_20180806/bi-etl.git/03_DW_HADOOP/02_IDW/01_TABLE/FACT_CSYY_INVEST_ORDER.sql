drop table if exists IDW.FACT_CSYY_INVEST_ORDER;
create table IDW.FACT_CSYY_INVEST_ORDER
(
   INVEST_SRC_ID        bigint comment '投资源表ID',
   INVEST_SRC_TAB       string comment '投资源表名',
   USER_CODE            bigint comment '用户编号',
   USER_ID              bigint comment '用户ID',
   PRODUCT_KEY          string comment '产品代理键',
   PRODUCT_CODE         string comment '产品编码',
   INVEST_TIME          string comment '投资时间',
   INVEST_AMT           decimal(38,10) comment '投资金额',
   REMAINING_PRINCIPAL  decimal(38,10) comment '剩余本金',
   TOTAL_INTEREST       decimal(38,10) comment '本次投资总收益',
   REMAINING_INTEREST   decimal(38,10) comment '剩余收益',
   EXPECT               int comment '订单期限',
   EXPECT_UNIT_CODE     int comment '期限单位 1:日 2:月 3:年',
   LOCK_BEGIN_TIME      string comment '锁定生效时间',
   LOCK_END_TIME        string comment '锁定结束时间',
   RATE                 decimal(38,10) comment '预计年收益',
   DEDUCTIBLE_AMT       decimal(38,10) comment '现金券抵扣金额',
   INVEST_TYPE_CODE     int comment '投资类型 1:定期 2:活期',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   INVEST_AMT_YEARLY    decimal(38,10) comment '年化投资金额'
)
COMMENT '财神爷爷投资订单'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY");
