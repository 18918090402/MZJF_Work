drop table if exists IDW.FACT_CSYY_AUM_SNAPSHOT;

create table IDW.FACT_CSYY_AUM_SNAPSHOT
(
   USER_CODE            bigint comment '用户编号',
   USER_ID              bigint comment '用户ID',
   INVEST_AMT           decimal(38,10) comment '原始投资金额',
   AUM                  decimal(38,10) comment '在投金额',
   MAX_AUM              decimal(38,10) comment '历史最高金额',
   MAX_AUM_DATE         string comment '历史最高出现日期',
   CSZPB_INVEST_AMT     decimal(38,10) comment '财神招牌宝原始投资金额',
   CSZPB_AUM            decimal(38,10) comment '财神招牌宝在投金额',
   CSZPB_MAX_AUM        decimal(38,10) comment '财神招牌宝历史最高金额',
   CSZPB_MAX_AUM_DATE   string comment '财神招牌宝历史最高出现日期',
   csyxb_invest_amt     decimal(38,10) comment '财神优选宝原始投资金额',
   CSYXB_AUM            decimal(38,10) comment '财神优选宝在投金额',
   CSYXB_MAX_AUM        decimal(38,10) comment '财神优选宝历史最高金额',
   CSYXB_MAX_AUM_DATE   string comment '财神优选宝历史最高出现日期',
   ZJJXK_INVEST_AMT     decimal(38,10) comment '钻金加息卡原始投资金额',
   ZJJXK_AUM            decimal(38,10) comment '钻金加息卡在投金额',
   ZJJXK_MAX_AUM        decimal(38,10) comment '钻金加息卡历史最高金额',
   ZJJXK_MAX_AUM_DATE   string comment '钻金加息卡历史最高出现日期',
   XRB_INVEST_AMT       decimal(38,10) comment '新人宝原始投资金额',
   XRB_AUM              decimal(38,10) comment '新人宝在投金额',
   XRB_MAX_AUM          decimal(38,10) comment '新人宝历史最高金额',
   XRB_MAX_AUM_DATE     string comment '新人宝历史最高出现日期',
   XHJK_INVEST_AMT      decimal(38,10) comment '新黄金卡原始投资金额',
   XHJK_AUM             decimal(38,10) comment '新黄金卡在投金额',
   XHJK_MAX_AUM         decimal(38,10) comment '新黄金卡历史最高金额',
   XHJK_MAX_AUM_DATE    string comment '新黄金卡历史最高出现日期',
   XBJK_INVEST_AMT      decimal(38,10) comment '新白金卡原始投资金额',
   XBJK_AUM             decimal(38,10) comment '新白金卡在投金额',
   XBJK_MAX_AUM         decimal(38,10) comment '新白金卡历史最高金额',
   XBJK_MAX_AUM_DATE    string comment '新白金卡历史最高出现日期',
   XZJK_INVEST_AMT      decimal(38,10) comment '新钻金卡原始投资金额',
   XZJK_AUM             decimal(38,10) comment '新钻金卡在投金额',
   XZJK_MAX_AUM         decimal(38,10) comment '新钻金卡历史最高金额',
   XZJK_MAX_AUM_DATE    string comment '新钻金卡历史最高出现日期',
   XYXB_INVEST_AMT      decimal(38,10) comment '新优选宝原始投资金额',
   XYXB_AUM             decimal(38,10) comment '新优选宝在投金额',
   XYXB_MAX_AUM         decimal(38,10) comment '新优选宝历史最高金额',
   XYXB_MAX_AUM_DATE    string comment '新优选宝历史最高出现日期',
   KXCS_INVEST_AMT      decimal(38,10) comment '开心财神原始投资金额',
   KXCS_AUM             decimal(38,10) comment '开心财神在投金额',
   KXCS_MAX_AUM         decimal(38,10) comment '开心财神历史最高金额',
   KXCS_MAX_AUM_DATE    string comment '开心财神历史最高出现日期',
   OTHER_INVEST_AMT     decimal(38,10) comment '其他原始投资金额',
   OTHER_AUM            decimal(38,10) comment '其他在投金额',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间'
)
COMMENT '财神爷爷AUM快照表'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY");
