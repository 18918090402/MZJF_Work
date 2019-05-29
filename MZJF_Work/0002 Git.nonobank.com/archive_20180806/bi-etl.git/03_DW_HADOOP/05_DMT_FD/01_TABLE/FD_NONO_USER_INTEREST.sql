drop table if exists dmt_fd.FD_NONO_USER_INTEREST;
create table if not exists dmt_fd.FD_NONO_USER_INTEREST
(
   SRC_ID               BIGINT COMMENT '源表ID',
   SRC_TAB              string COMMENT '源表名',
   USER_ID              BIGINT COMMENT '用户ID',
   FP_KEY               BIGINT COMMENT '计划代理键',
   FP_ID                BIGINT COMMENT '计划ID',
   INTEREST_AMT         DECIMAL(38,10) COMMENT '收益金额',
   INTEREST_DATE        string COMMENT '收益日期',
   DW_INVEST_RELATION_NO string COMMENT '投资关联编号 散投、债转:前置_(USER_ID)_(BO_ID) 精选:前置_(USER_ID)_(FP_ID) e诺千金:前置_(USER_ID)_(DT_ID) 前置规则为01:散投、债转 02:精选 03:e诺千金',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '诺诺用户收益信息'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");