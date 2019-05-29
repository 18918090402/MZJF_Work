DROP TABLE IF EXISTS DMT_MAIYA.FACT_MY_WW_DETAIL;
CREATE TABLE IF NOT EXISTS DMT_MAIYA.FACT_MY_WW_DETAIL
(
bo_id bigint comment '标的'
,p_name string comment '产品'
,mod_start_time string comment '委案开始时间'
,odc_name string comment '服务商'
,mod_contract string comment '委案批次'
,mod_close_time string comment '结案时间'
,mod_end_time string comment '委外结束时间'
,mod_status string comment '委案状态'
,real_name string comment '借款姓名'
,user_name string comment '用户名'
,mobile_num string comment '手机号'
,overdue_unrepay_days bigint comment '截止目前为止的逾期天数'
,aging string comment '账龄'
,overdue_unrepay_cnt bigint comment '剩余逾期期数'
,mod_overdue_repay_price  decimal(38,2) comment '逾期还款金额'
,mod_normal_repay_price decimal(38,2) comment '正常还款金额'
,advance_break_price decimal(38,2) comment '提前还款违约金'
,mod_repay_money decimal(38,2) comment '委外后还款总额'
,overdue_unrepay_price decimal(38,2) comment '逾期未还总额'
,unrepay_price decimal(38,2) comment '剩余还款金额'
,unrepay_price_punish decimal(38,2) comment '罚息和违约金'
,unrepay_price_b decimal(38,2) comment '未还本金'
,balance decimal(38,2) comment '可用余额'
,locking decimal(38,2) comment '锁定金额'
,last_repay_time string comment '最近还款日期'
,settlement_should_repay_amt decimal(38,2) comment '提前结清金额'
,is_all_repayed string comment '状态_是否已还清'
,DUNNING_NUM bigint comment '手别'
,stat_time string comment '取数时间'
)
COMMENT 'FKDH_委外_麦芽分案还款明细字段'
PARTITIONED BY (stat_date STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");