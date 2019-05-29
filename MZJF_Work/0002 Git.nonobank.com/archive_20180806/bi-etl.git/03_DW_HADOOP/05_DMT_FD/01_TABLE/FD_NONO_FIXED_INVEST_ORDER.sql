drop table if exists dmt_fd.FD_NONO_FIXED_INVEST_ORDER;
create table if not exists dmt_fd.FD_NONO_FIXED_INVEST_ORDER
(
   SRC_ID               BIGINT COMMENT '源表ID',
   SRC_TAB              string COMMENT '源表名',
   USER_ID              BIGINT COMMENT '用户ID',
   FP_KEY               BIGINT COMMENT '计划代理键',
   FP_ID                BIGINT COMMENT '计划ID',
   BO_ID                BIGINT COMMENT '借款ID',
   CATEGORY_CODE_02     INT COMMENT '计划分类02 0:精选计划 11:贴心计划 15:月月升计划',
   CATEGORY_NAME_02     string COMMENT '计划分类名称02',
   INVEST_TIME          string COMMENT '投资时间',
   INVEST_AMT           DECIMAL(38,10) COMMENT '投资金额',
   EXPECT               INT COMMENT '订单期限',
   EXPECT_UNIT_CODE     INT COMMENT '期限单位 1:日 2:月 3:年',
   LOCK_BEGIN_TIME      string COMMENT '锁定生效时间',
   LOCK_END_TIME        string COMMENT '锁定结束时间',
   MIN_RATE             DECIMAL(38,10) COMMENT '最低利率',
   MAX_RATE             DECIMAL(38,10) COMMENT '最高利率',
   ADD_RATE             DECIMAL(38,10) COMMENT '加息',
   DEDUCTIBLE_AMT       DECIMAL(38,10) COMMENT '现金券抵扣金额',
   INVEST_TYPE_CODE     INT COMMENT '投资类型 1:散投 2:债转 3:精选 4:e诺千金 5:活期 99:未知',
   DW_INVEST_RELATION_NO string COMMENT '投资关联编号 散投、债转:前置_(USER_ID)_(BO_ID) 精选:前置_(USER_ID)_(FP_ID) e诺千金:前置_(USER_ID)_(DT_ID) 前置规则为01:散投、债转 02:精选 03:e诺千金',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '诺诺定期投资订单'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");