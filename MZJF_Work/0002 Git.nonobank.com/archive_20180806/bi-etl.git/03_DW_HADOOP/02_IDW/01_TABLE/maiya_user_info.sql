drop table if exists idw.maiya_user_info;
create table if not exists idw.maiya_user_info
(
   dw_create_by         string comment '系统字段-创建者',
   dw_create_time       string comment '系统字段-创建时间',
   dw_update_by         string comment '系统字段-修改者',
   dw_update_time       string comment '系统字段-修改时间',
   maiya_user_id        int comment '麦芽用户id',
   user_id              bigint comment '用户id',
   username             string comment '用户名',
   mobile               string comment '电话',
   honor_level          string comment '信用等级',
   salary               int comment '薪水',
   is_qizha             int comment '是否欺诈',
   online_account_no    string comment '徽商电子账户',
   name                 string comment '姓名',
   sex                  int comment '性别',
   idcard_address       string comment '身份证地址',
   idcard               string comment '身份证',
   address              string comment '地址',
   user_type            int comment '用户身份',
   province_code        string comment '省编码',
   province_name        string comment '省名称',
   city_code            string comment '市编码',
   city_name            string comment '市名称',
   county_code          string comment '地区编码',
   county_name          string comment '地区名称',
   work_type            int comment '工作行业',
   work_type_name       string comment '工作行业名称',
   work_position        int comment '工作职位',
   work_position_name   string comment '职位名称',
   company_name         string comment '公司名称',
   academic             int comment '学历',
   academic_name        string comment '学历名称',
   family_user          string comment '直系亲属姓名',
   family_user_mobile   string comment '亲属电话',
   email                string comment '电子邮件',
   use_source           int comment '用户来源',
   nono_old_user        string comment '是否诺诺老用户',
   entry_year           string comment '入学年份',
   spouse_name          string comment '配偶姓名',
   spouse_idcard        string comment '配偶身份证号',
   spouse_mobile        string comment '配偶手机号',
   fdd_auth_status      int comment '是否认证法大大',
   mobile_address       string comment '手机归属地')
comment '麦芽用户基础信息表'
PARTITIONED BY (stat_date string COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
