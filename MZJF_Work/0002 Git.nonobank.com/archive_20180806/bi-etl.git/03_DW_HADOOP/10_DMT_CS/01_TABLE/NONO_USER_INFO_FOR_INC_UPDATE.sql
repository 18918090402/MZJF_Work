DROP TABLE IF EXISTS DMT_CS.NONO_USER_INFO_FOR_INC_UPDATE;
CREATE TABLE IF NOT EXISTS DMT_CS.NONO_USER_INFO_FOR_INC_UPDATE
(
   USER_ID              bigint comment '用户ID',
   USER_NAME            string comment '用户名',
   LAST_NAME            string comment '姓(名字的第一位)',
   GENDER               int comment '性别',
   FINANCE_ADVISOR      bigint comment '理财顾问ID',
   RECOMMENDER          bigint comment '推荐人ID',
   CURRENT_CITY_NAME    string comment '当前所在市',
   BIRTHDAY             string comment '生日',
   REGISTER_TIME        string comment '注册时间',
   LAST_LOGIN_TIME      string comment '最近一次登录时间',
   CHANNEL_NAME         string comment '来源渠道',
   NONO_MAX_AUM         decimal(38,10) comment '历史最高在投金额',
   NONO_AUM             decimal(38,10) comment '当前在投金额',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '诺诺每日增量更新用户信息'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
