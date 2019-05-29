DROP TABLE IF EXISTS IDW.FACT_USER_PHONE_BOOK;
CREATE TABLE IF NOT EXISTS IDW.FACT_USER_PHONE_BOOK
(
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   USER_ID              bigint comment '用户ID',
   LAST_NAME            string comment '姓',
   MIDDLE_NAME          string comment '中间名',
   FIRST_NAME           string comment '名',
   REAL_NAME            string comment '姓名',
   PHONE                string comment '电话')
COMMENT '用户手机通讯录'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
