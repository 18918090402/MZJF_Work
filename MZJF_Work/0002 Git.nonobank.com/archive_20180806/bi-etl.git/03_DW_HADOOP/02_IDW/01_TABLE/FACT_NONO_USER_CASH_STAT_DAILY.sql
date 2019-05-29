DROP TABLE IF EXISTS IDW.FACT_NONO_USER_CASH_STAT_DAILY;
CREATE TABLE IF NOT EXISTS IDW.FACT_NONO_USER_CASH_STAT_DAILY
(
   USER_ID              bigint comment '用户ID',
   PRODUCT_CATEGORY     string comment '产品',
   PLATFORM             int comment '投资端 1:诺诺 2:财神',
   EXPECT               int comment '订单期限',
   EXPECT_UNIT_CODE     int comment '期限单位 1:日 2:月 3:年',
   EXPECT_NAME          string comment '期限名称',
   EXPECT_MONTH         int comment '月化期限 期限单位为日的，除以30上取整',
   CASH_AMT             decimal(38,10) comment '兑付金额',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '诺诺用户兑付日统计'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");