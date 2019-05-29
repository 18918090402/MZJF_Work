set mapreduce.job.name=DMT_RM_FACT_APPROVAL_MXDMY_DATA; 
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

drop table if exists dmt_rm.FACT_APPROVAL_MXDMY_DATA;
create table if not exists dmt_rm.FACT_APPROVAL_MXDMY_DATA
( ORDER_NO STRING   COMMENT '订单编号',
  APPLY_NO STRING  COMMENT '申请号',
  AUDIT_NAME STRING  COMMENT '审核人员',
  PRODUCT STRING COMMENT '产品',
  PROCESS_BEGIN_TIME STRING  COMMENT '流转环节-进入时间',
  PROCESS_NAME STRING  COMMENT '流转环节- 名称',
  PROCESS_END_TIME STRING  COMMENT '流转环节-完成时间',
  DW_CREATE_BY     STRING COMMENT '系统字段-创建者',
   DW_CREATE_TIME   STRING COMMENT '系统字段-创建时间',
   DW_UPDATE_BY     STRING COMMENT '系统字段-修改者',
   DW_UPDATE_TIME   STRING COMMENT '系统字段-修改时间'
) COMMENT '风控征信表'
   PARTITIONED BY (STAT_DATE STRING COMMENT '分区键:统计日期')
    STORED AS PARQUET TBLPROPERTIES ("parquet.compression"="SNAPPY");