DROP TABLE IF EXISTS DMT_CSYY.FACT_CSYY_CUBE_AUM;
CREATE TABLE IF NOT EXISTS DMT_CSYY.FACT_CSYY_CUBE_AUM
(
   USER_CODE            bigint comment '用户编号',
   USER_ID              bigint comment '用户ID',
   PRODUCT_KEY          string comment '产品代理键',
   PRODUCT_CODE         string comment '产品编码',
   INVEST_TYPE_CODE     int comment '投资类型 1:定期 2:活期',
   AUM                  decimal(38,10) comment '在投金额',
   DIFF_BETWEEN_TODAY_AND_YESTERDAY  decimal(38,10) comment '与昨日差值',
   DIFF_BETWEEN_TODAY_AND_TOMORROW  decimal(38,10) comment '与明日差值',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '财神AUM数据立方体'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
