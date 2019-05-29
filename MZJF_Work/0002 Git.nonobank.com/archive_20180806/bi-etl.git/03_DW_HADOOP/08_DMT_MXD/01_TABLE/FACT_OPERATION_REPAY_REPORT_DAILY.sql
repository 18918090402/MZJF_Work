DROP TABLE IF EXISTS DMT_MXD.FACT_OPERATION_REPAY_REPORT_DAILY;
CREATE TABLE IF NOT EXISTS DMT_MXD.FACT_OPERATION_REPAY_REPORT_DAILY
(
DW_CREATE_BY         string comment '系统字段-创建者'
,DW_CREATE_TIME       string comment '系统字段-创建时间'
,DW_UPDATE_BY         string comment '系统字段-修改者'
,DW_UPDATE_TIME       string comment '系统字段-修改时间'
,p_id int comment '产品PID'
,first_overdue_repay_cnt int comment '首还逾期笔数'
,first_overdue_repay_price decimal(18,10) comment '首还逾期金额'
,first_repay_cnt int comment '首还笔数'
,first_repay_price decimal(18,10) comment '首还金额'
,first7_overdue_repay_cnt int comment 'T-7首还逾期笔数'
,first7_overdue_repay_price decimal(18,10) comment 'T-7首还逾期金额'
,first7_repay_cnt int comment 'T-7首还笔数'
,first7_repay_price decimal(18,10) comment 'T-7首还金额'
)
COMMENT '运营日报-还款'
PARTITIONED BY (stat_date STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");