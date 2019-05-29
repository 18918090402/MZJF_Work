DROP TABLE IF EXISTS IDW.DIM_NONO_PRODUCT;
CREATE TABLE IF NOT EXISTS IDW.DIM_NONO_PRODUCT
(
   FP_KEY               bigint comment '计划代理键',
   FP_ID                bigint comment '计划ID',
   FP_NAME              string comment '计划名称',
   PRICE_MIN            decimal(38,10) comment '最低起投金额',
   PRICE_MAX            decimal(38,10) comment '单人最高购买金额',
   PRICE_INCREMENT      decimal(38,10) comment '每份金额增量',
   RATE_MIN             decimal(38,10) comment '预计最低年收益',
   RATE_MAX             decimal(38,10) comment '预计最高年收益',
   PUBLISH_DATE         string comment '销售发布时间',
   FINISH_DATE          string comment '销售结束时间',
   EXPECT               int comment '锁定期限',
   EXPECT_UNIT_CODE     int comment '锁定期限单位 1:日 2:月 3:年',
   START_DATE           string comment '锁定开始时间',
   USE_COUPON_CODE      int comment '可用优惠券 0:都不能用 1:都能 2:加息 3:现金',
   COLLECTION_MODE_CODE int comment '收款方式 0:先息后本 1:到期还本付息 2:等额本息',
   LOCKING_DAY          int comment '锁定时间(天) 月月升专用',
   RATE_LIST            string comment '预期收益率 月月升12个月的预期收益率,用逗号隔开',
   CATEGORY_CODE_01     int comment '计划分类01 1:定期 2:活期',
   CATEGORY_CODE_02     int comment '计划分类02 0:精选计划 11:贴心计划 15:月月升计划',
   CATEGORY_NAME_02     string comment '计划分类名称02',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '诺诺资金端产品维表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
