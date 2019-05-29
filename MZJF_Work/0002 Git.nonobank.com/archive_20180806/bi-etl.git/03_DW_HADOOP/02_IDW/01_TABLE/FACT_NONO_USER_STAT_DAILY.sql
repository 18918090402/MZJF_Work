DROP TABLE IF EXISTS IDW.FACT_NONO_USER_STAT_DAILY;
CREATE TABLE IF NOT EXISTS IDW.FACT_NONO_USER_STAT_DAILY
(
   USER_ID              bigint comment '用户ID',
   INVEST_AMT           decimal(38,10) comment '投资金额',
   ANNUALIZED_INVEST_AMT decimal(38,10) comment '年化投资金额',
   EXPECTED_EARNINGS_AMT decimal(38,10) comment '预期收益额',
   INVEST_CNT           int comment '投资次数',
   DEDUCTIBLE_AMT       decimal(38,10) comment '抵扣金额',
   ADD_RATE_AMT         decimal(38,10) comment '加息金额',
   TOTAL_INVEST_CNT     int comment '累计投资次数',
   TOTAL_INVEST_AMT     decimal(38,10) comment '累计投资金额',
   TOTAL_ANNUALIZED_INVEST_AMT decimal(38,10) comment '累计年化投资金额',
   TOTAL_PLAN_INVEST_CNT int comment '累计精选投资次数',
   TOTAL_PLAN_INVEST_AMT decimal(38,10) comment '累计精选投资金额',
   TOTAL_PLAN_ANNUALIZED_INVEST_AMT decimal(38,10) comment '累计精选年化投资金额',
   IN_INVEST_AMT        decimal(38,10) comment '在投金额',
   MAX_IN_INVEST_AMT    decimal(38,10) comment '最高在投金额',
   MAX_IN_INVEST_AMT_DATE string comment '最高在投金额出现日期',
   AUM                  decimal(38,10) comment 'AUM',
   MAX_AUM              decimal(38,10) comment '最高AUM',
   MAX_AUM_DATE         string comment '最高AUM出现日期',
   YYS_LOCK_AUM         decimal(38,10) comment '月月升锁定期内AUM',
   YYS_UNLOCK_AUM       decimal(38,10) comment '月月升可转出AUM',
   CASH_AMT             decimal(38,10) comment '兑付金额',
   YYS_CASH_AMT         decimal(38,10) comment '月月升兑付金额',
   WITHDRAW_AMT         decimal(38,10) comment '提现金额',
   BALANCE_AMT          decimal(38,10) comment '账户余额',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '诺诺用户日统计'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
