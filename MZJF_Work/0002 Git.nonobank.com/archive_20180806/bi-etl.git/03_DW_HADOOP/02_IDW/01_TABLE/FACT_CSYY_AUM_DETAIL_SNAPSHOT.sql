drop table if exists IDW.FACT_CSYY_AUM_DETAIL_SNAPSHOT;

create table IDW.FACT_CSYY_AUM_DETAIL_SNAPSHOT
(
   USER_CODE            bigint comment '用户编号',
   USER_ID              bigint comment '用户ID',
   PRODUCT_KEY          string comment '产品代理键',
   PRODUCT_CODE         string comment '产品编码',
   INVEST_TYPE_CODE     int comment '投资类型 1:定期 2:活期',
   INVEST_AMT           decimal(38,10) comment '原始投资金额',
   AUM                  decimal(38,10) comment '在投金额',
   INVEST_SRC_ID        bigint comment '投资源表ID',
   INVEST_SRC_TAB       string comment '投资源表名',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   REMAINING_INTEREST   decimal(38,10) comment '剩余收益',
   TOTAL_INTEREST       decimal(38,10) comment '总收益'
)
COMMENT '财神爷爷AUM详情快照表'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY");