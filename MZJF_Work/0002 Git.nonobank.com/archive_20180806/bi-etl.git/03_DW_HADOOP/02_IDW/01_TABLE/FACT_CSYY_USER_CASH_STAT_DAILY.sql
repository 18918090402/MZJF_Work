DROP TABLE IF EXISTS IDW.FACT_CSYY_USER_CASH_STAT_DAILY;
CREATE TABLE IF NOT EXISTS IDW.FACT_CSYY_USER_CASH_STAT_DAILY
(
   USER_CODE            bigint comment '用户编号',
   USER_ID              bigint comment '用户ID',
   PRODUCT_CODE         string comment '产品编码',
   PRODUCT_NAME         string comment '产品名称',
   CASH_AMT             decimal(38,10) comment '兑付金额',
   HZD_AMT              decimal(38,10) comment '活转定金额',
   HQ_WITHDRAW_AMT      decimal(38,10) comment '活期提现金额',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '财神用户兑付日统计'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
