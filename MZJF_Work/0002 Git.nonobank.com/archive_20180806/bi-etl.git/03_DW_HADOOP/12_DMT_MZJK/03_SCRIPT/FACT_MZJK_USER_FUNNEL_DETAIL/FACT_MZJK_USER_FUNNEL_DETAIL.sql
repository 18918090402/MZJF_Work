set mapreduce.job.name = dmt_mzjk_fact_mzjk_user_funnel_detail_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table DMT_MZJK.FACT_MZJK_USER_FUNNEL_DETAIL partition
  (REGISTER_MONTH)
  select 'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         ui.id user_id,
         ui.register_time,
         zm.first_zhima_auth_time,
         uc.first_wide_pass_time,
         uc.first_zhima_focus_pass_time,
         edu.first_edu_auth_time,
         uc.first_narrow_pass_time,
         rc.first_received_credit_time,
         bp.first_apply_time,
         bo.first_ml_time,
         bo.first_confirm_time,
         bo.first_loan_success_time,
         from_unixtime(unix_timestamp(ui.register_time,
                                      'yyyy-MM-dd HH:mm:ss'),
                       'yyyy-MM') register_month
    from ods.t_user_info_hist ui
    left join (select user_id, min(auth_time) first_zhima_auth_time
                 from ods.t_user_zhima_auth_log_hist
                where auth_status = 1
                group by user_id) zm
      on ui.id = zm.user_id
    left join (select user_id,
                      min(case
                            when data_no in
                                 ('111wideAccessDcin', '110wideAccessDcin') and
                                 data_value = '1' then
                             create_time
                          end) first_wide_pass_time,
                      min(case
                            when data_no in ('zhimaFocusDcin') and
                                 data_value = '1' then
                             create_time
                          end) first_zhima_focus_pass_time,
                      min(case
                            when data_no in
                                 ('111narrowAccessDcin', '110narrowAccessDcin') and
                                 data_value = '1' then
                             create_time
                          end) first_narrow_pass_time
                 from ods.t_des_user_credit_hist
                group by user_id) uc
      on ui.id = uc.user_id
    left join (select user_id, min(auth_time) first_edu_auth_time
                 from ods.t_user_edu_auth_log_hist
                where auth_status = 1
                group by user_id) edu
      on ui.id = edu.user_id
    left join (select user_id, min(create_time) first_received_credit_time
                 from (select user_id, create_time
                         from ods.t_borrows_credit_amount_hist
                        where is_delete = 0
                          and total_amount > 0
                       union all
                       select user_id, create_time
                         from ods.t_borrows_lightning_credit_amount_hist
                        where is_delete = 0
                          and amount > 0) s
                group by user_id) rc
      on ui.id = rc.user_id
    left join (select user_id, min(bp_publish_time) first_apply_time
                 from ods.t_borrows_prepare_hist
                where p_id in (110, 111)
                group by user_id) bp
      on ui.id = bp.user_id
    left join (select t1.user_id,
                      min(t2.create_time) first_ml_time,
                      min(case
                            when t1.bo_can_success = 3 and
                                 t2.amount_change_status = 1 then
                             t1.bo_audit_time
                          end) first_confirm_time,
                      min(case
                            when t1.bo_is_success = 1 then
                             transfer_account_time
                          end) first_loan_success_time
                 from ods.t_borrows_hist t1
                 join ods.t_borrows_archive_hist t2
                   on t1.id = t2.bo_id
                  and t1.p_id in (110, 111)
                group by t1.user_id) bo
      on ui.id = bo.user_id
   where ui.biz_code = 'mzjk';