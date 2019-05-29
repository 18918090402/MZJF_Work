drop table if exists DMT_BF.DH_FACT_BORROWER_STAT_DAILY;

create table if not exists DMT_BF.DH_FACT_BORROWER_STAT_DAILY
(
   BUSI_LINE            string comment '所属业务线',
   HJ_CITY_CODE          string comment '户籍城市',
   BORROWER_CNT         decimal(38,0) comment '借款人数',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间'
)
comment '借款人数日统计'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;