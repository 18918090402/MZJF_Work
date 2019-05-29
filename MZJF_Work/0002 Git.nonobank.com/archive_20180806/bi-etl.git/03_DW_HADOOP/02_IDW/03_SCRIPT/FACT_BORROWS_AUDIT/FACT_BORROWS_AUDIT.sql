set mapreduce.job.name = IDW_FACT_BORROWS_AUDIT;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

INSERT OVERWRITE TABLE IDW.FACT_BORROWS_AUDIT
  select 'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         s.bo_id,
         s.user_id,
         s.p_id,
         s.category_name_01,
         s.biz_code_01,
         s.biz_name_01,
         s.depository_flag,
         s.ml_time,
         case
           when s.audit_status = '初审拒绝' then
            COALESCE(s.bo_audit_time, t.audit_reject_time)
         end audit_reject_time,
         case
           when s.audit_status = '终审拒绝' then
            COALESCE(s.bo_audit_time, t.confirm_reject_time)
         end confirm_reject_time,
         case
           when s.audit_status = '初审取消' then
            COALESCE(s.bo_audit_time, t.audit_cancel_time)
         end audit_cancel_time,
         case
           when s.audit_status = '终审取消' then
            COALESCE(s.bo_audit_time, t.confirm_cancel_time)
         end confirm_cancel_time,
         t.first_audit_time,
         t.last_audit_pass_time,
         t.last_confirm_time,
         t.confirm_pass_time,
         s.is_audit,
         s.is_confirm,
         s.audit_status,
         d.tongdun_uuid,
         d.nfcs_uuid,
         d.zhima_ivs_uuid,
         d.zhima_focus_uuid,
         d.zzc_applications_uuid,
         d.zzc_blacklist_uuid,
         d.baiqishi_ivs_risk_user_uuid,
         d.fushu_fund_rawdata_uuid,
         d.education_uuid,
         d.emay_blacklist_uuid,
         d.bd_risk_list_uuid,
         d.br_credit_report_uuid,
         d.moxie_report_data_bankhonor_uuid,
         d.moxie_report_data_jingdong_uuid,
         d.gxb_ecommerce_uuid,
         d.moxie_report_data_carrier_uuid,
         d.moxie_basic_data_carrier_uuid,
         t.reject_reason,
         d.bank_honor_upload_time,
         d.background_survey_time,
         s.visit_rslt,
         s.visit_time,
         case
           when s.audit_status = '审核通过' and s.p_id <> 140 then
            COALESCE(s.bo_audit_time, t.confirm_pass_time)
           when s.audit_status = '审核通过' and s.p_id = 140 then
            s.visit_time
         end pass_time,
         s.VIDEO_AUDIT_TIME,
         s.ml_price,
         s.confirm_pass_price
    from (select t2.bo_id,
                 t1.user_id,
                 t1.p_id,
                 t3.category_name_01,
                 t3.biz_code_01,
                 t3.biz_name_01,
                 t1.depository_flag,
                 case
                   when t1.p_id = 140 then
                    t2.create_time
                   when t1.p_id <> 140 and t2.is_audit > 0 then
                    t2.create_time
                 end ml_time,
                 coalesce(t2.is_audit, 0) is_audit,
                 coalesce(t2.is_confirm, 0) is_confirm,
                 t2.amount_change_status,
                 t1.bo_is_success,
                 t1.bo_is_finish,
                 t1.bo_audit_time,
                 case
                   when t1.p_id <> 140 and coalesce(t2.is_audit, 0) = 0 and
                        coalesce(t2.is_confirm, 0) = 0 and
                        (t1.bo_is_success = 3 OR t1.bo_is_finish = 2) then
                    '未提交超时流标'
                   when t1.p_id <> 140 and coalesce(t2.is_audit, 0) = 0 and
                        coalesce(t2.is_confirm, 0) = 0 then
                    '未提交'
                   when t1.p_id = 140 and coalesce(t2.is_audit, 0) = 0 and
                        coalesce(t2.is_confirm, 0) = 0 then
                    '人行报告上传'
                   when t2.is_audit = 3 and
                        coalesce(t2.is_confirm, 0) in (0, 4) then
                    '待初审'
                   when t2.is_audit = 2 and
                        coalesce(t2.is_confirm, 0) in (0, 4) then
                    '初审拒绝'
                   when t2.is_audit = 5 and
                        coalesce(t2.is_confirm, 0) in (0, 4) then
                    '初审取消'
                   when t1.p_id = 140 and t2.is_audit = 1 and
                        coalesce(t2.is_confirm, 0) = 0 then
                    '背景调查'
                   when t2.is_audit = 1 and t2.is_confirm = 3 then
                    '待终审'
                   when t2.is_audit = 1 and t2.is_confirm = 2 then
                    '终审拒绝'
                   when t2.is_audit = 1 and t2.is_confirm = 5 then
                    '终审取消'
                   when t2.is_audit = 4 and
                        coalesce(t2.is_confirm, 0) in (0, 4) and
                        (t1.bo_is_success = 3 OR t1.bo_is_finish = 2) then
                    '初审回退超时流标'
                   when t2.is_audit = 4 and
                        coalesce(t2.is_confirm, 0) in (0, 4) then
                    '初审回退'
                   when t2.is_audit = 1 and t2.is_confirm = 4 and
                        (t1.bo_is_success = 3 OR t1.bo_is_finish = 2) then
                    '终审回退超时流标'
                   when t2.is_audit = 1 and t2.is_confirm = 4 then
                    '终审回退'
                   when t1.p_id in (110, 111, 140) and
                        t2.amount_change_status not in (1, 2) and
                        t2.is_audit = 1 and t2.is_confirm = 1 and
                        t2.amount_after_change_value <= 0 and
                        t2.amount_before_change_value > 0 then
                    '额度不足流标'
                   when t1.p_id in (110, 111, 140) and
                        t2.amount_change_status not in (1, 2) and
                        t2.is_audit = 1 and t2.is_confirm = 1 and
                        t2.amount_after_change_value > 0 and
                        t2.amount_before_change_value > 0 then
                    '待用户确认'
                   when t1.p_id in (110, 111, 140) and
                        t2.amount_change_status not in (1, 2) and
                        t2.is_audit = 1 and t2.is_confirm = 1 and
                        t2.amount_before_change_value = 0 then
                    '待系统确认'
                   when t1.p_id in (110, 111, 140) and
                        t2.amount_change_status = 2 and t2.is_audit = 1 and
                        t2.is_confirm = 1 then
                    '用户已拒绝'
                   when t1.p_id not in (110, 111, 140) and t2.is_audit = 1 and
                        t2.is_confirm = 1 then
                    '审核通过'
                   when t1.p_id in (110, 111) and t2.amount_change_status = 1 and
                        t2.is_audit = 1 and t2.is_confirm = 1 then
                    '审核通过'
                   when t1.p_id = 140 and t2.amount_change_status = 1 and
                        t2.is_audit = 1 and t2.is_confirm = 1 and
                        ac.bo_id is null then
                    '待外访'
                   when t1.p_id = 140 and t2.amount_change_status = 1 and
                        t2.is_audit = 1 and t2.is_confirm = 1 and
                        ac.ac_type_status = 2 then
                    '外访拒绝'
                   when t1.p_id = 140 and t2.amount_change_status = 1 and
                        t2.is_audit = 1 and t2.is_confirm = 1 and
                        ac.ac_type_status = 1 then
                    '审核通过'
                   else
                    '未知'
                 end audit_status,
                 case
                   when ac.ac_type_status = 1 then
                    '通过'
                   when ac.ac_type_status = 2 then
                    '拒绝'
                 end visit_rslt,
                 ac.create_time visit_time,
                 t2.create_time VIDEO_AUDIT_TIME,
                 case
                   when t1.p_id in (110, 111, 140) and
                        t2.amount_change_status = 1 and t2.is_audit = 1 and
                        t2.is_confirm = 1 and
                        t2.amount_before_change_value > 0 then
                    t2.amount_before_change_value
                   else
                    t1.bo_price
                 end ml_price,
                 case
                   when t2.is_audit = 1 and t2.is_confirm = 1 and
                        t2.amount_before_change_value > 0 then
                    t2.amount_after_change_value
                   when t2.is_audit = 1 and t2.is_confirm = 1 then
                    t1.bo_price
                 end confirm_pass_price,
                 row_number() over(partition by t2.bo_id order by t2.create_time) rn
            from odsopr.borrows_hist t1
            join odsopr.borrows_archive_hist t2
              on t1.id = t2.bo_id
             and t2.keyword IN ('borrow_video_audit',
                                'MLD_final_auto_audit_pass',
                                'csmFin_auto_audit')
            join idw.dim_asset_product t3
              on t1.p_id = t3.p_id
            left join (select bo_id,
                             ac_type_status,
                             create_time,
                             row_number() over(partition by bo_id order by create_time) rn
                        from odsopr.admin_calendar_hist
                       where ac_type = 4) ac
              on t1.id = ac.bo_id
             and ac.rn = 1) s
    left join (select bo_id,
                      min(case
                            when title like '%初审%' then
                             create_time
                          end) first_audit_time,
                      max(case
                            when title like '%初审通过%' then
                             create_time
                          end) last_audit_pass_time,
                      max(case
                            when title like '%终审%' then
                             create_time
                          end) last_confirm_time,
                      min(case
                            when title like '%终审通过%' then
                             create_time
                          end) confirm_pass_time,
                      min(case
                            when title like '%初审拒绝%' then
                             create_time
                          end) audit_reject_time,
                      min(case
                            when title like '%终审拒绝%' then
                             create_time
                          end) confirm_reject_time,
                      min(case
                            when title like '%初审取消%' then
                             create_time
                          end) audit_cancel_time,
                      min(case
                            when title like '%终审取消%' then
                             create_time
                          end) confirm_cancel_time,
                      max(case
                            when title LIKE '%拒绝%' and audit_code <> '' then
                             audit_code
                          end) reject_reason
                 from odsopr.admin_work_remark_hist
                where bo_id > 0
                group by bo_id) t
      on s.bo_id = t.bo_id
    left join (select bo_id,
                      max(case
                            when credit_type = 1 then
                             report_id
                          end) TONGDUN_UUID,
                      max(case
                            when credit_type = 2 then
                             report_id
                          end) NFCS_UUID,
                      max(case
                            when credit_type = 3 then
                             report_id
                          end) ZHIMA_IVS_UUID,
                      max(case
                            when credit_type = 4 then
                             report_id
                          end) ZHIMA_FOCUS_UUID,
                      max(case
                            when credit_type = 5 then
                             report_id
                          end) ZZC_APPLICATIONS_UUID,
                      max(case
                            when credit_type = 6 then
                             report_id
                          end) ZZC_BLACKLIST_UUID,
                      max(case
                            when credit_type = 7 then
                             report_id
                          end) BAIQISHI_IVS_RISK_USER_UUID,
                      max(case
                            when credit_type = 9 then
                             report_id
                          end) FUSHU_FUND_RAWDATA_UUID,
                      max(case
                            when credit_type = 10 then
                             report_id
                          end) EDUCATION_UUID,
                      max(case
                            when credit_type = 13 then
                             report_id
                          end) EMAY_BLACKLIST_UUID,
                      max(case
                            when credit_type = 14 then
                             report_id
                          end) BD_RISK_LIST_UUID,
                      max(case
                            when credit_type = 15 then
                             report_id
                          end) BR_CREDIT_REPORT_UUID,
                      max(case
                            when credit_type = 16 then
                             report_id
                          end) MOXIE_REPORT_DATA_BANKHONOR_UUID,
                      max(case
                            when credit_type = 18 then
                             report_id
                          end) MOXIE_REPORT_DATA_JINGDONG_UUID,
                      max(case
                            when credit_type = 20 then
                             report_id
                          end) GXB_ECOMMERCE_UUID,
                      max(case
                            when credit_type = 21 then
                             report_id
                          end) MOXIE_REPORT_DATA_CARRIER_UUID,
                      max(case
                            when credit_type = 22 then
                             report_id
                          end) MOXIE_BASIC_DATA_CARRIER_UUID,
                      min(case
                            when credit_type = 29 then
                             create_time
                          end) bank_honor_upload_time,
                      min(case
                            when credit_type = 30 then
                             create_time
                          end) background_survey_time
                 from odsopr.user_credit_investigation_hist
                where bo_id > 0
                group by bo_id) d
      on s.bo_id = d.bo_id
   where s.rn = 1;