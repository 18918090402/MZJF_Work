DROP TABLE IF EXISTS IDW.DIM_REGION;

CREATE TABLE IF NOT EXISTS IDW.DIM_REGION
(
   KEY                  INT    COMMENT '代理键（主键）',
   REGION_ID            INT COMMENT '主键',
   REGION_NAME          STRING COMMENT '地区名称',
   REGION_LEVEL         INT COMMENT '地区层级',
   PARENT_ID            INT COMMENT '父ID',
   CREATE_TIME          STRING COMMENT '创建时间',
   UPDATE_TIME          STRING COMMENT '更新时间',
   DW_CREATE_BY         STRING COMMENT '系统字段-创建者',
   DW_CREATE_TIME       STRING COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         STRING COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       STRING COMMENT '系统字段-修改时间'
) COMMENT '区域维表'
STORED AS PARQUET TBLPROPERTIES ("parquet.compression"="SNAPPY");
;