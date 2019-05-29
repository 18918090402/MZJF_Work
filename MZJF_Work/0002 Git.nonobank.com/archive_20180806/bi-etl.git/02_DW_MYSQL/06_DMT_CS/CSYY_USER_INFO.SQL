DROP TABLE IF EXISTS DMT_CS.CSYY_USER_INFO;

CREATE TABLE DMT_CS.CSYY_USER_INFO
(
  user_id INT(11) PRIMARY KEY COMMENT '用户ID',
  user_name VARCHAR(128) COMMENT '用户名',
  mobile_no VARCHAR(32) COMMENT '手机号码',
  real_name VARCHAR(128) COMMENT '真实姓名',
  id_num VARCHAR(32) COMMENT '身份证号码',
  user_level VARCHAR(16) COMMENT '会员等级',
  gender VARCHAR(16) COMMENT '性别',
  birthday varchar(16) COMMENT '生日',
  recommender_id INT(11) COMMENT '推荐人ID',
  finance_advisor_id int(11) comment '理财顾问ID',
  current_city VARCHAR(128) COMMENT '当前所在市',
  register_time DATETIME COMMENT '注册时间',
  last_login_time DATETIME COMMENT '最近一次登录时间',
  channel VARCHAR(128) COMMENT '来源渠道',
  max_aum DECIMAL(18,2) COMMENT '历史最高在投金额',
  aum DECIMAL(18,2) COMMENT '当前在投金额',
  success_recharge_amt_7d DECIMAL(18,2) COMMENT '7日内成功充值总金额',
  success_withdraw_amt_7d DECIMAL(18,2) COMMENT '7日内成功取现总金额',
  plan_cash_amt_7d DECIMAL(18,2) COMMENT '7日内预计到期总金额',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT  '创建时间',
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

CREATE INDEX IDX_CSYY_USER_INFO_UPDATE_TIME ON DMT_CS.CSYY_USER_INFO(update_time);