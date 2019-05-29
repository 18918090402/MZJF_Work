DROP TABLE IF EXISTS IDW.FACT_BIZ_NONO_INVEST;
CREATE TABLE IF NOT EXISTS IDW.FACT_BIZ_NONO_INVEST
(
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   INVEST_SRC_ID        bigint comment '投资源表ID',
   INVEST_SRC_TAB       string comment '投资源表名',
   USER_ID              bigint comment '用户ID',
   PRODUCT_CATEGORY     string comment '产品',
   FP_ID                bigint comment '计划ID',
   INVEST_TIME          string comment '投资时间',
   INVEST_AMT           decimal(38,10) comment '投资金额',
   EXPECT               int comment '订单期限',
   EXPECT_UNIT_CODE     int comment '期限单位 1:日 2:月 3:年',
   LOCK_BEGIN_TIME      string comment '锁定生效时间',
   LOCK_END_TIME        string comment '锁定结束时间',
   MIN_RATE             decimal(38,10) comment '最低利率',
   MAX_RATE             decimal(38,10) comment '最高利率',
   ADD_RATE             decimal(38,10) comment '加息',
   DEDUCTIBLE_AMT       decimal(38,10) comment '现金券抵扣金额',
   INVEST_AMT_YEARLY    decimal(38,10) comment '年化投资金额',
   INVEST_NUM           int comment '投资批次',
   PRODUCT_INVEST_NUM   int comment '产品投资批次')
COMMENT '诺诺业务线投资'
PARTITIONED BY (DATA_STATE STRING COMMENT '数据状态')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");