drop table if exists idw.user_info_loan_extend;
create table if not exists idw.user_info_loan_extend
(
   dw_create_by         string comment '系统字段-创建者',
   dw_create_time       string comment '系统字段-创建时间',
   dw_update_by         string comment '系统字段-修改者',
   dw_update_time       string comment '系统字段-修改时间',
   user_id              bigint comment '用户id',
   stu_education        string comment '学籍学历',
   stu_start_date       string comment '学籍入学时间',
   stu_graduate_date    string comment '学籍预计毕业时间',
   stu_is_graduate      int comment '是否已毕业 0:未毕业 1:已毕业',
   stu_academy          string comment '就读院校',
   stu_campus           string comment '校区',
   stu_major            string comment '专业',
   stu_student_no       string comment '学号',
   stu_school_type      string comment '学校类别',
   stu_school_type_desc string comment '学校类别描述',
   stu_school_province_id bigint comment '学校省份id',
   stu_school_province_name string comment '学校省份名称',
   stu_school_city_id    bigint comment '学校城市id',
   stu_school_city_name  string comment '学校城市名称',
   campus_approach      int comment '用户来源',
   campus_approach_desc string comment '用户来源描述',
   family_income        int comment '家庭收入 0:未设置 1:5万以下 2:5-10万 3:10-20万 4:20万以上',
   family_income_desc   string comment '家庭收入描述',
   address_home         string comment '家庭住址',
   instructor_name      string comment '辅导员姓名',
   instructor_mobile    string comment '辅导员手机',
   instructor_mobile_state string comment '辅导员手机状态',
   instructor_mobile_address string comment '辅导员手机归属地',
   parent_name          string comment '父母姓名',
   parent_mobile        string comment '父母手机',
   parent_mobile_state  string comment '父母手机状态',
   parent_mobile_address string comment '父母手机归属地',
   friend1_name         string comment '好友1姓名',
   friend1_mobile       string comment '好友1手机',
   friend1_mobile_state string comment '好友1手机状态',
   friend1_mobile_address string comment '好友1手机归属地',
   friend2_name         string comment '好友2姓名',
   friend2_mobile       string comment '好友2手机',
   friend2_mobile_state string comment '好友2手机状态',
   friend2_mobile_address string comment '好友2手机归属地',
   friend3_name         string comment '好友3姓名',
   friend3_mobile       string comment '好友3手机',
   friend3_mobile_state string comment '好友3手机状态',
   friend3_mobile_address string comment '好友3手机归属地',
   monthly_debt         string comment '月负债')
COMMENT '用户借款属性扩展'
PARTITIONED BY (stat_date string COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
