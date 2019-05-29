drop table if exists idw.FACT_BORROWS_DUNNING;
create table if not exists idw.FACT_BORROWS_DUNNING
(
   DUNNING_ID           bigint comment '催收记录ID',
   BO_ID                bigint comment '借款ID',
   USER_ID              bigint comment '用户ID',
   MOD_PRODUCT          int comment '产品',
   MOD_COMPANY          int comment '催收公司',
   MOD_COMPANY_NAME     string comment '催收公司名称',
   MOD_COMPANY_TYPR     int comment '催收公司类型 0:委外 1:内催',
   MOD_CONTRACT         string comment '合同编号',
   MOD_MONEY            decimal(38,10) comment '逾期金额',
   MOD_TOTAL_MONEY      decimal(38,10) comment '总额 未还总额+罚息+违约金',
   MOD_START_TIME       string comment '开始时间',
   MOD_END_TIME         string comment '结束时间',
   MOD_CLOSE_TIME       string comment '结案时间',
   MOD_STATUS           int comment '状态 0:委外在案 1:委外结案 2:委外退案 3:提前退案 4:延期案件',
   MOD_IS_CANCEL        int comment '是否取消',
   CREATE_TIME          string comment '创建时间',
   UPDATE_TIME          string comment '更新时间',
   CREATER              bigint comment '创建者',
   UPDATER              bigint comment '更新者',
   OVERDUE_UNREPAY_DAYS int comment '逾期未还天数',
   AGING                string comment '账龄',
   DUNNING_NUM          int comment '当前标的第几次催收',
   DUNNED_OVERDUE_AMT   decimal(38,10) comment '催回逾期总额',
   DUNNED_NORMAL_AMT    decimal(38,10) comment '催回正常总额',
   IS_LAST_DUNNING      int comment '是否最新催收',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '借款催收记录'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");