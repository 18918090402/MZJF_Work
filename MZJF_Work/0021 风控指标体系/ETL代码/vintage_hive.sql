

set mapreduce.job.name = tmp_risk_vintage_1;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

drop table if exists tmp.tmp_risk_vintage_1;

create table tmp.tmp_risk_vintage_1 
as 
     select  br.bo_id                                                                                                              as bo_id
            ,br.user_id                                                                                                            as user_id
            ,bo.bo_success_time                                                                                                    as bo_success_time
            ,bo.bo_finish_price                                                                                                    as bo_finish_price
            ,case when bo2.user_id is null then '0' else '1' end                                                                   as user_type
            ,case 
                when bo1.score is not null and bo1.level in ('A') then 'A'
                when bo1.score is not null and bo1.level in ('B') then 'B'
                when bo1.score is not null and bo1.level in ('C') then 'C'
                when bo1.score is not null and bo1.level in ('D') then 'D'
                when bo1.score is not null and bo1.level in ('E') then 'E'
                when bo1.score is not null and bo1.level in ('F') then 'F'
                else '其他'
            end                                                                                                                    as level_type
            ,cast( months_between(to_date('${T_SUB_1}'),last_day(bo.bo_success_time)) as int )                                     as mob
            ,case 
                when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36) then 0
                else bo.bo_expect
            end                                                                                                                    as expect_type
            ,bo.p_key                                                                                                              as p_key
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
            end                                                                                                                    as product_cd
            ,max(case 
                    when br.BR_OVERDUE_TERMS > 0 and br.br_is_repay = 0 or to_date(br.br_repay_time) > '${T_SUB_1}' 
                        then case 
                                when datediff('${T_SUB_1}', br.br_time) > 0 then datediff('${T_SUB_1}', br.br_time) 
                                else 0 
                             end 
                        else 0 
                end)                                                                                                               as overdue_unrepay_days
            ,sum(case when br.br_is_repay = 0 or to_date(br.br_repay_time) > '${T_SUB_1}' then br.br_price_b else 0 end)           as unrepay_price_b
            ,'${T_SUB_1}'                                                                                                          as stat_date
       from idw.fact_borrows_repayment br
       join idw.fact_borrows bo
         on br.bo_id = bo.bo_id
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
                   left join (
                                    select bp_id,
                                           user_id,
                                           max(case when data_no = 'scoreLevel' then data_value end) SCORE_LEVEL,
                                           max(case when data_no = 'scoreResult' then data_value end) SCORE_RESULT
                                      from (select bp_id,user_id,data_value,data_no,
                                                   row_number() over(partition by bp_id, data_no order by id desc) rn
                                              from odsopr.des_main 
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
  left join (
                    select bo.user_id
                      from idw.fact_borrows bo 
                     where bo.bo_is_success = 1
                       and to_date(bo.bo_success_time) <= to_date(date_sub(trunc('${T_SUB_1}','MM'), 1))  --上月底
                  group by bo.user_id 
            ) bo2 
         on bo2.user_id = bo.user_id
      where bo.bo_is_success = 1 
        and to_date(bo.bo_success_time) >= '2013-12-01'                              --关注产品从此开始放款
        and to_date(bo.bo_success_time) <= '${T_SUB_1}'
        and bo.p_name not like '%麦芽%' and bo.p_name not like '%美呗%'              --排除麦芽、医美产品
   group by br.bo_id
            ,br.user_id
            ,bo.bo_success_time
            ,bo.bo_finish_price
            ,case when bo2.user_id is null then '0' else '1' end
            ,case 
                when bo1.score is not null and bo1.level in ('A') then 'A'
                when bo1.score is not null and bo1.level in ('B') then 'B'
                when bo1.score is not null and bo1.level in ('C') then 'C'
                when bo1.score is not null and bo1.level in ('D') then 'D'
                when bo1.score is not null and bo1.level in ('E') then 'E'
                when bo1.score is not null and bo1.level in ('F') then 'F'
                else '其他'
            end
            ,cast( months_between(to_date('${T_SUB_1}'),last_day(bo.bo_success_time)) as int )
            ,case 
                when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36) then 0
                else bo.bo_expect
            end
            ,bo.p_key
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
            end
            ;


            
set mapreduce.job.name = tmp_risk_vintage_2;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

drop table if exists tmp.tmp_risk_vintage_2;

create table tmp.tmp_risk_vintage_2             
as 
select  br.bo_id                                                                                                              as bo_id
        ,br.user_id                                                                                                            as user_id
        ,bo.bo_success_time                                                                                                    as bo_success_time
        ,bo.bo_finish_price                                                                                                    as bo_finish_price
        ,case when bo2.user_id is null then '0' else '1' end                                                                   as user_type
        ,case 
            when trim(bo1.level) = '' or bo1.level is null then '其他'
            else bo1.level
        end                                                                                                                    as level_type
        ,cast( months_between(to_date('${T_SUB_1}'),last_day(bo.bo_success_time)) as int )                                     as mob
        ,case 
            when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36) then 0
            else bo.bo_expect
        end                                                                                                                    as expect_type
        ,bo.p_key                                                                                                              as p_key
           ,case 
               when bo1.flag = '老医美' and bo1.dic_item in ('教育', '婚庆')    then '020101'
               when bo1.flag = '老医美' and bo1.dic_item = '医疗美容'           then '020102'
               when bo1.flag = '新医美' and bo1.qd_pass <> '1'                  then '020201'
               when bo1.flag = '新医美' and bo1.qd_pass = '1'                   then '020202'
               else '000000'
        end                                                                                                                    as product_cd
        ,max(case 
                when br.BR_OVERDUE_TERMS > 0 and br.br_is_repay = 0 or to_date(br.br_repay_time) > '${T_SUB_1}' 
                    then case 
                            when datediff('${T_SUB_1}', br.br_time) > 0 then datediff('${T_SUB_1}', br.br_time) 
                            else 0 
                         end 
                    else 0 
            end)                                                                                                               as overdue_unrepay_days
        ,sum(case when br.br_is_repay = 0 or to_date(br.br_repay_time) > '${T_SUB_1}' then br.br_price_b else 0 end)           as unrepay_price_b
        ,'${T_SUB_1}'                                                                                                          as stat_date
   from idw.fact_borrows_repayment br
   join idw.fact_borrows bo
     on br.bo_id = bo.bo_id
left join (
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
                            t.shop_name,
                            ll.LEVEL
                       from idw.fact_maiya_order t 
                  left join (
                                select order_no,
                                       max(CREDIT_LEVEL) AS LEVEL 
                                  from ODSOPR.ORD_ORDER 
                                 where DISABLED = 0
                                 group by order_no
                            ) ll
                         on ll.order_no = t.order_no
        ) bo1 
     on bo1.bo_id = bo.bo_id
left join (
                select bo.user_id
                  from idw.fact_borrows bo 
                 where bo.bo_is_success = 1
                   and to_date(bo.bo_success_time) <= to_date(date_sub(trunc('${T_SUB_1}','MM'), 1))  --上月底
              group by bo.user_id 
        ) bo2 
     on bo2.user_id = bo.user_id
  where bo.bo_is_success = 1 
    and to_date(bo.bo_success_time) >= '2013-12-01'                            --关注产品从此开始放款
    and to_date(bo.bo_success_time) <= '${T_SUB_1}'
    and bo1.SHOP_NAME not LIKE '%测试%' and bo1.SHOP_NAME not LIKE '%退款%'    --剔除测试和退款的数据
    and ( bo.p_name like '%麦芽%' or bo.p_name like '%美呗%' ) 
group by br.bo_id
        ,br.user_id
        ,bo.bo_success_time
        ,bo.bo_finish_price
        ,case when bo2.user_id is null then '0' else '1' end
        ,case 
            when trim(bo1.level) = '' or bo1.level is null then '其他'
            else bo1.level
        end
        ,cast( months_between(to_date('${T_SUB_1}'),last_day(bo.bo_success_time)) as int )
        ,case 
            when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36) then 0
            else bo.bo_expect
        end
        ,bo.p_key
           ,case 
               when bo1.flag = '老医美' and bo1.dic_item in ('教育', '婚庆')    then '020101'
               when bo1.flag = '老医美' and bo1.dic_item = '医疗美容'           then '020102'
               when bo1.flag = '新医美' and bo1.qd_pass <> '1'                  then '020201'
               when bo1.flag = '新医美' and bo1.qd_pass = '1'                   then '020202'
               else '000000'
        end
        ;


set mapreduce.job.name = tmp_risk_vintage_3;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;        
        

            insert overwrite table dw_srm.fact_risk_vintage_quota_m partition (stat_date)
            select t.bo_id
                   ,t.user_id
                   ,substr(t.bo_success_time,1,10)                                                                                        as bo_success_date
                   ,t.bo_finish_price
                   ,t.user_type
                   ,t.level_type
                   ,t.mob
                   ,t.expect_type
                   ,t.p_key
                   ,t.product_cd
                   ,uix.gender_type                                                                                                       as gender_type
                   ,case 
                       when uix.age = 0                     then 0 
                       when uix.age >= 0  and uix.age <= 25 then 1
                       when uix.age >= 26 and uix.age <= 30 then 2
                       when uix.age >= 31 and uix.age <= 35 then 3
                       when uix.age >= 36                   then 4
                   end                                                                                                                    as age_type
                   ,uix.education                                                                                                         as education_type
                   ,case 
                       when uix.SCHOOL_TYPE_DESC = '专科' then 4 
                       when uix.SCHOOL_TYPE_DESC = '3本'  then 3
                       when uix.SCHOOL_TYPE_DESC = '2本'  then 2
                       when uix.SCHOOL_TYPE_DESC = '1本'  then 1
                       when uix.SCHOOL_TYPE_DESC = '缺失' then 0
                       else 9
                   end                                                                                                                    as school_type
                   ,case 
                       when t.bo_finish_price >= 0      and t.bo_finish_price <= 1000               then 1
                       when t.bo_finish_price > 1000    and t.bo_finish_price <= 2000               then 2
                       when t.bo_finish_price > 2000    and t.bo_finish_price <= 3000               then 3
                       when t.bo_finish_price > 3000    and t.bo_finish_price <= 4000               then 4
                       when t.bo_finish_price > 4000    and t.bo_finish_price <= 5000               then 5
                       when t.bo_finish_price > 5000    and t.bo_finish_price <= 10000              then 6
                       when t.bo_finish_price > 10000   and t.bo_finish_price <= 20000              then 7
                       when t.bo_finish_price > 20000   and t.bo_finish_price <= 30000              then 8
                       when t.bo_finish_price > 30000   and t.bo_finish_price <= 40000              then 9
                       when t.bo_finish_price > 40000   and t.bo_finish_price <= 50000              then 10
                       when t.bo_finish_price > 50000   and t.bo_finish_price <= 60000              then 11
                       when t.bo_finish_price > 60000                                               then 12
                   end                                                                                                                    as loan_amt_type
                   ,uix.province_cd                                                                                                       as province_cd
                   ,case 
                       when crd.td_final_score is null                             then 0
                       when crd.td_final_score >= 0  and crd.td_final_score <= 10  then 1
                       when crd.td_final_score >= 11 and crd.td_final_score <= 20  then 2
                       when crd.td_final_score >= 21 and crd.td_final_score <= 30  then 3
                       when crd.td_final_score >= 31 and crd.td_final_score <= 40  then 4
                       when crd.td_final_score >= 41 and crd.td_final_score <= 50  then 5
                       when crd.td_final_score >= 51 and crd.td_final_score <= 60  then 6
                       when crd.td_final_score >= 61 and crd.td_final_score <= 70  then 7
                       when crd.td_final_score >= 71 and crd.td_final_score <= 80  then 8
                       when crd.td_final_score >= 81 and crd.td_final_score <= 90  then 9
                       when crd.td_final_score >= 91 and crd.td_final_score <= 100 then 10
                   end                                                                                                                    as td_score_type
                   ,case 
                       when crd.td_platform_count_7d is null                                   then 0
                       when crd.td_platform_count_7d >= 1  and crd.td_platform_count_7d <= 5   then 1
                       when crd.td_platform_count_7d >= 6  and crd.td_platform_count_7d <= 10  then 2
                       when crd.td_platform_count_7d >= 11 and crd.td_platform_count_7d <= 20  then 3
                       when crd.td_platform_count_7d >= 21 and crd.td_platform_count_7d <= 30  then 4
                       when crd.td_platform_count_7d >= 26 and crd.td_platform_count_7d <= 30  then 5
                       when crd.td_platform_count_7d >= 31                                     then 6
                   end                                                                                                                    as td_platform_7d_type
                   ,case 
                       when crd.td_platform_count_1m is null                                   then 0
                       when crd.td_platform_count_1m >= 1  and crd.td_platform_count_1m <= 5   then 1
                       when crd.td_platform_count_1m >= 6  and crd.td_platform_count_1m <= 10  then 2
                       when crd.td_platform_count_1m >= 11 and crd.td_platform_count_1m <= 20  then 3
                       when crd.td_platform_count_1m >= 21 and crd.td_platform_count_1m <= 30  then 4
                       when crd.td_platform_count_1m >= 26 and crd.td_platform_count_1m <= 30  then 5
                       when crd.td_platform_count_1m >= 31                                     then 6
                   end                                                                                                                    as td_platform_1m_type
                   ,case 
                       when crd.td_platform_count_3m is null                                   then 0
                       when crd.td_platform_count_3m >= 1  and crd.td_platform_count_3m <= 5   then 1
                       when crd.td_platform_count_3m >= 6  and crd.td_platform_count_3m <= 10  then 2
                       when crd.td_platform_count_3m >= 11 and crd.td_platform_count_3m <= 20  then 3
                       when crd.td_platform_count_3m >= 21 and crd.td_platform_count_3m <= 30  then 4
                       when crd.td_platform_count_3m >= 26 and crd.td_platform_count_3m <= 30  then 5
                       when crd.td_platform_count_3m >= 31                                     then 6
                   end                                                                                                                    as td_platform_3m_type
                   ,case 
                       when crd.td_platform_count_6m is null                                   then 0
                       when crd.td_platform_count_6m >= 1  and crd.td_platform_count_6m <= 5   then 1
                       when crd.td_platform_count_6m >= 6  and crd.td_platform_count_6m <= 10  then 2
                       when crd.td_platform_count_6m >= 11 and crd.td_platform_count_6m <= 20  then 3
                       when crd.td_platform_count_6m >= 21 and crd.td_platform_count_6m <= 30  then 4
                       when crd.td_platform_count_6m >= 26 and crd.td_platform_count_6m <= 30  then 5
                       when crd.td_platform_count_6m >= 31                                     then 6
                   end                                                                                                                    as td_platform_6m_type
                   ,case 
                        when amc.bo_id is not null and amc.batch = 1 then 1 
                        when amc.bo_id is not null and amc.batch = 2 then 2
                        else 0 
                   end                                                                                                                    as amc_type                 --new
                   ,case when grd.user_id is not null and grd.graduate_date <= '${T_SUB_1}' then 1 else 0 end                             as graduate_type            --new
                   ,case when t.overdue_unrepay_days >= 90 then 1 else 0 end                                                              as m3p_type                 --new
                   ,case when t.overdue_unrepay_days >= 180 then 1 else 0 end                                                             as m6p_type                 --new                   
                   ,t.overdue_unrepay_days                                                                                                as overdue_unrepay_days
                   ,t.unrepay_price_b                                                                                                     as unrepay_price_b
                   ,case when t.overdue_unrepay_days >= 1  then t.unrepay_price_b else 0 end                                              as dpd1_unrepay_price_b
                   ,case when t.overdue_unrepay_days >= 10 then t.unrepay_price_b else 0 end                                              as dpd10_unrepay_price_b
                   ,case when t.overdue_unrepay_days >= 30 then t.unrepay_price_b else 0 end                                              as dpd30_unrepay_price_b
                   ,case when t.overdue_unrepay_days >= 60 then t.unrepay_price_b else 0 end                                              as dpd60_unrepay_price_b
                   ,case when t.overdue_unrepay_days >= 90 then t.unrepay_price_b else 0 end                                              as dpd90_unrepay_price_b
                   ,'${T_SUB_1}'                                                                                                          as stat_date
            from      
            (     
                 select  bo_id
                        ,user_id
                        ,bo_success_time
                        ,bo_finish_price
                        ,user_type
                        ,level_type
                        ,mob
                        ,expect_type
                        ,p_key
                        ,product_cd
                        ,overdue_unrepay_days
                        ,unrepay_price_b
                        ,stat_date
                   from tmp.tmp_risk_vintage_1

            union all

                 select  bo_id
                        ,user_id
                        ,bo_success_time
                        ,bo_finish_price
                        ,user_type
                        ,level_type
                        ,mob
                        ,expect_type
                        ,p_key
                        ,product_cd
                        ,overdue_unrepay_days
                        ,unrepay_price_b
                        ,stat_date
                   from tmp.tmp_risk_vintage_2
            ) t 
  left join (
                     select ui.id user_id, 
                            ui2.id_num,
                            case when ui2.id_num is null then '00' else substr(ui2.id_num,1,2) end province_cd,
                            case when ui2.gender is null then 0 else ui2.gender end gender_type, 
                            case when ui2.birth_dt is null then 0 else year('${T_SUB_1}') - year(ui2.birth_dt) end age,
                            edu.college,
                            CASE 
                                WHEN ss.type = '4' THEN '专科'
                                WHEN ss.type < '4' THEN CONCAT(ss.type, '本')
                                when ss.type is null or trim(ss.type) = '' then '缺失'
                                ELSE ss.type
                            END SCHOOL_TYPE_DESC,
                            case 
                                when edu.education like '%博士%'                                                                                                        then 1 --'博士'
                                when edu.education like '%硕士%' or edu.education like '%研究生%'                                                                       then 2 --'硕士'
                                when edu.education = '本科' or edu.education like '%第二学士学位%' or edu.education like '%高升本%' or edu.education like '%专升本%'    then 3 --'本科'
                                when edu.education = '专科' or edu.education like '%大专%' or edu.education like '%第二专科%' or edu.education like '%专科(高职%'       then 4 --'专科'
                                when edu.education = '专科以下' or edu.education like '%中专及高中%' or edu.education like '%中专%' or edu.education like '%高中以下%'
                                     or edu.education like '%夜大电大函大普通班%' or edu.education like '%初中及以下%'                                                  then 5 --'专科以下'
                                when edu.education is null or trim(edu.education) = ''                                                                                  then 0 --'缺失'
                                else                                                                                                                                         9 --'其他'
                            end as education
                      from ods.t_user_info_hist ui 
                 left join (      
                              select ui.id user_id,
                                     coalesce(b.college, c.college) college,
                                     coalesce(b.degree, c.degree) education
                                from ods.t_user_info_hist ui
                                left join (select t1.user_id, t2.degree, t2.auth_time, t2.graduate_date, t2.college
                                             from odsopr.user_loan_auth_info_hist t1
                                             join odsopr.user_edu_auth_log_hist t2
                                               on t1.auth_code = 1
                                              and t1.auth_id = t2.id) b
                                  on ui.id = b.user_id
                                left join idw.user_pengyuan_edu_legacy c
                                  on ui.id = c.user_id
                               where coalesce(b.user_id, c.user_id) is not null 
                           ) edu
                        on ui.id = edu.user_id
                 left join (
                                select name,
                                       type,
                                       row_number() over(partition by name order by id desc) rn
                                  from odsopr.student_school_hist
                           ) ss
                        on edu.college = ss.name
                       and ss.rn = 1
                 left join (
                                select ui2.id, 
                                       ui2.id_num,
                                       case 
                                            when length(ui2.id_num) = 18 and substr(ui2.id_num,-2,1) in ('1','3','5','7','9') then 1     --18位 男
                                            when length(ui2.id_num) = 18 and substr(ui2.id_num,-2,1) in ('2','4','6','8','0') then 2     --18位 女
                                            when length(ui2.id_num) = 15 and substr(ui2.id_num,-1,1) in ('1','3','5','7','9') then 1     --15位 男
                                            when length(ui2.id_num) = 15 and substr(ui2.id_num,-1,1) in ('2','4','6','8','0') then 2     --15位 女
                                        end gender,
                                        from_unixtime(unix_timestamp(case when length(ui2.id_num) = 15 then concat('19', substr(ui2.id_num, 7, 6)) 
                                                                          when length(ui2.id_num) = 18 then substr(ui2.id_num, 7, 8)
                                                                     end,
                                                           'yyyyMMdd'),
                                            'yyyy-MM-dd') as birth_dt
                                from 
                                (select id , 
                                       case when ui.is_card = 1 then regexp_extract(regexp_replace(ui.id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) end  id_num
                                  from ods.t_user_info_hist ui ) ui2 
                           ) ui2
                        on ui2.id = ui.id
            ) uix
         on uix.user_id = t.user_id
  left join ( 
               select user_id, bo_id, cast(td_final_score as int) td_final_score, cast(td_platform_count_7d as int) td_platform_count_7d, 
                      cast(td_platform_count_1m as int) td_platform_count_1m,  cast(td_platform_count_3m as int) td_platform_count_3m, cast(td_platform_count_6m as int) td_platform_count_6m 
                 from odsopr.borrows_credit_info_merge_hist
            ) crd
         on crd.bo_id = t.bo_id
  left join idw.amc_bo amc              --amc处置标
         on amc.bo_id = t.bo_id
  left join msc.v_user_edu_record5 grd  --毕业情况
         on grd.user_id = t.user_id 
        and grd.h_ctime = 1 
;




