drop table if exists DMT_MXD.FACT_NC_M1_REPAYMENT;
create table if not exists DMT_MXD.FACT_NC_M1_REPAYMENT
(
  bo_id bigint COMMENT '标ID', 
  p_name string COMMENT '产品', 
  real_name string COMMENT '客户姓名', 
  overdue_uprepay_price decimal(38,2) COMMENT '逾期总额', 
  month_repay_price decimal(38,2) COMMENT '月还款金额', 
  unrepay_price_punish decimal(38,2) COMMENT '罚息', 
  overdue_unrepay_days bigint COMMENT '逾期天数', 
  settlement_should_repay_amt decimal(38,2) COMMENT '提前结清金额', 
  last_repay_time string COMMENT '最近还款日期', 
  repay_price decimal(38,2) COMMENT '还款金额', 
  mod_contract string COMMENT '合同编号', 
  odc_name string COMMENT '操作人', 
  stat_time string COMMENT '取数时间')
COMMENT '风控内催M1还款明细'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");