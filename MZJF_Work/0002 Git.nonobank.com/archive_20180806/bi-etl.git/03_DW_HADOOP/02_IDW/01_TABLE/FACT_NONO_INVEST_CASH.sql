DROP TABLE IF EXISTS IDW.FACT_NONO_INVEST_CASH;
CREATE TABLE IF NOT EXISTS IDW.FACT_NONO_INVEST_CASH
(
   CASH_SRC_ID          bigint comment '兑付源表ID',
   CASH_SRC_TAB         string comment '兑付源表名',
   USER_ID              bigint comment '用户ID',
   FP_KEY               bigint comment '计划代理键',
   FP_ID                bigint comment '计划ID',
   BO_ID                bigint comment '借款ID',
   DT_ID                bigint comment '债权ID',
   CATEGORY_CODE_02     int comment '计划分类02 0:精选计划 11:贴心计划 15:月月升计划',
   CATEGORY_NAME_02     string comment '计划分类名称02',
   PLAN_CASH_TIME       string comment '计划兑付时间',
   ACTUAL_CASH_TIME     string comment '实际兑付时间',
   CASH_STATUS          int comment '兑付状态',
   PRICE_PRINCIPAL      decimal(38,10) comment '本金',
   PRICE_INTEREST       decimal(38,10) comment '利息',
   PRICE_AMT            decimal(38,10) comment '金额',
   PRICE_PUNISH         decimal(38,10) comment '罚息和违约金',
   CASH_TYPE_CODE       int comment '兑付类型 1:正常兑付 2:债转',
   INVEST_TYPE_CODE     int comment '投资类型 1:散投 2:债转 3:精选 4:e诺千金 5:活期 99:未知',
   INVEST_RELATION_NO   string comment '投资关联编号 散投、债转:前置_(USER_ID)_(BO_ID) 精选:前置_(USER_ID)_(FP_ID) e诺千金:前置_(USER_ID)_(DT_ID) 前置规则为01:散投、债转 02:精选 03:e诺千金',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   TRANS_ID             string comment '交易凭证id',
   SERI_NO              string comment '交易流水号',
   PLATFORM             int comment '投资端 1:诺诺 2:财神',
   VA_ID                bigint comment 'vip_account的id',
   EXPECT               int comment '订单期限',
   EXPECT_UNIT_CODE     int comment '期限单位 1:日 2:月 3:年',
   REINVEST_TYPE        int comment '续投类型 0:到期转让 1:本金续投 2:本息续投',
   REINVEST_EXPECT      int comment '续投期限',
   REINVEST_EXPECT_UNIT_CODE int comment '续投期限单位 1:日 2:月 3:年',
   REINVEST_STATUS      int comment '续投状态 0:待续投 10:交易中 19:红包待激活 20:续投成功 30:用户取消 40:到期终止 95:异常待解冻 99:异常失败',
   NEXT_VA_ID           bigint comment '续投VA_ID')
COMMENT '诺诺投资兑付'
PARTITIONED BY (DATA_STATE STRING COMMENT '数据状态')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
