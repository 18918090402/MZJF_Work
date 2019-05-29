drop table if exists dmt_fd.FD_NONO_FIXED_INVEST_CASH;
create table if not exists dmt_fd.FD_NONO_FIXED_INVEST_CASH
(
   SRC_ID               BIGINT COMMENT '源表ID',
   SRC_TAB              string COMMENT '源表名',
   USER_ID              BIGINT COMMENT '用户ID',
   FP_KEY               BIGINT COMMENT '计划代理键',
   FP_ID                BIGINT COMMENT '计划ID',
   BO_ID                BIGINT COMMENT '借款ID',
   CATEGORY_CODE_02     INT COMMENT '计划分类02 0:精选计划 11:贴心计划 15:月月升计划',
   CATEGORY_NAME_02     string COMMENT '计划分类名称02',
   PLAN_ACCEPT_TIME     string COMMENT '计划收款时间',
   ACTUAL_ACCEPT_TIME   string COMMENT '实际收款时间',
   ACCEPT_STATUS        INT COMMENT '收款状态',
   PRICE_PRINCIPAL      DECIMAL(38,10) COMMENT '本金',
   PRICE_INTEREST       DECIMAL(38,10) COMMENT '利息',
   PRICE_AMT            DECIMAL(38,10) COMMENT '金额',
   PRICE_PUNISH         DECIMAL(38,10) COMMENT '罚息和违约金',
   ACCEPT_TYPE_CODE     INT COMMENT '收款类型 1:正常兑付 2:债转',
   INVEST_TYPE_CODE     INT COMMENT '投资类型 1:散投 2:债转 3:精选 4:e诺千金 5:活期 99:未知',
   DW_INVEST_RELATION_NO string COMMENT '投资关联编号 散投、债转:前置_(USER_ID)_(BO_ID) 精选:前置_(USER_ID)_(FP_ID) e诺千金:前置_(USER_ID)_(DT_ID) 前置规则为01:散投、债转 02:精选 03:e诺千金',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '诺诺定期投资兑付'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");