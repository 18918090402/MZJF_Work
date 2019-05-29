DROP TABLE IF EXISTS DMT_BF.WDZJ_REPAYMENT_INFO;
CREATE TABLE DMT_BF.WDZJ_REPAYMENT_INFO (
PROJECT_ID bigint   COMMENT '项目主键',
BO_ID  bigint   COMMENT '标的ID',
P_ID  bigint   COMMENT '预发标ID',
DEADLINE   int      COMMENT '借款期限',
DEADLINE_UNIT   string      COMMENT '借款期限单位',
HUILIU_TIME   string  COMMENT '回流时间',
IS_DELETE           int            COMMENT '是否删除，0:否，1:是',
DW_CREATE_BY        string         comment '系统字段-创建者',
DW_CREATE_TIME      string         comment '系统字段-创建时间',
DW_UPDATE_BY        string         comment '系统字段-修改者',
DW_UPDATE_TIME      string         comment '系统字段-修改时间'
) COMMENT '网贷之家提前回款记录'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY”);
