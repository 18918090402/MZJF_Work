DROP TABLE IF EXISTS DMT.FACT_NONO_USER_ACTIVITY_INFO;
CREATE TABLE IF NOT EXISTS DMT.FACT_NONO_USER_ACTIVITY_INFO
(
   USER_ID              bigint comment '用户ID',
   REGISTER_TIME        string comment '注册时间',
   IS_AUTHENTICATION    int comment '是否身份认证 0:否 1:是',
   FIRST_BIND_CARD_TIME string comment '首次绑卡时间',
   FIRST_INVEST_TIME    string comment '首次投资时间',
   LAST_30_DAYS_LOGIN_CNT int comment '过去30天登录次数',
   LAST_60_DAYS_LOGIN_CNT int comment '过去60天登录次数',
   LAST_30_DAYS_VIEW_COLUMN_CNT int comment '过去30天浏览栏目数',
   LAST_30_DAYS_VIEW_PRODUCT_CNT int comment '过去30天浏览产品数',
   LAST_30_DAYS_INVEST_CNT int comment '过去30天投资次数',
   INVEST_CNT           int comment '投资次数',
   SECOND_INVEST_AMT    decimal(38,10) comment '复投金额',
   LAST_30_DAYS_CLICK_THIRD_ICON_CNT int comment '过去30天点击app第三个图标次数',
   PROLOCUTOR_INVITE_REGISTER_CNT int comment '镑客大使邀请注册成功次数',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '诺诺用户活跃信息'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
