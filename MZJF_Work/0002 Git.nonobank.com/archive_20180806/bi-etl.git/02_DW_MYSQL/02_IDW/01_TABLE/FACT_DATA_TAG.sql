DROP TABLE IF EXISTS FACT_DATA_TAG;

/*==============================================================*/
/* Table: FACT_DATA_TAG                                         */
/*==============================================================*/
CREATE TABLE FACT_DATA_TAG
(
   DATA_TAG_DATE        DATETIME COMMENT '数据标签日期',
   DATA_TAG_CODE_ID     INT COMMENT '数据标签编码',
   DATA_TAG_VALUE       DECIMAL(38,10) COMMENT '数据标签值',
   DW_CREATE_BY         VARCHAR(64) DEFAULT 'SYS' COMMENT '系统字段-创建者',
   DW_CREATE_TIME       DATETIME COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         VARCHAR(64) DEFAULT 'SYS' COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       DATETIME COMMENT '系统字段-修改时间'
);

ALTER TABLE FACT_DATA_TAG COMMENT '事实表_数据标签';
