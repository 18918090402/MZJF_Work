-- 代码0
-- 1.创建表语句
USE IDW;
DROP TABLE IF EXISTS IDW.AAA;
-- 字段名和数据类型字段描述请参照维表
CREATE TABLE IF NOT EXISTS IDW.AAA
(  
    DW_CREATE_BY         STRING COMMENT '系统字段-创建者',
    DW_CREATE_TIME       STRING COMMENT '系统字段-创建时间',
    DW_UPDATE_BY         STRING COMMENT '系统字段-修改者',
    DW_UPDATE_TIME       STRING COMMENT '系统字段-修改时间',
    USER_ID BIGINT,
    B STRING
) COMMENT 'AAA'
PARTITIONED BY(STAT_DATE STRING)
STORED AS PARQUET TBLPROPERTIES ("parquet.compression"="SNAPPY");
;

-- 2.增加字段
-- 字段名和数据类型字段描述请参照维表
ALTER TABLE IDW.AAA  ADD COLUMNS( A STRING COMMENT 'A' );

-- 3.创建视图
-- 字段描述请参照维表
USE IDWOPR;
DROP VIEW IF EXISTS IDWOPR.AAA;
CREATE VIEW IF NOT EXISTS IDWOPR.AAA (
STAT_DATE         COMMENT '统计日期',
USER_ID           COMMENT '用户ID',
A                 COMMENT 'A',
B                 COMMENT 'B',
DW_CREATE_BY      COMMENT '数据更新人',
DW_CREATE_TIME     COMMENT '数据更新时间',
DW_UPDATE_BY      COMMENT '数据更新人',
DW_UPDATE_TIME     COMMENT '数据更新时间'
)AS
SELECT 
STAT_DATE
,USER_ID
,A
,B
,DW_CREATE_BY
,DW_CREATE_TIME
,DW_UPDATE_BY
,DW_UPDATE_TIME
FROM IDW.AAA;

-- 4.insert 数据
-- 字段名和数据类型请参照维表,null值请参照维表
set mapreduce.job.name=TASK_NAME_XX;

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.auto.convert.join=true;
set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

INSERT OVERWRITE TABLE IDW.AAA PARTITION(STAT_DATE) 
SELECT 
       'SYS' AS DW_CREATE_BY
       ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
       ,'SYS' AS DW_UPDATE_BY
       ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
       ,USER_ID
       ,NVL(MAX(CASE WHEN TAG_ID=1 THEN CAST(TAG_VALUE AS STRING) END),'A') AS A -- ==
       ,NVL(MAX(CASE WHEN TAG_ID=2 THEN CAST(TAG_VALUE AS STRING) END),'B') AS B -- ==
       ,FROM_UNIXTIME(UNIX_TIMESTAMP() -1*24*60*60,'yyyy-MM-dd') AS STAT_DATE
FROM IDW.USER_TAG_HIST
WHERE TAG_ID IN (1,2) AND HASH_PARTITION_ID=0
GROUP BY USER_ID
UNION ALL 1~9
;