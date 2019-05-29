drop table if exists DMT_BF.WDZJ_BORROWS_DETAIL_DAILY;

create table if not exists DMT_BF.WDZJ_BORROWS_DETAIL_DAILY
(
   BO_ID                bigint COMMENT '借款标id',
   BO_TITLE             string COMMENT '借款标题',
   BO_PRICE             decimal(38,10)  COMMENT '借款金额',
   BO_RATE              decimal(38,10) COMMENT '借款利率',
   BO_EXPECT            int COMMENT '借款期限',
   BO_EXPECT_CAT        int COMMENT '借款期限单位',
   P_ID                 bigint COMMENT '借款类型',
   BO_PAYTYPE           string COMMENT '还款方式',
   PROVINCE_NAME        string COMMENT '借款人所在省份',
   CITY_NAME            string COMMENT '借款人所在城市',
   USER_ID              bigint COMMENT '借款人ID',
   BO_DES               string COMMENT '借款用途',
   BO_FINISH_TIME       string COMMENT '标的成功时间',
   PUBLISH_TIME         string COMMENT '发标时间',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间'
)
comment '每日借款标信息'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;
