drop table if exists dmt_fd.FD_ASSET_PRODUCT;
create table if not exists dmt_fd.FD_ASSET_PRODUCT
(
   P_ID                 BIGINT COMMENT '产品ID',
   P_NAME               string COMMENT '产品名称',
   BUSI_LINE            string COMMENT '业务线名',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '借款产品维表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");