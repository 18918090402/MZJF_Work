CREATE TABLE `dmt_mzjk.fact_mzjk_repay_detail`(
`bo_id` bigint COMMENT '标的', 
`p_name` string COMMENT '产品', 
`user_name` string COMMENT '用户名',
`real_name` string COMMENT '借款姓名', 
bo_success_time string COMMENT '放款时间'
,repay_begin_day string COMMENT '最初还款日'
,bo_finish_price decimal(38,2) COMMENT '借款金额'
,bo_rate string COMMENT '借款年利率'
,bo_expect int COMMENT '借款期限'
,repayed_cnt int COMMENT '已还期数'
,overdue_unrepay_days int COMMENT '逾期天数'
,aging string COMMENT '账龄 '
,overdue_price decimal(38,2) COMMENT '逾期总额'
,unrepay_price_p decimal(38,2) COMMENT '未还总额'
,unrepay_price_b decimal(38,2) COMMENT '剩余本金'
,last_repay_time string COMMENT '最近还款日期'
,advance_break_price decimal(38,2) COMMENT '提前还款违约金'
,`settlement_should_repay_amt` decimal(38,2) COMMENT '提前结清金额'
,`is_all_repayed` string COMMENT ' 状态_是否已还清'
,`stat_time` string COMMENT '取数时间'
)COMMENT 'FKDH_麦子借款_麦子借款还款明细字段'
PARTITIONED BY (`stat_date` string COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");