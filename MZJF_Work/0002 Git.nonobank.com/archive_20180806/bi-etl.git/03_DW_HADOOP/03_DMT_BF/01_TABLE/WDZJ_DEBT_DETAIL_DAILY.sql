drop table if exists DMT_BF.WDZJ_DEBT_DETAIL_DAILY;

create table if not exists DMT_BF.WDZJ_DEBT_DETAIL_DAILY
(
   DBL_ID               bigint COMMENT '债权购买记录ID',
   USER_ID              bigint COMMENT '投资人ID',
   PRICE                decimal(38,10) COMMENT '支付金额',
   PAY_TIME             string COMMENT '支付时间',
   BO_ID                bigint COMMENT '借款标id',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间'
)
comment '每日投资人信息'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;
