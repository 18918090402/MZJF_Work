--创建角色
create role r_platform;


--角色和组的关系 
GRANT ROLE r_sys      TO GROUP hive ;
GRANT ROLE r_special  TO GROUP g_special ;
GRANT ROLE r_public   TO GROUP g_borrow , group g_finance, group g_hr, group g_invest, group g_legal, group g_president, group g_risk ;
GRANT ROLE r_admin    TO GROUP g_admin ;
GRANT ROLE r_analysis TO GROUP g_analysis ;
GRANT ROLE r_borrow   TO GROUP g_borrow ;
GRANT ROLE r_risk     TO GROUP g_risk ;
GRANT ROLE r_invest   TO GROUP g_invest ;
GRANT ROLE r_tech     TO GROUP g_tech ;
GRANT ROLE r_odsopr   to group g_admin, group g_analysis;
grant role r_finance  to group g_finance;
GRANT ROLE r_platform to group g_admin;


show role grant group g_admin;

--r_platform

grant all on database ods to role r_platform;
grant all on database tmp to role r_platform;

revoke all on database tmp from role r_platform;


--r_sys                 ok

--r_public              ok
grant select on idw.dim_user_hist_all to role r_public;

--r_special
GRANT select ON SERVER server1 TO ROLE r_special WITH GRANT OPTION;

--r_finance
GRANT select ON odsopr.finance_log_all TO ROLE r_finance;

--r_admin
grant all on database cgp3 to ROLE r_admin WITH GRANT OPTION;
grant all on database data_operation to ROLE r_admin WITH GRANT OPTION;
grant all on database default to ROLE r_admin WITH GRANT OPTION;
grant all on database dim to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_bf to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_bld to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_crm to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_cs to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_csyy to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_fd to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_hbase to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_hr to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_im to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_maiya to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_mxd to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_mzjk to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_rm to ROLE r_admin WITH GRANT OPTION;
grant all on database dmt_unifi to ROLE r_admin WITH GRANT OPTION;
grant all on database dmtopr to ROLE r_admin WITH GRANT OPTION;
grant all on database dwd to ROLE r_admin WITH GRANT OPTION;
grant all on database dws to ROLE r_admin WITH GRANT OPTION;
grant all on database idw to ROLE r_admin WITH GRANT OPTION;
grant all on database idwopr to ROLE r_admin WITH GRANT OPTION;
grant all on database kudu to ROLE r_admin WITH GRANT OPTION;
grant all on database kylin to ROLE r_admin WITH GRANT OPTION;
grant all on database log to ROLE r_admin WITH GRANT OPTION;
grant all on database msc to ROLE r_admin WITH GRANT OPTION;
grant all on database msci to ROLE r_admin WITH GRANT OPTION;
grant all on database odsopr to ROLE r_admin WITH GRANT OPTION;
grant all on database pdw to ROLE r_admin WITH GRANT OPTION;
grant all on database rpt to ROLE r_admin WITH GRANT OPTION;
grant all on database rt to ROLE r_admin WITH GRANT OPTION;
grant all on database scd_ods to ROLE r_admin WITH GRANT OPTION;
grant all on database scd_odsopr to ROLE r_admin WITH GRANT OPTION;
grant all on database sdr to ROLE r_admin WITH GRANT OPTION;
grant all on database test_zyy to ROLE r_admin WITH GRANT OPTION;
grant all on database tpcds_bin_partitioned_orc_100 to ROLE r_admin WITH GRANT OPTION;
grant all on database tpcds_bin_partitioned_parquet_100 to ROLE r_admin WITH GRANT OPTION;
grant all on database tpcds_text_100 to ROLE r_admin WITH GRANT OPTION;
grant all on database yimei to ROLE r_admin WITH GRANT OPTION;

revoke all on database ods from ROLE r_admin;

--r_analysis            
grant select on database cgp3 to ROLE r_analysis WITH GRANT OPTION;
grant select on database data_operation to ROLE r_analysis WITH GRANT OPTION;
grant select on database default to ROLE r_analysis WITH GRANT OPTION;
grant select on database dim to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_bf to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_bld to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_crm to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_cs to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_csyy to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_fd to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_hbase to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_hr to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_im to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_maiya to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_mxd to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_mzjk to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_rm to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmt_unifi to ROLE r_analysis WITH GRANT OPTION;
grant select on database dmtopr to ROLE r_analysis WITH GRANT OPTION;
grant select on database dwd to ROLE r_analysis WITH GRANT OPTION;
grant select on database dws to ROLE r_analysis WITH GRANT OPTION;
grant select on database idw to ROLE r_analysis WITH GRANT OPTION;
grant select on database idwopr to ROLE r_analysis WITH GRANT OPTION;
grant select on database kudu to ROLE r_analysis WITH GRANT OPTION;
grant select on database kylin to ROLE r_analysis WITH GRANT OPTION;
grant select on database log to ROLE r_analysis WITH GRANT OPTION;
grant all on database msc to ROLE r_analysis WITH GRANT OPTION;
grant select on database msci to ROLE r_analysis WITH GRANT OPTION;
grant select on database odsopr to ROLE r_analysis WITH GRANT OPTION;
grant select on database pdw to ROLE r_analysis WITH GRANT OPTION;
grant select on database rpt to ROLE r_analysis WITH GRANT OPTION;
grant select on database rt to ROLE r_analysis WITH GRANT OPTION;
grant select on database scd_ods to ROLE r_analysis WITH GRANT OPTION;
grant select on database scd_odsopr to ROLE r_analysis WITH GRANT OPTION;
grant select on database sdr to ROLE r_analysis WITH GRANT OPTION;
grant select on database test_zyy to ROLE r_analysis WITH GRANT OPTION;
grant select on database tpcds_bin_partitioned_orc_100 to ROLE r_analysis WITH GRANT OPTION;
grant select on database tpcds_bin_partitioned_parquet_100 to ROLE r_analysis WITH GRANT OPTION;
grant select on database tpcds_text_100 to ROLE r_analysis WITH GRANT OPTION;
grant select on database yimei to ROLE r_analysis WITH GRANT OPTION;

revoke select on database dmt_bf from ROLE r_analysis;
revoke select on database dmt_bld from ROLE r_analysis;
revoke select on database dmt_crm from ROLE r_analysis;
revoke select on database dmt_cs from ROLE r_analysis;
revoke select on database dmt_csyy from ROLE r_analysis;
revoke select on database dmt_fd from ROLE r_analysis;
revoke select on database dmt_hbase from ROLE r_analysis;
revoke select on database dmt_hr from ROLE r_analysis;
revoke select on database dmt_im from ROLE r_analysis;
revoke select on database dmt_maiya from ROLE r_analysis;
revoke select on database dmt_mxd from ROLE r_analysis;
revoke select on database dmt_mzjk from ROLE r_analysis;
revoke select on database dmt_rm from ROLE r_analysis;
revoke select on database dmt_unifi from ROLE r_analysis;
revoke select on database scd_ods from ROLE r_analysis;
revoke select on database scd_odsopr from ROLE r_analysis;
revoke select on database sdr from ROLE r_analysis;
revoke select on database test_zyy from ROLE r_analysis;
revoke select on database tpcds_bin_partitioned_orc_100 from ROLE r_analysis;
revoke select on database tpcds_bin_partitioned_parquet_100 from ROLE r_analysis;
revoke select on database tpcds_text_100 from ROLE r_analysis;
revoke select on database yimei from ROLE r_analysis;

revoke select on database dws from ROLE r_analysis;
revoke select on database msci from ROLE r_analysis;
revoke select on database pdw from ROLE r_analysis;
revoke select on database dwd from ROLE r_analysis;
revoke select on database cgp3 from ROLE r_analysis;
revoke select on database data_operation from ROLE r_analysis;
revoke select on database kylin from ROLE r_analysis;
revoke select on database kudu from ROLE r_analysis;
revoke select on database log from ROLE r_analysis;


--r_borrow              
grant select on idw.dim_asset_product TO ROLE r_borrow ;
grant select on idw.fact_borrows TO ROLE r_borrow ;
grant select on idw.fact_borrows_audit TO ROLE r_borrow ;
grant select on idw.fact_borrows_dunning TO ROLE r_borrow ;
grant select on idw.fact_borrows_prepare TO ROLE r_borrow ;
grant select on idw.fact_borrows_repayment TO ROLE r_borrow ;
grant select on idw.fact_in_repay_borrows_snapshot TO ROLE r_borrow ;
grant select on idw.fact_in_repay_borrows_snapshot_h6 TO ROLE r_borrow ;
grant select on idw.fact_maiya_order TO ROLE r_borrow ;
grant select on idw.fact_maiya_user_info TO ROLE r_borrow ;
grant select on idw.fact_month_repay_stat_daily TO ROLE r_borrow ;
grant select on idw.fact_repayed_borrows_stat TO ROLE r_borrow ;
grant select on idw.maiya_user_info TO ROLE r_borrow ;
grant select on odsopr.web_log TO ROLE r_borrow ;
grant select on msc.ssbi_holliday_date TO ROLE r_borrow ;
grant select on msc.ssbi_cycle_loan_user TO ROLE r_borrow ;
grant select on msc.v_user_edu_record TO ROLE r_borrow ;
grant select on msc.ssbi_market_settle TO ROLE r_borrow ;
grant select on msc.mz_reg_resource_market TO ROLE r_borrow ;
grant select on msc.ssbi_wp TO ROLE r_borrow ;
grant select on msc.ssbi_wp_risk_info TO ROLE r_borrow ;
grant select on msc.ssbi_market_member TO ROLE r_borrow ;
grant select on msc.ssbi_market_wp TO ROLE r_borrow ;
grant select on msc.ssbi_member_risk_info TO ROLE r_borrow ;
grant select on msc.ssbi_member TO ROLE r_borrow ;
grant select on msc.v_user_edu_record4 TO ROLE r_borrow ;


grant select on idw.fact_hor_data TO ROLE r_borrow ;
grant select on idw.fact_rm_des_main TO ROLE r_borrow ;
grant select on msc.ssbi_holliday_date TO ROLE r_borrow ;
grant select on msc.ssbi_cycle_loan_user TO ROLE r_borrow ;
grant select on msc.v_user_edu_record TO ROLE r_borrow ;
grant select on msc.ssbi_market_settle TO ROLE r_borrow ;
grant select on msc.mz_reg_resource_market TO ROLE r_borrow ;
grant select on msc.ssbi_wp TO ROLE r_borrow ;
grant select on msc.ssbi_wp_risk_info TO ROLE r_borrow ;
grant select on msc.ssbi_market_member TO ROLE r_borrow ;
grant select on msc.ssbi_market_wp TO ROLE r_borrow ;
grant select on msc.ssbi_member_risk_info TO ROLE r_borrow ;
grant select on msc.v_user_edu_record4 TO ROLE r_borrow ;
grant select on odsopr.reg_resource_market TO ROLE r_borrow ;
grant select on odsopr.des_dcin TO ROLE r_borrow ;
grant select on odsopr.des_main TO ROLE r_borrow ;
grant select on odsopr.user_gxb_auth_log TO ROLE r_borrow ;
grant select on odsopr.borrows_repayment TO ROLE r_borrow ;
grant select on odsopr.borrows_credit_amount TO ROLE r_borrow ;
grant select on odsopr.borrows_lightning_credit_amount TO ROLE r_borrow ;
grant select on odsopr.channel TO ROLE r_borrow ;
grant select on odsopr.borrows_archive TO ROLE r_borrow ;
grant select on odsopr.des_access_dcin TO ROLE r_borrow ;
grant select on odsopr.user_student_info TO ROLE r_borrow ;
grant select on odsopr.user_edu_auth_log TO ROLE r_borrow ;
grant select on odsopr.infra_sms_sms_send_content TO ROLE r_borrow ;
grant select on odsopr.infra_sms_sms_channel_info_new TO ROLE r_borrow ;
grant select on odsopr.borrows TO ROLE r_borrow ;
grant select on odsopr.user_work_info TO ROLE r_borrow ;
grant select on odsopr.credit_user_htsb_info TO ROLE r_borrow ;
grant select on odsopr.borrows_consulted_fee TO ROLE r_borrow ;
grant select on odsopr.borrows_raise TO ROLE r_borrow ;
grant select on odsopr.user_house_fund_auth_log TO ROLE r_borrow ;
grant select on odsopr.des_user_credit TO ROLE r_borrow ;
grant select on odsopr.borrows_external_mapping TO ROLE r_borrow ;
grant select on odsopr.borrows_prepare TO ROLE r_borrow ;
grant select on odsopr.app_log_final TO ROLE r_borrow ;
grant select on odsopr.hor_req_third_record TO ROLE r_borrow ;
grant select on odsopr.hor_third_channel TO ROLE r_borrow ;
grant select on odsopr.admin_work_remark TO ROLE r_borrow ;
grant select on msc.ssbi_member TO ROLE r_borrow ;

grant insert on msc.ssbi_market_settle TO ROLE r_borrow ;
grant insert on msc.mz_reg_resource_market TO ROLE r_borrow ;
grant insert on msc.ssbi_wp TO ROLE r_borrow ;
grant insert on msc.ssbi_wp_risk_info TO ROLE r_borrow ;
grant insert on msc.ssbi_member_risk_info TO ROLE r_borrow ;
grant insert on msc.ssbi_member TO ROLE r_borrow ;

grant select on odsopr.products TO ROLE r_borrow ;
grant select on odsopr.ord_order TO ROLE r_borrow ;

grant select,insert on msc.ssbi_marketing_user_list TO ROLE r_borrow ;


grant select on odsopr.borrows_accept TO ROLE r_borrow ;
grant select on odsopr.debt_exchange_account TO ROLE r_borrow ;
grant select on odsopr.vip_account TO ROLE r_borrow ;
grant select on odsopr.trans_repayment_info TO ROLE r_borrow ;
grant select on odsopr.trans_repayment_order TO ROLE r_borrow ;
grant select on odsopr.ord_order_check_history TO ROLE r_borrow ;
grant select on odsopr.region TO ROLE r_borrow ;
grant select on odsopr.sys_dic_item TO ROLE r_borrow ;
grant select on odsopr.ord_order_extend TO ROLE r_borrow ;


grant select on idw.fact_user_phone_book TO ROLE r_borrow ;
grant select on odsopr.user_login_detail_log_new TO ROLE r_borrow ;
grant select on odsopr.black_gray_list TO ROLE r_borrow ;
grant select on odsopr.borrows_dunning_contact TO ROLE r_borrow ;
grant select on odsopr.user_contact_info_new TO ROLE r_borrow ;
grant select on odsopr.user_pengyuan_edu_record TO ROLE r_borrow ;
grant select on odsopr.user_mobile_online TO ROLE r_borrow ;
grant select on odsopr.infra_sms_sms_message_log TO ROLE r_borrow ;
grant select on odsopr.system_sms_log TO ROLE r_borrow ;
grant select on odsopr.user_bankcard_auth TO ROLE r_borrow ;
grant select on odsopr.user_shebao_auth_log TO ROLE r_borrow ;
grant select on odsopr.user_idcard_audit_online_log TO ROLE r_borrow ;
grant select on odsopr.tb_p2p_record_recharge TO ROLE r_borrow ;
grant select on odsopr.sop_shop_face TO ROLE r_borrow ;
grant select on odsopr.sop_shop TO ROLE r_borrow ;
grant select on odsopr.ord_user_detail TO ROLE r_borrow ;
grant select on odsopr.user_info TO ROLE r_borrow ;
grant select on odsopr.ord_user TO ROLE r_borrow ;


grant select on idw.fact_rm_user_credit TO ROLE r_borrow ;

grant select on msc.v_user_edu_record5 TO ROLE r_borrow ;

grant select on odsopr.user_book_info to  ROLE r_borrow ;

grant select on odsopr.user_invite_relation_info to role r_borrow ;

grant select on odsopr.borrows_credit_amount_assess_log to role r_borrow ;
grant select on odsopr.des_access_dcin_detail to role r_borrow ;

--r_risk                
grant select on idw.dim_des_main TO ROLE r_risk; 
grant select on idw.fact_baiqishi_hor_data TO ROLE r_risk;  --已回收
grant select on idw.fact_bo_user_hor TO ROLE r_risk;
grant select on idw.fact_education_hor_data TO ROLE r_risk; --已回收
grant select on idw.fact_emay_hor_data TO ROLE r_risk;  --已回收
grant select on idw.fact_fushu_hor_data TO ROLE r_risk; --已回收
grant select on idw.fact_hor_data TO ROLE r_risk;
grant select on idw.fact_mld_order_credit TO ROLE r_risk;
grant select on idw.fact_rm_des_main TO ROLE r_risk;
grant select on idw.fact_rm_user_credit TO ROLE r_risk;
grant select on idw.fact_tungdun_hor_data TO ROLE r_risk; --已回收
grant select on idw.fact_zzc_blacklist_hor_data TO ROLE r_risk; --已回收

revoke select on idw.fact_zzc_blacklist_hor_data from ROLE r_risk;
revoke select on idw.fact_tungdun_hor_data from ROLE r_risk;
revoke select on idw.fact_fushu_hor_data from ROLE r_risk;
revoke select on idw.fact_emay_hor_data from ROLE r_risk;

grant select on database dmt_rm to ROLE r_risk;   --已回收


grant select on dmt_rm.des_main_data to ROLE r_risk;
grant select on dmt_rm.fact_approval_mxdmy_data to ROLE r_risk;
grant select on dmt_rm.fact_bld_hor_static to ROLE r_risk;
grant select on dmt_rm.fact_credit_data_mxdmy to ROLE r_risk;
grant select on dmt_rm.fact_hor_data_third_stats to ROLE r_risk;
grant select on dmt_rm.fact_loan_after_static_daily to ROLE r_risk;
grant select on dmt_rm.fact_maiya_hor_static to ROLE r_risk;
grant select on dmt_rm.fact_maiya_order_hor_static to ROLE r_risk;
grant select on dmt_rm.fact_mld_hor_static to ROLE r_risk;
grant select on dmt_rm.fact_shop_face_data to ROLE r_risk;
grant select on dmt_rm.fact_user_contact to ROLE r_risk;
grant select on dmt_rm.shop_loan_data to ROLE r_risk;
grant select on odsopr.app_log_final to ROLE r_risk;
grant select on odsopr.borrows_credit_amount to ROLE r_risk;



--r_invest              
grant select on idw.dim_csyy_product TO ROLE r_invest;
grant select on idw.dim_nono_product TO ROLE r_invest;
grant select on idw.fact_biz_csyy_aum TO ROLE r_invest;
grant select on idw.fact_biz_csyy_invest TO ROLE r_invest;
grant select on idw.fact_biz_csyy_invest_cash TO ROLE r_invest;
grant select on idw.fact_biz_csyy_recharge TO ROLE r_invest;
grant select on idw.fact_biz_csyy_withdraw TO ROLE r_invest;
grant select on idw.fact_biz_nono_aum TO ROLE r_invest;
grant select on idw.fact_biz_nono_invest TO ROLE r_invest;
grant select on idw.fact_biz_nono_invest_cash TO ROLE r_invest;
grant select on idw.fact_biz_nono_recharge TO ROLE r_invest;
grant select on idw.fact_biz_nono_withdraw TO ROLE r_invest;
grant select on idw.fact_csyy_aum_detail_snapshot TO ROLE r_invest;
grant select on idw.fact_csyy_aum_snapshot TO ROLE r_invest;
grant select on idw.fact_csyy_invest_cash TO ROLE r_invest;
grant select on idw.fact_csyy_invest_order TO ROLE r_invest;
grant select on idw.fact_csyy_recharge TO ROLE r_invest;
grant select on idw.fact_csyy_user_cash_stat_daily TO ROLE r_invest;
grant select on idw.fact_csyy_user_in_invest_stat_daily TO ROLE r_invest;
grant select on idw.fact_csyy_user_invest_stat_daily TO ROLE r_invest;
grant select on idw.fact_csyy_user_stat_daily TO ROLE r_invest;
grant select on idw.fact_csyy_withdraw TO ROLE r_invest;
grant select on idw.fact_nono_aum_detail_snapshot TO ROLE r_invest;
grant select on idw.fact_nono_aum_snapshot TO ROLE r_invest;
grant select on idw.fact_nono_invest_cash TO ROLE r_invest;
grant select on idw.fact_nono_invest_order TO ROLE r_invest;
grant select on idw.fact_nono_recharge TO ROLE r_invest;
grant select on idw.fact_nono_user_cash_stat_daily TO ROLE r_invest;
grant select on idw.fact_nono_user_cost TO ROLE r_invest;
grant select on idw.fact_nono_user_in_invest_stat_daily TO ROLE r_invest;
grant select on idw.fact_nono_user_invest_stat_daily TO ROLE r_invest;
grant select on idw.fact_nono_user_stat_daily TO ROLE r_invest;
grant select on idw.fact_nono_withdraw TO ROLE r_invest;
grant select on idw.fact_reinvest_red_packet TO ROLE r_invest;
grant select on idw.fact_reinvest_set_log TO ROLE r_invest;
grant select on idw.fact_reinvest_set_snapshot TO ROLE r_invest;

grant select on odsopr.user_buy_product TO ROLE r_invest;
grant select on odsopr.finance_plan TO ROLE r_invest;
grant select on odsopr.user_account_trade_log TO ROLE r_invest;
grant select on odsopr.invite_relations TO ROLE r_invest;
grant select on odsopr.user_crm_info TO ROLE r_invest;
grant select on odsopr.mobile_site TO ROLE r_invest;
grant select on odsopr.user_reward_card TO ROLE r_invest;
grant select on odsopr.reward_define TO ROLE r_invest;
grant select on odsopr.activity_user_detail TO ROLE r_invest;
grant select on odsopr.reward_type_define TO ROLE r_invest;
grant select on odsopr.csyy_sycee_user_point TO ROLE r_invest;
grant select on odsopr.csyy_sycee_user_product_detail TO ROLE r_invest;
grant select on odsopr.csyy_sycee_point_approach TO ROLE r_invest;
grant select on odsopr.ads_channel TO ROLE r_invest;
grant select on odsopr.ads_channel_cost TO ROLE r_invest;
grant select on odsopr.user_approach TO ROLE r_invest;
grant select on odsopr.approach_define TO ROLE r_invest;
grant select on odsopr.user_product TO ROLE r_invest;
grant select on odsopr.user_roulette_log TO ROLE r_invest;
grant select on odsopr.activity_info TO ROLE r_invest;
grant select on odsopr.user_account_trans_log TO ROLE r_invest;
grant select on odsopr.product_exchange_order_info TO ROLE r_invest;
grant select on odsopr.withdraw_reward TO ROLE r_invest;
grant select on odsopr.gb_user_account_log   TO ROLE r_invest;
grant select on odsopr.cunguan_interest_addition TO ROLE r_invest;
grant select on odsopr.jc_user_answer_log TO ROLE r_invest;
grant select on odsopr.jc_question  TO ROLE r_invest;
grant select on odsopr.jc_answer   TO ROLE r_invest;
grant select on odsopr.user_havest_record TO ROLE r_invest;
grant select on odsopr.activity_havest_prize TO ROLE r_invest;
grant select on idw.fact_csyy_sycee_user_point_snapshot TO ROLE r_invest;
grant select on odsopr.mkt_experience_cash TO ROLE r_invest;
grant select on odsopr.mkt_experience_cash_type TO ROLE r_invest;
grant select on odsopr.coin_log TO ROLE r_invest;
grant select on odsopr.activity_vip_physicalgoods_info TO ROLE r_invest;
grant select on odsopr.activity_vip TO ROLE r_invest;
grant select on odsopr.activity_point_log TO ROLE r_invest;
grant select on odsopr.activity_prize_gain_list TO ROLE r_invest;
grant select on DMT_BF.NONO_PROLOCUTOR_EARNINGS_DETAIL  TO ROLE r_invest;

grant select on odsopr.coin_type TO ROLE r_invest;
grant select on odsopr.activity_vip_physicalgoods TO ROLE r_invest;
grant select on odsopr.region TO ROLE r_invest;
grant select on odsopr.user_level TO ROLE r_invest;
grant select on odsopr.invt_va_reinvest_task TO ROLE r_invest;
grant select on odsopr.vip_form TO ROLE r_invest;
grant select on odsopr.vip_account TO ROLE r_invest;

grant select on odsopr.dim_special_user_config TO ROLE r_invest;
grant select on odsopr.admin TO ROLE r_invest;
grant select on odsopr.account_relation TO ROLE r_invest;
grant select on odsopr.user TO ROLE r_invest;
grant select on odsopr.user_detail TO ROLE r_invest;

grant select on odsopr.db_nono_user_coupon TO ROLE r_invest;
grant select on odsopr.user_logon_info TO ROLE r_invest;
grant select on odsopr.invt_custom_trans_info to role r_invest;

grant select on odsopr.welfare_privilege_code_x to role r_invest ;


grant select on odsopr.raffle_reward_config to role r_invest ;
grant select on odsopr.raffle_user_record to role r_invest ;
grant select on odsopr.debt_buy_log to role r_invest ;
grant select on odsopr.activity_reward to role r_invest ;


grant select on odsopr.mkt_raffle_Log to role r_invest ;


grant select on odsopr.acc_p2p to role r_invest ;
grant select on odsopr.user_reward_task to role r_invest ;
grant select on odsopr.finance_log to role r_invest ;
grant select on odsopr.finance_plan_scope to role r_invest ;
grant select on odsopr.coupon_use to role r_invest ;
grant select on odsopr.trans_detail to role r_invest ;
grant select on odsopr.user_interest to role r_invest ;
grant select on odsopr.gb_reward_define to role r_invest ;
grant select on odsopr.user_prize_record_x to role r_invest ;
grant select on odsopr.activity_prize to role r_invest ;
grant select on odsopr.user_approach_info to role r_invest ;



--r_tech                ok
grant select on odsopr.debt_exchange_account TO ROLE r_tech;
grant select on odsopr.debt_buy_log TO ROLE r_tech;
grant select on odsopr.borrows_accept TO ROLE r_tech;
grant select on odsopr.debt_sale TO ROLE r_tech;
grant select on odsopr.borrows_bidding TO ROLE r_tech;
grant select on odsopr.invt_borrows_accept_paid TO ROLE r_tech;
grant select on odsopr.invt_borrows_accept_unpaid TO ROLE r_tech;
grant select on odsopr.invt_borrows_accept_zero TO ROLE r_tech;
grant select on odsopr.finance_log_all TO ROLE r_tech;

grant select on odsopr.borrows TO ROLE r_tech;
grant select on odsopr.borrows_prepare TO ROLE r_tech;
grant select on odsopr.borrows_repayment TO ROLE r_tech;
grant select on odsopr.vip_account TO ROLE r_tech;
grant select on odsopr.vip_form TO ROLE r_tech;
grant select on odsopr.finance_account TO ROLE r_tech;
grant select on odsopr.finance_plan TO ROLE r_tech;




