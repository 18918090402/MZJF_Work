CREATE OR REPLACE VIEW DMT_CS.V_CSYY_USER_INFO_FOR_INC_UPDATE
AS
SELECT
  user_id,
  user_name,
  SUBSTR(real_name,1,1) AS family_name,
  gender,
  finance_advisor_id,
  recommender_id,
  current_city,
  birthday,
  register_time,
  last_login_time,
  channel,
  max_aum,
  aum,
  create_time,
  update_time
FROM DMT_CS.CSYY_USER_INFO;

GRANT SELECT ON DMT_CS.V_CSYY_USER_INFO_FOR_INC_UPDATE TO R_DMT_CS;
GRANT SHOW VIEW ON DMT_CS.V_CSYY_USER_INFO_FOR_INC_UPDATE TO R_DMT_CS;

CREATE OR REPLACE VIEW DMT_CS.V_CSYY_USER_INFO_FOR_API_QUERY
AS
SELECT
  user_id,
  mobile_no,
  real_name,
  id_num,
  user_level,
  success_recharge_amt_7d,
  success_withdraw_amt_7d,
  plan_cash_amt_7d,
  create_time,
  update_time
FROM DMT_CS.CSYY_USER_INFO;

GRANT SELECT ON DMT_CS.V_CSYY_USER_INFO_FOR_API_QUERY TO R_DMT_CS;
GRANT SHOW VIEW ON DMT_CS.V_CSYY_USER_INFO_FOR_API_QUERY TO R_DMT_CS;