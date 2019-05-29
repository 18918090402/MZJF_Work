set mapreduce.job.queuename= etl-kpi;

drop table if exists tmp.tmp_fact_borrows_01;
create table if not exists tmp.tmp_fact_borrows_01
stored as parquet 
as 
select user_id,bo_id
  from (select user_id,
               id bo_id,
               row_number() over(partition by user_id order by id) as rn
          from odsopr.borrows) x
 where rn = 1;

insert overwrite table idw.fact_borrows
  select /*+ mapjoin(ub) */
   bo.id as bo_id, --  借款ID
   bo.p_id as p_id, --  产品ID
   bo.bp_id as bp_id, --  预发标ID
   bo.user_id as user_id, --  用户ID
   bo.bo_aim as bo_aim, --  借款目的
   bo.bo_title as bo_title, --  借款标题
   bo.bo_repaysrc as bo_repaysrc, --  还款来源
   bo.bo_price as bo_price, --  借款金额
   bo.bo_finish_price as bo_finish_price, --  完成金额
   bo.bo_expect as bo_expect, --  借款期限
   bo.bo_expect_cat as bo_expect_cat, --  借款期限单位
   bo.bo_bidding_type as bo_bidding_type, --  标的类型
   bo.bo_safeguard_type as bo_safeguard_type, --  保障方式
   bo.bo_type as bo_type, --  借款类型
   bo.is_assurance as is_assurance, --  是否请求担保
   bo.bo_rate as bo_rate, --  借款年利率
   bo.bo_time as bo_time, --  有效时间
   bo.bo_paytype as bo_paytype, --  还款方式
   bo.bo_is_index as bo_is_index, --  是否推荐
   bo.bo_is_state as bo_is_state, --  借款状态
   bo.publish_time as publish_time, --  发布时间
   bo.bo_finish_rate as bo_finish_rate, --  完成度
   bo.bo_is_finish as bo_is_finish, --  是否完成
   bo.bo_finish_time as bo_finish_time, --  完成时间
   bo.bo_sign_am_id as bo_sign_am_id, --  签约人员
   bo.bo_sign_time as bo_sign_time, --  签约时间
   bo.bo_sign_result as bo_sign_result, --  签约结果
   NULL as bo_sign_remark, --  签约备注
   bo.bo_audit_am_id as bo_audit_am_id, --  审核人员
   bo.bo_audit_time as bo_audit_time, --  审核时间
   bo.bo_audit_remark as bo_audit_remark, --  审核备注
   bo.bo_is_success as bo_is_success, --  是否审核通过
   bo.bo_can_success as bo_can_success, --  是否可以审核通过
   bo.bo_is_republish as bo_is_republish, --  是否已重发
   bo.bo_is_case as bo_is_case, --  是否推荐案例
   bo.bo_guid as bo_guid, --  电子协议guid
   bo.bo_extno as bo_extno, --  协议编号
   bo.bo_agree_generated as bo_agree_generated, --  协议是否生成
   bo.bo_agree_time as bo_agree_time, --  协议生成时间
   bo.bo_all_repayed as bo_all_repayed, --  借款还款结束
   bo.bo_last_repayed_time as bo_last_repayed_time, --  最近还款时间
   bo.bo_sorce_talk as bo_sorce_talk, --  谈吐分值
   bo.bo_sorce_instrument as bo_sorce_instrument, --  仪表分值
   bo.bo_sorce_face as bo_sorce_face, --  面相分值
   bo.bo_sorce_cooperation as bo_sorce_cooperation, --  配合度分值
   bo.bo_pledge as bo_pledge, --  是否抵押
   bo.bo_house as bo_house, --  房产信息
   bo.bo_overdue_day_count as bo_overdue_day_count, --  逾期天数
   NULL as bo_overdue_remark, --  逾期备注
   bcf.zx_price as zx_price,
   bo.creator as creator,
   bo.updator as updator,
   bo.create_time as create_time,
   bo.update_time as update_time,
   CASE
     WHEN length(bo.bo_title) < 5 and bo.bo_title not regexp
      '^[0-9A-Za-z]*$' THEN
      bo.bo_title
     WHEN bo.bo_title regexp '创业' THEN
      '创业'
     WHEN bo.bo_title regexp '应急周转' THEN
      '应急周转'
     WHEN bo.bo_title regexp '培训' THEN
      '培训'
     WHEN bo.bo_title regexp '消费' THEN
      '消费'
     WHEN bo.bo_title regexp '就业' THEN
      '就业'
     WHEN bo.bo_title regexp '旅游|旅行' THEN
      "旅行"
     ELSE
      '(未知)'
   END as bo_purpose, --  借款用途
   if(ba.bo_id is not null, 1, 0) as is_video_audit, --  是否提交视频
   ba.create_time as video_audit_time, --  视频提交时间
   if(ub.bo_id is not null, 0, 1) as is_repeat_borrow, --  是否复借
   'SYS' as dw_create_by, --  系统字段-创建者
   from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time, --  系统字段-创建时间
   'SYS' as dw_update_by, --  系统字段-修改者
   from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time --  系统字段-修改时间
    FROM odsopr.borrows bo
    LEFT JOIN odsopr.products p
      ON p.id = bo.p_id
    LEFT JOIN (select bo_id, max(create_time) create_time
                 from odsopr.borrows_archive
                where keyword = 'borrow_video_audit'
                group by bo_id) ba
      on bo.id = ba.bo_id
    LEFT JOIN tmp.tmp_fact_borrows_01 ub
      on bo.user_id = ub.user_id
     and bo.id = ub.bo_id
    LEFT JOIN odsopr.borrows_consulted_fee bcf
      ON bo.id = bcf.bo_id;

drop table if exists tmp.tmp_fact_borrows_01;