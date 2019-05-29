DROP TABLE IF EXISTS DIM_DATA_TAG_CODE;

/*==============================================================*/
/* Table: DIM_DATA_TAG_CODE                                     */
/*==============================================================*/
CREATE TABLE DIM_DATA_TAG_CODE
(
   ID                   INT NOT NULL AUTO_INCREMENT COMMENT '代理键',
   DATA_TAG_CODE        INT NOT NULL COMMENT '数据标签编码',
   DATA_TAG_CODE_CN     VARCHAR(512) NOT NULL COMMENT '数据标签编码名称',
   DATA_DEC_NUM         INT NOT NULL DEFAULT 0 COMMENT '小数位数',
   DW_CREATE_BY         VARCHAR(64) DEFAULT 'SYS' COMMENT '系统字段-创建者',
   DW_CREATE_TIME       DATETIME COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         VARCHAR(64) DEFAULT 'SYS' COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       DATETIME COMMENT '系统字段-修改时间',
   PRIMARY KEY (ID)
);

ALTER TABLE DIM_DATA_TAG_CODE COMMENT '维度表_数据标签_CODE';