drop table if exists idw.user_register_action_legacy;
create table if not exists idw.user_register_action_legacy
(
   dw_create_by         string comment '系统字段-创建者',
   dw_create_time       string comment '系统字段-创建时间',
   dw_update_by         string comment '系统字段-修改者',
   dw_update_time       string comment '系统字段-修改时间',
   user_id              bigint comment '用户id',
   register_terminal    string comment '注册终端',
   register_ip          string comment '注册ip地址')
COMMENT '用户注册归档表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");