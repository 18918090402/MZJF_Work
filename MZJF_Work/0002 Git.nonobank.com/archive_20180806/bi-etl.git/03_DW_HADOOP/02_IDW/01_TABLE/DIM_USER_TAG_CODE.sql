DROP TABLE IF EXISTS IDW.DIM_USER_TAG_CODE;

CREATE TABLE IF NOT EXISTS IDW.DIM_USER_TAG_CODE
(
   ID                   INT    COMMENT '代理键（主键）',
   TAG_NAME             STRING COMMENT '标签名（英文字段名）',
   TAG_NAME_CN          STRING COMMENT '标签名中文',
   TAG_DESC             STRING COMMENT '标签描述',
   TAG_CLASS            STRING COMMENT '标签类型',
   TAG_CATEGORY_01      STRING COMMENT '标签分类1',
   TAG_CATEGORY_02      STRING COMMENT '标签分类2',
   TAG_CATEGORY_03      STRING COMMENT '标签分类3',
   NULL_VALUE           STRING COMMENT '空值填充值',
   TAG_DATA_TYPE        STRING COMMENT '标签数据类型',
   DW_CREATE_BY         STRING COMMENT '系统字段-创建者',
   DW_CREATE_TIME       STRING COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         STRING COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       STRING COMMENT '系统字段-修改时间'
) COMMENT '用户标签维表'
STORED AS PARQUET TBLPROPERTIES ("parquet.compression"="SNAPPY");
;