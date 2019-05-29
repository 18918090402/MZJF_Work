drop table if exists idw.fact_borrows_plus ;

CREATE TABLE idw.fact_borrows_plus 
(	
      bo_id bigint COMMENT '借款ID', 	
      p_id bigint COMMENT '产品ID', 	
      busi_line string COMMENT '所属业务线', 	
      bp_id bigint COMMENT '预发标ID', 	
      user_id bigint COMMENT '用户ID', 	
      bo_aim string COMMENT '借款目的', 	
      bo_title string COMMENT '借款标题', 	
      bo_repaysrc string COMMENT '还款来源', 	
      bo_price decimal(38,10) COMMENT '借款金额', 	
      bo_finish_price decimal(38,10) COMMENT '完成金额', 	
      bo_expect int COMMENT '借款期限', 	
      bo_expect_cat int COMMENT '借款期限单位', 	
      bo_bidding_type int COMMENT '标的类型', 	
      bo_safeguard_type int COMMENT '保障方式', 	
      bo_type int COMMENT '借款类型', 	
      is_assurance int COMMENT '是否请求担保', 	
      bo_rate decimal(38,10) COMMENT '借款年利率', 	
      bo_time int COMMENT '有效时间', 	
      bo_paytype string COMMENT '还款方式', 	
      bo_is_index int COMMENT '是否推荐', 	
      bo_is_state int COMMENT '借款状态', 	
      publish_time string COMMENT '发布时间', 	
      bo_finish_rate decimal(38,10) COMMENT '完成度', 	
      bo_is_finish int COMMENT '是否完成', 	
      bo_finish_time string COMMENT '完成时间', 	
      bo_sign_am_id bigint COMMENT '签约人员', 	
      bo_sign_time string COMMENT '签约时间', 	
      bo_sign_result int COMMENT '签约结果', 	
      bo_audit_am_id bigint COMMENT '审核人员', 	
      bo_audit_time string COMMENT '审核时间', 	
      bo_audit_remark string COMMENT '审核备注', 	
      bo_is_success int COMMENT '是否审核通过 1:通过 2:拒绝 3:超时流标 4:回退', 	
      bo_can_success int COMMENT '是否可以审核通过', 	
      bo_is_republish int COMMENT '是否已重发', 	
      bo_is_case int COMMENT '是否推荐案例', 	
      bo_guid string COMMENT '电子协议guid', 	
      bo_extno string COMMENT '协议编号', 	
      bo_agree_generated int COMMENT '协议是否生成', 	
      bo_agree_time string COMMENT '协议生成时间', 	
      bo_all_repayed int COMMENT '借款还款结束', 	
      all_repayed_time string COMMENT '还款结束时间', 	
      bo_sorce_talk int COMMENT '谈吐分值', 	
      bo_sorce_instrument int COMMENT '仪表分值', 	
      bo_sorce_face int COMMENT '面相分值', 	
      bo_sorce_cooperation int COMMENT '配合度分值', 	
      bo_pledge int COMMENT '是否抵押', 	
      bo_house string COMMENT '房产信息', 	
      creator bigint COMMENT '创建人', 	
      updator bigint COMMENT '更新人', 	
      create_time string COMMENT '创建时间', 	
      update_time string COMMENT '更新时间', 	
      bo_purpose string COMMENT '借款用途', 	
      zx_price decimal(38,10) COMMENT '咨询费', 	
      zx_status int COMMENT '咨询费状态 0:暂扣 1:退换 2:逾期扣除', 	
      is_repeat_borrow int COMMENT '是否复借', 	
      is_video_audit int COMMENT '是否提交视频', 	
      video_audit_time string COMMENT '视频提交时间', 	
      first_audit_time string COMMENT '首次初审时间', 	
      last_audit_pass_time string COMMENT '最近初审通过时间', 	
      last_confirm_time string COMMENT '最近终审时间', 	
      confirm_pass_time string COMMENT '终审通过时间', 	
      repay_begin_day string COMMENT '起始还款日', 	
      is_first_repay_overdue int COMMENT '是否首还逾期', 	
      first_repay_overdue_days int COMMENT '首还逾期天数', 	
      interest_rate_cut decimal(38,10) COMMENT '减息', 	
      repayment_coupon decimal(38,10) COMMENT '还款券金额', 	
      dw_create_by string COMMENT '系统字段-创建者', 	
      dw_create_time string COMMENT '系统字段-创建时间', 	
      dw_update_by string COMMENT '系统字段-修改者', 	
      dw_update_time string COMMENT '系统字段-修改时间', 	
      cur_status string COMMENT '当前状态', 	
      audit_status string COMMENT '初审状态', 	
      confirm_status string COMMENT '终审状态', 	
      audit_reject_time string COMMENT '初审拒绝时间', 	
      confirm_reject_time string COMMENT '终审拒绝时间', 	
      reject_time string COMMENT '拒绝时间', 	
      audit_cancel_time string COMMENT '初审取消时间', 	
      confirm_cancel_time string COMMENT '终审取消时间', 	
      fail_time string COMMENT '流标时间', 	
      category_name_01 string COMMENT '产品分类01', 	
      biz_code_01 string COMMENT '业务线编码01', 	
      biz_name_01 string COMMENT '业务线名称01', 	
      depository_flag int COMMENT '存管标记 0:初始 1:走存管 2:不走存管', 	
      first_overdue_expect_num int COMMENT '首次逾期期数', 	
      first_overdue_br_time string COMMENT '首次逾期应还时间', 	
      transfer_account_time string COMMENT '实际划转成功时间', 	
      p_name string COMMENT '产品名称', 	
      monthly_repayment_amt decimal(38,10) COMMENT '月还款金额', 	
      bo_success_time string COMMENT '放款时间', 	
      bo_success_num int COMMENT '成功放款批次', 	
      bo_confirm_num int COMMENT '终审通过批次', 	
      user_identity_type int COMMENT '用户身份： 1-无业，2-白领，3-蓝领', 	
      total_amount decimal(38,10) COMMENT '总额度', 	
      base_amount decimal(38,10) COMMENT '基础额度', 	
      used_amount decimal(38,10) COMMENT '已使用可借额度', 	
      increase_amount decimal(38,10) COMMENT '增信额度', 	
      top_amount decimal(38,10) COMMENT '额度上限:个人最高额度限制', 	
      lbs_access_city string COMMENT '准入时获取的LBS地址', 	
      lbs_complete_data_city string COMMENT '生成正式标的LBS地址', 	
      credit_type int COMMENT '授信模式类型 1-基础项提额项模式, 2-高学历模式, 3-消费能力模式', 	
      bp_channel int COMMENT '申请渠道', 	
      rc_id bigint COMMENT '资方id', 	
      rc_name string COMMENT '资方名称', 	
      p_key int COMMENT '产品代理键',
      bia_product string COMMENT '大一统产品名称',
      biz_name string COMMENT '大一统产品线',
      pass_time string COMMENT '审核通过时间', 	
      ml_time string COMMENT '进件时间', 	
      bo_last_repayed_time string COMMENT '最近还款时间', 	
      ml_price decimal(38,10) COMMENT '进件金额', 	
      confirm_pass_price decimal(38,10) COMMENT '审批金额', 	
      is_borrows_raise int COMMENT '是否一键再借', 	
      is_stock_campaign int COMMENT '是否存量战役', 	
      is_graduate string COMMENT '是否已毕业', 	
      second_repay_overdue_days bigint COMMENT '第二期逾期天数', 	
      third_repay_overdue_days bigint COMMENT '第三期逾期天数', 	
      fourth_repay_overdue_days bigint COMMENT '第四期逾期天数', 	
      fifth_repay_overdue_days bigint COMMENT '第五期逾期天数', 	
      sixth_repay_overdue_days bigint COMMENT '第六期逾期天数', 	
      seventh_repay_overdue_days bigint COMMENT '第七期逾期天数', 	
      eighth_repay_overdue_days bigint COMMENT '第八期逾期天数', 	
      ninth_repay_overdue_days bigint COMMENT '第九期逾期天数', 	
      tenth_repay_overdue_days bigint COMMENT '第十期逾期天数', 	
      eleventh_repay_overdue_days bigint COMMENT '第十一期逾期天数', 	
      twelfh_repay_overdue_days bigint COMMENT '第十二期逾期天数'
)	
COMMENT '借款表'
ROW FORMAT DELIMITED
NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;



set mapreduce.job.name = idw_fact_borrows_plus_01;
set mapreduce.job.queuename = etl-dw;

drop table if exists tmp.tmp_fact_borrows_plus_01;
create table if not exists tmp.tmp_fact_borrows_plus_01
stored as parquet 
as 
    select bo.id bo_id
           ,max(case when br.br_expect_num = 1  and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then 1 else 0 end)                                                                          as is_first_repay_overdue
           ,max(case when br.br_expect_num = 1  and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as first_repay_overdue_days
           ,max(case when br.br_expect_num = 2  and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as second_repay_overdue_days
           ,max(case when br.br_expect_num = 3  and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as third_repay_overdue_days
           ,max(case when br.br_expect_num = 4  and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as fourth_repay_overdue_days
           ,max(case when br.br_expect_num = 5  and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as fifth_repay_overdue_days
           ,max(case when br.br_expect_num = 6  and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as sixth_repay_overdue_days
           ,max(case when br.br_expect_num = 7  and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as seventh_repay_overdue_days
           ,max(case when br.br_expect_num = 8  and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as eighth_repay_overdue_days
           ,max(case when br.br_expect_num = 9  and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as ninth_repay_overdue_days
           ,max(case when br.br_expect_num = 10 and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as tenth_repay_overdue_days
           ,max(case when br.br_expect_num = 11 and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as eleventh_repay_overdue_days
           ,max(case when br.br_expect_num = 12 and coalesce(to_date(br.br_repay_time), '{T}') > to_date(br.br_time) then datediff(coalesce(to_date(br.br_repay_time), '{T}') , to_date(br.br_time)) else 0 end) as twelfth_repay_overdue_days
           ,min(br.br_time)                                                                                                                                                     as repay_begin_day            --起始还款日
           ,max(case when bo.bo_all_repayed = 1 then br.br_repay_time end)                                                                                                      as all_repayed_time           --还款结束时间
           ,min(case when br.br_overdue_terms > 0 then br.br_expect_num end)                                                                                                    as FIRST_OVERDUE_EXPECT_NUM   --首次逾期期数
           ,min(case when br.br_overdue_terms > 0 then br.br_time end)                                                                                                          as FIRST_OVERDUE_BR_TIME      --首次逾期应还时间
           ,case when bo.bo_paytype in ('DEBX', 'DBDX') then max(br.br_price) else max(br1.br_price) end                                                                        as MONTHLY_REPAYMENT_AMT      --月还款金额
           ,max(case when br.BR_IS_REPAY > 0 then br.BR_REPAY_TIME end)                                                                                                         as LAST_REPAYED_TIME          --最近还款时间
      from odsopr.borrows bo
      join odsopr.borrows_repayment br
        on bo.id = br.bo_id
       and bo.bo_is_success = 1
 LEFT JOIN 
         (      SELECT bo_id, br_price FROM odsopr.borrows_repayment
                 WHERE date_format(BR_TIME,'yyyy-MM') = from_unixtime(unix_timestamp(), 'yyyy-MM')
         ) br1  --新增其它还款方式的月还款金额 
        ON BR.BO_ID = BR1.BO_ID
     group by bo.id, bo.bo_paytype
     ;






set mapreduce.job.name = idw_fact_borrows_plus_02; 
set mapreduce.job.queuename = etl-dw;  
set hive.exec.parallel = true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict; 
set hive.exec.max.dynamic.partitions.pernode = 100000000;
set hive.exec.max.dynamic.partitions = 100000000;
set hive.exec.max.created.files = 100000000;
SET mapreduce.map.memory.mb=8192;


insert overwrite table idw.fact_borrows_plus
          SELECT bo.bo_id
                 ,bo.p_id
                 ,bo.busi_line
                 ,bo.bp_id
                 ,bo.user_id
                 ,bo.bo_aim
                 ,bo.bo_title
                 ,bo.bo_repaysrc
                 ,bo.bo_price
                 ,bo.bo_finish_price
                 ,bo.bo_expect
                 ,bo.bo_expect_cat
                 ,bo.bo_bidding_type
                 ,bo.bo_safeguard_type
                 ,bo.bo_type
                 ,bo.is_assurance
                 ,bo.bo_rate
                 ,bo.bo_time
                 ,bo.bo_paytype
                 ,bo.bo_is_index
                 ,bo.bo_is_state
                 ,bo.publish_time
                 ,bo.bo_finish_rate
                 ,bo.bo_is_finish
                 ,bo.bo_finish_time
                 ,bo.bo_sign_am_id
                 ,bo.bo_sign_time
                 ,bo.bo_sign_result
                 ,bo.bo_audit_am_id
                 ,bo.bo_audit_time
                 ,bo.bo_audit_remark
                 ,bo.bo_is_success
                 ,bo.bo_can_success
                 ,bo.bo_is_republish
                 ,bo.bo_is_case
                 ,bo.bo_guid
                 ,bo.bo_extno
                 ,bo.bo_agree_generated
                 ,bo.bo_agree_time
                 ,bo.bo_all_repayed
                 ,tmp3.all_repayed_time AS ALL_REPAYED_TIME
                 ,bo.bo_sorce_talk
                 ,bo.bo_sorce_instrument
                 ,bo.bo_sorce_face
                 ,bo.bo_sorce_cooperation
                 ,bo.bo_pledge
                 ,bo.bo_house
                 ,bo.creator
                 ,bo.updator
                 ,bo.create_time
                 ,bo.update_time
                 ,bo.bo_purpose
                 ,COALESCE(bcf.zx_price, bs.triple_consult_fee) AS zx_price
                 ,bcf.zx_state AS zx_status
                 ,CASE WHEN bo.BO_SUCCESS_NUM = 1 THEN 0
                       WHEN bo.BO_SUCCESS_NUM > 1 THEN 1
                       ELSE NULL
                 END AS is_repeat_borrow
                 ,bo.is_video_audit
                 ,bo.video_audit_time
                 ,bo.first_audit_time                                    AS first_audit_time --  首次初审时间
                 ,bo.last_audit_pass_time                                AS last_audit_pass_time --  最近初审通过时间
                 ,bo.last_confirm_time                                   AS last_confirm_time --  最近终审时间
                 ,bo.confirm_pass_time                                   AS confirm_pass_time--  终审通过时间
                 ,tmp3.repay_begin_day                                   AS repay_begin_day --  起始还款日
                 ,tmp3.is_first_repay_overdue                            AS is_first_repay_overdue --  是否首还逾期
                 ,tmp3.first_repay_overdue_days                          AS first_repay_overdue_days --  首还逾期天数
                 ,urc.interest_rate_cut                                  AS interest_rate_cut --  减息
                 ,uhc.repayment_coupon                                   AS repayment_coupon --  还款券金额
                 ,'SYS'                                                  AS dw_create_by --  系统字段-创建者
                 ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS dw_create_time --  系统字段-创建时间
                 ,'SYS'                                                  AS dw_update_by --  系统字段-修改者
                 ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS dw_update_time --  系统字段-修改时间
                 ,bo.CUR_STATUS
                 ,bo.AUDIT_STATUS
                 ,bo.CONFIRM_STATUS
                 ,bo.AUDIT_REJECT_TIME
                 ,bo.CONFIRM_REJECT_TIME 
                 ,CASE WHEN cur_status regexp '拒绝' THEN bo.bo_audit_time END REJECT_TIME
                 ,bo.AUDIT_CANCEL_TIME
                 ,bo.CONFIRM_CANCEL_TIME
                 ,CASE WHEN cur_status regexp '流标' THEN COALESCE(bo.bo_cancel_time, bo.bo_audit_time) END FAIL_TIME
                 ,p.CATEGORY_NAME_01
                 ,p.BIZ_CODE_01
                 ,p.BIZ_NAME_01
                 ,bo.DEPOSITORY_FLAG
                 ,tmp3.FIRST_OVERDUE_EXPECT_NUM
                 ,tmp3.FIRST_OVERDUE_BR_TIME
                 ,bo.TRANSFER_ACCOUNT_TIME
                 ,p.P_NAME
                 ,tmp3.MONTHLY_REPAYMENT_AMT
                 ,bo.BO_SUCCESS_TIME
                 ,bo.BO_SUCCESS_NUM
                 ,bo.BO_CONFIRM_NUM
                 ,bs.user_identity_type
                 ,bs.total_amount
                 ,bs.base_amount
                 ,bs.used_amount
                 ,bs.increase_amount
                 ,bs.top_amount
                 ,bs.lbs_access_city
                 ,bs.lbs_complete_data_city
                 ,bs.credit_type
                 ,bo.bp_channel
                 ,bo.rc_id
                 ,bo.rc_name
                 ,bo.p_key
                 ,bia.p_name as bia_product
                 ,bia.biz_name
                 ,bo.pass_time
                 ,bo.ml_time
                 ,tmp3.LAST_REPAYED_TIME BO_LAST_REPAYED_TIME
                 ,bo.ml_price
                 ,bo.confirm_pass_price
                 ,case when bra.id is not null then 1 else 0 end IS_BORROWS_RAISE
                 ,cast(bra.is_stock_campaign as int) is_stock_campaign
                 ,bo.is_graduate
                 ,tmp3.second_repay_overdue_days
                 ,tmp3.third_repay_overdue_days
                 ,tmp3.fourth_repay_overdue_days
                 ,tmp3.fifth_repay_overdue_days
                 ,tmp3.sixth_repay_overdue_days
                 ,tmp3.seventh_repay_overdue_days
                 ,tmp3.eighth_repay_overdue_days
                 ,tmp3.ninth_repay_overdue_days
                 ,tmp3.tenth_repay_overdue_days
                 ,tmp3.eleventh_repay_overdue_days
                 ,tmp3.twelfth_repay_overdue_days
            FROM 
            (
                   SELECT t1.id AS bo_id, --  借款ID
                          case when ym.bo_id is not null and ym.is_lt = '否' then 28
                               when ym.bo_id is not null and ym.is_lt = '是' then 29 
                               when t1.p_id = 148 then 30 
                               when t1.p_id = 87 and bp.bp_channel = 7 then 4
                               when t1.p_id = 87 and bp.bp_channel = 6 then 1
                               when t1.p_id = 87 and bp.bp_channel = 5 then 2
                               when t1.p_id = 87 then 27
                               when t1.p_id = 110 then 3
                               when t1.p_id in (99, 88,83,77,102) and grad.user_id is not null and grad.graduate_date > '2019-02-19' and (oo.shop_name not like "%测试%" or oo.shop_name is null) then 8 
                               when t1.p_id = 88 then 5
                               when t1.p_id in (99, 77, 102) then 6
                               when t1.p_id = 83 then 7
                               when t1.p_id = 96 and oo.order_type = 2 and oo.shop_name not like '%测试%' then 9
                               when t1.p_id = 96 and (oo.order_type in (1,4) or oo.order_type is null) and (oo.shop_name not like "%测试%" or oo.shop_name is null) then 10
                               when t1.p_id = 145 and oo.review_source = '0' then 28
                               when t1.p_id = 145 and oo.review_source = '1' then 29
                               when t1.p_id = 104 then 11
                               when t1.p_id = 111 then 12
                               when t1.p_id = 140 then 20
                               when t1.p_id in (86, 93, 101) then 13
                               when pc.p_id is not null and t1.bo_paytype = 'XXHB' then 14
                               when pc.p_id is not null and t1.bo_paytype = 'DBDX' then 15
                               when t1.p_id = 92 then 17
                               when t1.p_id in (94, 97) then 18
                               when t1.bo_audit_time < '2016-06-29' and (oo.shop_name not like "%测试%" or oo.shop_name is null) then 16
                               else 19
                         end p_key,
                         bp.bp_channel,
                         t1.p_id AS p_id, --  产品ID
                         CASE WHEN t1.p_id IN (77, 83, 87, 88, 102) THEN '信用贷'
                              WHEN (t1.p_id = 93 AND t1.bo_audit_time < '2017-01-01') OR t1.id IN (845926) THEN '过桥'
                              WHEN t1.p_id IN (86, 103) OR t1.id IN (61892, 61894, 74633, 76582, 76834) OR t1.p_id = 93 THEN '大房东'
                              WHEN t1.p_id IN (94, 97) THEN 'Unifi'
                              WHEN t1.p_id IN (96, 104, 100) THEN '麦芽分期'
                              WHEN t1.p_id = 92 THEN '非标'
                              WHEN t1.bo_audit_time < '2015-03-01' THEN '融易贷' -- 2015.3.1之前老产品逾期率高  
                              ELSE '其他'
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
                            WHEN LENGTH(t1.bo_title) < 5 AND t1.bo_title NOT REGEXP '^[0-9A-Za-z]*$' THEN t1.bo_title
                            WHEN t1.bo_title REGEXP '创业' THEN '创业'
                            WHEN t1.bo_title REGEXP '应急周转' THEN '应急周转'
                            WHEN t1.bo_title REGEXP '培训' THEN '培训'
                            WHEN t1.bo_title REGEXP '消费' THEN '消费'
                            WHEN t1.bo_title REGEXP '就业' THEN '就业'
                            WHEN t1.bo_title REGEXP '旅游|旅行' THEN "旅行"
                            ELSE '(未知)'
                         END AS bo_purpose,
                         CASE
                            WHEN t1.bo_is_success = 1 AND t1.bo_all_repayed = 1 THEN '还款完成'
                            WHEN t1.bo_is_success = 1 AND t1.bo_all_repayed = 0 THEN '还款中'
                            WHEN ba.audit_status in ('终审拒绝',
                                                    '终审取消',
                                                    '初审拒绝',
                                                    '初审取消',
                                                    '未提交超时流标',
                                                    '初审回退超时流标',
                                                    '终审回退超时流标',
                                                    '用户已拒绝',
                                                    '外访拒绝',
                                                    '额度不足流标') THEN ba.audit_status
                            WHEN t1.bo_is_success = 2 THEN '拒绝'
                            WHEN t1.bo_is_success = 3 OR t1.bo_is_finish = 2 THEN '流标'
                            WHEN t1.bo_is_finish = 1 AND t1.bo_is_success = 0 THEN '募集完成待放款'
                            WHEN t1.bo_is_success = 0 AND t1.bo_is_finish = 0 AND t1.bo_can_success = 3 THEN '终审通过待匹配'
                            WHEN t1.bo_is_success = 0 AND t1.bo_is_finish = 0 AND ba.bo_id IS NULL THEN '待提交视频'
                            ELSE coalesce(ba.audit_status, '未知')
                         END cur_status,
                         IF(ba.bo_id IS NOT NULL, 1, 0) AS is_video_audit,
                         ba.video_audit_time,
                         CASE
                            WHEN ba.bo_id IS NOT NULL AND (ba.is_audit = 0 OR ba.is_audit IS NULL) THEN '未提交'
                            WHEN ba.is_audit = 1 THEN '初审通过'
                            WHEN ba.is_audit = 2 THEN '初审拒绝'
                            WHEN ba.is_audit = 3 THEN '待初审'
                            WHEN ba.is_audit = 4 THEN '初审回退'
                            WHEN ba.is_audit = 5 THEN '初审取消'
                         END AUDIT_STATUS,
                         CASE
                            WHEN ba.bo_id IS NOT NULL AND (ba.is_confirm = 0 OR ba.is_confirm IS NULL) THEN '未提交'
                            WHEN ba.is_confirm = 1 THEN '终审通过'
                            WHEN ba.is_confirm = 2 THEN '终审拒绝'
                            WHEN ba.is_confirm = 3 THEN '待终审'
                            WHEN ba.is_confirm = 4 THEN '终审回退'
                            WHEN ba.is_confirm = 5 THEN '终审取消'
                         END CONFIRM_STATUS,
                         t1.DEPOSITORY_FLAG,
                         t1.TRANSFER_ACCOUNT_TIME,
                         CASE WHEN t1.bo_is_success = 1 THEN COALESCE(t1.TRANSFER_ACCOUNT_TIME, t1.bo_agree_time) end BO_SUCCESS_TIME,
                         CASE WHEN t1.bo_is_success = 1 THEN row_number() over(PARTITION BY t1.user_id, t1.bo_is_success ORDER BY COALESCE(t1.transfer_account_time, t1.bo_agree_time)) END BO_SUCCESS_NUM,
                         CASE WHEN t1.bo_can_success = 3 THEN row_number() over(PARTITION BY t1.user_id, t1.bo_can_success ORDER BY t1.bo_audit_time) END BO_CONFIRM_NUM,
                         CASE WHEN t1.bo_is_success = 1 THEN COALESCE(t1.rc_id, 2) END rc_id,
                         CASE WHEN t1.bo_is_success = 1 AND t1.rc_id = 1 THEN '星河金服' WHEN t1.bo_is_success = 1 AND (t1.rc_id = 2 OR t1.rc_id IS NULL) THEN '诺诺网贷' END rc_name,
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
                         ba.confirm_pass_price,
                         case 
                            when get_json_object(t1.bo_change_remark, '$.type') = 0 then '未知'
                            when get_json_object(t1.bo_change_remark, '$.type') = 1 then '专科以下'
                            when get_json_object(t1.bo_change_remark, '$.type') = 2 then '已毕业'
                            when get_json_object(t1.bo_change_remark, '$.type') = 3 then '未毕业'
                            else '未知'
                         end is_graduate
                    FROM odsopr.borrows t1
               LEFT JOIN idw.FACT_BORROWS_AUDIT ba
                      ON t1.id = ba.bo_id
               left join msc.xinyimei ym 
                      on cast(ym.bo_id as bigint) = t1.id 
                     and cast(ym.nono_id as bigint) = t1.user_id
               LEFT JOIN odsopr.borrows_prepare bp
                      ON t1.bp_id = bp.id
               left join odsopr.ord_order oo
                      on t1.id = oo.bo_id
                     and oo.disabled = 0
                     and oo.bo_id > 0
               left join odsopr.products_config pc
                      on t1.p_id = pc.p_id
                     and pc.key = 'car_loan_flag'
                     AND pc.value = '1'                 
               left join 
                       (
                            SELECT row_number() OVER (PARTITION BY ff.user_id ORDER BY ff.create_time DESC, ff.is_school_record DESC, ff.education DESC, ff.graduate_date ASC, ff.update_time DESC) h_ctime,
                                   ff.user_id, ff.graduate_date 
                               FROM
                                (   SELECT DISTINCT 
                                                  f.user_id,
                                                  f.education,
                                                  f.is_school_record,
                                                  f.graduate_date,
                                                  f.create_time,
                                                  f.update_time
                                       FROM
                                       (
                                                 SELECT el.user_id,
                                                        1 is_school_record,
                                                        el.education,
                                                        CASE
                                                            WHEN el.graduate_date = substr(to_date(el.create_time), 1, 4) AND substr(to_date(el.create_time), 6, 5) >= '07-01' THEN concat(substr(to_date(el.create_time), 1, 4), '-07-01')
                                                            WHEN el.graduate_date = substr(to_date(el.create_time), 1, 4) AND substr(to_date(el.create_time), 6, 5) <= '07-01' THEN to_date(el.create_time)
                                                            WHEN el.graduate_date < substr(to_date(el.create_time), 1, 4) THEN concat(CAST(CAST(el.graduate_date AS INT) AS STRING), '-07-01')
                                                        END graduate_date,
                                                        el.create_time,
                                                        el.update_time
                                                   FROM odsopr.user_edu_auth_log el
                                                  WHERE el.auth_status = 1
                                                    AND el.education IN (2,3,4,5)
                                                            
                                                UNION ALL 
                                                
                                               SELECT si.user_id,
                                                      0 is_school_record,
                                                      CASE
                                                          WHEN si.education IN ('大专','大专WFXSSProbe','专科','专科(高职)') THEN 2
                                                          WHEN si.education IN ('大学本科(简称大学)','本科','专升本') THEN 3
                                                          WHEN si.education IN ('硕士研究生','硕士及以上','研究生') THEN 4
                                                          WHEN si.education IN ('博士研究生','博士') THEN 5
                                                          WHEN si.education IS NOT NULL THEN 1
                                                      END education,
                                                      CASE
                                                          WHEN si.create_time < '2018-04-18' AND si.edu_graduate_date IS NOT NULL THEN concat(substr(si.edu_graduate_date, 1, 4), '-', substr(si.edu_graduate_date, 5, 2), '-', substr(si.edu_graduate_date, 7, 2))
                                                          WHEN si.education IN ('大学本科(简称大学)','本科') THEN concat(CAST((CAST(si.edu_start_date AS INT) + 4) AS STRING), '-07-01')
                                                          WHEN si.education IN ('专升本') THEN concat(CAST((CAST(si.edu_start_date AS INT) + 2) AS STRING), '-07-01')
                                                          WHEN si.education IN ('大专','大专WFXSSProbe','专科','专科(高职)','硕士研究生','硕士及以上','研究生') THEN concat(CAST((CAST(si.edu_start_date AS INT) + 3) AS STRING), '-07-01')
                                                          WHEN si.education IN ('博士研究生','博士') THEN concat(CAST((CAST(si.edu_start_date AS INT) + 3) AS STRING), '-07-01')
                                                      END graduate_date,
                                                      si.create_time,
                                                      si.update_time
                                                 FROM odsopr.user_student_info si
                                                WHERE si.education IS NOT NULL
                                                  AND si.education IN ('大专', '大专WFXSSProbe', '专科', '专科(高职)', '大学本科(简称大学)', '本科', '专升本', '硕士研究生', '硕士及以上', '研究生', '博士研究生', '博士')
                                                  AND si.edu_start_date IS NOT NULL
                                       
                                                UNION ALL 
                                                
                                               SELECT py.user_id,
                                                      1 is_school_record,
                                                      CASE
                                                          WHEN py.degree IN ('专科(高职)', '专科(高职', '专科', '第二专科') THEN 2
                                                          WHEN py.degree IN ('本科', '第二学士学位', '第二本科', '高升本', '专升本') THEN 3
                                                          WHEN py.degree = '硕士研究生' THEN 4
                                                          WHEN py.degree = '博士研究生' THEN 5
                                                          ELSE 1
                                                      END education,
                                                      CASE
                                                          WHEN py.graduatetime = substr(to_date(py.create_time), 1, 4) AND substr(to_date(py.create_time), 6, 5) >= '07-01' THEN concat(substr(to_date(py.create_time), 1, 4), '-07-01')
                                                          WHEN py.graduatetime = substr(to_date(py.create_time), 1, 4) AND substr(to_date(py.create_time), 6, 5) <= '07-01' THEN to_date(py.create_time)
                                                          WHEN py.graduatetime < substr(to_date(py.create_time), 1, 4) THEN concat(CAST(CAST(py.graduatetime AS INT) AS STRING), '-07-01')
                                                      END graduate_date,
                                                      py.create_time,
                                                      py.update_time
                                                 FROM odsopr.user_pengyuan_edu_record py
                                                WHERE py.degree IS NOT NULL
                                                  AND py.degree IN ('专科(高职)', '专科(高职', '专科', '第二专科', '本科', '第二学士学位', '第二本科', '高升本', '专升本', '硕士研究生', '博士研究生')
                                        ) f
                                ) ff
                       ) grad  
                      on grad.user_id = t1.user_id 
                     and grad.h_ctime = 1
            ) bo
    LEFT JOIN 
            (
                    SELECT bo_id, MAX(zx_price) zx_price, MAX(zx_state) zx_state
                      FROM odsopr.borrows_consulted_fee_hist
                  GROUP BY bo_id
            ) bcf
          ON bo.bo_id = bcf.bo_id
   LEFT JOIN tmp.tmp_fact_borrows_plus_01 tmp3
          ON bo.bo_id = tmp3.bo_id
   LEFT JOIN 
           (
                    SELECT bp_id, SUM(cutvalue) interest_rate_cut
                      FROM odsopr.user_interestratecut_hist
                     WHERE bp_id > 0
                  GROUP BY bp_id
           ) urc
          ON bo.bp_id = urc.bp_id
   LEFT JOIN 
           (
                    SELECT bo_id, SUM(VALUE) repayment_coupon
                      FROM odsopr.user_hkconpon_hist
                     WHERE bo_id > 0
                  GROUP BY bo_id
            ) uhc
           ON bo.bo_id = uhc.bo_id
    LEFT JOIN idw.DIM_ASSET_PRODUCT p
           ON bo.p_id = p.p_id
    LEFT JOIN odsopr.borrows_snapshot_hist bs
           ON bo.bo_id = bs.bo_id
          and bs.is_delete = 0
    left join idw.fact_user_info ui
           on bo.user_id = ui.user_id
    left join odsopr.fact_channel_group_hist cg
           on ui.channel_id = cg.channel_id
          and cg.group_code = 'DLD'
    left join odsopr.borrows_raise bra
           on bo.bo_id = bra.bo_id
    left join odsopr.dim_bia_asset_product_plus bia
           on bia.p_key = bo.p_key
    ;
