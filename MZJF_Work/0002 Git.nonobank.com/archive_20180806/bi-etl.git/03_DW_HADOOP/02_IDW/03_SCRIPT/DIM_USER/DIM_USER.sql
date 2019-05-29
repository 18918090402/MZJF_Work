--1
set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=IDW_DIM_USER_01;
set hive.exec.parallel=true;
set hive.exec.reducers.bytes.per.reducer=58720256;
set hive.groupby.skewindata = true;
set hive.map.aggr = false; 
set hive.enforce.bucketing = true;

drop table if exists tmp.tmp_dim_user_01;
create table if not exists tmp.tmp_dim_user_01
stored as parquet 
as
SELECT t1.USER_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 41 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_LOGIN_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 45 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS AUTHENTICATION_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 47 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 48 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_FIRST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 49 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 50 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 51 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_TERMINAL,
       NVL(MAX(CASE
                 WHEN TAG_ID = 52 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 53 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 54 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 55 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 56 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_TERMINAL,
       NVL(MAX(CASE
                 WHEN TAG_ID = 57 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BIND_CARD_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 58 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BIND_CARD_ACCOUNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 59 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BIND_CARD_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 60 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BINDCARD_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 61 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_BIND_CARD_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 62 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_BIND_CARD_ACCOUNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 63 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_BIND_CARD_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 64 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 65 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_FIRST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 66 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 67 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_SECOND_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 68 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_SECOND_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 69 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_SECOND_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 70 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_THIRD_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 71 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_THIRD_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 72 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_THIRD_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 73 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 74 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 75 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 76 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_CASH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 77 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_CASH_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 78 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_CASH_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 79 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 80 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_MAX_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 81 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_MAX_AUM_DATE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 82 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_BALANCE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 97 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 98 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_FIRST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 99 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 100 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_SECOND_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 101 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_SECOND_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 102 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_SECOND_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 103 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_THIRD_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 104 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_THIRD_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 105 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_THIRD_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 106 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 107 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 108 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 109 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS CSYY_LAST_30_DAYS_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 110 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS CSYY_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 111 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_CASH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 112 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_CASH_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 113 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_CASH_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 114 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 115 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_MAX_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 116 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_MAX_AUM_DATE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 117 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_BALANCE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 118 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_CASH_PRINCIPAL_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 119 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_CASH_PRINCIPAL_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 120 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 121 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_FIRST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 122 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 123 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 124 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 125 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 126 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 127 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 128 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_IS_LOSS_BEFORE_2017,
       NVL(MAX(CASE
                 WHEN TAG_ID = 129 THEN
                  CAST(TAG_VALUE AS BIGINT)
               END),
           NULL) AS CSYY_INVITE_USER_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 84 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 85 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 86 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_PROLOCUTOR_INVITE_REGISTER_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 92 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_LOGIN_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 93 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_60_DAYS_LOGIN_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 94 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_VIEW_COLUMN_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 95 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_VIEW_PRODUCT_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 96 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_CLICK_THIRD_ICON_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 134 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS STU_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 135 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS EDU_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 135 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BL_EDU_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 135 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BL_CARD_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 138 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BO_SUCCESS_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 139 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MAX_OVERDUE_DAYS,
       NVL(MAX(CASE
                 WHEN TAG_ID = 140 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS SESAME_NUMBER,
       NVL(MAX(CASE
                 WHEN TAG_ID = 141 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS PHONE_ONLINE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 142 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS IS_GJJ_SUBMIT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 143 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS GJJ_SUBMIT_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 144 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS IS_SB_SUBMIT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 145 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS SB_SUBMIT_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 146 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS TONGDUN_SCORE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 147 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS USER_CREDIT_RANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 173 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           0) AS NONO_IS_BLACK_LIST,
       NVL(MAX(CASE
                 WHEN TAG_ID = 174 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS CSYY_CHANNEL_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 175 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_CHANNEL_NAME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 176 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_7DAYS_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 177 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_7DAYS_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 178 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_7DAYS_ETA_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 179 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_7DAYS_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 180 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_7DAYS_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 181 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_7DAYS_ETA_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 182 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BO_APPLY_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 183 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 184 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_TOTAL_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 186 THEN
                  CAST(TAG_VALUE AS BIGINT)
               END),
           NULL) AS FINANCE_ADVISOR,
       NVL(MAX(CASE
                 WHEN TAG_ID = 210 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS IS_BLACK_GRAY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 211 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MAIYA_SALARY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 212 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_COMPANY_NAME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 213 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MAIYA_WORK_POSITION,
       NVL(MAX(CASE
                 WHEN TAG_ID = 214 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_WORK_POSITION_NAME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 215 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_FAMILY_USER,
       NVL(MAX(CASE
                 WHEN TAG_ID = 216 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_FAMILY_USER_MOBILE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 217 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           'NA') AS NONO_INVEST_PREFERRED,
       NVL(MAX(CASE
                 WHEN TAG_ID = 219 THEN
                  CAST(TAG_VALUE AS BIGINT)
               END),
           NULL) AS NONO_LAST_CASH_FP_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 221 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 298 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BL_GRADUATE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 224 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MLD_CREDIT_APPLY_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 225 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MLD_BO_SUCCESS_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 226 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_FIRST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 227 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 228 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_SECOND_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 229 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_SECOND_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 230 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_THIRD_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 231 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_THIRD_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 232 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 233 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 234 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_TOTAL_PLAN_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 235 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_PLAN_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 236 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_PLAN_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 237 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_IN_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 238 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_MAX_IN_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 239 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_MAX_IN_INVEST_AMT_DATE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 240 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_FIRST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 241 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 242 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_SECOND_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 243 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_SECOND_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 244 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_THIRD_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 245 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_THIRD_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 246 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 247 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 248 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_TOTAL_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 249 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_90_DAYS_WITHDRAW_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 250 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_90_DAYS_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 251 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_WITHDRAW_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 252 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 253 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_USER_LOST_STATUS,
       NVL(MAX(CASE
                 WHEN TAG_ID = 261 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_BALANCE_LOCKING_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 262 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_BALANCE_TOTAL_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 263 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS BASE_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 264 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS INCREASE_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 265 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS TOTAL_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 266 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS USED_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 267 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS AMT_111,
       NVL(MAX(CASE
                 WHEN TAG_ID = 272 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_ACCOUNT_NO,
       NVL(MAX(CASE
                 WHEN TAG_ID = 273 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_STATUS,
       NVL(MAX(CASE
                 WHEN TAG_ID = 274 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS HSB_BALANCE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 275 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS HSB_FREEZE_AMOUNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 276 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_MOBILE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 277 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_BANK_CARD,
       NVL(MAX(CASE
                 WHEN TAG_ID = 278 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS HAS_NOT_DEPOSITORY_OVERDUE_DEBT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 287 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_ML_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 288 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_ACTUAL_BO_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 290 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS BASE_AMOUNT_TYPE_110
  FROM IDW.USER_TAG_HIST t1
 WHERE TAG_ID >= 1
   AND TAG_ID <= 298
   and hash_partition_id >= 0
   and hash_partition_id <= 3
 GROUP BY t1.USER_ID
union all
SELECT t1.USER_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 41 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_LOGIN_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 45 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS AUTHENTICATION_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 47 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 48 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_FIRST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 49 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 50 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 51 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_TERMINAL,
       NVL(MAX(CASE
                 WHEN TAG_ID = 52 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 53 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 54 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 55 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 56 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_TERMINAL,
       NVL(MAX(CASE
                 WHEN TAG_ID = 57 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BIND_CARD_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 58 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BIND_CARD_ACCOUNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 59 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BIND_CARD_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 60 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BINDCARD_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 61 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_BIND_CARD_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 62 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_BIND_CARD_ACCOUNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 63 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_BIND_CARD_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 64 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 65 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_FIRST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 66 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 67 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_SECOND_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 68 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_SECOND_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 69 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_SECOND_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 70 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_THIRD_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 71 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_THIRD_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 72 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_THIRD_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 73 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 74 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 75 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 76 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_CASH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 77 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_CASH_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 78 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_CASH_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 79 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 80 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_MAX_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 81 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_MAX_AUM_DATE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 82 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_BALANCE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 97 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 98 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_FIRST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 99 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 100 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_SECOND_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 101 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_SECOND_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 102 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_SECOND_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 103 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_THIRD_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 104 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_THIRD_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 105 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_THIRD_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 106 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 107 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 108 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 109 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS CSYY_LAST_30_DAYS_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 110 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS CSYY_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 111 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_CASH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 112 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_CASH_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 113 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_CASH_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 114 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 115 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_MAX_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 116 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_MAX_AUM_DATE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 117 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_BALANCE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 118 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_CASH_PRINCIPAL_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 119 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_CASH_PRINCIPAL_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 120 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 121 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_FIRST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 122 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 123 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 124 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 125 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 126 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 127 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 128 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_IS_LOSS_BEFORE_2017,
       NVL(MAX(CASE
                 WHEN TAG_ID = 129 THEN
                  CAST(TAG_VALUE AS BIGINT)
               END),
           NULL) AS CSYY_INVITE_USER_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 84 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 85 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 86 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_PROLOCUTOR_INVITE_REGISTER_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 92 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_LOGIN_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 93 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_60_DAYS_LOGIN_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 94 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_VIEW_COLUMN_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 95 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_VIEW_PRODUCT_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 96 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_CLICK_THIRD_ICON_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 134 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS STU_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 135 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS EDU_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 135 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BL_EDU_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 135 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BL_CARD_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 138 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BO_SUCCESS_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 139 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MAX_OVERDUE_DAYS,
       NVL(MAX(CASE
                 WHEN TAG_ID = 140 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS SESAME_NUMBER,
       NVL(MAX(CASE
                 WHEN TAG_ID = 141 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS PHONE_ONLINE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 142 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS IS_GJJ_SUBMIT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 143 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS GJJ_SUBMIT_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 144 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS IS_SB_SUBMIT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 145 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS SB_SUBMIT_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 146 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS TONGDUN_SCORE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 147 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS USER_CREDIT_RANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 173 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           0) AS NONO_IS_BLACK_LIST,
       NVL(MAX(CASE
                 WHEN TAG_ID = 174 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS CSYY_CHANNEL_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 175 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_CHANNEL_NAME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 176 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_7DAYS_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 177 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_7DAYS_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 178 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_7DAYS_ETA_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 179 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_7DAYS_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 180 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_7DAYS_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 181 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_7DAYS_ETA_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 182 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BO_APPLY_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 183 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 184 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_TOTAL_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 186 THEN
                  CAST(TAG_VALUE AS BIGINT)
               END),
           NULL) AS FINANCE_ADVISOR,
       NVL(MAX(CASE
                 WHEN TAG_ID = 210 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS IS_BLACK_GRAY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 211 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MAIYA_SALARY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 212 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_COMPANY_NAME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 213 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MAIYA_WORK_POSITION,
       NVL(MAX(CASE
                 WHEN TAG_ID = 214 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_WORK_POSITION_NAME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 215 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_FAMILY_USER,
       NVL(MAX(CASE
                 WHEN TAG_ID = 216 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_FAMILY_USER_MOBILE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 217 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           'NA') AS NONO_INVEST_PREFERRED,
       NVL(MAX(CASE
                 WHEN TAG_ID = 219 THEN
                  CAST(TAG_VALUE AS BIGINT)
               END),
           NULL) AS NONO_LAST_CASH_FP_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 221 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 298 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BL_GRADUATE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 224 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MLD_CREDIT_APPLY_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 225 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MLD_BO_SUCCESS_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 226 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_FIRST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 227 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 228 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_SECOND_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 229 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_SECOND_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 230 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_THIRD_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 231 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_THIRD_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 232 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 233 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 234 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_TOTAL_PLAN_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 235 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_PLAN_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 236 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_PLAN_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 237 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_IN_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 238 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_MAX_IN_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 239 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_MAX_IN_INVEST_AMT_DATE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 240 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_FIRST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 241 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 242 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_SECOND_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 243 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_SECOND_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 244 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_THIRD_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 245 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_THIRD_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 246 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 247 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 248 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_TOTAL_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 249 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_90_DAYS_WITHDRAW_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 250 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_90_DAYS_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 251 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_WITHDRAW_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 252 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 253 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_USER_LOST_STATUS,
       NVL(MAX(CASE
                 WHEN TAG_ID = 261 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_BALANCE_LOCKING_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 262 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_BALANCE_TOTAL_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 263 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS BASE_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 264 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS INCREASE_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 265 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS TOTAL_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 266 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS USED_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 267 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS AMT_111,
       NVL(MAX(CASE
                 WHEN TAG_ID = 272 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_ACCOUNT_NO,
       NVL(MAX(CASE
                 WHEN TAG_ID = 273 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_STATUS,
       NVL(MAX(CASE
                 WHEN TAG_ID = 274 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS HSB_BALANCE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 275 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS HSB_FREEZE_AMOUNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 276 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_MOBILE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 277 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_BANK_CARD,
       NVL(MAX(CASE
                 WHEN TAG_ID = 278 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS HAS_NOT_DEPOSITORY_OVERDUE_DEBT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 287 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_ML_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 288 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_ACTUAL_BO_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 290 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS BASE_AMOUNT_TYPE_110
  FROM IDW.USER_TAG_HIST t1
 WHERE TAG_ID >= 1
   AND TAG_ID <= 298
   and hash_partition_id >= 4
   and hash_partition_id <= 6
 GROUP BY t1.USER_ID
union all
SELECT t1.USER_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 41 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_LOGIN_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 45 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS AUTHENTICATION_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 47 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 48 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_FIRST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 49 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 50 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 51 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_RECHARGE_TERMINAL,
       NVL(MAX(CASE
                 WHEN TAG_ID = 52 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 53 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 54 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 55 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 56 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_RECHARGE_TERMINAL,
       NVL(MAX(CASE
                 WHEN TAG_ID = 57 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BIND_CARD_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 58 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BIND_CARD_ACCOUNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 59 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BIND_CARD_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 60 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BINDCARD_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 61 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_BIND_CARD_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 62 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_BIND_CARD_ACCOUNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 63 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS LAST_BIND_CARD_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 64 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 65 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_FIRST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 66 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 67 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_SECOND_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 68 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_SECOND_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 69 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_SECOND_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 70 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_THIRD_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 71 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_THIRD_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 72 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_THIRD_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 73 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 74 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 75 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_INVEST_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 76 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_CASH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 77 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_CASH_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 78 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_CASH_PRODUCT_SCOPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 79 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 80 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_MAX_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 81 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_MAX_AUM_DATE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 82 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_BALANCE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 97 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 98 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_FIRST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 99 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 100 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_SECOND_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 101 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_SECOND_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 102 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_SECOND_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 103 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_THIRD_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 104 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_THIRD_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 105 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_THIRD_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 106 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_INVEST_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 107 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 108 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_INVEST_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 109 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS CSYY_LAST_30_DAYS_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 110 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS CSYY_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 111 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_CASH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 112 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_CASH_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 113 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_CASH_PRODUCT_CODE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 114 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 115 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_MAX_AUM,
       NVL(MAX(CASE
                 WHEN TAG_ID = 116 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_MAX_AUM_DATE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 117 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_BALANCE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 118 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_CASH_PRINCIPAL_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 119 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_CASH_PRINCIPAL_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 120 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 121 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_FIRST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 122 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 123 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 124 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_RECHARGE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 125 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 126 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_RECHARGE_BANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 127 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_RECHARGE_TYPE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 128 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_IS_LOSS_BEFORE_2017,
       NVL(MAX(CASE
                 WHEN TAG_ID = 129 THEN
                  CAST(TAG_VALUE AS BIGINT)
               END),
           NULL) AS CSYY_INVITE_USER_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 84 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 85 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 86 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_PROLOCUTOR_INVITE_REGISTER_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 92 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_LOGIN_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 93 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_60_DAYS_LOGIN_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 94 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_VIEW_COLUMN_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 95 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_VIEW_PRODUCT_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 96 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_30_DAYS_CLICK_THIRD_ICON_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 134 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS STU_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 135 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS EDU_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 135 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BL_EDU_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 135 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BL_CARD_AUTH_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 138 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BO_SUCCESS_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 139 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MAX_OVERDUE_DAYS,
       NVL(MAX(CASE
                 WHEN TAG_ID = 140 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS SESAME_NUMBER,
       NVL(MAX(CASE
                 WHEN TAG_ID = 141 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS PHONE_ONLINE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 142 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS IS_GJJ_SUBMIT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 143 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS GJJ_SUBMIT_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 144 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS IS_SB_SUBMIT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 145 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS SB_SUBMIT_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 146 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS TONGDUN_SCORE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 147 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS USER_CREDIT_RANK,
       NVL(MAX(CASE
                 WHEN TAG_ID = 173 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           0) AS NONO_IS_BLACK_LIST,
       NVL(MAX(CASE
                 WHEN TAG_ID = 174 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS CSYY_CHANNEL_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 175 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_CHANNEL_NAME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 176 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_7DAYS_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 177 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_7DAYS_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 178 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_7DAYS_ETA_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 179 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_7DAYS_RECHARGE_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 180 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_7DAYS_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 181 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_7DAYS_ETA_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 182 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_BO_APPLY_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 183 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 184 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_TOTAL_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 186 THEN
                  CAST(TAG_VALUE AS BIGINT)
               END),
           NULL) AS FINANCE_ADVISOR,
       NVL(MAX(CASE
                 WHEN TAG_ID = 210 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS IS_BLACK_GRAY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 211 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MAIYA_SALARY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 212 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_COMPANY_NAME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 213 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MAIYA_WORK_POSITION,
       NVL(MAX(CASE
                 WHEN TAG_ID = 214 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_WORK_POSITION_NAME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 215 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_FAMILY_USER,
       NVL(MAX(CASE
                 WHEN TAG_ID = 216 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS MAIYA_FAMILY_USER_MOBILE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 217 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           'NA') AS NONO_INVEST_PREFERRED,
       NVL(MAX(CASE
                 WHEN TAG_ID = 219 THEN
                  CAST(TAG_VALUE AS BIGINT)
               END),
           NULL) AS NONO_LAST_CASH_FP_ID,
       NVL(MAX(CASE
                 WHEN TAG_ID = 221 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 298 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS BL_GRADUATE_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 224 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MLD_CREDIT_APPLY_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 225 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS MLD_BO_SUCCESS_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 226 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_FIRST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 227 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_FIRST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 228 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_SECOND_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 229 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_SECOND_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 230 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_THIRD_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 231 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_THIRD_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 232 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 233 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 234 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_TOTAL_PLAN_INVEST_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 235 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_PLAN_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 236 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_TOTAL_PLAN_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 237 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_IN_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 238 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_MAX_IN_INVEST_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 239 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_MAX_IN_INVEST_AMT_DATE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 240 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_FIRST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 241 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_FIRST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 242 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_SECOND_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 243 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_SECOND_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 244 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_THIRD_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 245 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_THIRD_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 246 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_LAST_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 247 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS CSYY_LAST_INVEST_EXPECT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 248 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS CSYY_TOTAL_INVEST_AMT_YEARLY,
       NVL(MAX(CASE
                 WHEN TAG_ID = 249 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS NONO_LAST_90_DAYS_WITHDRAW_CNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 250 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_90_DAYS_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 251 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_LAST_WITHDRAW_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 252 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_LAST_WITHDRAW_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 253 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS NONO_USER_LOST_STATUS,
       NVL(MAX(CASE
                 WHEN TAG_ID = 261 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_BALANCE_LOCKING_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 262 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS NONO_BALANCE_TOTAL_AMT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 263 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS BASE_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 264 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS INCREASE_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 265 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS TOTAL_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 266 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS USED_AMT_110,
       NVL(MAX(CASE
                 WHEN TAG_ID = 267 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS AMT_111,
       NVL(MAX(CASE
                 WHEN TAG_ID = 272 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_ACCOUNT_NO,
       NVL(MAX(CASE
                 WHEN TAG_ID = 273 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_STATUS,
       NVL(MAX(CASE
                 WHEN TAG_ID = 274 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS HSB_BALANCE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 275 THEN
                  CAST(TAG_VALUE AS DECIMAL(38, 10))
               END),
           NULL) AS HSB_FREEZE_AMOUNT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 276 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_MOBILE,
       NVL(MAX(CASE
                 WHEN TAG_ID = 277 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS HSB_BANK_CARD,
       NVL(MAX(CASE
                 WHEN TAG_ID = 278 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS HAS_NOT_DEPOSITORY_OVERDUE_DEBT,
       NVL(MAX(CASE
                 WHEN TAG_ID = 287 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_ML_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 288 THEN
                  CAST(TAG_VALUE AS STRING)
               END),
           NULL) AS FIRST_ACTUAL_BO_TIME,
       NVL(MAX(CASE
                 WHEN TAG_ID = 290 THEN
                  CAST(TAG_VALUE AS INT)
               END),
           NULL) AS BASE_AMOUNT_TYPE_110
  FROM IDW.USER_TAG_HIST t1
 WHERE TAG_ID >= 1
   AND TAG_ID <= 298
   and hash_partition_id >= 7
   and hash_partition_id <= 9
 GROUP BY t1.USER_ID;
 

--2
set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=IDW_DIM_USER_02;
set hive.exec.parallel=true;
 
INSERT OVERWRITE TABLE IDW.DIM_USER
  select 'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         t1.user_id,
         t1.user_name,
         t1.real_name,
         t1.gender,
         t1.mobile_num,
         t1.email,
         t1.is_email,
         t1.register_time,
         t1.is_authentication,
         t1.is_photo,
         t1.is_education_auth,
         t1.is_student_auth,
         t1.is_special,
         t1.is_cheat,
         t1.status,
         t1.status_desc,
         t1.pc_id,
         t1.pc_id_desc,
         t1.english_name,
         t1.birthday,
         t1.age,
         t1.constellation,
         t1.qq,
         t1.current_mobile_no,
         t1.hj_province,
         t1.hj_city,
         t1.hj_address,
         t1.current_province,
         t1.current_city,
         t1.birth_province,
         t1.contact_address,
         t1.marriage_status,
         t1.marriage_status_desc,
         t1.is_have_passport,
         t1.is_social_security,
         t1.is_driving_license,
         t1.house_status,
         t1.education,
         t1.channel_id,
         t1.channel_name,
         t2.last_login_time,
         t1.register_terminal,
         t1.user_rank,
         t1.user_rank_desc,
         t2.authentication_time,
         t1.recommender,
         t2.nono_first_recharge_time,
         t2.nono_first_recharge_amt,
         t2.nono_first_recharge_bank,
         t2.nono_first_recharge_type,
         t2.nono_first_recharge_terminal,
         t2.nono_last_recharge_time,
         t2.nono_last_recharge_amt,
         t2.nono_last_recharge_bank,
         t2.nono_last_recharge_type,
         t2.nono_last_recharge_terminal,
         t2.first_bind_card_time,
         t2.first_bind_card_account,
         t2.first_bind_card_bank,
         t2.bindcard_cnt,
         t2.last_bind_card_time,
         t2.last_bind_card_account,
         t2.last_bind_card_bank,
         t2.nono_first_invest_time,
         t2.nono_first_invest_amt,
         t2.nono_first_invest_product_scope,
         t2.nono_second_invest_time,
         t2.nono_second_invest_amt,
         t2.nono_second_invest_product_scope,
         t2.nono_third_invest_time,
         t2.nono_third_invest_amt,
         t2.nono_third_invest_product_scope,
         t2.nono_last_invest_time,
         t2.nono_last_invest_amt,
         t2.nono_last_invest_product_scope,
         t2.nono_last_cash_time,
         t2.nono_last_cash_amt,
         t2.nono_last_cash_product_scope,
         t2.nono_aum,
         t2.nono_max_aum,
         t2.nono_max_aum_date,
         t2.nono_balance_amt,
         t1.user_type,
         t1.hj_province_name,
         t1.hj_city_name,
         t1.current_province_name,
         t1.current_city_name,
         t1.birth_province_name,
         t2.csyy_first_invest_time,
         t2.csyy_first_invest_amt,
         t2.csyy_first_invest_product_code,
         t2.csyy_second_invest_time,
         t2.csyy_second_invest_amt,
         t2.csyy_second_invest_product_code,
         t2.csyy_third_invest_time,
         t2.csyy_third_invest_amt,
         t2.csyy_third_invest_product_code,
         t2.csyy_last_invest_time,
         t2.csyy_last_invest_amt,
         t2.csyy_last_invest_product_code,
         t2.csyy_last_30_days_invest_cnt,
         t2.csyy_invest_cnt,
         t2.csyy_last_cash_time,
         t2.csyy_last_cash_amt,
         t2.csyy_last_cash_product_code,
         t2.csyy_aum,
         t2.csyy_max_aum,
         t2.csyy_max_aum_date,
         t2.csyy_balance_amt,
         t2.csyy_last_cash_principal_amt,
         t2.nono_last_cash_principal_amt,
         t2.csyy_first_recharge_time,
         t2.csyy_first_recharge_amt,
         t2.csyy_first_recharge_bank,
         t2.csyy_first_recharge_type,
         t2.csyy_last_recharge_time,
         t2.csyy_last_recharge_amt,
         t2.csyy_last_recharge_bank,
         t2.csyy_last_recharge_type,
         t2.nono_is_loss_before_2017,
         t2.csyy_invite_user_id,
         t1.id_num,
         t2.nono_last_30_days_invest_cnt,
         t2.nono_invest_cnt,
         t2.nono_prolocutor_invite_register_cnt,
         t2.nono_last_30_days_login_cnt,
         t2.nono_last_60_days_login_cnt,
         t2.nono_last_30_days_view_column_cnt,
         t2.nono_last_30_days_view_product_cnt,
         t2.nono_last_30_days_click_third_icon_cnt,
         NULL AS busi_line,
         t1.edu_start_date,
         t1.edu_graduate_date,
         t2.stu_auth_time,
         t2.edu_auth_time,
         t2.bl_edu_auth_time,
         t2.bl_card_auth_time,
         t2.first_bo_success_time,
         t2.max_overdue_days,
         t2.sesame_number,
         t2.phone_online_time,
         t2.is_gjj_submit,
         t2.gjj_submit_time,
         t2.is_sb_submit,
         t2.sb_submit_time,
         t2.tongdun_score,
         t2.user_credit_rank,
         t1.instructor_name,
         t1.instructor_mobile,
         t1.instructor_mobile_state,
         t1.instructor_mobile_address,
         t1.parent_name,
         t1.parent_mobile,
         t1.parent_mobile_state,
         t1.parent_mobile_address,
         t1.friend1_name,
         t1.friend1_mobile,
         t1.friend1_mobile_state,
         t1.friend1_mobile_address,
         t1.friend2_name,
         t1.friend2_mobile,
         t1.friend2_mobile_state,
         t1.friend2_mobile_address,
         t1.friend3_name,
         t1.friend3_mobile,
         t1.friend3_mobile_state,
         t1.friend3_mobile_address,
         t1.cou_address,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd')  stat_date,
         t1.mxd_education,
         t1.ad_plan,
         t1.ad_unit,
         t1.channel_detail,
         t2.nono_is_black_list,
         t2.csyy_channel_id,
         t2.csyy_channel_name,
         t2.nono_7days_recharge_amt,
         t2.nono_7days_withdraw_amt,
         t2.nono_7days_eta_amt,
         t2.csyy_7days_recharge_amt,
         t2.csyy_7days_withdraw_amt,
         t2.csyy_7days_eta_amt,
         t2.first_bo_apply_time,
         t2.nono_total_invest_amt,
         t2.csyy_total_invest_amt,
         t1.register_biz,
         t1.finance_advisor,
         t1.academy,
         t1.major,
         t1.is_graduate,
         t1.campus_approach,
         t1.campus_approach_desc,
         t1.student_no,
         t1.campus,
         t1.family_income,
         t1.family_income_desc,
         t1.school_type,
         t1.school_type_desc,
         t1.school_province_id,
         t1.school_province_name,
         t1.school_city_id,
         t1.school_city_name,
         t1.job,
         t1.current_job_time,
         t1.total_job_time,
         t1.company_name,
         t1.company_type,
         t1.company_business_type,
         t1.company_tel,
         t1.register_ip,
         t2.is_black_gray,
         t2.maiya_salary,
         t2.maiya_company_name,
         t2.maiya_work_position,
         t2.maiya_work_position_name,
         t2.maiya_family_user,
         t2.maiya_family_user_mobile,
         t2.nono_invest_preferred,
         t1.is_dfd_admin_member,
         t2.nono_last_cash_fp_id,
         t1.address_home,
         t2.nono_total_invest_amt_yearly,
         t2.bl_graduate_time,
         t1.mobile_address,
         t2.mld_credit_apply_cnt,
         t2.mld_bo_success_cnt,
         t2.nono_first_invest_amt_yearly,
         t2.nono_first_invest_expect,
         t2.nono_second_invest_amt_yearly,
         t2.nono_second_invest_expect,
         t2.nono_third_invest_amt_yearly,
         t2.nono_third_invest_expect,
         t2.nono_last_invest_amt_yearly,
         t2.nono_last_invest_expect,
         t2.nono_total_plan_invest_cnt,
         t2.nono_total_plan_invest_amt,
         t2.nono_total_plan_invest_amt_yearly,
         t2.nono_in_invest_amt,
         t2.nono_max_in_invest_amt,
         t2.nono_max_in_invest_amt_date,
         t2.csyy_first_invest_amt_yearly,
         t2.csyy_first_invest_expect,
         t2.csyy_second_invest_amt_yearly,
         t2.csyy_second_invest_expect,
         t2.csyy_third_invest_amt_yearly,
         t2.csyy_third_invest_expect,
         t2.csyy_last_invest_amt_yearly,
         t2.csyy_last_invest_expect,
         t2.csyy_total_invest_amt_yearly,
         t2.nono_last_90_days_withdraw_cnt,
         t2.nono_last_90_days_withdraw_amt,
         t2.nono_last_withdraw_time,
         t2.nono_last_withdraw_amt,
         t2.nono_user_lost_status,
         t3.username maiya_user_name,
         t3.name maiya_real_name,
         t3.mobile maiya_mobile_num,
         t3.province_code maiya_register_province_code,
         t3.city_code maiya_register_city_code,
         t3.province_name maiya_register_province_name,
         t3.city_name maiya_register_city_name,
         t2.nono_balance_locking_amt,
         t2.nono_balance_total_amt,
         t2.base_amt_110,
         t2.increase_amt_110,
         t2.total_amt_110,
         t2.used_amt_110,
         t2.amt_111,
         t1.know_approach_code,
         t1.know_approach_name,
         t1.unifi_register_country_code,
         t1.unifi_register_country_name,
         t2.hsb_account_no,
         t2.hsb_status,
         t2.hsb_balance,
         t2.hsb_freeze_amount,
         t2.hsb_mobile,
         t2.hsb_bank_card,
         t2.has_not_depository_overdue_debt,
         t3.idcard maiya_id_num,
         t3.sex maiya_gender,
         t3.academic_name maiya_education,
         t3.email maiya_email,
         t3.use_source maiya_user_source,
         t3.work_type_name maiya_work_type,
         t3.is_qizha maiya_is_qizha,
         t3.mobile_address maiya_mobile_address,
         t1.mobile_address_province,
         t2.first_ml_time,
         t2.first_actual_bo_time,
         t1.company_business_sort,
         t1.company_address,
         t1.spouse_name,
         t1.spouse_idnum,
         t1.spouse_mobile,
         t1.spouse_company,
         t1.monthly_salary,
         t2.base_amount_type_110
    from idw.fact_user_info t1
    left join tmp.tmp_dim_user_01 t2
      on t1.user_id = t2.user_id
    left join (select *,
                      row_number() over(partition by user_id order by maiya_user_id desc) rn
                 from idw.fact_maiya_user_info) t3
      on t1.user_id = t3.user_id
     and t3.rn = 1;

--3
invalidate metadata IDW.DIM_USER
