

--帐户余额
drop view if exists msc.tmp_account_balance_20190308; 
create view msc.tmp_account_balance_20190308
as 
select user_id, sum(account_bal) account_bal, sum(standing_amt) standing_amt from 
(
    select user_id, role_id, balance,
           if(role_id = 7, balance, 0) as account_bal,      --账户余额
           if(role_id = 13, balance, 0) as standing_amt     --站岗资金
      from odsopr.finance_account 
     where role_id in (7, 13)   
) t
group by 1 
;




--充值数据
drop view if exists msc.tmp_recharge_20190308; 
create view msc.tmp_recharge_20190308
as 
select user_id, sum(RECHARGE_AMT) RECHARGE_AMT 
from (
  select 'biz_nono_recharge' biz_recharge,
         t2.USER_ID,
         t2.RECHARGE_TIME,
         t2.PAY_TYPE,
         t2.RECHARGE_TYPE,
         t2.RECHARGE_AMT,
         t2.system_id
    from idw.FACT_NONO_RECHARGE t2
   where t2.DATA_STATE = 'current'
     and t2.system_id = 'NONOBANK'
     
     union all
     
  select 'biz_nono_recharge',
         t2.USER_ID,
         t2.RECHARGE_TIME,
         t2.PAY_TYPE,
         t2.RECHARGE_TYPE,
         t2.RECHARGE_AMT,
         t1.register_biz
    from idw.dim_user t1
    join idw.FACT_NONO_RECHARGE t2
      on t1.user_id = t2.user_id
   where t1.register_biz in ('csyy', 'nono')
     and t2.DATA_STATE = 'curing'

    union all 

  select 'biz_csyy_recharge' ,
         t1.USER_ID,
         t1.RECHARGE_TIME,
         t1.PAY_TYPE,
         t1.RECHARGE_TYPE,
         t1.RECHARGE_AMT,
         t1.system_id
    from idw.FACT_NONO_RECHARGE t1
    left join ods.t_account_relation_hist t2
      on t1.user_id = t2.nono_user_id
   where t1.DATA_STATE = 'current'
     and t1.system_id = 'CSYY'

  union all

  select 'biz_csyy_recharge',
         t1.USER_ID,
         t1.RECHARGE_TIME,
         t1.PAY_TYPE,
         null RECHARGE_TYPE,
         t1.RECHARGE_AMT,
         'csyy'
    from idw.FACT_CSYY_RECHARGE t1
) t 
group by 1     
;




--提现数据
drop view if exists msc.tmp_withdraw_20190308; 
create view msc.tmp_withdraw_20190308
as 
select user_id, sum(withdraw_amt) withdraw_amt
from (
    select 'biz_nono_withdraw' biz_withdraw,
           user_id, 
           withdraw_channel, 
           withdraw_time, 
           withdraw_amt 
    from IDW.FACT_BIZ_NONO_WITHDRAW 
      
      union all 
      
    select 'biz_csyy_withdraw' biz_withdraw,
           user_id, 
           withdraw_channel, 
           withdraw_time, 
           withdraw_amt 
    from IDW.FACT_BIZ_CSYY_WITHDRAW 
) t 
group by 1      
;


--投资数据 
drop view if exists msc.tmp_invest_20190308; 
create view msc.tmp_invest_20190308
as 
select user_id, sum(invest_amt) invest_amt 
from (
SELECT 'biz_csyy_invest' biz_invest, user_id, product_category, product_code, invest_time, invest_amt 
FROM idw.fact_biz_csyy_invest 
UNION all
select 'biz_nono_invest' biz_invest, user_id, product_category, cast(fp_id as STRING), invest_time, invest_amt
from idw.fact_biz_nono_invest
) t 
group by 1    
;


--结算数据
drop view if exists msc.tmp_cash_20190308; 
create view msc.tmp_cash_20190308
as 
select t.user_id, 
       sum(ifnull(price_principal,price_amt)) price_principal,
       sum(ifnull(price_interest,0)) price_interest,
       sum(ifnull(price_amt,0)) price_amt
from 
(
    select 'biz_nono_invest_cash' biz_cash, user_id, product_category, cast(fp_id as string) fp_id, plan_cash_time, actual_cash_time,
           cash_status, price_principal, price_interest, price_amt, price_punish
      from IDW.FACT_BIZ_NONO_INVEST_CASH
      
      union all 

    --select 'biz_nono_invest_cash_curing' biz_cash, user_id, case
    --           when INVEST_TYPE_CODE = 1 then
    --            '散投'
    --           when INVEST_TYPE_CODE = 2 then
    --            '债转'
    --           when INVEST_TYPE_CODE = 3 then
    --            CATEGORY_NAME_02
    --           WHEN INVEST_TYPE_CODE = 4 THEN
    --            'E诺千金'
    --           WHEN INVEST_TYPE_CODE = 5 THEN
    --            '活期'
    --           WHEN INVEST_TYPE_CODE = 99 THEN
    --            'NA'
    --           ELSE
    --            'NA'
    --         end PRODUCT_CATEGORY, cast(fp_id as string), plan_cash_time, actual_cash_time,
    --       cash_status, price_principal, price_interest, price_amt, price_punish
    --  from IDW.FACT_NONO_INVEST_CASH
    -- where platform = 1 
    --   and data_state = 'curing'
    --   
    --   union all

    select 'biz_csyy_invest_cash' biz_cash, user_id, product_category, product_code, plan_cash_time, actual_cash_time,
           cash_status, price_principal, price_interest, price_amt, 0 
      from IDW.FACT_BIZ_CSYY_INVEST_CASH 

) t 
where t.cash_status = 1 
group by 1 
;



--471 财神收益、122 财神收益、682 平台福利, 计算 income 

drop view if exists msc.tmp_income_20190308; 
create view msc.tmp_income_20190308
as 
select fl.user_id, sum(fl.income)
from odsopr.finance_log_all fl
where to_date(create_time) <= to_date('${dt}') 
and fl.income > 0
and ((operation_relation = 471 and remark LIKE '%收益%') or operation_relation = 122 or operation_relation = 682)   --122  收益  、 470 
group by 1
--having user_id = 
;
        


--汇总SQL

       select t1.user_id                                                  as user_id
              ,t1.bank_deposit_flag                                       as deposit_flag
              ,sum(ifnull(t1.aum,0))                                      as aum 
              ,sum(ifnull(t1.in_invest_amt,0))                            as in_invest_amt
              ,sum(ifnull(t2.account_bal,0))                              as account_bal
              ,sum(ifnull(t2.standing_amt,0))                             as standing_amt
              ,sum(ifnull(t3.RECHARGE_AMT,0))                             as RECHARGE_AMT
              --,sum(ifnull(t10.all_recharge,0))                            as all_recharge
              ,sum(ifnull(t4.withdraw_amt,0))                             as withdraw_amt
              ,sum(ifnull(t5.invest_amt,0))                               as invest_amt
              ,sum(ifnull(t6.price_principal,0))                          as cash_price_principal
              ,sum(ifnull(t6.price_interest,0))                           as cash_price_interest
              ,sum(ifnull(t9.income, 0))                                  as extra_income

              ,sum(ifnull(t8.deductible_amt,0))                           as deductible_amt
              
              ,sum(ifnull(t7.price_principal,0))                          as debt_price_principal 
              ,sum(ifnull(t7.price_interest,0))                           as debt_price_interest
              ,sum(ifnull(t7.price,0))                                    as debt_price
              ,sum(ifnull(t7.overdue_unpaid_price_principal,0))           as overdue_unpaid_debt_price_principal
              ,sum(ifnull(t7.unpaid_price_principal,0))                   as unpaid_debt_price_principal
              ,sum(ifnull(t7.overdue_unpaid_price,0))                     as overdue_unpaid_debt_price
              ,sum(ifnull(t7.unpaid_price,0))                             as unpaid_debt_price              
              
         FROM (
                    SELECT user_id, 
                           if(to_date(t.register_time) <= '2017-05-31', 'before', 'after') bank_deposit_flag,      --'2017-05-31'存管时间分界线
                           sum(aum) aum, sum(in_invest_amt) in_invest_amt
                        FROM 
                        (
                            SELECT au.user_id,'csyy',
                                   sum(aum) aum,
                                   sum(in_invest_amt) in_invest_amt
                            FROM idw.fact_biz_csyy_aum au
                            WHERE stat_date = to_date(date_sub(now(),1))
                            AND aum > 0
                            GROUP BY 1

                            UNION ALL 

                            SELECT au.user_id, 'nono',
                                   sum(aum) aum,
                                   sum(in_invest_amt) in_invest_amt
                            FROM idw.fact_biz_nono_aum au
                            LEFT JOIN msc.v_nono_invest_special_user sp 
                            ON au.user_id = sp.user_id
                            WHERE sp.user_id IS NULL
                            AND stat_date = to_date(date_sub(now(),1))
                            AND aum > 0
                            GROUP BY 1
                        ) k
                        left join odsopr.user_info t 
                        on t.id = k.user_id 
                        GROUP BY 1, 2 
                        ORDER BY 2, 1
              ) t1
              
    left join msc.tmp_account_balance_20190308 t2
           on t2.user_id = t1.user_id 
           
    left join msc.tmp_recharge_20190308 t3
           on t3.user_id = t1.user_id 
           
    left join msc.tmp_withdraw_20190308 t4
           on t4.user_id = t1.user_id 
    
    left join msc.tmp_invest_20190308 t5
           on t5.user_id = t1.user_id 
           
    left join msc.tmp_cash_20190308 t6
           on t6.user_id = t1.user_id
           
    --left join (
    --                   select user_id
    --                          ,sum(original_price)                                        as original_price 
    --                          ,sum(price)                                                 as price 
    --                          ,sum(repay_price)                                           as repay_price 
    --                          ,sum(overdue_unpaid_price)                                  as overdue_unpaid_price 
    --                          ,sum(unpaid_price)                                          as unpaid_price 
    --                    from dmt.fact_debt_exchange_account_snapshot
    --                   where stat_date = to_date(date_sub(now(),1))
    --                group by 1
    --          ) t7
    --       on t7.user_id = t1.user_id 
    
    left join (
                     select b.user_id,
                            --b.bo_id, 
                            sum( b.price_principal ) as price_principal,
                            sum( b.price_interest ) as price_interest,
                            sum( b.price ) as price,
                            sum( case when b.plan_time <= to_date(date_sub(now(),1)) and (b.success_time is null or b.plan_time < to_date(b.success_time)) then b.price_principal 
                                      else 0 end ) as overdue_unpaid_price_principal ,
                            sum( case when b.plan_time > to_date(date_sub(now(),1)) then b.price_principal 
                                      else 0 end ) as unpaid_price_principal,
                                      
                            sum( case when b.plan_time <= to_date(date_sub(now(),1)) and (b.success_time is null or b.plan_time < to_date(b.success_time)) then b.price
                                      else 0 end ) as overdue_unpaid_price ,
                            sum( case when b.plan_time > to_date(date_sub(now(),1)) then b.price
                                      else 0 end ) as unpaid_price                      
                      from odsopr.invt_borrows_accept_unpaid b 
                 left join idw.fact_borrows_repayment br 
                        on br.bo_id = b.bo_id 
                       and br.br_expect_num = b.expect_num                      
                     where b.is_pay = 0 
                       and b.is_delete = 0 
                       and br.compensate_time is null          --剔除恢复债权的数据
                  group by 1
              ) t7 
           on t7.user_id = t1.user_id
           
    LEFT JOIN ( 
                    SELECT cu.user_id ,
                           SUM(CASE
                                   WHEN uc.type = 1 THEN uc.value
                                   ELSE 0
                               END) add_rate ,
                           SUM(CASE
                                   WHEN uc.type = 0 THEN uc.value
                                   ELSE 0
                               END) deductible_amt
                    FROM odsopr.coupon_use cu
                    JOIN odsopr.db_nono_user_coupon uc 
                    ON cu.uv_id = uc.id
                    AND uc.is_used = 1
                    GROUP BY 1 
              ) t8 
           on t8.user_id = t1.user_id
           
    left join (
                      select fl.user_id, sum(fl.income) income
                        from odsopr.finance_log_all fl
                       where to_date(create_time) <= to_date(date_sub(now(),1)) 
                         and fl.income > 0
                         and ((operation_relation = 471 and remark LIKE '%收益%') or operation_relation = 122 or operation_relation = 682)   --122  收益  、 470 
                    group by 1
              ) t9 
           on t9.user_id = t1.user_id
           
    left join (
                        select a.user_id,sum(income) as all_recharge
                          from odsopr.finance_log a 
                          join odsopr.finance_operation_relation b 
                            on a.operation_relation  = b.id 
                          join odsopr.finance_operation c
                            on b.operation_id = c.id 
                           and c.operation_name like '%充值%'  
                      group by 1    
              ) t10    --补充存管后注册用户缺失的充值数据
           on t10.user_id = t1.user_id           
    
    group by 2, 1
    ;
    
    
