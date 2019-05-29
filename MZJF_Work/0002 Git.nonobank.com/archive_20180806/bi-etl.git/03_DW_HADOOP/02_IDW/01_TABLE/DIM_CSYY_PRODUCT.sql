drop table if exists IDW.DIM_CSYY_PRODUCT;

create table if not exists IDW.DIM_CSYY_PRODUCT
(
   PRODUCT_KEY          string comment '产品代理键',
   PRODUCT_CODE         string comment '产品编码',
   PRODUCT_NAME         string comment '产品名称',
   PRICE_MIN            decimal(38,10) comment '最低起投金额',
   PRICE_MAX            decimal(38,10) comment '单人最高购买金额',
   PRICE_INCREMENT      decimal(38,10) comment '每份金额增量',
   RATE                 decimal(38,10) comment '预计年收益',
   LOCKING_DAY          int comment '锁定时间(天) 开心财神专用',
   RATE_LIST            string comment '预期收益率 开心财神365天的预期收益率,用冒号隔开',
   CATEGORY_CODE_01     int comment '产品分类01 1:定期 2:活期',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间'
)
comment '财神爷爷资金端产品维表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;