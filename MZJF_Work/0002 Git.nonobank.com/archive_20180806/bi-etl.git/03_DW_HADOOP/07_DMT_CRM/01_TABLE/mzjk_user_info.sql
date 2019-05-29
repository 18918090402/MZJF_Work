drop table if exists dmt_crm.mzjk_user_info;
create table if not exists dmt_crm.mzjk_user_info
(
   dw_create_by         string comment '系统字段-创建者',
   dw_create_time       string comment '系统字段-创建时间',
   dw_update_by         string comment '系统字段-修改者',
   dw_update_time       string comment '系统字段-修改时间',
   user_id              bigint comment '用户id',
   user_name            string comment '用户名',
   mobile_num           string comment '手机号',
   real_name            string comment '姓名',
   gender               string comment '性别',
   age                  int comment '年龄',
   id_num               string comment '身份证号',
   marriage_status      string comment '婚姻状态',
   hj_province_name     string comment '户籍省',
   hj_city_name         string comment '户籍市',
   job                  string comment '职业',
   is_education_auth    int comment '是否学历认证',
   is_student_auth      int comment '是否学籍认证',
   email                string comment '电子邮箱',
   register_time        string comment '注册时间',
   register_phone_model string comment '注册设备机型',
   register_network     string comment '注册网络环境',
   qq                   string comment 'qq',
   channel_id           bigint comment '注册渠道id',
   channel_name         string comment '注册渠道名称',
   monthly_salary       string comment '月薪',
   monthly_debt         string comment '月负债'
)
COMMENT '麦子借款用户'
PARTITIONED BY (stat_date string COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
