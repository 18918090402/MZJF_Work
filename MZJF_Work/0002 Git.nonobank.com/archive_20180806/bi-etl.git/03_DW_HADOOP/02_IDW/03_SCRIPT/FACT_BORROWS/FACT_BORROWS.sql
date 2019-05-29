set mapreduce.job.name = idw_fact_borrows_03;
set mapreduce.job.queuename = etl-dw;

drop table if exists tmp.tmp_fact_borrows_03;
create table if not exists tmp.tmp_fact_borrows_03
stored as parquet 
as 
select bo.id bo_id,
       sum(case
             when br.br_expect_num = 1 and br.br_overdue_terms > 0 then
              1
             else
              0
           end) is_first_repay_overdue,
       sum(case
             when br.br_expect_num = 1 and br.br_overdue_terms > 0 then
              datediff(coalesce(br.br_repay_time,
                                from_unixtime(unix_timestamp(), 'yyyy-MM-dd')),
                       br.br_time)
             else
              0
           end) first_repay_overdue_days,
       min(br.br_time) repay_begin_day,
       max(case
             when bo.bo_all_repayed = 1 then
              br.br_repay_time
           end) all_repayed_time,
       min(case
             when br.br_overdue_terms > 0 then
              br.br_expect_num
           end) FIRST_OVERDUE_EXPECT_NUM,
       min(case
             when br.br_overdue_terms > 0 then
              br.br_time
           end) FIRST_OVERDUE_BR_TIME,
       case
         when bo.bo_paytype in ('DEBX', 'DBDX') then
          max(br.br_price)
       end MONTHLY_REPAYMENT_AMT,
       max(case
             when br.BR_IS_REPAY > 0 then
              br.BR_REPAY_TIME
           end) LAST_REPAYED_TIME
  from odsopr.borrows_hist bo
  join odsopr.borrows_repayment_hist br
    on bo.id = br.bo_id
   and bo.bo_is_success = 1
 group by bo.id, bo.bo_paytype;

set mapreduce.job.name = idw_fact_borrows_04;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table idw.fact_borrows
  SELECT bo.bo_id,
         bo.p_id,
         bo.busi_line,
         bo.bp_id,
         bo.user_id,
         bo.bo_aim,
         bo.bo_title,
         bo.bo_repaysrc,
         bo.bo_price,
         bo.bo_finish_price,
         bo.bo_expect,
         bo.bo_expect_cat,
         bo.bo_bidding_type,
         bo.bo_safeguard_type,
         bo.bo_type,
         bo.is_assurance,
         bo.bo_rate,
         bo.bo_time,
         bo.bo_paytype,
         bo.bo_is_index,
         bo.bo_is_state,
         bo.publish_time,
         bo.bo_finish_rate,
         bo.bo_is_finish,
         bo.bo_finish_time,
         bo.bo_sign_am_id,
         bo.bo_sign_time,
         bo.bo_sign_result,
         bo.bo_audit_am_id,
         bo.bo_audit_time,
         bo.bo_audit_remark,
         bo.bo_is_success,
         bo.bo_can_success,
         bo.bo_is_republish,
         bo.bo_is_case,
         bo.bo_guid,
         bo.bo_extno,
         bo.bo_agree_generated,
         bo.bo_agree_time,
         bo.bo_all_repayed,
         tmp3.all_repayed_time AS ALL_REPAYED_TIME,
         bo.bo_sorce_talk,
         bo.bo_sorce_instrument,
         bo.bo_sorce_face,
         bo.bo_sorce_cooperation,
         bo.bo_pledge,
         bo.bo_house,
         bo.creator,
         bo.updator,
         bo.create_time,
         bo.update_time,
         bo.bo_purpose,
         COALESCE(bcf.zx_price, bs.triple_consult_fee) AS zx_price,
         bcf.zx_state AS zx_status,
         CASE
           WHEN bo.BO_SUCCESS_NUM = 1 THEN
            0
           WHEN bo.BO_SUCCESS_NUM > 1 THEN
            1
           ELSE
            NULL
         END AS is_repeat_borrow,
         bo.is_video_audit,
         bo.video_audit_time,
         bo.first_audit_time AS first_audit_time, --  首次初审时间
         bo.last_audit_pass_time AS last_audit_pass_time, --  最近初审通过时间
         bo.last_confirm_time AS last_confirm_time, --  最近终审时间
         bo.confirm_pass_time, --  终审通过时间
         tmp3.repay_begin_day AS repay_begin_day, --  起始还款日
         tmp3.is_first_repay_overdue AS is_first_repay_overdue, --  是否首还逾期
         tmp3.first_repay_overdue_days AS first_repay_overdue_days, --  首还逾期天数
         urc.interest_rate_cut AS interest_rate_cut, --  减息
         uhc.repayment_coupon AS repayment_coupon, --  还款券金额
         'SYS' AS dw_create_by, --  系统字段-创建者
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS dw_create_time, --  系统字段-创建时间
         'SYS' AS dw_update_by, --  系统字段-修改者
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS dw_update_time, --  系统字段-修改时间
         bo.CUR_STATUS,
         bo.AUDIT_STATUS,
         bo.CONFIRM_STATUS,
         bo.AUDIT_REJECT_TIME,
         bo.CONFIRM_REJECT_TIME,
         CASE
           WHEN cur_status regexp '拒绝' THEN
            bo.bo_audit_time
         END REJECT_TIME,
         bo.AUDIT_CANCEL_TIME,
         bo.CONFIRM_CANCEL_TIME,
         CASE
           WHEN cur_status regexp '流标' THEN
            COALESCE(bo.bo_cancel_time, bo.bo_audit_time)
         END FAIL_TIME,
         p.CATEGORY_NAME_01,
         p.BIZ_CODE_01,
         p.BIZ_NAME_01,
         bo.DEPOSITORY_FLAG,
         tmp3.FIRST_OVERDUE_EXPECT_NUM,
         tmp3.FIRST_OVERDUE_BR_TIME,
         bo.TRANSFER_ACCOUNT_TIME,
         p.P_NAME,
         tmp3.MONTHLY_REPAYMENT_AMT,
         bo.BO_SUCCESS_TIME,
         bo.BO_SUCCESS_NUM,
         bo.BO_CONFIRM_NUM,
         bs.user_identity_type,
         bs.total_amount,
         bs.base_amount,
         bs.used_amount,
         bs.increase_amount,
         bs.top_amount,
         bs.lbs_access_city,
         bs.lbs_complete_data_city,
         bs.credit_type,
         bp.bp_channel,
         bo.rc_id,
         bo.rc_name,
         case
           when bo.bo_id = 112 or (bo.p_id = 87 and bp.bp_channel = 7) or
                cg.channel_id is not null then
            4
           when bo.p_id = 87 and bp.bp_channel = 6 then
            1
           when bo.p_id = 87 and bp.bp_channel = 5 then
            2
           when bo.p_id = 87 then
            27
           when bo.p_id = 110 then
            3
           when bo.p_id in (88, 83, 99, 77, 102) and
                bo.bo_audit_time < '2017-07-01' and
                ui.edu_graduate_date >= '2018' then
            8
           when bo.p_id = 88 then
            5
           when bo.p_id in (99, 77, 102) then
            6
           when bo.p_id = 83 then
            7
           when bo.p_id = 96 and oo.order_type = 2 then
            9
           when bo.p_id = 96 and oo.order_type = 1 then
            10
           when bo.p_id = 145 and oo.review_source = '0' then
            28
           when bo.p_id = 145 and oo.review_source = '1' then
            29
           when bo.p_id = 104 then
            11
           when bo.p_id = 111 then
            12
           when bo.p_id = 140 then
            20
           when bo.p_id in (86, 93, 101) then
            13
           when pc.p_id is not null and bo.bo_paytype = 'XXHB' then
            14
           when pc.p_id is not null and bo.bo_paytype = 'DBDX' then
            15
           when bo.p_id = 92 then
            17
           when bo.p_id in (94, 97) then
            18
           when bo.bo_audit_time < '2015-03-01' then
            16
           else
            19
         end p_key,
         bo.pass_time,
         bo.ml_time,
         tmp3.LAST_REPAYED_TIME BO_LAST_REPAYED_TIME,
         bo.ml_price,
         bo.confirm_pass_price,
         case
           when bra.id is not null then
            1
           else
            0
         end IS_BORROWS_RAISE,
         cast(bra.is_stock_campaign as int) is_stock_campaign
    FROM (SELECT t1.id AS bo_id, --  借款ID
                 t1.p_id AS p_id, --  产品ID
                 CASE
                   WHEN t1.p_id IN (77, 83, 87, 88, 102) THEN
                    '信用贷'
                   WHEN (t1.p_id = 93 AND t1.bo_audit_time < '2017-01-01') OR
                        t1.id IN (845926) THEN
                    '过桥'
                   WHEN t1.p_id IN (86, 103) OR
                        t1.id IN (61892, 61894, 74633, 76582, 76834) OR
                        t1.p_id = 93 THEN
                    '大房东'
                   WHEN t1.p_id IN (94, 97) THEN
                    'Unifi'
                   WHEN t1.p_id IN (96, 104, 100) THEN
                    '麦芽分期'
                   WHEN t1.p_id = 92 THEN
                    '非标'
                   WHEN t1.bo_audit_time < '2015-03-01' THEN
                    '融易贷' -- 2015.3.1之前老产品逾期率高  
                   ELSE
                    '其他'
                 END AS busi_line, -- 所属业务线
                 t1.bp_id AS bp_id, --  预发标ID
                 t1.user_id AS user_id, --  用户ID
                 t1.bo_aim AS bo_aim, --  借款目的
                 t1.bo_title AS bo_title, --  借款标题
                 t1.bo_repaysrc AS bo_repaysrc, --  还款来源
                 t1.bo_price AS bo_price, --  借款金额
                 t1.bo_finish_price AS bo_finish_price, --  完成金额
                 t1.bo_expect AS bo_expect, --  借款期限
                 t1.bo_expect_cat AS bo_expect_cat, --  借款期限单位
                 t1.bo_bidding_type AS bo_bidding_type, --  标的类型
                 t1.bo_safeguard_type AS bo_safeguard_type, --  保障方式
                 t1.bo_type AS bo_type, --  借款类型
                 t1.is_assurance AS is_assurance, --  是否请求担保
                 t1.bo_rate AS bo_rate, --  借款年利率
                 t1.bo_time AS bo_time, --  有效时间
                 t1.bo_paytype AS bo_paytype, --  还款方式
                 t1.bo_is_index AS bo_is_index, --  是否推荐
                 t1.bo_is_state AS bo_is_state, --  借款状态
                 t1.publish_time AS publish_time, --  发布时间
                 t1.bo_finish_rate AS bo_finish_rate, --  完成度
                 t1.bo_is_finish AS bo_is_finish, --  是否完成
                 t1.bo_finish_time AS bo_finish_time, --  完成时间
                 t1.bo_sign_am_id AS bo_sign_am_id, --  签约人员
                 t1.bo_sign_time AS bo_sign_time, --  签约时间
                 t1.bo_sign_result AS bo_sign_result, --  签约结果
                 t1.bo_audit_am_id AS bo_audit_am_id, --  审核人员
                 t1.bo_audit_time AS bo_audit_time, --  审核时间
                 t1.bo_audit_remark AS bo_audit_remark, --  审核备注
                 t1.bo_is_success AS bo_is_success, --  是否审核通过
                 t1.bo_can_success AS bo_can_success, --  是否可以审核通过
                 t1.bo_is_republish AS bo_is_republish, --  是否已重发
                 t1.bo_is_case AS bo_is_case, --  是否推荐案例
                 t1.bo_guid AS bo_guid, --  电子协议guid
                 t1.bo_extno AS bo_extno, --  协议编号
                 t1.bo_agree_generated AS bo_agree_generated, --  协议是否生成
                 t1.bo_agree_time AS bo_agree_time, --  协议生成时间
                 t1.bo_all_repayed AS bo_all_repayed, --  借款还款结束
                 t1.bo_sorce_talk AS bo_sorce_talk, --  谈吐分值
                 t1.bo_sorce_instrument AS bo_sorce_instrument, --  仪表分值
                 t1.bo_sorce_face AS bo_sorce_face, --  面相分值
                 t1.bo_sorce_cooperation AS bo_sorce_cooperation, --  配合度分值
                 t1.bo_pledge AS bo_pledge, --  是否抵押
                 t1.bo_house AS bo_house, --  房产信息
                 t1.creator AS creator, -- 创建人
                 t1.updator AS updator, -- 更新人
                 t1.create_time AS create_time, -- 创建时间
                 t1.update_time AS update_time, -- 更新时间
                 CASE
                   WHEN LENGTH(t1.bo_title) < 5 AND t1.bo_title NOT REGEXP
                    '^[0-9A-Za-z]*$' THEN
                    t1.bo_title
                   WHEN t1.bo_title REGEXP '创业' THEN
                    '创业'
                   WHEN t1.bo_title REGEXP '应急周转' THEN
                    '应急周转'
                   WHEN t1.bo_title REGEXP '培训' THEN
                    '培训'
                   WHEN t1.bo_title REGEXP '消费' THEN
                    '消费'
                   WHEN t1.bo_title REGEXP '就业' THEN
                    '就业'
                   WHEN t1.bo_title REGEXP '旅游|旅行' THEN
                    "旅行"
                   ELSE
                    '(未知)'
                 END AS bo_purpose,
                 CASE
                   WHEN t1.bo_is_success = 1 AND t1.bo_all_repayed = 1 THEN
                    '还款完成'
                   WHEN t1.bo_is_success = 1 AND t1.bo_all_repayed = 0 THEN
                    '还款中'
                   WHEN ba.audit_status in ('终审拒绝',
                                            '终审取消',
                                            '初审拒绝',
                                            '初审取消',
                                            '未提交超时流标',
                                            '初审回退超时流标',
                                            '终审回退超时流标',
                                            '用户已拒绝',
                                            '外访拒绝',
                                            '额度不足流标') THEN
                    ba.audit_status
                   WHEN t1.bo_is_success = 2 THEN
                    '拒绝'
                   WHEN t1.bo_is_success = 3 OR t1.bo_is_finish = 2 THEN
                    '流标'
                   WHEN t1.bo_is_finish = 1 AND t1.bo_is_success = 0 THEN
                    '募集完成待放款'
                   WHEN t1.bo_is_success = 0 AND t1.bo_is_finish = 0 AND
                        t1.bo_can_success = 3 THEN
                    '终审通过待匹配'
                   WHEN t1.bo_is_success = 0 AND t1.bo_is_finish = 0 AND
                        ba.bo_id IS NULL THEN
                    '待提交视频'
                   ELSE
                    coalesce(ba.audit_status, '未知')
                 END cur_status,
                 IF(ba.bo_id IS NOT NULL, 1, 0) AS is_video_audit,
                 ba.video_audit_time,
                 CASE
                   WHEN ba.bo_id IS NOT NULL AND
                        (ba.is_audit = 0 OR ba.is_audit IS NULL) THEN
                    '未提交'
                   WHEN ba.is_audit = 1 THEN
                    '初审通过'
                   WHEN ba.is_audit = 2 THEN
                    '初审拒绝'
                   WHEN ba.is_audit = 3 THEN
                    '待初审'
                   WHEN ba.is_audit = 4 THEN
                    '初审回退'
                   WHEN ba.is_audit = 5 THEN
                    '初审取消'
                 END AUDIT_STATUS,
                 CASE
                   WHEN ba.bo_id IS NOT NULL AND
                        (ba.is_confirm = 0 OR ba.is_confirm IS NULL) THEN
                    '未提交'
                   WHEN ba.is_confirm = 1 THEN
                    '终审通过'
                   WHEN ba.is_confirm = 2 THEN
                    '终审拒绝'
                   WHEN ba.is_confirm = 3 THEN
                    '待终审'
                   WHEN ba.is_confirm = 4 THEN
                    '终审回退'
                   WHEN ba.is_confirm = 5 THEN
                    '终审取消'
                 END CONFIRM_STATUS,
                 t1.DEPOSITORY_FLAG,
                 t1.TRANSFER_ACCOUNT_TIME,
                 CASE
                   WHEN t1.bo_is_success = 1 THEN
                    COALESCE(t1.TRANSFER_ACCOUNT_TIME, t1.bo_agree_time)
                 end BO_SUCCESS_TIME,
                 CASE
                   WHEN t1.bo_is_success = 1 THEN
                    row_number()
                    over(PARTITION BY t1.user_id,
                         t1.bo_is_success ORDER BY
                         COALESCE(t1.transfer_account_time, t1.bo_agree_time))
                 END BO_SUCCESS_NUM,
                 CASE
                   WHEN t1.bo_can_success = 3 THEN
                    row_number()
                    over(PARTITION BY t1.user_id,
                         t1.bo_can_success ORDER BY t1.bo_audit_time)
                 END BO_CONFIRM_NUM,
                 CASE
                   WHEN t1.bo_is_success = 1 THEN
                    COALESCE(t1.rc_id, 2)
                 END rc_id,
                 CASE
                   WHEN t1.bo_is_success = 1 AND t1.rc_id = 1 THEN
                    '星河金服'
                   WHEN t1.bo_is_success = 1 AND
                        (t1.rc_id = 2 OR t1.rc_id IS NULL) THEN
                    '诺诺网贷'
                 END rc_name,
                 ba.audit_reject_time,
                 ba.confirm_reject_time,
                 ba.first_audit_time,
                 ba.last_audit_pass_time,
                 ba.last_confirm_time,
                 ba.confirm_pass_time,
                 ba.audit_cancel_time,
                 ba.confirm_cancel_time,
                 ba.pass_time,
                 t1.bo_cancel_time,
                 ba.ml_time,
                 ba.ml_price,
                 ba.confirm_pass_price
            FROM odsopr.borrows_hist t1
            LEFT JOIN idw.FACT_BORROWS_AUDIT ba
              ON t1.id = ba.bo_id) bo
    LEFT JOIN (SELECT bo_id, MAX(zx_price) zx_price, MAX(zx_state) zx_state
                 FROM odsopr.borrows_consulted_fee_hist
                GROUP BY bo_id) bcf
      ON bo.bo_id = bcf.bo_id
    LEFT JOIN tmp.tmp_fact_borrows_03 tmp3
      ON bo.bo_id = tmp3.bo_id
    LEFT JOIN (SELECT bp_id, SUM(cutvalue) interest_rate_cut
                 FROM odsopr.user_interestratecut_hist
                WHERE bp_id > 0
                GROUP BY bp_id) urc
      ON bo.bp_id = urc.bp_id
    LEFT JOIN (SELECT bo_id, SUM(VALUE) repayment_coupon
                 FROM odsopr.user_hkconpon_hist
                WHERE bo_id > 0
                GROUP BY bo_id) uhc
      ON bo.bo_id = uhc.bo_id
    LEFT JOIN idw.DIM_ASSET_PRODUCT p
      ON bo.p_id = p.p_id
    LEFT JOIN odsopr.borrows_snapshot_hist bs
      ON bo.bo_id = bs.bo_id
     and bs.is_delete = 0
    LEFT JOIN odsopr.borrows_prepare_hist bp
      ON bo.bp_id = bp.id
    left join idw.fact_user_info ui
      on bo.user_id = ui.user_id
    left join odsopr.fact_channel_group_hist cg
      on ui.channel_id = cg.channel_id
     and cg.group_code = 'DLD'
    left join odsopr.ord_order_hist oo
      on bo.bo_id = oo.bo_id
     and oo.disabled = 0
     and oo.bo_id > 0
    left join odsopr.products_config_hist pc
      on bo.p_id = pc.p_id
     and pc.key = 'car_loan_flag'
     AND pc.value = '1'
    left join odsopr.borrows_raise bra
      on bo.bo_id = bra.bo_id;