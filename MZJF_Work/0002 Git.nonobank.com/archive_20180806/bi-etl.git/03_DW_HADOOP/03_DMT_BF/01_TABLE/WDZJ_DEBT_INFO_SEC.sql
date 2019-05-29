DROP TABLE IF EXISTS DMT_BF.WDZJ_DEBT_INFO;
CREATE TABLE DMT_BF.WDZJ_DEBT_INFO (
PROJECT_ID          string         COMMENT '关联外键',
SUBSCRIBE_USER_NAME bigint         COMMENT '投标人id',
AMOUNT              decimal(38,10) COMMENT '投标金额',
VALID_AMOUNT        decimal(38,10) COMMENT '有效金额',
ADD_DATE            string         COMMENT '投标时间',
STATUS              int            COMMENT '投标状态',
TYPE                int            COMMENT '标识手动或自动投标',
SOURCE_TYPE         int            COMMENT '投标来源',
DBL_ID              bigint         COMMENT '关联债转购买id',
HUILIU_TIME         string         COMMENT '回流时间',
IS_DELETE           int            COMMENT '是否删除，0:否，1:是',
DW_CREATE_BY        string         comment '系统字段-创建者',
DW_CREATE_TIME      string         comment '系统字段-创建时间',
DW_UPDATE_BY        string         comment '系统字段-修改者',
DW_UPDATE_TIME      string         comment '系统字段-修改时间'
) COMMENT '网贷之家投标记录'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
