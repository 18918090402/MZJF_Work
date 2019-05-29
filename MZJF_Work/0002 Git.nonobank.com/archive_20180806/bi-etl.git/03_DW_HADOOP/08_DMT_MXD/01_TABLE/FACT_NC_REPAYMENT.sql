drop table if exists DMT_MXD.FACT_NC_REPAYMENT;
create table if not exists DMT_MXD.FACT_NC_REPAYMENT
(
  bo_id bigint COMMENT '标ID', 
  mod_start_time string COMMENT '委案开始时间', 
  odc_name string COMMENT '服务商', 
  mod_contract string COMMENT '委案批次', 
  user_name string COMMENT '用户名', 
  real_name string COMMENT '姓名', 
  mobile_num string COMMENT '手机号', 
  p_name string COMMENT '产品', 
  bo_expect bigint COMMENT '期限', 
  should_repay_cnt bigint COMMENT '应还期数', 
  repayed_cnt bigint COMMENT '实际已还期数', 
  overdue_unrepay_days bigint COMMENT '截止目前为止的逾期天数', 
  aging string COMMENT '账龄 ', 
  overdue_price decimal(38,2) COMMENT '逾期总额 ', 
  start_overdue_price decimal(38,2) COMMENT '截止委外开始时间的逾期总额', 
  advance_break_price decimal(38,2) COMMENT '提前还款违约金', 
  mod_normal_repay_price decimal(38,2) COMMENT '正常还款金额', 
  mod_overdue_repay_price decimal(38,2) COMMENT '逾期还款金额', 
  mod_price decimal(38,2) COMMENT '委外后还款总额', 
  overdue_rate string COMMENT '逾期回收率', 
  unrepay_price_b decimal(38,2) COMMENT '剩余本金', 
  unrepay_price_punish decimal(38,2) COMMENT '剩余罚息和违约金 ', 
  repay_end_time string COMMENT '到期时间', 
  is_all_repayed string COMMENT ' 是否已还清', 
  advance_repay_price decimal(38,2) COMMENT '提前还款金额', 
  last_repay_time string COMMENT '最近还款日期', 
  unrepay_price_p decimal(38,2) COMMENT '未还总额', 
  balance decimal(38,2) COMMENT '可用余额', 
  stat_time string COMMENT '取数时间')
COMMENT '风控内催还款明细'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日',
                STAT_TYPE int COMMENT '1:上午 2:下午')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");