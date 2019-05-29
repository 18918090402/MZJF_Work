DROP TABLE IF EXISTS DMT.FACT_NONO_USER_ACTIVITY_LEVEL;
CREATE TABLE IF NOT EXISTS DMT.FACT_NONO_USER_ACTIVITY_LEVEL
(
   USER_ID              bigint comment '用户ID',
   USER_CATEGORY        int comment '用户分类 1:新用户 2:活跃用户 3:忠诚用户 4:沉默用户 5:僵尸用户',
   ACTIVITY_LEVEL       string comment '活跃级别 1-1: 新用户阶段1 2-1: 活跃用户阶段1',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '诺诺用户活跃级别'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
