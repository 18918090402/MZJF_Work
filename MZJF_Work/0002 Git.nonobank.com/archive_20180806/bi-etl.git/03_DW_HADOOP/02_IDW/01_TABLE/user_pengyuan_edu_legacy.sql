drop table if exists idw.user_pengyuan_edu_legacy;
create table if not exists idw.user_pengyuan_edu_legacy
(
   dw_create_by         string comment '系统字段-创建者',
   dw_create_time       string comment '系统字段-创建时间',
   dw_update_by         string comment '系统字段-修改者',
   dw_update_time       string comment '系统字段-修改时间',
   user_id              bigint comment '用户id',
   college              string comment '学校名称',
   degree               string comment '学历',
   specialityname       string comment '专业名称',
   graduatetime         string comment '毕业时间',
   studyresult          string comment '学习结果',
   studystyle           string comment '学习类型',
   create_time          string comment '认证时间')
COMMENT '用户学历归档表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");