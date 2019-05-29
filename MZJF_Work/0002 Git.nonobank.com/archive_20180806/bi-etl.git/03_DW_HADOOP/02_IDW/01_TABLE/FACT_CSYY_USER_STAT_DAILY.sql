DROP TABLE IF EXISTS IDW.FACT_CSYY_USER_STAT_DAILY;
CREATE TABLE IF NOT EXISTS IDW.FACT_CSYY_USER_STAT_DAILY
(
   USER_CODE            bigint comment '用户编号',
   USER_ID              bigint comment '用户ID',
   INVEST_AMT           decimal(38,10) comment '投资金额',
   ANNUALIZED_INVEST_AMT decimal(38,10) comment '年化投资金额',
   EXPECTED_EARNINGS_AMT decimal(38,10) comment '预期收益额',
   INVEST_CNT           int comment '投资次数',
   DEDUCTIBLE_AMT       decimal(38,10) comment '抵扣金额',
   TOTAL_INVEST_CNT     int comment '累计投资次数',
   TOTAL_INVEST_AMT     decimal(38,10) comment '累计投资金额',
   TOTAL_ANNUALIZED_INVEST_AMT decimal(38,10) comment '累计年化投资金额',
   AUM                  decimal(38,10) comment 'AUM',
   MAX_AUM              decimal(38,10) comment '最高AUM',
   MAX_AUM_DATE         string comment '最高AUM出现日期',
   KXCS_LOCK_AUM        decimal(38,10) comment '开心财神锁定期内AUM',
   KXCS_UNLOCK_AUM      decimal(38,10) comment '开心财神可转出AUM',
   CASH_AMT             decimal(38,10) comment '兑付金额',
   HZD_AMT              decimal(38,10) comment '活转定金额',
   HQ_WITHDRAW_AMT      decimal(38,10) comment '活期提现金额',
   KXCS_CASH_AMT        decimal(38,10) comment '开心财神兑付金额',
   BALANCE_AMT          decimal(38,10) comment '账户余额',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '财神用户日统计'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
