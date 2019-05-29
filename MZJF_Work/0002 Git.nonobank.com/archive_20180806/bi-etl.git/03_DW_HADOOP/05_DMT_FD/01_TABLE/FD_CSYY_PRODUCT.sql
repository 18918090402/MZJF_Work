drop table if exists dmt_fd.FD_CSYY_PRODUCT;
create table if not exists dmt_fd.FD_CSYY_PRODUCT
(
   PRODUCT_CODE         string COMMENT '产品编码',
   PRODUCT_NAME         string COMMENT '产品名称',
   CATEGORY_CODE_01     INT COMMENT '计划分类01 1:定期 2:活期',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '财神爷爷资金端产品维表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");