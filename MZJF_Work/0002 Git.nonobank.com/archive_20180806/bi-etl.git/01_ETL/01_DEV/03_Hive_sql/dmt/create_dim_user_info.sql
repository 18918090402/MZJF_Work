CREATE TABLE IF NOT EXISTS DMT.DIM_USER_INFO
    (
   USER_ID              bigint comment '用户ID',
   USER_NAME            string comment '用户名',
   GENDER               string comment '性别',
   AGE                  int comment '年龄',
   GRADE                int comment '年级',
   EDUCATION            string comment '学历',
   REGISTER_PROVINCE    string comment '户籍省份',
   SCHOOL_PROVINCE      string comment '学校省份',
   SCHOOL               string comment '学校',
   TERMINAL             string comment '终端'
    )
    COMMENT '维度表_用户'
    ROW FORMAT DELIMITED
      NULL DEFINED AS ''
    STORED AS PARQUET TBLPROPERTIES ("parquet.compression"="SNAPPY");