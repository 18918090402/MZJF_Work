drop table if exists IDW.FACT_REINVEST_SET_SNAPSHOT;
create table if not exists IDW.FACT_REINVEST_SET_SNAPSHOT
(
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间',
   VA_ID                bigint comment '当前VA_ID',
   USER_ID              bigint comment '用户ID',
   PRODUCT_CATEGORY_CODE int comment '当前投资产品 0:精选计划 11:贴心计划 15:月月升计划',
   PRODUCT_CATEGORY_NAME string comment '当前投资产品名称',
   EXPECT               int comment '当前投资期限',
   EXPECT_UNIT_CODE     int comment '当前投资期限单位 1:日 2:月 3:年',
   REINVEST_TYPE        int comment '续投类型 0:到期转让 1:本金续投 2:本息续投',
   REINVEST_EXPECT      int comment '续投期限',
   REINVEST_EXPECT_UNIT_CODE int comment '续投期限单位 1:日 2:月 3:年',
   REINVEST_AMT         decimal(38,10) comment '续投金额',
   REINVEST_AMT_YEARLY  decimal(38,10) comment '续投年化金额',
   REINVEST_START_DATE  string comment '开始续投时间',
   REINVEST_STATUS      int comment '续投状态 0:待续投 10:交易中 19:红包待激活 20:续投成功 30:用户取消 40:到期终止 95:异常待解冻 99:异常失败',
   NEXT_VA_ID           bigint comment '续投VA_ID')
COMMENT '续投设置快照'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");