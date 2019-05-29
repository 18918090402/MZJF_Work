CREATE TABLE DMT_BF.CSYY_INVESTING_USER_CHG(
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   USER_ID              bigint comment '用户ID',
   USER_CODE            bigint comment '用户编号',
   MOBILE_NUM           string comment '手机号',
   GENDER               int comment '性别 1:男 2:女',
   REAL_NAME            string comment '姓名',
   CHG_FLAG             string comment '变更标志 I:新增 D:删除 U:更新')
COMMENT '财神在投用户变更日志'
PARTITIONED BY (STAT_DATE string comment '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");