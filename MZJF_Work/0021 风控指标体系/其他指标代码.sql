

drop table if exists msc.risk_basic_inf_20181218 ;

     
create table msc.risk_basic_inf_20181218
as 
     select '线上' ind
            ,bo.user_id
            ,case 
                when bo.score is not null and bo.level in ('A') then 'A'
                when bo.score is not null and bo.level in ('B') then 'B'
                when bo.score is not null and bo.level in ('C') then 'C'
                when bo.score is not null and bo.level in ('D') then 'D'
                when bo.score is not null and bo.level in ('E') then 'E'
                when bo.score is not null and bo.level in ('F') then 'F'
                else '其他'
            end as level_cat
            ,case 
                when bo.product = '信用贷（专）'           then '010101'
                when bo.product = '信用贷（本）'           then '010102'
                when bo.product = '名校贷应急包'           then '010103'
                when bo.product = '大额借'                 then '010201'
                when bo.product = '高学历贷'               then '010202'
                when bo.product = '消费能力贷'             then '010203'
                when bo.product = '白领包'                 then '010301'
                when bo.product = '社保贷'                 then '010302'
                when bo.product = '应届贷'                 then '010303'
                when bo.product = '金卡-信用贷'            then '010401'
                when bo.product = '金卡-麦子借款'          then '010402'
                else '000000'
            end as product_cd
            ,bo.p_key
            ,null                       as order_no
            ,ap.APPLY_NO                as apply_no
            ,ap.APPLY_DATE              as APPLY_DATE
            ,ap.APPLY_AMT               as APPLY_AMT
            ,bo.bo_agree_time           as DISBURSED_DATE
            ,bo.bo_finish_price         as DISBURSED_amt
            ,ap.APPLY_TERM
            ,ap.APPROVE_RESULT
            ,ap.REFUSE_REASON
            ,ap.AUTO_DECISION
            ,bo.bo_is_success
            ,ap.stat_date
       from dmt_rm.fact_apply ap
  left join (
                  select bo.user_id,
                         bo.bo_id ,
                         bo.bo_agree_time,
                         case
                           when bo.p_id = 87 and bp.bp_channel = 5   then '社保贷'
                           when bo.p_id = 87 and bp.bp_channel = 6   then '应届贷'
                           when bo.p_id = 87 and bp.bp_channel = 7   then '按揭贷'
                           when bo.p_id = 110 and bo.credit_type = 2 then '高学历贷'
                           when bo.p_id = 110 and bo.credit_type = 3 then '消费能力贷'
                           when bo.p_id = 140 and (mp.external_channel = '3' or mp.external_channel is null ) then '金卡-麦子借款'
                           when bo.p_id = 140 and mp.external_channel = '4' then '金卡-信用贷'
                           else bo.p_name
                         end PRODUCT,
                         bo.p_id,
                         bo.p_key,
                         bo.p_name,
                         bo.bo_finish_price,
                         bo.bo_is_success,
                         dm.SCORE_LEVEL LEVEL,
                         dm.SCORE_RESULT SCORE
                    from idw.fact_borrows bo
                    left join odsopr.borrows_prepare bp
                      on bo.bp_id = bp.id
                    left join 
                            (
                                select bp_id,
                                       user_id,
                                       max(case when data_no = 'scoreLevel' then data_value end) SCORE_LEVEL,
                                       max(case when data_no = 'scoreResult' then data_value end) SCORE_RESULT
                                  from (select bp_id,user_id,data_value,data_no,
                                               row_number() over(partition by bp_id, data_no order by id desc) rn
                                          from ods.t_des_main_hist 
                                          where data_no in ( 'scoreLevel','scoreResult' ) ) s
                                 where s.rn = 1
                                 group by bp_id, user_id
                            ) dm
                      on bo.bp_id = dm.bp_id
                     and bo.user_id = dm.user_id
               left join odsopr.borrows_external_mapping mp 
                      on mp.bo_id = bo.bo_id
            ) bo 
         on bo.bo_id = ap.APPLY_NO
      where (ap.product not like '%麦芽%' or ap.product not like '%美呗%')   -- 由于fact_apply的数据来自borrows表，没有将线下的产品剔除掉
        and ap.stat_date = cast(regexp_replace(to_date(date_sub(now(),2)),'-','') as int)
      
      union all
      
     select '线下' ind
            ,am.nono_user_id        as user_id
            ,am1.LEVEL              as level_cat
            ,case 
                when am1.flag = '老医美' and am1.dic_item in ('教育', '婚庆')    then '020101'
                when am1.flag = '老医美' and am1.dic_item = '医疗美容'           then '020102'
                when am1.flag = '新医美' and am1.qd_pass <> '1'                  then '020201'
                when am1.flag = '新医美' and am1.qd_pass = '1'                   then '020202'
                else '000000'
            end as product_cd
            ,bo.p_key
            ,am.order_no                    as order_no
            ,am.APPLY_NO                    as apply_no
            ,am.create_time                 as APPLY_DATE
            ,am.APPLY_AMOUNT                as APPLY_AMT            
            ,bo.bo_agree_time               as disbursed_date            
            ,bo.bo_finish_price             as disbursed_amt
            ,am.TOTAL_PARTS                 as APPLY_TERM
            ,am.ORDER_STATUS                AS APPROVE_RESULT
            ,am.REFUSE_REASON               as REFUSE_REASON
            ,''                             as AUTO_DECISION
            ,bo.bo_is_success
            ,am.stat_date
       from dmt_rm.fact_apply_maiya_data am
  left join (
                 SELECT t.order_no, 
                        t.apply_no,
                        t.qd_pass,
                        t.dic_item,
                        case 
                            when to_date(t.create_time) >= '2018-04-03' and merchant_name = '上海迪蔻医疗美容门诊部有限公司'     then '新医美'
                            when to_date(t.create_time) >= '2018-04-03' and merchant_name = '上海雅尚医疗美容门诊部有限公司'     then '新医美'
                            when to_date(t.create_time) >= '2018-04-12' and merchant_name = '上海容妍医院管理有限公司'           then '新医美'
                            when to_date(t.create_time) >= '2018-04-21' and merchant_name = '上海纽赛医疗美容门诊部有限公司'     then '新医美'
                            when to_date(t.create_time) >= '2018-04-21' and merchant_name = '上海韩镜医疗美容医院有限公司'       then '新医美'
                            when to_date(t.create_time) >= '2018-04-24' and merchant_name = '上海南山医院有限公司'               then '新医美'
                            when to_date(t.create_time) >= '2018-04-25' and merchant_name = '上海历思医疗美容门诊部有限公司'     then '新医美'
                            when to_date(t.create_time) >= '2018-05-11' and merchant_name = '上海名媛医疗美容门诊部有限公司'     then '新医美'
                            when to_date(t.create_time) >= '2018-05-11' and merchant_name = '上海明桥医疗美容门诊部有限公司'     then '新医美'
                            when to_date(t.create_time) >= '2018-05-19' and merchant_name = '上海翔茂医疗美容门诊部有限公司'     then '新医美'
                            when to_date(t.create_time) >= '2018-05-31' and merchant_name = '上海翡立思医疗美容门诊部有限公司'   then '新医美'
                            when to_date(t.create_time) >= '2018-06-22' and merchant_name = '广州艾美医疗美容门诊有限公司'       then '新医美'
                            when to_date(t.create_time) >= '2018-06-22' and merchant_name = '特壹美（广州）健康管理有限公司'     then '新医美'
                            when to_date(t.create_time) >= '2018-06-22' and merchant_name = '广州新颜医疗美容门诊有限公司'       then '新医美'
                            when to_date(t.create_time) >= '2018-06-22' and merchant_name = '深圳恒丽医疗美容门诊部有限公司'     then '新医美'
                            when to_date(t.create_time) >= '2018-06-26' and merchant_name = '上海复美医疗美容门诊部有限公司'     then '新医美'
                            when to_date(t.create_time) >= '2018-06-25' and merchant_name = '深圳臻希美医疗美容门诊部'           then '新医美'
                            when to_date(t.create_time) >= '2018-06-22' and merchant_name = '深圳市八福贸易有限公司盛美佳门诊部' then '新医美'
                            when to_date(t.create_time) >= '2018-07-04' and merchant_name = '上海铭悦医疗美容门诊部有限公司'     then '新医美'
                            else '老医美'
                        end as flag,
                        ll.LEVEL
                   from dmt_rm.fact_apply_maiya_data t 
              left join (
                            select order_no,
                                   max(CREDIT_LEVEL) AS LEVEL 
                              from ODS.T_ORD_ORDER_HIST 
                             where DISABLED = 0
                             group by order_no
                        ) ll
                     on ll.order_no = t.order_no
                  where t.MERCHANT_NAME not LIKE '%测试%'
                    and t.stat_date = cast(regexp_replace(to_date(date_sub(now(),2)),'-','') as int)
            ) am1
         on am1.order_no = am.order_no
  left join idw.fact_borrows bo 
         on bo.bo_id = am.apply_no
      where am.MERCHANT_NAME not LIKE '%测试%'
        and am.stat_date = cast(regexp_replace(to_date(date_sub(now(),2)),'-','') as int)
      ;       

      
      
      
--
drop table if exists dw_srm.fact_risk_quota_d;


create table dw_srm.fact_risk_quota_d
as
     select t.user_id
            ,t.order_no
            ,t.apply_no
            ,t.level_cat
            ,t.product_cd
            ,t.p_key
            ,to_date(t.apply_date) as apply_date
            ,t.apply_amt
            ,to_date(t.disbursed_date) as disbursed_date
            ,t.disbursed_amt
            
            --放款数
            ,case when disbursed_amt > 0 then 1 else 0 end as disbursed_num
                       
            --申请数
            ,case when t.ind = '线上' then 1 else 0 end as crd_apply_num
            ,case when t.ind = '线下' then 1 else 0 end as cus_apply_num
            
            --申请金额
            ,case when t.ind = '线上' then t.apply_amt else 0 end as crd_apply_amt
            ,case when t.ind = '线下' then t.apply_amt else 0 end as cus_apply_amt
            
            --申请期限
            ,case when t.ind = '线上' then t.apply_term else 0 end as crd_apply_term
            ,case when t.ind = '线下' then t.apply_term else 0 end as cus_apply_term
            
            --拒绝的申请
            ,case when t.ind = '线上' and t.approve_result like '%拒绝%'       then 1 else 0 end as crd_apply_num_refuse
            ,case when t.ind = '线下' and t.approve_result like '%审核不通过%' then 1 else 0 end as cus_apply_num_refuse
            ,case when t.ind = '线上' and t.approve_result like '%拒绝%'       then 1 else 0 end as aud_1_apply_num_refuse
            ,case when t.ind = '线下' and t.approve_result like '%审核不通过%' then 1 else 0 end as aud_2_apply_num_refuse
            
            --自动拒绝的申请
            ,case when t.ind = '线上' and t.APPROVE_RESULT like '%拒绝%' and t.AUTO_DECISION = '自动拒绝'  then 1 else 0 end     as crd_apply_num_auto_refuse
            ,case when t.ind = '线上' and ap1.apply_no is not null and ap1.aud_1_apply_num_auto_refuse = 1 then 1 else 0 end     as aud_1_apply_num_auto_refuse
            ,case when t.ind = '线下' and ap2.order_no is not null and ap2.aud_2_apply_num_auto_refuse = 1 then 1 else 0 end     as aud_2_apply_num_auto_refuse
        
            --人工拒绝的申请
            ,case when t.ind = '线上' and t.APPROVE_RESULT like '%拒绝%' and t.AUTO_DECISION = '人工' then 1 else 0 end        as crd_apply_num_manual_refuse
            ,case when t.ind = '线上' and ap1.apply_no is not null and ap1.aud_1_apply_num_manual_refuse = 1 then 1 else 0 end as aud_1_apply_num_manual_refuse
            ,case when t.ind = '线下' and ap2.order_no is not null and ap2.aud_2_apply_num_manual_refuse = 1 then 1 else 0 end as aud_2_apply_num_manual_refuse
            
            --通过的申请数
            ,case when t.ind = '线上' and t.approve_result like '%终审通过%'      then 1 else 0 end                   as crd_apply_num_pass
            ,case when t.ind = '线下' and t.approve_result in ('已放款','已结清') then 1 else 0 end                   as cus_apply_num_pass
            ,case when t.ind = '线上' and t.approve_result like '%终审通过%'      then 1 else 0 end                   as aud_1_apply_num_pass
            ,case when t.ind = '线下' and ap2.order_no is not null and ap2.aud_2_apply_num_pass = 1 then 1 else 0 end as aud_2_apply_num_pass
            
            --自动通过的申请数
            ,case when t.ind = '线上' and t.APPROVE_RESULT like '%终审通过%' and t.AUTO_DECISION = '自动通过' then 1 else 0 end      as crd_apply_num_auto_pass
            ,case when t.ind = '线上' and t.APPROVE_RESULT like '%终审通过%' and ap1.aud_1_apply_num_auto_pass = 1 then 1 else 0 end as aud_1_apply_num_auto_pass
            
            --人工通过的申请数
            ,case when t.ind = '线上' and t.APPROVE_RESULT like '%终审通过%' and t.AUTO_DECISION = '人工' then 1 else 0 end as crd_apply_num_manual_pass
            
            --取消的申请数
            ,case when t.ind = '线上' and t.approve_result like '%取消%' then 1 else 0 end                              as crd_apply_num_cancel
            ,case when t.ind = '线下' and t.approve_result = '取消' then 1 else 0 end                                   as cus_apply_num_cancel
            ,case when t.ind = '线上' and t.approve_result like '%取消%' then 1 else 0 end                              as aud_1_apply_num_cancel
            ,case when t.ind = '线下' and ap2.order_no is not null and ap2.aud_2_apply_num_cancel = 1 then 1 else 0 end as aud_2_apply_num_cancel
            
            --欺诈的申请数
            ,case when t.ind = '线上' and (t.refuse_reason like '%盗用%' or
                                           t.refuse_reason like '%造假%' or
                                           t.refuse_reason like '%虚假%' or
                                           t.refuse_reason like '%诈骗%' or
                                           t.refuse_reason like '%套现%' or
                                           t.refuse_reason like '%CD12：网贷黑名单用户%' or
                                           t.refuse_reason like '%ZD12：网贷黑名单用户%' or
                                           t.refuse_reason like '%ED0201：外部网贷黑名单%') then 1 else 0 end           as crd_apply_num_fraud
            ,case when t.ind = '线下' and (t.refuse_reason like '%欺诈%' or
                                           t.refuse_reason like '%盗用%' or
                                           t.refuse_reason like '%造假%' or
                                           t.refuse_reason like '%虚假%' or
                                           t.refuse_reason like '%诈骗%' or
                                           t.refuse_reason like '%套现%' or
                                           t.refuse_reason like '%CD12：网贷黑名单用户%' or
                                           t.refuse_reason like '%ZD12：网贷黑名单用户%' or
                                           t.refuse_reason like '%ED0201：外部网贷黑名单%') then 1 else 0 end           as cus_apply_num_fraud
            
            --线上审批的时间
            ,crd_apl_hour.crd_approve_pass_hour
            ,crd_apl_hour.crd_approve_refuse_hour
            ,crd_apl_hour.crd_approve_cancel_hour
            
            --信审审批的时间
            
       from msc.risk_basic_inf_20181218 t
  left join (
                 select apply_no
                        ,max(case when process_name LIKE '%自动审批拒绝%' then 1 else 0 end)                                           as aud_1_apply_num_auto_refuse
                        ,max(case when process_name LIKE '%拒绝%'  and (audit_name <> '' OR audit_name is not null) then 1 else 0 end) as aud_1_apply_num_manual_refuse
                        ,max(case when process_name LIKE '%自动审批通过%' then 1 else 0 end)                                           as aud_1_apply_num_auto_pass
                   from dmt_rm.fact_approval_mxdmy_data 
               group by apply_no
            ) ap1   --线上
         on cast(ap1.apply_no as bigint) = t.apply_no
  left join (
                 select order_no
                        ,max(case when process_name LIKE '%审核不通过%' and audit_name = '' then 1 else 0 end)                         as aud_2_apply_num_auto_refuse
                        ,max(case when process_name LIKE '%审核不通过%' and audit_name <> '' then 1 else 0 end)                        as aud_2_apply_num_manual_refuse
                        ,max(case when process_name in ('待客户确认', '推标中') then 1 else 0 end)                                     as aud_2_apply_num_pass
                        ,max(case when process_name LIKE '%取消%' and audit_name <> '' and audit_name <> '.' then 1 else 0 end)        as aud_2_apply_num_cancel
                   from dmt_rm.fact_approval_mxdmy_data 
               group by order_no
            ) ap2   --线下
         on ap2.order_no = t.order_no         
  left join (
                       select t.apply_no 
                            --线上审核时间
                            ,(unix_timestamp(max(case when t.approve_result like '%终审通过%' then apl.process_begin_time end)) - unix_timestamp(min(case when t.approve_result like '%终审通过%' then apl.process_begin_time end)))/3600 as crd_approve_pass_hour
                            ,(unix_timestamp(max(case when t.approve_result like '%拒绝%' then apl.process_begin_time end)) - unix_timestamp(min(case when t.approve_result like '%拒绝%' then apl.process_begin_time end)))/3600         as crd_approve_refuse_hour
                            ,(unix_timestamp(max(case when t.approve_result like '%取消%' then apl.process_begin_time end)) - unix_timestamp(min(case when t.approve_result like '%取消%' then apl.process_begin_time end)))/3600         as crd_approve_cancel_hour
                       from msc.risk_basic_inf_20181218 t 
                  left join dmt_rm.fact_approval_mxdmy_data apl 
                         on cast(apl.apply_no as bigint) = t.apply_no 
                      where t.ind = '线上' 
                        and (t.approve_result like '%终审通过%' or t.approve_result like '%拒绝%' or t.approve_result like '%取消%')
                   group by t.apply_no 
            ) crd_apl_hour
          on crd_apl_hour.apply_no = t.apply_no
;



--
create view dw_srmopr.fact_risk_quota_d as select * from dw_srm.fact_risk_quota_d ;




--还原历史数据 

drop table if exists msc.fact_borrows_unrepay_h_20181220;


CREATE TABLE msc.fact_borrows_unrepay_h_20181220 
(
    user_id                      bigint,
    bo_id                        bigint,
    bo_finish_price              decimal(38,10),
    bo_agree_time                string,
    overdue_unrepay_days         int,
    unrepay_price_b              decimal(38,10),
    unrepay_price_l              decimal(38,10),
    unrepay_price                decimal(38,10)
)
comment '历史未还本金-补'
partitioned by (stat_date string comment '统计日期 年-月')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





insert overwrite table msc.fact_borrows_unrepay_h_20181220 partition (stat_date)
 select br.user_id
        ,br.bo_id
        ,bo.bo_finish_price
        ,bo.bo_agree_time
        ,max(case 
                when br.BR_OVERDUE_TERMS > 0 and br.br_is_repay = 0 or to_date(br.br_repay_time) >= to_date('${dt}') 
                    then case 
                            when datediff(to_date('${dt}'), to_date(br.br_time)) >= 0 
                                then datediff(to_date('${dt}'), to_date(br.br_time)) 
                         end 
            end) as overdue_unrepay_days
        ,sum(case when br.br_is_repay = 0 or to_date(br.br_repay_time) > '${dt}' then br.br_price_b else 0 end) as unrepay_price_b
        ,sum(case when br.br_is_repay = 0 or to_date(br.br_repay_time) > '${dt}' then br.br_price_l else 0 end) as unrepay_price_l
        ,sum(case when br.br_is_repay = 0 or to_date(br.br_repay_time) > '${dt}' then br.br_price else 0 end)   as unrepay_price        
        ,'${dt}' as stat_date
   from idw.fact_borrows_repayment br
   join idw.fact_borrows bo
     on br.bo_id = bo.bo_id
    and bo.bo_agree_time is not null 
    and to_date(bo.bo_agree_time) <= '${dt}'
  --where 1=1
    --and ( br.br_is_repay = 0 or to_date(br.br_repay_time) > '${dt}' )
    --and br.bo_id = 2538272
group by 1,2,3,4,9
;




--    数据从  2013-12-20 18:43:14.0  开始恢复


drop table if exists msc.fact_risk_overdue_quota_m_prepare;


CREATE TABLE msc.fact_risk_overdue_quota_m_prepare 
(
    user_id                         bigint,
    level_type                      string,
    bo_id                           bigint,
    product_cd                      string,
    p_key                           int,
    expect_type                     int,
    amc_type                        int,
    graduate_type                   int,
    m3p_type                        int,
    m6p_type                        int,
    bo_success_date                 string,
    bo_finish_price                 decimal(38,10),
    overdue_unrepay_days            int,
    unrepay_price_b                 decimal(38,10),
    m0                              int,
    m0_unrepay_price_b              decimal(38,10),
    m1                              int,
    m1_unrepay_price_b              decimal(38,10),
    m2                              int,
    m2_unrepay_price_b              decimal(38,10),
    m3                              int,
    m3_unrepay_price_b              decimal(38,10),
    m4                              int,
    m4_unrepay_price_b              decimal(38,10),
    m2p                             int,
    m2p_unrepay_price_b             decimal(38,10),
    m4p                             int,
    m4p_unrepay_price_b             decimal(38,10),
    new_loss                        int,
    new_loss_unrepay_price_b        decimal(38,10),
    mob                             int,
    fraud_loss                      int,
    fraud_loss_unrepay_price_b      decimal(38,10)
)
comment '风控逾期指标表 - 预准备'
partitioned by (stat_date string comment '统计日期 年-月')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;



--old
     insert overwrite table msc.fact_risk_overdue_quota_m_prepare partition (stat_date)
     select t.user_id 
            ,dim.level_cat
            ,t.bo_id
            ,case 
                when dim.product = '信用贷（专）'           then '010101'
                when dim.product = '信用贷（本）'           then '010102'
                when dim.product = '名校贷应急包'           then '010103'
                when dim.product = '大额借'                 then '010201'
                when dim.product = '高学历贷'               then '010202'
                when dim.product = '消费能力贷'             then '010203'
                when dim.product = '白领包'                 then '010301'
                when dim.product = '社保贷'                 then '010302'
                when dim.product = '应届贷'                 then '010303'
                when dim.product = '金卡-信用贷'            then '010401'
                when dim.product = '金卡-麦子借款'          then '010402'
                when dim.product = '极速金卡-信用贷'        then '010501'
                when dim.product = '极速金卡-麦子借款'      then '010502'
                when dim.product = '教育分期'               then '020101'
                when dim.product = '医美分期'               then '020102'
                when dim.product = '爱美呗分期(非担保)'     then '020201'
                when dim.product = '爱美呗分期(担保)'       then '020202'
                else '000000'
            end as product_cd            
            ,dim.p_key                      --大一统产品p_key
            ,dim.bo_expect_type             --产品期限分类     
            ,t.bo_agree_time                --放款时间
            ,dim.bo_finish_price            --放款金额
            ,t.overdue_unrepay_days         --当前逾期天数
            ,t.unrepay_price_b              --逾期未还本金
            ,case when t.OVERDUE_UNREPAY_DAYS =   0  or t.OVERDUE_UNREPAY_DAYS is null  then 1 else 0 end                 as m0
            ,case when t.OVERDUE_UNREPAY_DAYS =   0  or t.OVERDUE_UNREPAY_DAYS is null  then t.UNREPAY_PRICE_B else 0 end as m0_unrepay_price_b              --M0未还本金
            
            ,case when t.OVERDUE_UNREPAY_DAYS >=  1  and t.OVERDUE_UNREPAY_DAYS  <= 29  then 1 else 0 end                 as m1
            ,case when t.OVERDUE_UNREPAY_DAYS >=  1  and t.OVERDUE_UNREPAY_DAYS  <= 29  then t.UNREPAY_PRICE_B else 0 end as m1_unrepay_price_b              --M1未还本金
            
            ,case when t.OVERDUE_UNREPAY_DAYS >= 30  and t.OVERDUE_UNREPAY_DAYS  <= 59  then 1 else 0 end                 as m2
            ,case when t.OVERDUE_UNREPAY_DAYS >= 30  and t.OVERDUE_UNREPAY_DAYS  <= 59  then t.UNREPAY_PRICE_B else 0 end as m2_unrepay_price_b              --M2未还本金
            
            ,case when t.OVERDUE_UNREPAY_DAYS >= 60  and t.OVERDUE_UNREPAY_DAYS  <= 89  then 1 else 0 end                 as m3
            ,case when t.OVERDUE_UNREPAY_DAYS >= 60  and t.OVERDUE_UNREPAY_DAYS  <= 89  then t.UNREPAY_PRICE_B else 0 end as m3_unrepay_price_b              --M3未还本金
            
            ,case when t.OVERDUE_UNREPAY_DAYS >= 90  and t.OVERDUE_UNREPAY_DAYS  <= 119 then 1 else 0 end                 as m4
            ,case when t.OVERDUE_UNREPAY_DAYS >= 90  and t.OVERDUE_UNREPAY_DAYS  <= 119 then t.UNREPAY_PRICE_B else 0 end as m4_unrepay_price_b              --M4未还本金
            
            ,case when t.OVERDUE_UNREPAY_DAYS >= 30                                     then 1 else 0 end                 as m2p
            ,case when t.OVERDUE_UNREPAY_DAYS >= 30                                     then t.UNREPAY_PRICE_B else 0 end as m2p_unrepay_price_b             --M2+未还本金
            
            ,case when t.OVERDUE_UNREPAY_DAYS >= 90                                     then 1 else 0 end                 as m4p
            ,case when t.OVERDUE_UNREPAY_DAYS >= 90                                     then t.UNREPAY_PRICE_B else 0 end as m4p_unrepay_price_b             --M4+未还本金
            ,case when t.OVERDUE_UNREPAY_DAYS >= 90 and t2.bo_id is not null then 1 else 0 end                            as new_loss                        --新增损失
            ,case when t.OVERDUE_UNREPAY_DAYS >= 90 and t2.bo_id is not null then t.UNREPAY_PRICE_B else 0 end            as new_loss_unrepay_price_b        --新增损失未还本金
            ,cast(months_between(to_date('${dt}'),last_day(t.bo_agree_time)) as int )                                     as mob                             --MOB
            ,case when t.OVERDUE_UNREPAY_DAYS >= 90 and t2.bo_id is not null 
                  and months_between(to_date('${dt}'),last_day(t.bo_agree_time)) <= 6 then 1 else 0 end                   as fraud_loss                      --欺诈损失
            ,case when t.OVERDUE_UNREPAY_DAYS >= 90 and t2.bo_id is not null 
                  and months_between(to_date('${dt}'),last_day(t.bo_agree_time)) <= 6 then t.UNREPAY_PRICE_B else 0 end   as fraud_loss_unrepay_price_b      --欺诈损失未还本金
            ,'${dt}' as stat_date
       from msc.fact_borrows_unrepay_h_20181220 t    /*   2013-11-30   ~  2018-11-30    */   
 inner join msc.v_dim_vintage dim
         on dim.user_id = t.user_id
        and dim.bo_id = t.bo_id
        and dim.stat_date <= '${dt}'
  left join msc.fact_borrows_unrepay_h_20181220 t2
         on t2.bo_id = t.bo_id 
        and t2.stat_date = to_date(date_sub(trunc('${dt}','MONTH'),1))
        and ( t2.OVERDUE_UNREPAY_DAYS < 90 or t2.OVERDUE_UNREPAY_DAYS is null )
      where t.stat_date = '${dt}'
        and to_date(t.bo_agree_time) <= '${dt}'
;



--new  
      insert overwrite table msc.fact_risk_overdue_quota_m_prepare partition (stat_date)
      select t.user_id 
             ,t.level_type 
             ,t.bo_id 
             ,t.product_cd
             ,t.p_key
             ,t.expect_type
             ,t.amc_type
             ,t.graduate_type
             ,t.m3p_type
             ,t.m6p_type             
             ,t.bo_success_date
             ,t.bo_finish_price
             ,t.overdue_unrepay_days
             ,t.unrepay_price_b
             ,case when t.OVERDUE_UNREPAY_DAYS =   0  or t.OVERDUE_UNREPAY_DAYS is null  then 1 else 0 end                 as m0
             ,case when t.OVERDUE_UNREPAY_DAYS =   0  or t.OVERDUE_UNREPAY_DAYS is null  then t.UNREPAY_PRICE_B else 0 end as m0_unrepay_price_b              --M0未还本金
            
             ,case when t.OVERDUE_UNREPAY_DAYS >=  1  and t.OVERDUE_UNREPAY_DAYS  <= 29  then 1 else 0 end                 as m1
             ,case when t.OVERDUE_UNREPAY_DAYS >=  1  and t.OVERDUE_UNREPAY_DAYS  <= 29  then t.UNREPAY_PRICE_B else 0 end as m1_unrepay_price_b              --M1未还本金
            
             ,case when t.OVERDUE_UNREPAY_DAYS >= 30  and t.OVERDUE_UNREPAY_DAYS  <= 59  then 1 else 0 end                 as m2
             ,case when t.OVERDUE_UNREPAY_DAYS >= 30  and t.OVERDUE_UNREPAY_DAYS  <= 59  then t.UNREPAY_PRICE_B else 0 end as m2_unrepay_price_b              --M2未还本金
            
             ,case when t.OVERDUE_UNREPAY_DAYS >= 60  and t.OVERDUE_UNREPAY_DAYS  <= 89  then 1 else 0 end                 as m3
             ,case when t.OVERDUE_UNREPAY_DAYS >= 60  and t.OVERDUE_UNREPAY_DAYS  <= 89  then t.UNREPAY_PRICE_B else 0 end as m3_unrepay_price_b              --M3未还本金
            
             ,case when t.OVERDUE_UNREPAY_DAYS >= 90  and t.OVERDUE_UNREPAY_DAYS  <= 119 then 1 else 0 end                 as m4
             ,case when t.OVERDUE_UNREPAY_DAYS >= 90  and t.OVERDUE_UNREPAY_DAYS  <= 119 then t.UNREPAY_PRICE_B else 0 end as m4_unrepay_price_b              --M4未还本金
            
             ,case when t.OVERDUE_UNREPAY_DAYS >= 30                                     then 1 else 0 end                 as m2p
             ,case when t.OVERDUE_UNREPAY_DAYS >= 30                                     then t.UNREPAY_PRICE_B else 0 end as m2p_unrepay_price_b             --M2+未还本金
            
             ,case when t.OVERDUE_UNREPAY_DAYS >= 90                                     then 1 else 0 end                 as m4p
             ,case when t.OVERDUE_UNREPAY_DAYS >= 90                                     then t.UNREPAY_PRICE_B else 0 end as m4p_unrepay_price_b             --M4+未还本金
             
             ,case when t.OVERDUE_UNREPAY_DAYS >= 90                 --当期逾期90天以上
                    and t2.bo_id is not null                         --上月逾期不超90天
                    and t3.bo_id is null                             --排除以往已损失的
                   then 1 else 0 end                                                                                       as new_loss                        --新增损失
             ,case when t.OVERDUE_UNREPAY_DAYS >= 90 
                    and t2.bo_id is not null 
                    and t3.bo_id is null 
                   then t.UNREPAY_PRICE_B else 0 end                                                                       as new_loss_unrepay_price_b        --新增损失未还本金
             
             ,cast(months_between(to_date('${dt}'),last_day(t.bo_success_date)) as int )                                   as mob                             --MOB
             
             ,case when t.OVERDUE_UNREPAY_DAYS >= 90 
                    and t2.bo_id is not null 
                    and t3.bo_id is null
                    and months_between(to_date('${dt}'),last_day(t.bo_success_date)) <= 6 
                   then 1 else 0 end                                                                                      as fraud_loss                      --欺诈损失
             ,case when t.OVERDUE_UNREPAY_DAYS >= 90 
                    and t2.bo_id is not null
                    and t3.bo_id is null                    
                    and months_between(to_date('${dt}'),last_day(t.bo_success_date)) <= 6 
                   then t.UNREPAY_PRICE_B else 0 end                                                                      as fraud_loss_unrepay_price_b      --欺诈损失未还本金
             ,'${dt}' as stat_date             
        from dw_srmopr.fact_risk_vintage_quota_m t 
   left join dw_srmopr.fact_risk_vintage_quota_m t2     --上月未损失
          on t2.bo_id = t.bo_id 
         and t2.stat_date = to_date(date_sub(trunc('${dt}','MM'),1))
         and t2.OVERDUE_UNREPAY_DAYS < 90
   left join ( 
                   select bo_id 
                     from dw_srmopr.fact_risk_vintage_quota_m 
                    where stat_date < to_date(date_sub(trunc('${dt}','MM'),1))
                      and OVERDUE_UNREPAY_DAYS >= 90 
                 group by bo_id
             ) t3     --排除以往已损失
          on t3.bo_id = t.bo_id        
       where t.stat_date = '${dt}'
;




-- 逾期率、滚动率、迁徙率、损失率月表


drop table if exists dw_srm.fact_risk_overdue_quota_m;


CREATE TABLE dw_srm.fact_risk_overdue_quota_m 
(
    user_id                         bigint,
    level_type                      string,                 --modify
    bo_id                           bigint,
    product_cd                      string,
    p_key                           int,
    expect_type                     int,                    --modify
    bo_success_date                 string,                 --modify
    amc_type                        int,
    graduate_type                   int,
    m3p_type                        int,
    m6p_type                        int,
    bo_finish_price                 decimal(38,10),
    overdue_unrepay_days            int,
    unrepay_price_b                 decimal(38,10),
    m0_unrepay_price_b              decimal(38,10),
    m1_unrepay_price_b              decimal(38,10),
    m2_unrepay_price_b              decimal(38,10),
    m3_unrepay_price_b              decimal(38,10),
    m4_unrepay_price_b              decimal(38,10),
    m2p_unrepay_price_b             decimal(38,10),
    m4p_unrepay_price_b             decimal(38,10),
    m2p_unrepay_price_b_exloss      decimal(38,10),
    m4p_unrepay_price_b_exloss      decimal(38,10),
    unrepay_price_b_exloss          decimal(38,10),
    last_m0_unrepay_price_b         decimal(38,10),
    last_m1_unrepay_price_b         decimal(38,10),
    last_m2_unrepay_price_b         decimal(38,10),
    last_m3_unrepay_price_b         decimal(38,10),
    new_loss                        int,
    new_loss_unrepay_price_b        decimal(38,10),
    mob                             int,
    fraud_loss                      int,
    fraud_loss_unrepay_price_b      decimal(38,10),
    recover_loss                    int,
    new_loss_repayed_price_b        decimal(38,10),
    net_new_loss_price              decimal(38,10),
    fraud_loss_repayed_price_b      decimal(38,10),
    net_fraud_loss_price            decimal(38,10),
    m0_m1_roll_unrepay_price_b      decimal(38,10),
    m1_m2_roll_unrepay_price_b      decimal(38,10),
    m2_m3_roll_unrepay_price_b      decimal(38,10),
    m3_m4_roll_unrepay_price_b      decimal(38,10),
    m4_roll_unrepay_price_b         decimal(38,10),
    m0_roll_unrepay_price_b         decimal(38,10)
)
comment '风控逾期/损失/滚动/迁徙率指标'
partitioned by (stat_date string comment '统计日期 年-月')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;



--view 
drop view dw_srmopr.fact_risk_overdue_quota_m ;



CREATE VIEW dw_srmopr.fact_risk_overdue_quota_m 
AS 
SELECT user_id,	
       level_type,	
       bo_id,	
       product_cd,	
       p_key,	
       expect_type,	
       bo_success_date,	
       amc_type,	
       graduate_type,	
       m3p_type,	
       m6p_type,	
       bo_finish_price,	
       overdue_unrepay_days,	
       	
       unrepay_price_b,	
       if(unrepay_price_b>0,1,0) unrepay_price_b_flag,	
       	
       m0_unrepay_price_b,	
       if(m0_unrepay_price_b>0,1,0) m0_unrepay_price_b_flag,	
       	
       m1_unrepay_price_b,	
       if(m1_unrepay_price_b>0,1,0) m1_unrepay_price_b_flag,	
       	
       m2_unrepay_price_b,	
       if(m2_unrepay_price_b>0,1,0) m2_unrepay_price_b_flag,	
       	
       m3_unrepay_price_b,	
       if(m3_unrepay_price_b>0,1,0) m3_unrepay_price_b_flag,	
       	
       m4_unrepay_price_b,	
       if(m4_unrepay_price_b>0,1,0) m4_unrepay_price_b_flag,	
       	
       m2p_unrepay_price_b,	
       if(m2p_unrepay_price_b>0,1,0) m2p_unrepay_price_b_flag,	
       	
       m4p_unrepay_price_b,	
       if(m4p_unrepay_price_b>0,1,0) m4p_unrepay_price_b_flag,	
       	
       m2p_unrepay_price_b_exloss,	
       if(m2p_unrepay_price_b_exloss>0,1,0) m2p_unrepay_price_b_exloss_flag,	
       	
       m4p_unrepay_price_b_exloss,	
       if(m4p_unrepay_price_b_exloss>0,1,0) m4p_unrepay_price_b_exloss_flag,	
       	
       unrepay_price_b_exloss,	
       if(unrepay_price_b_exloss>0,1,0) unrepay_price_b_exloss_flag,	
       	
       last_m0_unrepay_price_b,	
       if(last_m0_unrepay_price_b>0,1,0) last_m0_unrepay_price_b_flag,	
       	
       last_m1_unrepay_price_b,	
       if(last_m1_unrepay_price_b>0,1,0) last_m1_unrepay_price_b_flag,	
       	
       last_m2_unrepay_price_b,	
       if(last_m2_unrepay_price_b>0,1,0) last_m2_unrepay_price_b_flag,	
       	
       last_m3_unrepay_price_b,	
       if(last_m3_unrepay_price_b>0,1,0) last_m3_unrepay_price_b_flag,	
       	
       new_loss,	
       new_loss_unrepay_price_b,	
       mob,	
       fraud_loss,	
       fraud_loss_unrepay_price_b,	
       recover_loss,	
       new_loss_repayed_price_b,	
       net_new_loss_price,	
       fraud_loss_repayed_price_b,	
       net_fraud_loss_price,	
       m0_m1_roll_unrepay_price_b,	
       m1_m2_roll_unrepay_price_b,	
       m2_m3_roll_unrepay_price_b,	
       m3_m4_roll_unrepay_price_b,	
       m4_roll_unrepay_price_b,	
       m0_roll_unrepay_price_b,	
       stat_date	
from dw_srm.fact_risk_overdue_quota_m	
;




--  插入事实表
       insert overwrite table dw_srm.fact_risk_overdue_quota_m partition (stat_date)
       select t.user_id
              ,t.level_type
              ,t.bo_id
              ,t.product_cd
              ,t.p_key
              ,t.expect_type
              ,t.bo_success_date
              ,t.amc_type                 --new
              ,t.graduate_type            --new
              ,t.m3p_type                 --new
              ,t.m6p_type                 --new              
              ,t.bo_finish_price
              ,t.overdue_unrepay_days
              ,t.unrepay_price_b
              
              ,t.m0_unrepay_price_b                                                                                         --截至月末M0帐户撮合借贷余额
              ,t.m1_unrepay_price_b                                                                                         --截至月末M1帐户撮合借贷余额
              ,t.m2_unrepay_price_b                                                                                         --截至月末M2帐户撮合借贷余额
              ,t.m3_unrepay_price_b                                                                                         --截至月末M3帐户撮合借贷余额
              ,t.m4_unrepay_price_b                                                                                         --截至月末M4帐户撮合借贷余额
              
              ,t.m2p_unrepay_price_b                                                                                        --截至月末M2+帐户撮合借贷余额
              ,t.m4p_unrepay_price_b                                                                                        --截至月末M4+帐户撮合借贷余额
              
              ,case when t.new_loss = 1 then 0 else t.m2p_unrepay_price_b end as m2p_unrepay_price_b_exloss                 --截至月末M2+帐户撮合借贷余额（剔除新增损失、结清帐户）
              ,case when t.new_loss = 1 then 0 else t.m4p_unrepay_price_b end as m4p_unrepay_price_b_exloss                 --截至月末M4+帐户撮合借贷余额（剔除新增损失、结清帐户）            
              ,case when t.new_loss = 1 then 0 else t.unrepay_price_b end     as unrepay_price_b_exloss                     --当月新增损失账户的撮合借贷余额
              
              ,ifnull(t3.m0_unrepay_price_b,0) as last_m0_unrepay_price_b                                                   --截止上月末M0的撮合借贷余额
              ,ifnull(t3.m1_unrepay_price_b,0) as last_m1_unrepay_price_b                                                   --截止上月末M1的撮合借贷余额
              ,ifnull(t3.m2_unrepay_price_b,0) as last_m2_unrepay_price_b                                                   --截止上月末M2的撮合借贷余额
              ,ifnull(t3.m3_unrepay_price_b,0) as last_m3_unrepay_price_b                                                   --截止上月末M3的撮合借贷余额
              
              ,t.new_loss                                                                                                   --新增损失标识
              ,t.new_loss_unrepay_price_b                                                                                   --新增损失时的撮合借贷余额
              
              ,t.mob                                                                                                        --MOB
              
              ,t.fraud_loss                                                                                                 --欺诈损失标识
              ,t.fraud_loss_unrepay_price_b                                                                                 --欺诈损失时的撮合借贷余额
              
              ,case when t2.bo_id is not null                         --历史新增的损失
                     and t3.unrepay_price_b - t.unrepay_price_b > 0   --当月还款 
                    then 1 else 0 end                                  as recover_loss                                      --损失回收标识
                    
              ,case when t2.bo_id is not null 
                     and t3.unrepay_price_b - t.unrepay_price_b > 0 
                    then t3.unrepay_price_b - t.unrepay_price_b       --上月的未还本金-当前的未还本金 = 本月回收金额
                    else 0 end                                         as new_loss_repayed_price_b                          --损失回收金额 ***
                    
              ,t.new_loss_unrepay_price_b - (case when t2.bo_id is not null 
                     and t3.unrepay_price_b - t.unrepay_price_b > 0 
                    then t3.unrepay_price_b - t.unrepay_price_b 
                    else 0 end)                                        as net_new_loss_price                                --净损失
                    
              ,case when tt.bo_id is not null 
                     and t3.unrepay_price_b - t.unrepay_price_b > 0 
                    then t3.unrepay_price_b - t.unrepay_price_b       --上月的未还本金-当前的未还本金 = 本月回收金额
                    else 0 end                                         as fraud_loss_repayed_price_b                        --欺诈损失回收金额 ***
                    
              ,t.fraud_loss_unrepay_price_b - (case when tt.bo_id is not null 
                     and t3.unrepay_price_b - t.unrepay_price_b > 0 
                    then t3.unrepay_price_b - t.unrepay_price_b 
                    else 0 end)                                        as net_fraud_loss_price                              --净欺诈损失金额
                    
              ,case when t3.bo_id is not null 
                     and t3.m0 = 1     --m0
                     and  t.m1 = 1     --m1
                    then t.m1_unrepay_price_b else 0 end               as m0_m1_roll_unrepay_price_b                        --上期月末M0到本期月末M1的撮合借贷余额
              ,case when t3.bo_id is not null 
                     and t3.m1 = 1     --m1
                     and  t.m2 = 1     --m2
                    then t.m2_unrepay_price_b else 0 end               as m1_m2_roll_unrepay_price_b                        --上期月末M1到本期月末M2的撮合借贷余额
              ,case when t3.bo_id is not null 
                     and t3.m2 = 1     --m2
                     and  t.m3 = 1     --m3
                    then t.m3_unrepay_price_b else 0 end               as m2_m3_roll_unrepay_price_b                        --上期月末M2到本期月末M3的撮合借贷余额
              ,case when t3.bo_id is not null 
                     and t3.m3 = 1     --m3
                     and  t.m4 = 1     --m4
                    then t.m4_unrepay_price_b else 0 end               as m3_m4_roll_unrepay_price_b                        --上期月末M3到本期月末M4的撮合借贷余额
              ,case when t7.bo_id is not null and t7.m0 = 1 
                     and t6.bo_id is not null and t6.m1 = 1 
                     and t5.bo_id is not null and t5.m2 = 1 
                     and t3.bo_id is not null and t3.m3 = 1 
                     and  t.bo_id is not null and  t.m4 = 1 
                    then t.m4_unrepay_price_b else 0 end               as m4_roll_unrepay_price_b                           --M0_M4的撮合借贷余额  （滚动率的分子）
              ,case when t7.bo_id is not null and t7.m0 = 1 
                    then t7.m0_unrepay_price_b else 0 end              as m0_roll_unrepay_price_b                           --M0_M4的撮合借贷余额  （滚动率的分母）
              ,t.stat_date
         from msc.fact_risk_overdue_quota_m_prepare t     -- 当月末
    left join msc.fact_risk_overdue_quota_m_prepare t2    -- 历史新增的损失帐户
           on t2.bo_id = t.bo_id
          and t2.stat_date < '${dt}' 
          and t2.new_loss = 1 
    left join msc.fact_risk_overdue_quota_m_prepare tt    -- 历史欺诈的损失帐户
           on tt.bo_id = t.bo_id
          and tt.stat_date < '${dt}' 
          and tt.fraud_loss = 1 
    left join msc.fact_risk_overdue_quota_m_prepare t3    -- 前1月末    m3
           on t3.bo_id = t.bo_id 
          and t3.stat_date = to_date(date_sub(trunc('${dt}','MM'),1))    
    left join msc.fact_risk_overdue_quota_m_prepare t5    -- 前2月末    m2 
           on t5.bo_id = t.bo_id 
          and t5.stat_date = to_date(date_sub(trunc(date_sub(trunc('${dt}','MM'),1),'MM'),1))
    left join msc.fact_risk_overdue_quota_m_prepare t6    -- 前3月末    m1
           on t6.bo_id = t.bo_id 
          and t6.stat_date = to_date(date_sub(trunc(date_sub(trunc(date_sub(trunc('${dt}','MM'),1),'MM'),1),'MM'),1))
    left join msc.fact_risk_overdue_quota_m_prepare t7    -- 前4月末    m0 
           on t7.bo_id = t.bo_id 
          and t7.stat_date = to_date(date_sub(trunc(date_sub(trunc(date_sub(trunc(date_sub(trunc('${dt}','MM'),1),'MM'),1),'MM'),1),'MM'),1))
        where t.stat_date = '${dt}'
       ;




--白领包验证
select sum(case when new_loss = 1 then 1 else 0 end), sum(new_loss_unrepay_price_b), sum(new_loss_repayed_price_b), sum(net_new_loss_price), sum(net_fraud_loss_price)
from dw_srmopr.fact_risk_overdue_quota_m 
where 1 = 1
--and new_loss = 1 
and stat_date = '2017-01-31'
and product_cd = '010301'

--and substr(product_cd,1,2) = '01'
;



       
--损失、欺诈的验证       
select bo_id from dw_srm.fact_risk_overdue_quota_m 
where new_loss = 1 
and bo_id not in (
select bo_id from dw_srm.fact_risk_overdue_quota_m 
where fraud_loss = 1 ) 
and recover_loss = 1 
;




       
       
-- cube 

     select t.stat_date
            ,t.user_id 
            ,t.bo_id
            ,t.product_cd
            ,t.p_key
            ,t.level_type       --修改字段名
            ,t.expect_type      --修改字段名
            ,t.amc_type         --新增维度 
            ,t.graduate_type    --新增维度
            ,t.m3p_type         --新增维度
            ,t.m6p_type         --新增维度
            ,sum(t.unrepay_price_b)                 --截止月末撮合借贷余额
            ,sum(t.m1_unrepay_price_b)              --截止月末M1账户撮合借贷余额
            ,sum(t.m2_unrepay_price_b)              --截止月末M2账户撮合借贷余额
            ,sum(t.m3_unrepay_price_b)              --截止月末M3账户撮合借贷余额
            ,sum(t.m2p_unrepay_price_b)             --截止月末M2+账户撮合借贷余额
            ,sum(t.m4p_unrepay_price_b)             --截止月末M4+账户撮合借贷余额
            ,sum(t.m2p_unrepay_price_b_exloss)      --截止月末M2+账户撮合借贷余额-新增损失-结清
            ,sum(t.m4p_unrepay_price_b_exloss)      --截止月末M4+账户撮合借贷余额-新增损失-结清
            ,sum(t.unrepay_price_b_exloss)          --截止月末撮合借贷余额-新增损失-结清
            ,sum(new_loss)                          --新增损失
            ,sum(fraud_loss)                        --欺诈损失
            ,sum(new_loss_repayed_price_b)          --当月回收
            ,sum(net_new_loss_price)                --净损失
            ,sum(net_fraud_loss_price)              --净欺诈损失
            ,sum(last_m0_unrepay_price_b)           --截止上月末M0的撮合借贷余额 
            ,sum(last_m1_unrepay_price_b)           --截止上月末M1的撮合借贷余额
            ,sum(last_m2_unrepay_price_b)           --截止上月末M2的撮合借贷余额
            ,sum(last_m3_unrepay_price_b)           --截止上月末M3的撮合借贷余额
            ,sum(m0_m1_roll_unrepay_price_b)        --上期月末M0到本期月末M1的撮合借贷余额
            ,sum(m1_m2_roll_unrepay_price_b)        --上期月末M1到本期月末M2的撮合借贷余额
            ,sum(m2_m3_roll_unrepay_price_b)        --上期月末M2到本期月末M3的撮合借贷余额
            ,sum(m3_m4_roll_unrepay_price_b)        --上期月末M3到本期月末M4的撮合借贷余额
            ,sum(m4_roll_unrepay_price_b)           --M0_M4的撮合借贷余额  （滚动率的分子）
            ,sum(m0_roll_unrepay_price_b)           --M0_M4的撮合借贷余额  （滚动率的分母）
       from dw_srmopr.fact_risk_overdue_quota_m t
       
 inner join odsopr.dim_bia_asset_product p 
         on p.p_key = t.p_key 
         
 inner join dw_srmopr.dim_date d 
         on d.day_short_desc = t.stat_date 
         
 inner join dw_srmopr.dim_product_cat pc 
         on pc.product_cd = t.product_cd 
         
 inner join dw_srmopr.dim_level_cat lc 
         on lc.level_type = t.level_type           --修改字段名
         
 inner join dw_srmopr.dim_expect_cat ec 
         on ec.expect_type = t.expect_type         --修改字段名
         
 inner join dw_srmopr.dim_amc_cat amc 
         on amc.amc_type = t.amc_type         
        
 inner join dw_srmopr.dim_graduate_cat grd 
         on grd.graduate_type = t.graduate_type

 inner join dw_srmopr.dim_overdue_m3p_cat m3p
         on m3p.m3p_type = t.m3p_type 
        
 inner join dw_srmopr.dim_overdue_m6p_cat m6p
         on m6p.m6p_type = t.m6p_type         
      where t.stat_date = '${dt}' 
   group by t.stat_date
            ,t.user_id 
            ,t.bo_id
            ,t.product_cd
            ,t.p_key
            ,t.level_type
            ,t.expect_type
            ,t.amc_type
            ,t.graduate_type
            ,t.m3p_type
            ,t.m6p_type
       ;


       

       
-- FSTPD 

--开发代码、验证
   select * from ( 
    select bo.bo_id
           ,to_date(bo.bo_success_time) as bo_success_time
           ,bo.bo_finish_price
           
           ,sum(case when br.br_expect_num = 1 and br.br_overdue_terms > 0 then 1 else 0 end) as is_first_repay_overdue
           ,sum(case when br.br_expect_num = 1 and br.br_overdue_terms > 0 then 
                    datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) else 0 end) as first_repay_overdue_days                    
           ,sum(case when br.br_expect_num = 2 and br.br_overdue_terms > 0 then 1 else 0 end) as is_second_repay_overdue
           ,sum(case when br.br_expect_num = 2 and br.br_overdue_terms > 0 then 
                    datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) else 0 end) as second_repay_overdue_days
           ,sum(case when br.br_expect_num = 3 and br.br_overdue_terms > 0 then 1 else 0 end) as is_third_repay_overdue
           ,sum(case when br.br_expect_num = 3 and br.br_overdue_terms > 0 then 
                    datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) else 0 end) as third_repay_overdue_days

           ,sum(case when br.br_expect_num = 1 and (br.br_overdue_terms > 0 
                                                or br.br_overdue_terms = 0 and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) then 
                    1 else 0 end) as is_first_repay_overdue_1           
           ,sum(case when br.br_expect_num = 1 and (br.br_overdue_terms > 0 
                                                or br.br_overdue_terms = 0 and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) then 
                    datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) else 0 end) as first_repay_overdue_days_1                    
           ,sum(case when br.br_expect_num = 2 and (br.br_overdue_terms > 0 
                                                or br.br_overdue_terms = 0 and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) then 
                    1 else 0 end) as is_second_repay_overdue_1           
           ,sum(case when br.br_expect_num = 2 and (br.br_overdue_terms > 0 
                                                or br.br_overdue_terms = 0 and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) then 
                    datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) else 0 end) as second_repay_overdue_days_1
           ,sum(case when br.br_expect_num = 3 and (br.br_overdue_terms > 0 
                                                or br.br_overdue_terms = 0 and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) then 
                    1 else 0 end) as is_third_repay_overdue_1
           ,sum(case when br.br_expect_num = 3 and (br.br_overdue_terms > 0 
                                                or br.br_overdue_terms = 0 and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) then 
                    datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) else 0 end) as third_repay_overdue_days_1                               
           ,'${dt}' stat_date
      from idw.fact_borrows bo
      join idw.fact_borrows_repayment br
        on bo.bo_id = br.bo_id
       and bo.bo_is_success = 1
       and to_date(bo.bo_success_time) <= '${dt}'
  group by 1,2,3,16
  ) t 
  where 1=1 
  --and to_date(t.bo_success_time) = '2018-08-31' 
  --and bo_id=528
  and t.is_first_repay_overdue <> is_first_repay_overdue_1
;

--

drop table if exists dw_srm.fact_risk_fstpd_quota_d;


CREATE TABLE dw_srm.fact_risk_fstpd_quota_d 
(
    bo_success_month                string,
    ind                             string,
    user_id                         bigint,
    bo_id                           bigint,
    level_cat                       string,
    product_cd                      string,
    bo_expect_type                  int,
    p_key                           int,
    bo_success_time                 string,
    mob                             int,
    bo_finish_price                 decimal(38,10),
    is_first_repay_overdue          bigint,
    first_repay_overdue_days        bigint,
    first_unrepay_price_b           decimal(38,10),
    is_second_repay_overdue         bigint,
    second_repay_overdue_days       bigint,
    second_unrepay_price_b          decimal(38,10),
    is_third_repay_overdue          bigint,
    third_repay_overdue_days        bigint,
    third_unrepay_price_b           decimal(38,10),
    first_1_unrepay_price_b         decimal(38,10),
    first_3_unrepay_price_b         decimal(38,10),
    first_7_unrepay_price_b         decimal(38,10),
    first_15_unrepay_price_b        decimal(38,10),
    first_30_unrepay_price_b        decimal(38,10),
    second_30_unrepay_price_b       decimal(38,10),
    third_30_unrepay_price_b        decimal(38,10)
)
comment '风控FSTPD指标'
partitioned by (stat_date string comment '统计日期 年-月-日')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;


drop view if exists dw_srmopr.fact_risk_fstpd_quota_d;

create view dw_srmopr.fact_risk_fstpd_quota_d as select * from dw_srm.fact_risk_fstpd_quota_d;


--

     insert overwrite table dw_srm.fact_risk_fstpd_quota_d partition (stat_date) 
     select t.bo_success_month
            ,t.ind
            ,t.user_id
            ,t.bo_id
            ,t.level_cat
            ,t.product_cd
            ,t.bo_expect_type
            ,t.p_key
            ,t.bo_agree_time
            ,t.mob
            ,t.bo_finish_price
            ,t.is_first_repay_overdue
            ,t.first_repay_overdue_days
            ,t.first_unrepay_price_b
            ,t.is_second_repay_overdue
            ,t.second_repay_overdue_days
            ,t.second_unrepay_price_b
            ,t.is_third_repay_overdue
            ,t.third_repay_overdue_days
            ,t.third_unrepay_price_b
            ,case when t.first_repay_overdue_days  >= 1  then t.first_unrepay_price_b  else 0 end   as first_1_unrepay_price_b   --FPD_1的剩余本金
            ,case when t.first_repay_overdue_days  >= 3  then t.first_unrepay_price_b  else 0 end   as first_3_unrepay_price_b   --FPD_3的剩余本金
            ,case when t.first_repay_overdue_days  >= 7  then t.first_unrepay_price_b  else 0 end   as first_7_unrepay_price_b   --FPD_7的剩余本金
            ,case when t.first_repay_overdue_days  >= 15 then t.first_unrepay_price_b  else 0 end   as first_15_unrepay_price_b  --FPD_15的剩余本金
            ,case when t.first_repay_overdue_days  >= 30 then t.first_unrepay_price_b  else 0 end   as first_30_unrepay_price_b  --FPD_30的剩余本金
           
            ,case when t.first_repay_overdue_days  <= 29 
                   and t.second_repay_overdue_days >= 30 then t.second_unrepay_price_b else 0 end   as second_30_unrepay_price_b --SPD_30的剩余本金
           
            ,case when t.first_repay_overdue_days  <= 29 
                   and t.second_repay_overdue_days <= 29 
                   and t.third_repay_overdue_days  >= 30 then t.third_unrepay_price_b  else 0 end   as third_30_unrepay_price_b  --TPD_30的剩余本金
            ,t.stat_date
    from  
    (
        select substr(to_date(bo.bo_agree_time),1,7) as bo_success_month
               ,'线上' ind
               ,bo.user_id
               ,bo.bo_id
                ,case 
                    when bo1.score is not null and bo1.level in ('A') then 'A'
                    when bo1.score is not null and bo1.level in ('B') then 'B'
                    when bo1.score is not null and bo1.level in ('C') then 'C'
                    when bo1.score is not null and bo1.level in ('D') then 'D'
                    when bo1.score is not null and bo1.level in ('E') then 'E'
                    when bo1.score is not null and bo1.level in ('F') then 'F'
                    else '其他'
                end as level_cat
                ,case 
                    when bo1.product = '信用贷（专）'           then '010101'
                    when bo1.product = '信用贷（本）'           then '010102'
                    when bo1.product = '名校贷应急包'           then '010103'
                    when bo1.product = '大额借'                 then '010201'
                    when bo1.product = '高学历贷'               then '010202'
                    when bo1.product = '消费能力贷'             then '010203'
                    when bo1.product = '白领包'                 then '010301'
                    when bo1.product = '社保贷'                 then '010302'
                    when bo1.product = '应届贷'                 then '010303'
                    when bo1.product = '金卡-信用贷'            then '010401'
                    when bo1.product = '金卡-麦子借款'          then '010402'
                    when bo1.product = '极速金卡-信用贷'        then '010501'
                    when bo1.product = '极速金卡-麦子借款'      then '010502'
                    else '000000'
                end as product_cd
                ,case 
                    when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36)    then 0
                    else bo.bo_expect
                end as bo_expect_type            
               ,bo.p_key
               ,to_date(bo.bo_agree_time) as bo_agree_time
               ,cast(months_between(to_date('${dt}'),last_day(bo.bo_agree_time)) as int ) as mob
               ,bo.bo_finish_price
               --FPD
               ,sum(case when br.br_expect_num = 1 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')), 
                                            case 
                                                when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                                else to_date(br.br_repay_time) 
                                            end , 
                                            to_date(br.br_time)
                                          ) > 0 ) 
                         then 1 
                         else 0 
               end) as is_first_repay_overdue
               ,sum(case when br.br_expect_num = 1 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')), 
                                            case 
                                                when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                                else to_date(br.br_repay_time) 
                                            end , 
                                            to_date(br.br_time)
                                          ) > 0 ) 
                         then datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')),      
                                        case 
                                            when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                            else to_date(br.br_repay_time) 
                                        end , 
                                        to_date(br.br_time)
                                      ) 
                         else 0 
               end) as first_repay_overdue_days
               ,sum(case when br.br_expect_num >= 1 then br.br_price_b else 0 end ) as first_unrepay_price_b
               
               --SPD         
               ,sum(case when br.br_expect_num = 2 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) 
                         then 1 
                         else 0 
               end) as is_second_repay_overdue
               ,sum(case when br.br_expect_num = 2 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')), 
                                            case 
                                                when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                                else to_date(br.br_repay_time) 
                                            end , 
                                            to_date(br.br_time)) > 0 
                                          ) 
                         then datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')),      
                                        case 
                                            when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                            else to_date(br.br_repay_time) 
                                        end , 
                                        to_date(br.br_time)
                                      ) 
                         else 0 
               end) as second_repay_overdue_days
               ,sum(case when br.br_expect_num >= 2 then br.br_price_b else 0 end ) as second_unrepay_price_b
               
               --TPD         
               ,sum(case when br.br_expect_num = 3 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) 
                         then 1 
                         else 0 
               end) as is_third_repay_overdue
               ,sum(case when br.br_expect_num = 3 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')), 
                                            case 
                                                when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                                else to_date(br.br_repay_time) 
                                            end , 
                                            to_date(br.br_time)) > 0 
                                          ) 
                         then datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')),      
                                        case 
                                            when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                            else to_date(br.br_repay_time) 
                                        end , 
                                        to_date(br.br_time)
                                      ) 
                         else 0 
               end) as third_repay_overdue_days
               ,sum(case when br.br_expect_num >= 3 then br.br_price_b else 0 end ) as third_unrepay_price_b
               ,'${dt}' stat_date
          from idw.fact_borrows bo
          join idw.fact_borrows_repayment br
            on bo.bo_id = br.bo_id
     left join (
                      select bo.user_id,
                             bo.bo_id ,
                             bo.bo_agree_time,
                             case
                               when bo.p_id = 87 and bp.bp_channel = 5   then '社保贷'
                               when bo.p_id = 87 and bp.bp_channel = 6   then '应届贷'
                               when bo.p_id = 87 and bp.bp_channel = 7   then '按揭贷'
                               when bo.p_id = 110 and bo.credit_type = 2 then '高学历贷'
                               when bo.p_id = 110 and bo.credit_type = 3 then '消费能力贷'
                               when bo.p_id = 140 and (mp.external_channel = '3' or mp.external_channel is null ) then '金卡-麦子借款'
                               when bo.p_id = 140 and mp.external_channel = '4' then '金卡-信用贷'
                               when bo.p_id = 148 and (mp.external_channel = '3' or mp.external_channel is null ) then '极速金卡-麦子借款'
                               when bo.p_id = 148 and mp.external_channel = '4' then '极速金卡-信用贷'                               
                               else bo.p_name
                             end PRODUCT,
                             bo.p_id,
                             bo.p_key,
                             bo.p_name,
                             bo.bo_finish_price,
                             bo.bo_is_success,
                             dm.SCORE_LEVEL LEVEL,
                             dm.SCORE_RESULT SCORE
                        from idw.fact_borrows bo
                        left join odsopr.borrows_prepare bp
                          on bo.bp_id = bp.id
                        left join 
                                (
                                    select bp_id,
                                           user_id,
                                           max(case when data_no = 'scoreLevel' then data_value end) SCORE_LEVEL,
                                           max(case when data_no = 'scoreResult' then data_value end) SCORE_RESULT
                                      from (select bp_id,user_id,data_value,data_no,
                                                   row_number() over(partition by bp_id, data_no order by id desc) rn
                                              from ods.t_des_main_hist 
                                              where data_no in ( 'scoreLevel','scoreResult' ) ) s
                                     where s.rn = 1
                                     group by bp_id, user_id
                                ) dm
                          on bo.bp_id = dm.bp_id
                         and bo.user_id = dm.user_id
                   left join odsopr.borrows_external_mapping mp 
                          on mp.bo_id = bo.bo_id
                ) bo1 
             on bo1.bo_id = bo.bo_id
          where 1 = 1
            and bo.bo_is_success = 1
            --and to_date(bo.bo_success_time) <= '${dt}'
            and to_date(bo.bo_agree_time) <= '${dt}'
            and not exists (select 1 from idw.fact_maiya_order a where a.bo_id = bo.bo_id)
      group by 1,2,3,4,5,6,7,8,9,10,11,21
      
      union all
      
        select substr(to_date(bo.bo_agree_time),1,7)
               ,'线下' ind       --剔除测试数据  
               ,bo.user_id
               ,bo.bo_id
               ,mo.LEVEL              as level_cat
               ,case 
                   when mo.flag = '老医美' and mo.dic_item in ('教育', '婚庆')    then '020101'
                   when mo.flag = '老医美' and mo.dic_item = '医疗美容'           then '020102'
                   when mo.flag = '新医美' and mo.qd_pass <> '1'                  then '020201'
                   when mo.flag = '新医美' and mo.qd_pass = '1'                   then '020202'
                   else '000000'
                end as product_cd
                ,case 
                    when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36)    then 0
                    else bo.bo_expect
                end as bo_expect_type               
               ,bo.p_key
               ,to_date(bo.bo_agree_time) as bo_agree_time
               ,cast(months_between(to_date('${dt}'),last_day(bo.bo_agree_time)) as int ) as mob
               ,bo.bo_finish_price
               --FPD
               ,sum(case when br.br_expect_num = 1 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) 
                         then 1 
                         else 0 
               end) as is_first_repay_overdue
               ,sum(case when br.br_expect_num = 1 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')), 
                                            case 
                                                when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                                else to_date(br.br_repay_time) 
                                            end , 
                                            to_date(br.br_time)) > 0 
                                          ) 
                         then datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')),      
                                        case 
                                            when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                            else to_date(br.br_repay_time) 
                                        end , 
                                        to_date(br.br_time)
                                      ) 
                         else 0 
               end) as first_repay_overdue_days
               ,sum(case when br.br_expect_num >= 1 then br.br_price_b else 0 end ) as first_unrepay_price_b
               
               --SPD         
               ,sum(case when br.br_expect_num = 2 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) 
                         then 1 
                         else 0 
               end) as is_second_repay_overdue
               ,sum(case when br.br_expect_num = 2 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')), 
                                            case 
                                                when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                                else to_date(br.br_repay_time) 
                                            end , 
                                            to_date(br.br_time)) > 0 
                                          ) 
                         then datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')),      
                                        case 
                                            when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                            else to_date(br.br_repay_time) 
                                        end , 
                                        to_date(br.br_time)
                                      ) 
                         else 0 
               end) as second_repay_overdue_days
               ,sum(case when br.br_expect_num >= 2 then br.br_price_b else 0 end ) as second_unrepay_price_b
               
               --TPD         
               ,sum(case when br.br_expect_num = 3 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff(coalesce(to_date(br.br_repay_time), to_date('${dt}')), to_date(br.br_time)) > 0 ) 
                         then 1 
                         else 0 
               end) as is_third_repay_overdue
               ,sum(case when br.br_expect_num = 3 
                          and (to_date('${dt}') > to_date(br.br_time)) 
                          and (br.br_overdue_terms > 0 
                               or br.br_overdue_terms = 0 
                              and datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')), 
                                            case 
                                                when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                                else to_date(br.br_repay_time) 
                                            end , 
                                            to_date(br.br_time)) > 0 
                                          ) 
                         then datediff( --coalesce(to_date(br.br_repay_time), to_date('${dt}')),      
                                        case 
                                            when to_date(br.br_repay_time) is null or to_date(br.br_repay_time)> to_date('${dt}') then to_date('${dt}')
                                            else to_date(br.br_repay_time) 
                                        end , 
                                        to_date(br.br_time)
                                      ) 
                         else 0 
               end) as third_repay_overdue_days
               ,sum(case when br.br_expect_num >= 3 then br.br_price_b else 0 end ) as third_unrepay_price_b
               ,'${dt}' stat_date
          from idw.fact_borrows bo
          join idw.fact_borrows_repayment br
            on bo.bo_id = br.bo_id
          join (
                         SELECT t.order_no, 
                                t.bo_id,
                                t.qd_pass,
                                t.SHOP_COMPANY_TYPE dic_item,
                                case 
                                    when to_date(t.create_time) >= '2018-04-03' and SHOP_NAME = '上海迪蔻医疗美容门诊部有限公司'     then '新医美'
                                    when to_date(t.create_time) >= '2018-04-03' and SHOP_NAME = '上海雅尚医疗美容门诊部有限公司'     then '新医美'
                                    when to_date(t.create_time) >= '2018-04-12' and SHOP_NAME = '上海容妍医院管理有限公司'           then '新医美'
                                    when to_date(t.create_time) >= '2018-04-21' and SHOP_NAME = '上海纽赛医疗美容门诊部有限公司'     then '新医美'
                                    when to_date(t.create_time) >= '2018-04-21' and SHOP_NAME = '上海韩镜医疗美容医院有限公司'       then '新医美'
                                    when to_date(t.create_time) >= '2018-04-24' and SHOP_NAME = '上海南山医院有限公司'               then '新医美'
                                    when to_date(t.create_time) >= '2018-04-25' and SHOP_NAME = '上海历思医疗美容门诊部有限公司'     then '新医美'
                                    when to_date(t.create_time) >= '2018-05-11' and SHOP_NAME = '上海名媛医疗美容门诊部有限公司'     then '新医美'
                                    when to_date(t.create_time) >= '2018-05-11' and SHOP_NAME = '上海明桥医疗美容门诊部有限公司'     then '新医美'
                                    when to_date(t.create_time) >= '2018-05-19' and SHOP_NAME = '上海翔茂医疗美容门诊部有限公司'     then '新医美'
                                    when to_date(t.create_time) >= '2018-05-31' and SHOP_NAME = '上海翡立思医疗美容门诊部有限公司'   then '新医美'
                                    when to_date(t.create_time) >= '2018-06-22' and SHOP_NAME = '广州艾美医疗美容门诊有限公司'       then '新医美'
                                    when to_date(t.create_time) >= '2018-06-22' and SHOP_NAME = '特壹美（广州）健康管理有限公司'     then '新医美'
                                    when to_date(t.create_time) >= '2018-06-22' and SHOP_NAME = '广州新颜医疗美容门诊有限公司'       then '新医美'
                                    when to_date(t.create_time) >= '2018-06-22' and SHOP_NAME = '深圳恒丽医疗美容门诊部有限公司'     then '新医美'
                                    when to_date(t.create_time) >= '2018-06-26' and SHOP_NAME = '上海复美医疗美容门诊部有限公司'     then '新医美'
                                    when to_date(t.create_time) >= '2018-06-25' and SHOP_NAME = '深圳臻希美医疗美容门诊部'           then '新医美'
                                    when to_date(t.create_time) >= '2018-06-22' and SHOP_NAME = '深圳市八福贸易有限公司盛美佳门诊部' then '新医美'
                                    when to_date(t.create_time) >= '2018-07-04' and SHOP_NAME = '上海铭悦医疗美容门诊部有限公司'     then '新医美'
                                    else '老医美'
                                end as flag,
                                ll.LEVEL
                           from idw.fact_maiya_order t 
                      left join (
                                    select order_no,
                                           max(CREDIT_LEVEL) AS LEVEL 
                                      from ODS.T_ORD_ORDER_HIST 
                                     where DISABLED = 0
                                     group by order_no
                                ) ll
                             on ll.order_no = t.order_no
                          where t.SHOP_NAME not LIKE '%测试%'
               ) mo 
            on mo.bo_id = bo.bo_id
         where 1 = 1
           and bo.bo_is_success = 1
           --and to_date(bo.bo_success_time) <= '${dt}'
           and to_date(bo.bo_agree_time) <= '${dt}'
      group by 1,2,3,4,5,6,7,8,9,10,11,21
    ) t 
;



--验证用户的FSTPD      bo_id = 2267679

    select t.stat_date                                            --统计日期
           ,t.bo_success_month                                    --放款月份
           ,t.user_id
           ,t.bo_id
           ,t.bo_success_time
           ,t.level_cat                                           --客户等级
           ,t.product_cd                                          --产品编码
           ,t.p_key                                               --p_key
           ,t.bo_expect_type                                      --期限编码
           ,t.bo_finish_price       as bo_finish_price            --放款金额
           ,case when t.first_repay_overdue_days  >= 1  then t.first_unrepay_price_b  else 0 end   as first_1_unrepay_price_b   --FPD_1的剩余本金
           ,case when t.first_repay_overdue_days  >= 3  then t.first_unrepay_price_b  else 0 end   as first_3_unrepay_price_b   --FPD_3的剩余本金
           ,case when t.first_repay_overdue_days  >= 7  then t.first_unrepay_price_b  else 0 end   as first_7_unrepay_price_b   --FPD_7的剩余本金
           ,case when t.first_repay_overdue_days  >= 15 then t.first_unrepay_price_b  else 0 end   as first_15_unrepay_price_b  --FPD_15的剩余本金
           ,case when t.first_repay_overdue_days  >= 30 then t.first_unrepay_price_b  else 0 end   as first_30_unrepay_price_b  --FPD_30的剩余本金
           
           ,case when t.first_repay_overdue_days  <= 29 
                  and t.second_repay_overdue_days >= 30 then t.second_unrepay_price_b else 0 end       as second_30_unrepay_price_b --SPD_30的剩余本金
           
           ,case when t.first_repay_overdue_days  <= 29 
                  and t.second_repay_overdue_days <= 29 
                  and t.third_repay_overdue_days  >= 30 then t.third_unrepay_price_b  else 0 end       as third_30_unrepay_price_b  --TPD_30的剩余本金
      from dw_srmopr.fact_risk_fstpd_quota_d t
     where t.stat_date = '${dt}'
     ;
     

--cube 

    select t.stat_date                                                        --统计日期
           ,t.bo_success_time                                                 --放款日期
           ,t.user_id
           ,t.bo_id
           ,t.level_cat                                                       --客户等级
           ,t.product_cd                                                      --产品编码
           ,t.p_key                                                           --p_key
           ,t.bo_expect_type                                                  --期限编码
           ,sum(t.bo_finish_price)               as bo_finish_price           --放款金额
           ,sum(first_1_unrepay_price_b)         as first_1_unrepay_price_b   --FPD_1的剩余本金
           ,sum(first_3_unrepay_price_b)         as first_3_unrepay_price_b   --FPD_3的剩余本金
           ,sum(first_7_unrepay_price_b)         as first_7_unrepay_price_b   --FPD_7的剩余本金
           ,sum(first_15_unrepay_price_b)        as first_15_unrepay_price_b  --FPD_15的剩余本金
           ,sum(first_30_unrepay_price_b)        as first_30_unrepay_price_b  --FPD_30的剩余本金
           ,sum(second_30_unrepay_price_b)       as second_30_unrepay_price_b --SPD_30的剩余本金
           ,sum(second_30_unrepay_price_b)       as third_30_unrepay_price_b  --TPD_30的剩余本金
      from dw_srmopr.fact_risk_fstpd_quota_d t
inner join odsopr.dim_bia_asset_product p 
        on p.p_key = t.p_key 
inner join dw_srmopr.dim_date d 
        on d.day_short_desc = t.bo_success_time     --
inner join dw_srmopr.dim_product_cat pc 
        on pc.product_cd = t.product_cd 
inner join dw_srmopr.dim_level_cat lc 
        on lc.level_type = t.level_cat 
inner join dw_srmopr.dim_expect_cat ec 
        on ec.expect_type = t.bo_expect_type      
  group by t.stat_date
           ,t.bo_success_time
           ,t.user_id
           ,t.bo_id
           ,t.level_cat
           ,t.product_cd
           ,t.p_key
           ,t.bo_expect_type
  order by t.stat_date
           ,t.bo_success_time
     ;
