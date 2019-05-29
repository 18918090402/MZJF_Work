DROP TABLE IF EXISTS DMT_MAIYA.FACT_MY_NC_DETAIL;
CREATE TABLE IF NOT EXISTS DMT_MAIYA.FACT_MY_NC_DETAIL
(
bo_id bigint comment '标ID'
,mod_start_time string comment '委案开始时间'
,odc_name string comment '服务商'
,mod_contract string comment '委案批次'
,real_name string comment '借款姓名'
,user_name string comment '用户名'
,p_name string comment '产品'
,bo_expect bigint comment '期限'
,should_repay_cnt bigint comment '应还期数'
,repayed_cnt bigint comment '实际已还期数'
,overdue_unrepay_days bigint comment '截止目前为止的逾期天数'
,aging string comment '账龄 '
,overdue_price decimal(38,2) comment '逾期总额 '
,start_overdue_price decimal(38,2) comment '截止委外开始时间的逾期总额'
,advance_break_price decimal(38,2) comment '提前还款违约金'
,mod_normal_repay_price decimal(38,2) comment '正常还款金额'
,mod_overdue_repay_price  decimal(38,2) comment '逾期还款金额'
,mod_price decimal(38,2) comment '委外后还款总额'
,overdue_rate string comment '逾期回收率'
,unrepay_price_b decimal(38,2) comment '剩余本金'
,unrepay_price_punish decimal(38,2) comment '剩余罚息和违约金 '   
,repay_end_time string comment '到期时间'
,is_all_repayed string comment ' 是否已还清'
,advance_repay_price decimal(38,2) comment '提前还款金额'
,last_repay_time string comment '最近还款日期'
,unrepay_price_p decimal(38,2) comment '未还总额'
,balance decimal(38,2) comment '可用余额'
,stat_time string comment '取数时间'
)
COMMENT 'FKDH_内催_麦芽分案还款明细'
PARTITIONED BY (stat_date STRING,stat_hour int COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");