DROP TABLE IF EXISTS DMT_CS.CSYY_USER_INFO_FOR_API_QUERY;
CREATE TABLE IF NOT EXISTS DMT_CS.CSYY_USER_INFO_FOR_API_QUERY
(
   USER_ID              bigint comment '用户ID',
   MOBILE_NUM           string comment '手机号',
   REAL_NAME            string comment '真实姓名',
   ID_NUM               string comment '身份证号码(后4位)',
   USER_RANK_DESC       string comment '会员等级',
   CSYY_7DAYS_RECHARGE_AMT decimal(38,10) comment '7日内成功充值总金额',
   CSYY_7DAYS_WITHDRAW_AMT decimal(38,10) comment '7日内成功取现总金额',
   CSYY_7DAYS_ETA_AMT   decimal(38,10) comment '7日内预计到期总金额',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '财神API查询用户信息'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
