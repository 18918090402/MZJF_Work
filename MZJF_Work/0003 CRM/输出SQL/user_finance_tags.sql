select 
t1.user_id 
,t1.register_biz 
,t1.nono_total_invest_amt 
,t1.nono_total_invest_amt_yearly 
,t1.nono_invest_cnt 
,t1.nono_aum 
,t3.nono_aum_yearly 
,t1.nono_max_aum 
,t3.nono_max_aum_year 
,t3.nono_invet_cnt_month 
,t1.nono_last_invest_time 
,t1.csyy_aum 
,t1.nono_prolocutor_invite_register_cnt 
,t2.nono_prolocutor_invite_amt 
,t2.nono_prolocutor_invite_last_time 
,t1.nono_balance_amt 
,t3.nono_bbs_active_30 
,t3.nono_shop_active_90 
,t3.nono_invest_active_90 
,t3.nono_login_active_30 
,t1.last_login_time 
,t3.nono_login_interval 
,t3.nono_sign_m 
,t3.nono_sign_last_time 
,t3.nono_lost_ratio 
,t3.nono_invest_ratio 
,t3.nono_lost_rank 
,t1.nono_last_recharge_time 
,t1.nono_last_withdraw_time 
,t3.nono_no_invest_reason 
,t3.nono_tel_cnt 
,t3.nono_bt_coupon_cnt 
,t3.nono_bt_coupon_lost_time 
,t3.nono_dy_coupon_cnt 
,t3.nono_dy_coupon_lost_time 
,t3.nono_cash_packet_wait 
,t3.nono_money 
,t3.nono_tqbj_wait_money 
,t3.nono_tqbj_lost_time 
from idw.dim_user t1 
left join ( select a.recommender as user_id 
,sum(a.nono_total_invest_amt) as nono_prolocutor_invite_amt 
,max(a.register_time) as nono_prolocutor_invite_last_time 
from idw.dim_user a where a.recommender is not null 
group by a.recommender ) t2 on t1.user_id = t2.user_id 
left join idw.user_tag_finance t3 on t1.user_id = t3.user_id and t3.stat_date = \'{T_SUB_1}\'
where register_biz = "nono" 
limit 10240 
