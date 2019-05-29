DROP TABLE IF EXISTS IDW.FACT_NONO_USER_COST;
CREATE TABLE IF NOT EXISTS IDW.FACT_NONO_USER_COST
(
   COST_DATE            string comment '成本发生日期',
   USER_ID              bigint comment '用户ID',
   COST_TYPE_CODE       int comment '成本类型 1:线下 2:线上 ',
   COST_CATEGORY_CODE   int comment '费用分类 1:现金券 2:加息券 3:红包 4:磅客大使',
   CHANNEL_ID           bigint comment '渠道ID',
   CHANNEL_NAME         string comment '渠道名称',
   CHANNEL_TYPE         string comment '渠道类型',
   COST_AMT             decimal(38,10) comment '金额',
   COST_SRC_ID          bigint comment '成本源表ID',
   COST_SRC_TAB         string comment '成本源表名',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '诺诺用户成本表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
