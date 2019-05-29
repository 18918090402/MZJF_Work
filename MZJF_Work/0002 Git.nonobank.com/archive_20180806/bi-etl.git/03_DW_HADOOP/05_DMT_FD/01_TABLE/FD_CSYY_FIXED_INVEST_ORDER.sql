drop table if exists dmt_fd.FD_CSYY_FIXED_INVEST_ORDER;
create table if not exists dmt_fd.FD_CSYY_FIXED_INVEST_ORDER
(
   SRC_ID               BIGINT COMMENT '源表ID',
   SRC_TAB              string COMMENT '源表名',
   USER_ID              BIGINT COMMENT '用户ID',
   USER_CODE            BIGINT COMMENT '用户编号',
   PRODUCT_CODE         string COMMENT '产品编码',
   INVEST_TIME          string COMMENT '投资时间',
   INVEST_AMT           DECIMAL(38,10) COMMENT '投资金额',
   REMAINING_PRINCIPAL  DECIMAL(38,10) COMMENT '剩余本金',
   TOTAL_INTEREST       DECIMAL(38,10) COMMENT '本次投资总收益',
   REMAINING_INTEREST   DECIMAL(38,10) COMMENT '剩余收益',
   EXPECT               INT COMMENT '订单期限',
   EXPECT_UNIT_CODE     INT COMMENT '期限单位 1:日 2:月 3:年',
   LOCK_BEGIN_TIME      string COMMENT '锁定生效时间',
   LOCK_END_TIME        string COMMENT '锁定结束时间',
   MIN_RATE             DECIMAL(38,10) COMMENT '最低利率',
   MAX_RATE             DECIMAL(38,10) COMMENT '最高利率',
   DEDUCTIBLE_AMT       DECIMAL(38,10) COMMENT '现金券抵扣金额',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '财神爷爷定期投资订单'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");