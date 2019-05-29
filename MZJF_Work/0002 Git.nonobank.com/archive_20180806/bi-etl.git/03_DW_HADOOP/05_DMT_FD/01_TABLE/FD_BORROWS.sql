drop table if exists dmt_fd.fd_borrows;
create table if not exists dmt_fd.fd_borrows
(
   BO_ID                BIGINT COMMENT '借款ID',
   USER_ID              BIGINT COMMENT '用户ID',
   P_ID                 BIGINT COMMENT '产品ID',
   BO_EXPECT            INT COMMENT '期数',
   BO_EXPECT_CAT        INT COMMENT '期数单位',
   BO_RATE              DECIMAL(38,10) COMMENT '年利率',
   BO_AUDIT_TIME        string COMMENT '审核时间',
   BO_AGREE_TIME        string COMMENT '协议生效时间',
   BO_FINISH_PRICE      DECIMAL(38,10) COMMENT '放款金额',
   ZX_PRICE             DECIMAL(38,10) COMMENT '咨询费',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '借款表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");