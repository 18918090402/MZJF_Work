drop table if exists DMT_MZJK.FACT_MZJK_USER_FUNNEL_DETAIL;
create table if not exists DMT_MZJK.FACT_MZJK_USER_FUNNEL_DETAIL
(
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   USER_ID              bigint comment '用户ID',
   REGISTER_TIME        string comment '注册时间',
   FIRST_ZHIMA_AUTH_TIME string comment '首次芝麻认证通过时间',
   FIRST_WIDE_PASS_TIME string comment '首次大准入通过时间',
   FIRST_ZHIMA_FOCUS_PASS_TIME string comment '首次芝麻行业关注通过时间',
   FIRST_EDU_AUTH_TIME  string comment '首次学历认证通过时间',
   FIRST_NARROW_PASS_TIME string comment '首次小准入通过时间',
   FIRST_RECEIVED_CREDIT_TIME string comment '首次获得额度时间',
   FIRST_APPLY_TIME     string comment '首次申请借款时间',
   FIRST_ML_TIME        string comment '首次进件时间',
   FIRST_CONFIRM_TIME   string comment '首次终审通过时间',
   FIRST_LOAN_SUCCESS_TIME string comment '首次放款时间')
COMMENT '注册用户转化明细'
PARTITIONED BY (REGISTER_MONTH STRING COMMENT '注册月份')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
