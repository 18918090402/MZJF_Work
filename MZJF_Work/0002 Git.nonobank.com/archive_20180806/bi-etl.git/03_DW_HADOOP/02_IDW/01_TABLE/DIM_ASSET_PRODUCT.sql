drop table if exists idw.DIM_ASSET_PRODUCT;
create table if not exists idw.DIM_ASSET_PRODUCT
(
   P_KEY                bigint comment '产品代理键',
   P_ID                 bigint comment '产品ID',
   P_CODE               string comment '产品编号',
   P_TYPE               int comment '产品类型',
   P_NAME               string comment '产品名称',
   P_PAY_TYPE           string comment '还款方式',
   P_ACCEPT_TYPE        string comment '收款方式',
   P_EXPECT             int comment '期限',
   P_DELAY_MONTH        int comment '推迟还款月份',
   P_ASSURE_TYPE        string comment '担保类型',
   P_APPROACH           string comment '渠道',
   P_PRICE_MIN          decimal(38,10) comment '最低借款金额',
   P_PRICE_MAX          decimal(38,10) comment '最高借款金额',
   P_COMPENSATION       int comment '是否允许代偿',
   P_COMPENSATION_OVERDUE int comment '逾期多少天启动代偿',
   P_ENABLED            int comment '是否启用',
   P_CREATOR            bigint comment '创建人',
   P_UPDATOR            bigint comment '更新人',
   CREATE_TIME          string comment '创建时间',
   UPDATE_TIME          string comment '更新时间',
   CATEGORY_NAME_01     string comment '产品分类01',
   BIZ_CODE_01          string comment '业务线编码01',
   BIZ_NAME_01          string comment '业务线名称01',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '借款产品维表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");