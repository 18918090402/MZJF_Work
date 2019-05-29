drop table if exists idw.user_tag_loan;
create table if not exists idw.user_tag_loan
(
  dw_update_by string COMMENT '系统字段-修改者', 
  dw_update_time string COMMENT '系统字段-修改时间', 
  user_id bigint COMMENT '用户id', 
  stu_auth_time string COMMENT '学籍认证时间', 
  edu_auth_time string COMMENT '学历认证时间', 
  edu_education string COMMENT '最高学历', 
  edu_graduate_time string COMMENT '最高学历毕业时间', 
  sesame_number int COMMENT '芝麻信用分数', 
  phone_online_time string COMMENT '手机入网时间', 
  is_gjj_submit int COMMENT '是否完善公积金', 
  gjj_submit_time string COMMENT '完善公积金时间', 
  is_sb_submit int COMMENT '是否完善社保', 
  sb_submit_time string COMMENT '完善社保时间', 
  tongdun_score int COMMENT '同盾分', 
  user_credit_rank string COMMENT '用户的信用等级', 
  is_black_gray int COMMENT '是否属于反欺诈黑灰名单库', 
  max_overdue_days int COMMENT '最长逾期天数', 
  first_bo_apply_time string COMMENT '首次申请借款时间', 
  first_ml_time string COMMENT '首次进件时间', 
  first_bo_success_time string COMMENT '首借成功时间', 
  first_actual_bo_time string COMMENT '首次实际放款时间', 
  mld_credit_apply_cnt int COMMENT '麦粒贷申请授信次数', 
  mld_bo_success_cnt int COMMENT '成功借麦粒贷的次数', 
  base_amt_110 decimal(38,10) COMMENT '大额借基础额度', 
  increase_amt_110 decimal(38,10) COMMENT '大额借增信额度', 
  total_amt_110 decimal(38,10) COMMENT '大额借总额度', 
  used_amt_110 decimal(38,10) COMMENT '大额借已用额度', 
  base_amount_type_110 int COMMENT '大额借基础额度认定类型', 
  amt_111 decimal(38,10) COMMENT '闪电借额度', 
  has_not_depository_overdue_debt int COMMENT '是否有非存管逾期债权')
COMMENT '用户贷款标签'
PARTITIONED BY (stat_date string COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
