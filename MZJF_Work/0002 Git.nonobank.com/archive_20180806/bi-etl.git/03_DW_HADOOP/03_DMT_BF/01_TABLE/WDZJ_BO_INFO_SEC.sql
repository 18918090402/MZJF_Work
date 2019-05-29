DROP TABLE IF EXISTS DMT_BF.WDZJ_BO_INFO;
CREATE TABLE if not exists  DMT_BF.WDZJ_BO_INFO (
PROJECT_ID       string         COMMENT '标的id',
TITLE            string         COMMENT '借款标题',
AMOUNT           decimal(38,10)  COMMENT '借款金额',
SCHEDULE         int            COMMENT '进度',
INTEREST_RATE    string         COMMENT '利率',
DEADLINE         int            COMMENT '借款期限',
DEADLINE_UNIT    string         COMMENT '期限单位',
REWARD           decimal(38,10) COMMENT '奖励',
TYPE             string         COMMENT '标的类型',
REPAYMENT_TYPE   int            COMMENT '还款方式',
PROVINCE         string         COMMENT '借款人所在省份',
CITY             string         COMMENT '借款人所在城市',
USER_NAME          bigint         COMMENT '发标人',
AMOUNT_USED_DESC string         COMMENT '借款用途',
LOAN_URL         string         COMMENT '标的详细页面地址链接',
SUCCESS_TIME     string         COMMENT '标的计息时间',
PUBLISH_TIME     string         COMMENT '发标时间',
IS_AGENCY        int            COMMENT '是否机构借款',
BO_ID            bigint         COMMENT '自用bo_id',
BO_TYPE          int            COMMENT '标的类型 1.新标 2.债转标 3.虚拟标 4.拆分标(v3) 5.拆分标(非v3)',
P_ID             bigint         COMMENT '自用资产类型',
HUILIU_TIME      string         COMMENT '回流时间',
IS_DELETE        int            COMMENT '是否删除，0:否，1:是',
DW_CREATE_BY     string         comment '系统字段-创建者',
DW_CREATE_TIME   string         comment '系统字段-创建时间',
DW_UPDATE_BY     string         comment '系统字段-修改者',
DW_UPDATE_TIME   string         comment '系统字段-修改时间'
) COMMENT '网贷之家标的回流表'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
