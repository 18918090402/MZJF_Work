drop table if exists idw.METRIC_VALUE_CUR;
create table if not exists idw.METRIC_VALUE_CUR
(
   DATA_FREQ            int comment '数据频率 1:日 2:周 3:月 4:季 5:半年 6:年',
   DATA_TIME            string comment '数据时间',
   METRIC_DIM           MAP<string,string> comment '指标维度',
   METRIC_VALUE         decimal(38,10) comment '指标值',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '当日指标值'
PARTITIONED BY (METRIC_ID            int comment '指标ID')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");