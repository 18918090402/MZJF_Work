
set mapreduce.job.name=DMT_RM_FACT_CREDIT_DATA_MXDMY; 
set mapreduce.job.queuename = etl-dw;  

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 

set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict; 
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

drop table if exists dmt_rm.FACT_CREDIT_DATA_MXDMY;
create table if not exists dmt_rm.FACT_CREDIT_DATA_MXDMY
( ORDER_NO STRING   COMMENT '订单编号',
  APPLY_NO STRING  COMMENT '申请号',
  CREDIT_ZM STRING COMMENT '芝麻',
  CREDIT_TD STRING  COMMENT '同盾',
  MULT_INVEST_1M STRING  COMMENT '多投借贷1月内',
  MULT_INVEST_3M STRING  COMMENT '多投借贷3月内',
  MULT_INVEST_6M STRING COMMENT '多投借贷6月内',
  CREDIT_JXL STRING  COMMENT '聚信立',
  CREDIT_MY STRING COMMENT '麦芽评级',
  FACE_S STRING  COMMENT '活体识别照对比',
  IDCARD_S STRING  COMMENT '身份证照对比',
  DW_CREATE_BY     STRING COMMENT '系统字段-创建者',
   DW_CREATE_TIME   STRING COMMENT '系统字段-创建时间',
   DW_UPDATE_BY     STRING COMMENT '系统字段-修改者',
   DW_UPDATE_TIME   STRING COMMENT '系统字段-修改时间'
) COMMENT '风控征信表'
   PARTITIONED BY (STAT_DATE STRING COMMENT '分区键:统计日期')
    STORED AS PARQUET TBLPROPERTIES ("parquet.compression"="SNAPPY");