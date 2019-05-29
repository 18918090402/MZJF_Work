drop table if exists dmt_fd.FD_CSYY_CUR_INVEST_SNAPSHOT;
create table if not exists dmt_fd.FD_CSYY_CUR_INVEST_SNAPSHOT
(
   STAT_DATE            string comment '日期',
   USER_ID              bigint comment '用户ID',
   USER_CODE            bigint comment '用户编号',
   PRODUCT_CODE         string comment '产品编码',
   BALANCE              decimal(38,10) comment '金额',
   RATE                 decimal(38,10) comment '利率',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '财神爷爷活期在投信息表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");