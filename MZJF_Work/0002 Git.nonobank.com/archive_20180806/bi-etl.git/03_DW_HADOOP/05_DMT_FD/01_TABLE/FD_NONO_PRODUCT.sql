drop table if exists dmt_fd.FD_NONO_PRODUCT;
create table if not exists dmt_fd.FD_NONO_PRODUCT
(
   FP_KEY               BIGINT COMMENT '计划代理键',
   FP_ID                BIGINT COMMENT '计划ID',
   FP_NAME              string COMMENT '计划名称',
   LOCKING_DAY          INT COMMENT '锁定时间(天) 月月升专用',
   RATE_LIST            string COMMENT '预期收益率 月月升12个月的预期收益率,用逗号隔开',
   CATEGORY_CODE_01     INT COMMENT '计划分类01 1:定期 2:活期',
   CATEGORY_CODE_02     INT COMMENT '计划分类02 0:精选计划 11:贴心计划 15:月月升计划',
   CATEGORY_NAME_02     string COMMENT '计划分类名称02',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '诺诺资金端产品维表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");