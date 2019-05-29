DROP TABLE IF EXISTS DMT_MXD.FACT_MXD_M1OVER_DETAIL;
CREATE TABLE IF NOT EXISTS DMT_MXD.FACT_MXD_M1OVER_DETAIL
(
bo_id bigint comment '标ID'
,p_name string comment '产品'
,real_name string comment '客户姓名'
,overdue_uprepay_price  decimal(38,2) comment '逾期总额'
,month_repay_price  decimal(38,2) comment '月还款金额'
,unrepay_price_punish  decimal(38,2) comment '罚息'
,overdue_unrepay_days bigint comment '逾期天数'
,settlement_should_repay_amt decimal(38,2) comment '提前结清金额'
,last_repay_time string comment '最近还款日期'
,repay_price decimal(38,2) comment '还款金额'
,odc_name string comment '操作人'
,stat_time string comment '取数时间'
)
COMMENT 'FKDH_NC_华道M1还款明细数据'
PARTITIONED BY (stat_date STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");