drop table if exists dmt_fd.FD_CSYY_USER_INTEREST;
create table if not exists dmt_fd.FD_CSYY_USER_INTEREST
(
   SRC_ID               BIGINT COMMENT '源表ID',
   SRC_TAB              string COMMENT '源表名',
   USER_ID              BIGINT COMMENT '用户ID',
   USER_CODE            BIGINT COMMENT '用户编号',
   PRODUCT_CODE         string COMMENT '产品编码',
   PRINCIPAL_AMT        DECIMAL(38,10) COMMENT '计息金额',
   INTEREST_AMT         DECIMAL(38,10) COMMENT '收益金额',
   INTEREST_DATE        string COMMENT '收益日期',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间',
   UPDATE_TIME          string comment '更新时间')
COMMENT '财神爷爷用户收益信息'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");