DROP TABLE IF EXISTS IDW.FACT_NONO_AUM_DETAIL_SNAPSHOT;
CREATE TABLE IF NOT EXISTS IDW.FACT_NONO_AUM_DETAIL_SNAPSHOT
(
   USER_ID              bigint comment '用户ID',
   FP_KEY               bigint comment '计划代理键',
   FP_ID                bigint comment '计划ID',
   BO_ID                bigint comment '借款ID',
   DT_ID                bigint comment '债权ID',
   INVEST_TYPE_CODE     int comment '投资类型 1:散投 2:债转 3:精选 4:e诺千金 5:活期 99:未知',
   CATEGORY_CODE_02     int comment '计划分类02 0:精选计划 11:贴心计划 15:月月升计划',
   CATEGORY_NAME_02     string comment '计划分类名称02',
   INVEST_AMT           decimal(38,10) comment '原始投资金额',
   AUM                  decimal(38,10) comment '在投金额',
   INVEST_RELATION_NO   string comment '投资关联编号 散投、债转:前置_(USER_ID)_(BO_ID) 精选:前置_(USER_ID)_(FP_ID) e诺千金:前置_(USER_ID)_(DT_ID) 前置规则为01:散投、债转 02:精选 03:e诺千金',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   IN_INVEST_AMT        decimal(38,10) comment '在投金额',
   TRANS_ID             string comment '交易凭证id',
   SERI_NO              string comment '交易流水号',
   PLATFORM             int comment '投资端 1:诺诺 2:财神',
   PRODUCT_CATEGORY     string comment '产品',
   VA_ID                bigint comment 'vip_account的id')
COMMENT '诺诺AUM详情快照表'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");