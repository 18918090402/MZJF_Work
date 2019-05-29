set mapreduce.job.name = idw_fact_borrows_prepare_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table idw.fact_borrows_prepare
  select bp.id bp_id,
         bp.user_id,
         bp.ml_id,
         bp.p_id,
         CASE
           WHEN coalesce(bo.p_id, bp.p_id) IN (77, 83, 87, 88, 102) THEN
            '名校贷'
           WHEN (coalesce(bo.p_id, bp.p_id) = 93 and
                if(bo.id is null, bp.bp_publish_time, bo.bo_audit_time) <
                '2017-01-01') OR bo.id in (845926) THEN
            '过桥'
           WHEN coalesce(bo.p_id, bp.p_id) IN (86, 103) OR
                bo.id IN (61892, 61894, 74633, 76582, 76834) OR
                coalesce(bo.p_id, bp.p_id) = 93 THEN
            '大房东'
           WHEN coalesce(bo.p_id, bp.p_id) IN (94, 97) THEN
            'Unifi'
           WHEN coalesce(bo.p_id, bp.p_id) IN (96, 104, 100) THEN
            '麦芽分期'
           WHEN coalesce(bo.p_id, bp.p_id) = 92 THEN
            '非标'
           WHEN if(bo.id is null, bp.bp_publish_time, bo.bo_audit_time) <
                '2015-03-01' THEN
            '融易贷' -- 2015.3.1之前老产品逾期率高  
           ELSE
            '其他'
         END busi_line,
         bp.bp_aim,
         bp.bp_title,
         bp.bp_price,
         bp.bp_expect,
         bp.bp_expect_cat,
         bp.bp_rate,
         bp.bp_bidding_type,
         bp.bp_promotion_time,
         bp.bp_repaysrc,
         bp.bp_pledge,
         bp.bp_house,
         bp.bp_pledge_type,
         bp.flag_borrows,
         bp.is_assurance,
         bp.is_part,
         bp.part_price,
         bp.bp_time,
         bp.bp_paytype,
         bp.bp_ben_paytype,
         bp.bp_xi_paytype,
         bp.bp_acctype,
         bp.bp_ben_acctype,
         bp.bp_xi_acctype,
         bp.bp_is_state,
         bp.bp_hurry,
         bp.bp_is_index,
         bp.bp_publish_time,
         bp.bp_last_modifed_time,
         bp.bp_uploads_finish,
         bp.bp_pre_approval_am_id,
         bp.bp_pre_approval_status,
         bp.bp_pre_approval_time,
         bp.bp_pre_approval_op_id,
         bp.bp_pre_approval_remark,
         bp.bp_pre_approval_assign_time,
         bp.bp_visit_am_id,
         bp.bp_visit_am_id_bk,
         bp.bp_visit_status,
         bp.bp_visit_time,
         bp.bp_visit_op_id,
         bp.bp_visit_remark,
         bp.bp_visit_assign_time,
         bp.bp_lacked_uploads,
         bp.bp_approval_am_id,
         bp.bp_approval_status,
         bp.bp_approval_time,
         bp.bp_approval_remark,
         bp.bp_approval_op_id,
         bp.bp_approval_assign_time,
         bp.bp_approval_sign_remark,
         bp.bp_approval_loan_remark,
         bp.bp_is_success,
         bp.bp_send_sms_time,
         bp.bp_price_audit,
         bp.bp_expect_audit,
         bp.bp_rate_audit,
         bp.bp_review_am_id,
         bp.bp_review_status,
         bp.bp_review_time,
         bp.bp_review_remark,
         bp.bp_review_op_id,
         bp.bp_review_sign_remark,
         bp.bp_review_loan_remark,
         bp.bp_review_ps_remark,
         bp.bp_review_assign_time,
         bp.bp_protocol_template,
         bp.is_illegal,
         bp.bp_illegal_remark,
         bp.bp_resource,
         bp.bp_need_htsb,
         bp.bp_need_jxl,
         bp.bp_rate_lender,
         bp.bp_repeat_result,
         bp.bp_channel,
         bp.creator,
         bp.updator,
         bp.create_time,
         bp.update_time,
         'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         case
           when bo.id = 112 or
                (coalesce(bo.p_id, bp.p_id) = 87 and bp.bp_channel = 7) or
                cg.channel_id is not null then
            4
           when coalesce(bo.p_id, bp.p_id) = 87 and bp.bp_channel = 6 then
            1
           when coalesce(bo.p_id, bp.p_id) = 87 and bp.bp_channel = 5 then
            2
           when coalesce(bo.p_id, bp.p_id) = 87 then
            27
           when coalesce(bo.p_id, bp.p_id) = 110 then
            3
           when coalesce(bo.p_id, bp.p_id) in (88, 83, 99, 77, 102) and
                if(bo.id is not null, bo.bo_audit_time, bp.bp_publish_time) <
                '2017-07-01' and ui.edu_graduate_date >= '2018' then
            8
           when coalesce(bo.p_id, bp.p_id) = 88 then
            5
           when coalesce(bo.p_id, bp.p_id) in (99, 77, 102) then
            6
           when coalesce(bo.p_id, bp.p_id) = 83 then
            7
           when coalesce(bo.p_id, bp.p_id) = 96 and oo.order_type = 2 then
            9
           when coalesce(bo.p_id, bp.p_id) = 96 and oo.order_type = 1 then
            10
           when coalesce(bo.p_id, bp.p_id) = 145 and oo.review_source = '0' then
            28
           when coalesce(bo.p_id, bp.p_id) = 145 and oo.review_source = '1' then
            29
           when coalesce(bo.p_id, bp.p_id) = 104 then
            11
           when coalesce(bo.p_id, bp.p_id) = 111 then
            12
           when coalesce(bo.p_id, bp.p_id) = 140 then
            20
           when coalesce(bo.p_id, bp.p_id) in (86, 93, 101) then
            13
           when pc.p_id is not null and bo.bo_paytype = 'XXHB' then
            14
           when pc.p_id is not null and bo.bo_paytype = 'DBDX' then
            15
           when coalesce(bo.p_id, bp.p_id) = 92 then
            17
           when coalesce(bo.p_id, bp.p_id) in (94, 97) then
            18
           when if(bo.id is not null, bo.bo_audit_time, bp.bp_publish_time) <
                '2015-03-01' then
            16
           else
            19
         end p_key
    from odsopr.borrows_prepare_hist bp
    left join odsopr.borrows_hist bo
      on bp.id = bo.bp_id
    left join idw.fact_user_info ui
      on coalesce(bo.user_id, bp.user_id) = ui.user_id
    left join odsopr.fact_channel_group_hist cg
      on ui.channel_id = cg.channel_id
     and cg.group_code = 'DLD'
    left join odsopr.ord_order_hist oo
      on bo.id = oo.bo_id
     and oo.disabled = 0
     and oo.bo_id > 0
    left join odsopr.products_config_hist pc
      on coalesce(bo.p_id, bp.p_id) = pc.p_id
     and pc.key = 'car_loan_flag'
     AND pc.value = '1';