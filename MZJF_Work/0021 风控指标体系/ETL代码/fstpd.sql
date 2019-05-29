--impala

     insert overwrite table dw_srm.fact_risk_fstpd_quota_d partition (stat_date) 
     select t.bo_success_month
            ,t.ind
            ,t.user_id
            ,t.bo_id
            ,t.level_type                              --modify
            ,t.product_cd
            ,t.expect_type                             --modify
            ,t.p_key
            ,t.bo_success_time
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
        select a.bo_success_month
               ,a.ind
               ,a.user_id
               ,a.bo_id
               ,a.level_type
               ,a.product_cd
               ,a.expect_type
               ,a.p_key
               ,a.bo_success_time
               ,a.mob
               ,a.bo_finish_price
               --FPD
               ,sum(case when a.br_expect_num = 1 and (to_date('${T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('${T_SUB_1}') then to_date('${T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_first_repay_overdue
               ,sum(case when a.br_expect_num = 1 and (to_date('${T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('${T_SUB_1}') then to_date('${T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('${T_SUB_1}') then to_date('${T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as first_repay_overdue_days
               ,sum(case when a.br_expect_num >= 1 then a.br_price_b else 0 end )                                                                                             as first_unrepay_price_b
               
               --SPD
               ,sum(case when a.br_expect_num = 2 and (to_date('${T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('${T_SUB_1}') then to_date('${T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_second_repay_overdue
               ,sum(case when a.br_expect_num = 2 and (to_date('${T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('${T_SUB_1}') then to_date('${T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('${T_SUB_1}') then to_date('${T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as second_repay_overdue_days
               ,sum(case when a.br_expect_num >= 2 then a.br_price_b else 0 end )                                                                                             as second_unrepay_price_b
               
               --TPD
               ,sum(case when a.br_expect_num = 3 and (to_date('${T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('${T_SUB_1}') then to_date('${T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_third_repay_overdue
               ,sum(case when a.br_expect_num = 3 and (to_date('${T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('${T_SUB_1}') then to_date('${T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('${T_SUB_1}') then to_date('${T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as third_repay_overdue_days
               ,sum(case when a.br_expect_num >= 3 then a.br_price_b else 0 end )                                                                                             as third_unrepay_price_b
               ,a.stat_date
          from (
                    select substr(to_date(bo.bo_success_time),1,7) as bo_success_month
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
                            end as level_type
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
                                when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36) then 0
                                else bo.bo_expect
                            end as expect_type 
                           ,bo.p_key
                           ,to_date(bo.bo_success_time) as bo_success_time
                           ,cast(months_between(to_date('${T_SUB_1}'),last_day(bo.bo_success_time)) as int ) as mob
                           ,bo.bo_finish_price
                           ,br.br_expect_num
                           ,br.br_price_b
                           ,br.br_repay_time
                           ,br.br_time
                           ,br.br_overdue_terms
                           ,'${T_SUB_1}' stat_date
                      from idw.fact_borrows bo
                      join idw.fact_borrows_repayment br
                        on bo.bo_id = br.bo_id
                 left join (
                                          select bo.user_id,
                                                 bo.bo_id ,
                                                 bo.bo_success_time,
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
                      where 1 = 1
                        and bo.bo_is_success = 1
                        and to_date(bo.bo_success_time) <= '${T_SUB_1}'
                        and bo.p_name not like '%麦芽%' and bo.p_name not like '%美呗%'              --排除麦芽、医美产品
                  
                      union all
                  
                    select substr(to_date(bo.bo_success_time),1,7)
                           ,'线下' ind       --剔除测试和退款的数据  
                           ,bo.user_id
                           ,bo.bo_id
                           ,mo.LEVEL              as level_type
                           ,case 
                               when mo.flag = '老医美' and mo.dic_item in ('教育', '婚庆')    then '020101'
                               when mo.flag = '老医美' and mo.dic_item = '医疗美容'           then '020102'
                               when mo.flag = '新医美' and mo.qd_pass <> '1'                  then '020201'
                               when mo.flag = '新医美' and mo.qd_pass = '1'                   then '020202'
                               else '000000'
                            end as product_cd
                            ,case 
                                when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36) then 0
                                else bo.bo_expect
                            end as expect_type               
                           ,bo.p_key
                           ,to_date(bo.bo_success_time) as bo_success_time
                           ,cast(months_between(to_date('${T_SUB_1}'),last_day(bo.bo_success_time)) as int ) as mob
                           ,bo.bo_finish_price
                           ,br.br_expect_num
                           ,br.br_price_b
                           ,br.br_repay_time
                           ,br.br_time
                           ,br.br_overdue_terms                           
                           ,'${T_SUB_1}' stat_date
                      from idw.fact_borrows bo
                      join idw.fact_borrows_repayment br
                        on bo.bo_id = br.bo_id
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
                           ) mo 
                        on mo.bo_id = bo.bo_id
                     where 1 = 1
                       and bo.bo_is_success = 1
                       and to_date(bo.bo_success_time) <= '${T_SUB_1}'
                       and mo.SHOP_NAME not LIKE '%测试%' and mo.SHOP_NAME not LIKE '%退款%'    --剔除测试和退款的数据
                       and ( bo.p_name like '%麦芽%' or bo.p_name like '%美呗%' )
                ) a 
       group by 1,2,3,4,5,6,7,8,9,10,11,21
          
    ) t 
;
