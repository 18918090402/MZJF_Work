DROP TABLE IF EXISTS DMT.FACT_NONO_CUBE_AUM;
CREATE TABLE IF NOT EXISTS DMT.FACT_NONO_CUBE_AUM
(
   USER_ID              bigint comment '用户ID',
   INVEST_TYPE_CODE     int comment '投资类型 1:散投 2:债转 3:精选 4:e诺千金 5:活期 99:未知',
   FP_KEY               bigint comment '计划代理键',
   FP_ID                bigint comment '计划ID',
   CATEGORY_CODE_02     int comment '计划分类02 0:精选计划 11:贴心计划 15:月月升计划',
   CATEGORY_NAME_02     string comment '计划分类名称02',
   EXPECT               int comment '期限',
   EXPECT_UNIT_CODE     int comment '期限单位 1:日 2:月 3:年',
   AUM                  decimal(38,10) comment '在投金额',
   DIFF_BETWEEN_TODAY_AND_YESTERDAY  decimal(38,10) comment '与昨日差值',
   DIFF_BETWEEN_TODAY_AND_TOMORROW  decimal(38,10) comment '与明日差值',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '诺诺AUM数据立方体'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
