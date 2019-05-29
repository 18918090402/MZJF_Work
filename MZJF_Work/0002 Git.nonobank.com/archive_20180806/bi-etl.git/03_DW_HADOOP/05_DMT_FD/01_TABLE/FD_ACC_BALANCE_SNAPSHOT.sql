drop table if exists dmt_fd.FD_ACC_BALANCE_SNAPSHOT;
create table if not exists dmt_fd.FD_ACC_BALANCE_SNAPSHOT
(
   STAT_DATE            string COMMENT '日期',
   ACC_NAME             string COMMENT '账户名称',
   ACC_BALANCE          DECIMAL(38,10) COMMENT '账户余额',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '账户余额信息'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");