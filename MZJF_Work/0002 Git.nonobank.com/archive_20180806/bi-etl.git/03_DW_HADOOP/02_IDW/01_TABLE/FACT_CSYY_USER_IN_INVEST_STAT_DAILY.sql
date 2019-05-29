DROP TABLE IF EXISTS IDW.FACT_CSYY_USER_IN_INVEST_STAT_DAILY;
CREATE TABLE IF NOT EXISTS IDW.FACT_CSYY_USER_IN_INVEST_STAT_DAILY
(
   USER_CODE            bigint comment '用户编号',
   USER_ID              bigint comment '用户ID',
   PRODUCT_CODE         string comment '产品编码',
   PRODUCT_NAME         string comment '产品名称',
   AUM                  decimal(38,10) comment 'AUM',
   KXCS_LOCK_AUM        decimal(38,10) comment '开心财神锁定期内AUM',
   KXCS_UNLOCK_AUM      decimal(38,10) comment '开心财神可转出AUM',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '财神用户在投日统计'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");