DROP TABLE IF EXISTS IDW.FACT_BIZ_NONO_AUM;
CREATE TABLE IF NOT EXISTS IDW.FACT_BIZ_NONO_AUM
(
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   USER_ID              bigint comment '用户ID',
   PRODUCT_CATEGORY     string comment '产品',
   FP_ID                bigint comment '计划ID',
   IN_INVEST_AMT        decimal(38,10) comment '在投金额',
   AUM                  decimal(38,10) comment 'AUM')
COMMENT '诺诺业务线在投'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");