DROP TABLE IF EXISTS IDW.FACT_NONO_INVEST_ORDER;
CREATE TABLE IF NOT EXISTS IDW.FACT_NONO_INVEST_ORDER
(
   INVEST_SRC_ID        bigint comment '投资源表ID',
   INVEST_SRC_TAB       string comment '投资源表名',
   USER_ID              bigint comment '用户ID',
   FP_KEY               bigint comment '计划代理键',
   FP_ID                bigint comment '计划ID',
   BO_ID                bigint comment '借款ID',
   DT_ID                bigint comment '债权ID',
   CATEGORY_CODE_02     int comment '计划分类02 0:精选计划 11:贴心计划 15:月月升计划',
   CATEGORY_NAME_02     string comment '计划分类名称02',
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
   TERMINAL_CODE        string comment '终端类型 0:PC 1:名校贷 2:诺诺镑客app 3:诺诺镑客微站 4:诺诺镑客IOS 5:诺诺镑客Andriod 6:Ipad 7:微信',
   STATUS               int comment '状态 0:不成功 1:部分成功 2:成功 3:进行中 4:终止',
   INVEST_TYPE_CODE     int comment '投资类型 1:散投 2:债转 3:精选 4:e诺千金 5:活期 99:未知',
   REMARK               string comment '备注',
   INVEST_RELATION_NO   string comment '投资关联编号 散投、债转:前置_(USER_ID)_(BO_ID) 精选:前置_(USER_ID)_(FP_ID) e诺千金:前置_(USER_ID)_(DT_ID) 前置规则为01:散投、债转 02:精选 03:e诺千金',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   INVEST_AMT_YEARLY    decimal(38,10) comment '年化投资金额',
   TRANS_ID             string comment '交易凭证id',
   SERI_NO              string comment '交易流水号',
   PLATFORM             int comment '投资端 1:诺诺 2:财神')
COMMENT '诺诺投资订单'
PARTITIONED BY (DATA_STATE STRING COMMENT '数据状态')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
