DROP TABLE IF EXISTS DMT_MXD.FACT_MXD_CHANNEL_COST_DETAIL;
CREATE TABLE IF NOT EXISTS DMT_MXD.FACT_MXD_CHANNEL_COST_DETAIL
(
   USER_ID              bigint comment '用户ID',
   REGISTER_DATE        string comment '注册日期',
   EDUCATION            string comment '学历',
   CHANNEL_ID           int comment '渠道ID',
   CHANNEL_NAME         string comment '渠道名称',
   ADS_START_DATE       string comment '渠道推广开始日期',
   ADS_END_DATE         string comment '渠道推广结束日期',
   CHANNEL_PLAN         string comment '渠道计划',
   CHANNEL_UNIT         string comment '渠道单元',
   CHANNEL_DETAIL       string comment '渠道明细',
   CHANNEL_OWNER        string comment '渠道负责人',
   TOTAL_CHANNEL_ID     int comment '总渠道ID',
   TOTAL_CHANNEL_NAME   string comment '总渠道名称',
   CHANNEL_TYPE         string comment '渠道类型',
   CHANNEL_TYPE_2       string comment '渠道类型2级',
   CHANNEL_TYPE_3       string comment '渠道类型3级',
   CHANNEL_TYPE_4       string comment '渠道类型4级',
   AVG_COST             decimal(38,10) comment '平均费用',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '名校贷渠道成本'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
