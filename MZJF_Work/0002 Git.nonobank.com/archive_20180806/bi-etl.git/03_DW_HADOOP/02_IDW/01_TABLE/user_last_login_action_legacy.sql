drop table if exists idw.user_last_login_action_legacy;
create table if not exists idw.user_last_login_action_legacy
(
   dw_create_by         string comment '系统字段-创建者',
   dw_create_time       string comment '系统字段-创建时间',
   dw_update_by         string comment '系统字段-修改者',
   dw_update_time       string comment '系统字段-修改时间',
   user_id              bigint comment '用户id',
   terminal             string comment '终端',
   ip                   string comment 'ip地址',
   login_time           string comment '登录时间',
   login_biz            string comment '登录平台')
COMMENT '用户最近登录归档表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");