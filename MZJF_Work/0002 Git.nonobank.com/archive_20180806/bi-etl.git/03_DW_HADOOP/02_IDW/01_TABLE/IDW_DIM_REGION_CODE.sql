CREATE TABLE IF NOT EXISTS IDW.DIM_REGION_CODE
(
   KEY			INT    COMMENT '代理主键',
   CODE                 INT    COMMENT '主键',
   DISTRICT_CODE        INT    COMMENT '地区编码',
   DISTRICT_NAME        STRING COMMENT '地区名称',
   CITY_CODE            INT COMMENT '市编码',
   CITY_NAME            STRING COMMENT '市名称',
   PROVINCE_CODE        INT COMMENT '省编码',
   PROVINCE_NAME        STRING COMMENT '省名称',
   DW_CREATE_BY         STRING COMMENT '系统字段-创建者',
   DW_CREATE_TIME       STRING COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         STRING COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       STRING COMMENT '系统字段-修改时间'
) COMMENT '区域维表'
STORED AS PARQUET TBLPROPERTIES ("parquet.compression"="SNAPPY");