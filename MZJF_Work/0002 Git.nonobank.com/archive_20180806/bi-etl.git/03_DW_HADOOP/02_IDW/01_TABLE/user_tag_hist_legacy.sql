DROP TABLE IF EXISTS idw.user_tag_hist_legacy;
CREATE TABLE IF NOT EXISTS idw.user_tag_hist_legacy
(   
   USER_ID              BIGINT COMMENT '用户唯一标识',  
   TAG_VALUE            STRING COMMENT '用户标签值',
   DW_CREATE_TIME       STRING COMMENT '系统字段-创建时间'
) COMMENT '归档用户标签列表'
PARTITIONED BY (TAG_ID INT COMMENT '用户标签编码', HASH_PARTITION_ID INT COMMENT '用户唯一标识哈希值')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");