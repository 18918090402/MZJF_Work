drop table if exists idw.user_tag;
create table if not exists idw.user_tag
(
   dw_create_by         string comment '系统字段-创建者',
   dw_create_time       string comment '系统字段-创建时间',
   dw_update_by         string comment '系统字段-修改者',
   dw_update_time       string comment '系统字段-修改时间',
   user_id              bigint comment '用户id',
   authentication_time  string comment '身份认证时间',
   first_bind_card_time string comment '首次绑卡时间',
   first_bind_card_account string comment '首次绑卡账户',
   first_bind_card_bank string comment '首次绑卡银行',
   last_bind_card_time  string comment '最近绑卡时间',
   last_bind_card_account string comment '最近绑卡账户',
   last_bind_card_bank  string comment '最近绑卡银行',
   bindcard_cnt         string comment '累计绑卡次数',
   first_recharge_time  string comment '首次充值时间',
   first_recharge_amt   decimal(38,10) comment '首次充值金额',
   first_recharge_bank  string comment '首次充值银行',
   first_recharge_type  string comment '首次充值类型',
   first_recharge_terminal string comment '首次充值终端',
   first_recharge_biz   string comment '首次充值平台',
   last_recharge_time   string comment '最近充值时间',
   last_recharge_amt    decimal(38,10) comment '最近充值金额',
   last_recharge_bank   string comment '最近充值银行',
   last_recharge_type   string comment '最近充值类型',
   last_recharge_terminal string comment '最近充值终端',
   last_recharge_biz    string comment '最近充值平台',
   last_login_time      string comment '最近登录时间',
   last_login_biz       string comment '最近登录平台',
   nono_first_invest_time string comment '诺诺首次投资时间',
   csyy_first_invest_time string comment '财神首次投资时间',
   xyd_first_apply_time string comment '信用贷首次申请时间',
   bld_first_apply_time string comment '白领贷首次申请时间',
   mzjk_first_apply_time string comment '麦子借款首次申请时间'
   )
COMMENT '用户基础标签'
PARTITIONED BY (stat_date string COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
