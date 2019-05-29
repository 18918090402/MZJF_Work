drop table if exists DMT_BF.DH_FACT_OVERDUE_RATE_END_MONTH;

create table if not exists DMT_BF.DH_FACT_OVERDUE_RATE_END_MONTH
(
   BUSI_LINE            string comment '所属业务线',
   AGING                string comment '账龄',
   HJ_PROVINCE          string comment '户籍省份',
   OVERDUE_RATE         decimal(38,10) comment '逾期率',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间'
)
comment '逾期率月末统计'
PARTITIONED BY (STAT_MONTH STRING COMMENT '统计日期 年-月')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;