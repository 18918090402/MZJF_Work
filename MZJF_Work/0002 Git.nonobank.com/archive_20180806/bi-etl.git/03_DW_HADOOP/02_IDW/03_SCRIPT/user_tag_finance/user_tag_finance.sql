set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_tag_finance_01;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table idw.user_tag_finance partition
  (stat_date)
  select 'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         user_id,
         
         --nono
         max(case
               when tag_id = 64 then
                cast(tag_value as string)
             end) as nono_first_invest_time,
         max(case
               when tag_id = 65 then
                cast(tag_value as decimal(38, 10))
             end) as nono_first_invest_amt,
         max(case
               when tag_id = 66 then
                cast(tag_value as string)
             end) as nono_first_invest_product_scope,
         max(case
               when tag_id = 226 then
                cast(tag_value as decimal(38, 10))
             end) as nono_first_invest_amt_yearly,
         max(case
               when tag_id = 227 then
                cast(tag_value as string)
             end) as nono_first_invest_expect,
         max(case
               when tag_id = 67 then
                cast(tag_value as string)
             end) as nono_second_invest_time,
         max(case
               when tag_id = 68 then
                cast(tag_value as decimal(38, 10))
             end) as nono_second_invest_amt,
         max(case
               when tag_id = 69 then
                cast(tag_value as string)
             end) as nono_second_invest_product_scope,
         max(case
               when tag_id = 228 then
                cast(tag_value as decimal(38, 10))
             end) as nono_second_invest_amt_yearly,
         max(case
               when tag_id = 229 then
                cast(tag_value as string)
             end) as nono_second_invest_expect,
         max(case
               when tag_id = 70 then
                cast(tag_value as string)
             end) as nono_third_invest_time,
         max(case
               when tag_id = 71 then
                cast(tag_value as decimal(38, 10))
             end) as nono_third_invest_amt,
         max(case
               when tag_id = 72 then
                cast(tag_value as string)
             end) as nono_third_invest_product_scope,
         max(case
               when tag_id = 230 then
                cast(tag_value as decimal(38, 10))
             end) as nono_third_invest_amt_yearly,
         max(case
               when tag_id = 231 then
                cast(tag_value as string)
             end) as nono_third_invest_expect,
         max(case
               when tag_id = 73 then
                cast(tag_value as string)
             end) as nono_last_invest_time,
         max(case
               when tag_id = 74 then
                cast(tag_value as decimal(38, 10))
             end) as nono_last_invest_amt,
         max(case
               when tag_id = 75 then
                cast(tag_value as string)
             end) as nono_last_invest_product_scope,
         max(case
               when tag_id = 232 then
                cast(tag_value as decimal(38, 10))
             end) as nono_last_invest_amt_yearly,
         max(case
               when tag_id = 233 then
                cast(tag_value as string)
             end) as nono_last_invest_expect,
         max(case
               when tag_id = 76 then
                cast(tag_value as string)
             end) as nono_last_cash_time,
         max(case
               when tag_id = 119 then
                cast(tag_value as decimal(38, 10))
             end) as nono_last_cash_principal_amt,
         max(case
               when tag_id = 77 then
                cast(tag_value as decimal(38, 10))
             end) as nono_last_cash_amt,
         max(case
               when tag_id = 78 then
                cast(tag_value as string)
             end) as nono_last_cash_product_scope,
         max(case
               when tag_id = 219 then
                cast(tag_value as bigint)
             end) as nono_last_cash_fp_id,
         max(case
               when tag_id = 79 then
                cast(tag_value as decimal(38, 10))
             end) as nono_aum,
         max(case
               when tag_id = 80 then
                cast(tag_value as decimal(38, 10))
             end) as nono_max_aum,
         max(case
               when tag_id = 81 then
                cast(tag_value as string)
             end) as nono_max_aum_date,
         max(case
               when tag_id = 84 then
                cast(tag_value as int)
             end) as nono_last_30_days_invest_cnt,
         max(case
               when tag_id = 85 then
                cast(tag_value as int)
             end) as nono_invest_cnt,
         max(case
               when tag_id = 183 then
                cast(tag_value as decimal(38, 10))
             end) as nono_total_invest_amt,
         max(case
               when tag_id = 221 then
                cast(tag_value as decimal(38, 10))
             end) as nono_total_invest_amt_yearly,
         max(case
               when tag_id = 234 then
                cast(tag_value as int)
             end) as nono_total_plan_invest_cnt,
         max(case
               when tag_id = 235 then
                cast(tag_value as decimal(38, 10))
             end) as nono_total_plan_invest_amt,
         max(case
               when tag_id = 236 then
                cast(tag_value as decimal(38, 10))
             end) as nono_total_plan_invest_amt_yearly,
         max(case
               when tag_id = 237 then
                cast(tag_value as decimal(38, 10))
             end) as nono_in_invest_amt,
         max(case
               when tag_id = 238 then
                cast(tag_value as decimal(38, 10))
             end) as nono_max_in_invest_amt,
         max(case
               when tag_id = 239 then
                cast(tag_value as string)
             end) as nono_max_in_invest_amt_date,
         max(case
               when tag_id = 251 then
                cast(tag_value as string)
             end) as nono_last_withdraw_time,
         max(case
               when tag_id = 252 then
                cast(tag_value as decimal(38, 10))
             end) as nono_last_withdraw_amt,
         max(case
               when tag_id = 249 then
                cast(tag_value as int)
             end) as nono_last_90_days_withdraw_cnt,
         max(case
               when tag_id = 250 then
                cast(tag_value as decimal(38, 10))
             end) as nono_last_90_days_withdraw_amt,
         max(case
               when tag_id = 176 then
                cast(tag_value as decimal(38, 10))
             end) as nono_7days_recharge_amt,
         max(case
               when tag_id = 177 then
                cast(tag_value as decimal(38, 10))
             end) as nono_7days_withdraw_amt,
         max(case
               when tag_id = 178 then
                cast(tag_value as decimal(38, 10))
             end) as nono_7days_eta_amt,
         max(case
               when tag_id = 92 then
                cast(tag_value as int)
             end) as nono_last_30_days_login_cnt,
         max(case
               when tag_id = 93 then
                cast(tag_value as int)
             end) as nono_last_60_days_login_cnt,
         max(case
               when tag_id = 253 then
                cast(tag_value as string)
             end) as nono_user_lost_status,
         max(case
               when tag_id = 86 then
                cast(tag_value as int)
             end) as nono_prolocutor_invite_register_cnt,
             
         --nono_new_20180817
         max(case
               when tag_id = 299 then
                cast(tag_value as decimal(38,10))
             end) as NONO_AUM_YEARLY,
         max(case
               when tag_id = 300 then
                cast(tag_value as decimal(38,10))
             end) as NONO_MAX_AUM_YEAR,
         max(case
               when tag_id = 301 then
                cast(tag_value as int)
             end) as NONO_INVET_CNT_MONTH,
         max(case
               when tag_id = 304 then
                cast(tag_value as int)
             end) as NONO_BBS_ACTIVE_30,
         max(case
               when tag_id = 305 then
                cast(tag_value as int)
             end) as NONO_SHOP_ACTIVE_90,
         max(case
               when tag_id = 306 then
                cast(tag_value as int)
             end) as NONO_INVEST_ACTIVE_90,
         max(case
               when tag_id = 307 then
                cast(tag_value as int)
             end) as NONO_LOGIN_ACTIVE_30,
         max(case
               when tag_id = 309 then
                cast(tag_value as int)
             end) as NONO_LOGIN_INTERVAL,
         max(case
               when tag_id = 310 then
                cast(tag_value as int)
             end) as NONO_SIGN_M,
         max(case
               when tag_id = 311 then
                cast(tag_value as timestamp)
             end) as NONO_SIGN_LAST_TIME,
         max(case
               when tag_id = 312 then
                cast(tag_value as string)
             end) as NONO_NO_INVEST_REASON,
         max(case
               when tag_id = 313 then
                cast(tag_value as int)
             end) as NONO_TEL_CNT,
         max(case
               when tag_id = 314 then
                cast(tag_value as decimal(38,10))
             end) as NONO_LOST_RATIO,                
         max(case
               when tag_id = 315 then
                cast(tag_value as decimal(38,10))
             end) as NONO_INVEST_RATIO,
         max(case
               when tag_id = 316 then
                cast(tag_value as int)
             end) as NONO_LOST_RANK,
         max(case
               when tag_id = 317 then
                cast(tag_value as int)
             end) as NONO_BT_COUPON_CNT,
         max(case
               when tag_id = 318 then
                cast(tag_value as timestamp)
             end) as NONO_BT_COUPON_LOST_TIME,
         max(case
               when tag_id = 319 then
                cast(tag_value as int)
             end) as NONO_DY_COUPON_CNT,
         max(case
               when tag_id = 320 then
                cast(tag_value as timestamp)
             end) as NONO_DY_COUPON_LOST_TIME,
         max(case
               when tag_id = 321 then
                cast(tag_value as decimal(38,10))
             end) as NONO_CASH_PACKET_WAIT,
         max(case
               when tag_id = 322 then
                cast(tag_value as int)
             end) as NONO_MONEY,
                  max(case
               when tag_id = 323 then
                cast(tag_value as decimal(38,10))
             end) as NONO_TQBJ_WAIT_MONEY,
                  max(case
               when tag_id = 324 then
                cast(tag_value as decimal(38,10))
             end) as NONO_TQBJ_LOST_TIME,
                     
         --csyy             
         max(case
               when tag_id = 97 then
                cast(tag_value as string)
             end) as csyy_first_invest_time,
         max(case
               when tag_id = 98 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_first_invest_amt,
         max(case
               when tag_id = 99 then
                cast(tag_value as string)
             end) as csyy_first_invest_product_code,
         max(case
               when tag_id = 240 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_first_invest_amt_yearly,
         max(case
               when tag_id = 241 then
                cast(tag_value as string)
             end) as csyy_first_invest_expect,
         max(case
               when tag_id = 100 then
                cast(tag_value as string)
             end) as csyy_second_invest_time,
         max(case
               when tag_id = 101 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_second_invest_amt,
         max(case
               when tag_id = 102 then
                cast(tag_value as string)
             end) as csyy_second_invest_product_code,
         max(case
               when tag_id = 242 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_second_invest_amt_yearly,
         max(case
               when tag_id = 243 then
                cast(tag_value as string)
             end) as csyy_second_invest_expect,
         max(case
               when tag_id = 103 then
                cast(tag_value as string)
             end) as csyy_third_invest_time,
         max(case
               when tag_id = 104 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_third_invest_amt,
         max(case
               when tag_id = 105 then
                cast(tag_value as string)
             end) as csyy_third_invest_product_code,
         max(case
               when tag_id = 244 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_third_invest_amt_yearly,
         max(case
               when tag_id = 245 then
                cast(tag_value as string)
             end) as csyy_third_invest_expect,
         max(case
               when tag_id = 106 then
                cast(tag_value as string)
             end) as csyy_last_invest_time,
         max(case
               when tag_id = 107 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_last_invest_amt,
         max(case
               when tag_id = 108 then
                cast(tag_value as string)
             end) as csyy_last_invest_product_code,
         max(case
               when tag_id = 246 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_last_invest_amt_yearly,
         max(case
               when tag_id = 247 then
                cast(tag_value as string)
             end) as csyy_last_invest_expect,
         max(case
               when tag_id = 111 then
                cast(tag_value as string)
             end) as csyy_last_cash_time,
         max(case
               when tag_id = 118 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_last_cash_principal_amt,
         max(case
               when tag_id = 112 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_last_cash_amt,
         max(case
               when tag_id = 113 then
                cast(tag_value as string)
             end) as csyy_last_cash_product_code,
         max(case
               when tag_id = 114 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_aum,
         max(case
               when tag_id = 115 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_max_aum,
         max(case
               when tag_id = 116 then
                cast(tag_value as string)
             end) as csyy_max_aum_date,
         max(case
               when tag_id = 109 then
                cast(tag_value as int)
             end) as csyy_last_30_days_invest_cnt,
         max(case
               when tag_id = 110 then
                cast(tag_value as int)
             end) as csyy_invest_cnt,
         max(case
               when tag_id = 184 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_total_invest_amt,
         max(case
               when tag_id = 248 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_total_invest_amt_yearly,
         max(case
               when tag_id = 117 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_balance_amt,
         max(case
               when tag_id = 129 then
                cast(tag_value as bigint)
             end) as csyy_invite_user_id,
         max(case
               when tag_id = 174 then
                cast(tag_value as int)
             end) as csyy_channel_id,
         max(case
               when tag_id = 175 then
                cast(tag_value as string)
             end) as csyy_channel_name,
         max(case
               when tag_id = 179 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_7days_recharge_amt,
         max(case
               when tag_id = 180 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_7days_withdraw_amt,
         max(case
               when tag_id = 181 then
                cast(tag_value as decimal(38, 10))
             end) as csyy_7days_eta_amt,
         date_sub(current_date(), 1) stat_date
    from idw.user_tag_hist
   where tag_id in (64,
                    65,
                    66,
                    226,
                    227,
                    67,
                    68,
                    69,
                    228,
                    229,
                    70,
                    71,
                    72,
                    230,
                    231,
                    73,
                    74,
                    75,
                    232,
                    233,
                    76,
                    119,
                    77,
                    78,
                    219,
                    79,
                    80,
                    81,
                    84,
                    85,
                    183,
                    221,
                    234,
                    235,
                    236,
                    237,
                    238,
                    239,
                    251,
                    252,
                    249,
                    250,
                    176,
                    177,
                    178,
                    92,
                    93,
                    253,
                    86,
                    97,
                    98,
                    99,
                    240,
                    241,
                    100,
                    101,
                    102,
                    242,
                    243,
                    103,
                    104,
                    105,
                    244,
                    245,
                    106,
                    107,
                    108,
                    246,
                    247,
                    111,
                    118,
                    112,
                    113,
                    114,
                    115,
                    116,
                    109,
                    110,
                    184,
                    248,
                    117,
                    129,
                    174,
                    175,
                    179,
                    180,
                    181,
                    299,
                    300,
                    301,
                    304,
                    305,
                    306,
                    307,
                    309,
                    310,
                    311,
                    312,
                    313,
                    314,
                    315,
                    316,
                    317,
                    318,
                    319,
                    320,
                    321,
                    322,
                    323,
                    324)
     and user_id > 0
   group by user_id;