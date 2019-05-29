--tmp tab fact_risk_overdue_quota_m_prepare
drop table if exists tmp.fact_risk_overdue_quota_m_prepare;

create table tmp.fact_risk_overdue_quota_m_prepare
as 
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
             
             ,cast(months_between(to_date('${T_SUB_1}'),last_day(t.bo_success_date)) as int )                                   as mob                             --MOB
             
             ,case when t.OVERDUE_UNREPAY_DAYS >= 90 
                    and t2.bo_id is not null 
                    and t3.bo_id is null
                    and months_between(to_date('${T_SUB_1}'),last_day(t.bo_success_date)) <= 6 
                   then 1 else 0 end                                                                                      as fraud_loss                      --欺诈损失
             ,case when t.OVERDUE_UNREPAY_DAYS >= 90 
                    and t2.bo_id is not null
                    and t3.bo_id is null                    
                    and months_between(to_date('${T_SUB_1}'),last_day(t.bo_success_date)) <= 6 
                   then t.UNREPAY_PRICE_B else 0 end                                                                      as fraud_loss_unrepay_price_b      --欺诈损失未还本金
             ,'${T_SUB_1}' as stat_date             
        from dw_srmopr.fact_risk_vintage_quota_m t 
   left join dw_srmopr.fact_risk_vintage_quota_m t2     --上月未损失
          on t2.bo_id = t.bo_id 
         and t2.stat_date = to_date(date_sub(trunc('${T_SUB_1}','MM'),1))
         and t2.OVERDUE_UNREPAY_DAYS < 90
   left join ( 
                   select bo_id 
                     from dw_srmopr.fact_risk_vintage_quota_m 
                    where stat_date < to_date(date_sub(trunc('${T_SUB_1}','MM'),1))
                      and OVERDUE_UNREPAY_DAYS >= 90 
                 group by bo_id
             ) t3     --排除以往已损失
          on t3.bo_id = t.bo_id        
       where t.stat_date = '${T_SUB_1}'
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
                    then t.m3_unrepay_price_b else 0 end               as m3_m4_roll_unrepay_price_b                        --上期月末M3到本期月末M4的撮合借贷余额
              ,case when t7.bo_id is not null and t7.m0 = 1 
                     and t6.bo_id is not null and t6.m1 = 1 
                     and t5.bo_id is not null and t5.m2 = 1 
                     and t3.bo_id is not null and t3.m3 = 1 
                     and  t.bo_id is not null and  t.m4 = 1 
                    then t.m4_unrepay_price_b else 0 end               as m4_roll_unrepay_price_b                           --M0_M4的撮合借贷余额  （滚动率的分子）
              ,case when t7.bo_id is not null and t7.m0 = 1 
                     --and t6.bo_id is not null and t6.m1 = 1 
                     --and t5.bo_id is not null and t5.m2 = 1 
                     --and t3.bo_id is not null and t3.m3 = 1 
                     --and  t.bo_id is not null and  t.m4 = 1 
                    then t7.m0_unrepay_price_b else 0 end              as m0_roll_unrepay_price_b                           --M0_M4的撮合借贷余额  （滚动率的分母）
              ,t.stat_date
         from tmp.fact_risk_overdue_quota_m_prepare t     -- 当月末
    left join tmp.fact_risk_overdue_quota_m_prepare t2    -- 历史新增的损失帐户
           on t2.bo_id = t.bo_id
          and t2.stat_date < '${T_SUB_1}' 
          and t2.new_loss = 1 
    left join tmp.fact_risk_overdue_quota_m_prepare tt    -- 历史欺诈的损失帐户
           on tt.bo_id = t.bo_id
          and tt.stat_date < '${T_SUB_1}' 
          and tt.fraud_loss = 1 
    left join tmp.fact_risk_overdue_quota_m_prepare t3    -- 前1月末    m3
           on t3.bo_id = t.bo_id 
          and t3.stat_date = to_date(date_sub(trunc('${T_SUB_1}','MM'),1))    
    left join tmp.fact_risk_overdue_quota_m_prepare t5    -- 前2月末    m2 
           on t5.bo_id = t.bo_id 
          and t5.stat_date = to_date(date_sub(trunc(date_sub(trunc('${T_SUB_1}','MM'),1),'MM'),1))
    left join tmp.fact_risk_overdue_quota_m_prepare t6    -- 前3月末    m1
           on t6.bo_id = t.bo_id 
          and t6.stat_date = to_date(date_sub(trunc(date_sub(trunc(date_sub(trunc('${T_SUB_1}','MM'),1),'MM'),1),'MM'),1))
    left join tmp.fact_risk_overdue_quota_m_prepare t7    -- 前4月末    m0 
           on t7.bo_id = t.bo_id 
          and t7.stat_date = to_date(date_sub(trunc(date_sub(trunc(date_sub(trunc(date_sub(trunc('${T_SUB_1}','MM'),1),'MM'),1),'MM'),1),'MM'),1))
        where t.stat_date = '${T_SUB_1}'
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
         on amc.amc_type = t.amc_type              --增加维度
        
 inner join dw_srmopr.dim_graduate_cat grd 
         on grd.graduate_type = t.graduate_type    --增加维度

 inner join dw_srmopr.dim_overdue_m3p_cat m3p
         on m3p.m3p_type = t.m3p_type              --增加维度
        
 inner join dw_srmopr.dim_overdue_m6p_cat m6p
         on m6p.m6p_type = t.m6p_type              --增加维度
      where t.stat_date = '${T_SUB_1}' 
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
