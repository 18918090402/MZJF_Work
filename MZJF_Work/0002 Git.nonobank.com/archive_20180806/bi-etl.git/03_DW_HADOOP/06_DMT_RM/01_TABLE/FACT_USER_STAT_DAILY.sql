DROP TABLE IF EXISTS DMT_RM.FACT_USER_STAT_DAILY;
CREATE TABLE IF NOT EXISTS DMT_RM.FACT_USER_STAT_DAILY
(
   USER_ID              bigint comment '用户ID',
   USER_NAME            string comment '用户名',
   REAL_NAME            string comment '真实姓名',
   IN_REPAYMENT_CNT     int comment '还款中笔数',
   ALREADY_REPAYMENT_CNT int comment '已结清笔数',
   REJECT_CNT           int comment '被拒绝次数',
   LAST_REJECT_TIME     string comment '最近一次拒绝时间',
   OVERDUE_LESS_7_DAY_CNT int comment '逾期7天以内的次数',
   OVERDUE_LESS_30_DAY_CNT int comment '逾期30天以内的次数',
   OVERDUE_LESS_60_DAY_CNT int comment '逾期60天以内的次数',
   OVERDUE_MORE_60_DAY_CNT int comment '逾期60天以上的次数',
   MAX_BO_BRICE         decimal(38,10) comment '历史借款最高金额',
   LOAN_MXD_BKB_CNT     int comment '成功借名校贷（本科包）的次数',
   LOAN_MXD_ZKB_CNT     int comment '成功借专科包的次数',
   LOAN_MXD_YJB_CNT     int comment '成功借应急包的次数',
   LOAN_MXD_BLB_CNT     int comment '成功借白领包的次数',
   LOAN_MYFQ_CNT        int comment '成功借麦芽分期的次数',
   LOAN_USA_MXD_CNT     int comment '成功借美国名校贷的次数',
   LOAN_UNIFI_XED_CNT   int comment '成功借unifi小额贷的次数',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   MLD_CREDIT_APPLY_CNT bigint comment '麦粒贷申请授信次数',
   MLD_BO_SUCCESS_CNT   bigint comment '成功借麦粒贷的次数',
   REGISTER_TIME        string comment '注册时间')
COMMENT '用户表'
PARTITIONED BY (STAT_DATE int COMMENT '统计日期 年月日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
