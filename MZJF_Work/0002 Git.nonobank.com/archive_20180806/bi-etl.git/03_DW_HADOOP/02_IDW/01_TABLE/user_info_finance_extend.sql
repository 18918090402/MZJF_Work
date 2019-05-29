drop table if exists idw.user_info_finance_extend;
create table if not exists idw.user_info_finance_extend
(
   dw_create_by         string comment '系统字段-创建者',
   dw_create_time       string comment '系统字段-创建时间',
   dw_update_by         string comment '系统字段-修改者',
   dw_update_time       string comment '系统字段-修改时间',
   user_id              bigint comment '用户id',   
   user_rank            string comment '会员等级 0:普通会员 1:vip1 2:vip2 3:vip3',
   user_rank_desc       string comment '会员等级描述')
COMMENT '用户理财属性扩展'
PARTITIONED BY (stat_date string COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
