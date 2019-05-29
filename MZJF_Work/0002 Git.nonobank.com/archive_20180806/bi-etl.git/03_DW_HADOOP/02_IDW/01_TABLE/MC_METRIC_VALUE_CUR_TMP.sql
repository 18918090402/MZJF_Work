drop table if exists idw.MC_METRIC_VALUE_CUR_TMP;
create table if not exists idw.MC_METRIC_VALUE_CUR_TMP
(
   DATA_FREQ            int comment '数据频率 1:日 2:周 3:月 4:季 5:半年 6:年',
   DATA_TIME            string comment '数据时间',
   METRIC_CODE          string comment '指标代码',
   DIM_GROUP_ID         int comment '维度组合ID',
   METRIC_DIM           MAP<string,string> comment '指标维度',
   METRIC_VALUE         decimal(38,10) comment '指标值')
COMMENT '非代数型指标临时表'
PARTITIONED BY (METRIC_ID            int comment '指标ID',
                DIM_TYPE             int comment '维度类型',
                BIZ                  string comment '所属业务线')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");