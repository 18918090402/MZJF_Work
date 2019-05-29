drop table if exists idw.FACT_REINVEST_SET_LOG;
create table if not exists idw.FACT_REINVEST_SET_LOG
(
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   ID                   bigint comment '主键ID',
   USER_ID              bigint comment '用户ID',
   VA_ID                bigint comment '当前va_id',
   PRODUCT_CATEGORY_CODE int comment '当前投资产品 0:精选计划 11:贴心计划 15:月月升计划',
   PRODUCT_CATEGORY_NAME string comment '当前投资产品名称',
   EXPECT               int comment '当前投资期限',
   EXPECT_UNIT_CODE     int comment '当前投资期限单位 1:日 2:月 3:年',
   REINVEST_TYPE        int comment '续投类型 0:到期转让 1:本金续投 2:本息续投',
   REINVEST_EXPECT      int comment '续投期限',
   REINVEST_EXPECT_UNIT_CODE int comment '续投期限单位 1:日 2:月 3:年',
   REINVEST_AMT         decimal(38,10) comment '续投金额',
   REINVEST_AMT_YEARLY  decimal(38,10) comment '续投年化金额',
   RED_PACKET_PRICE     decimal(38,10) comment '现金红包金额',
   CREATE_TIME          string comment '操作时间')
COMMENT '续投设置日志表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");