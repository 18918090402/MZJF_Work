
DROP VIEW IDWOPR.FACT_FIN_LOG_ALL;
CREATE VIEW IDWOPR.FACT_FIN_LOG_ALL 
AS 
--直接获取bo_id
select 
    'remark_bo_id' source_id
    ,t.id
    ,t.account_id
    ,t.role_id
    ,t.operation_relation
    ,t2.source_describe
    ,coalesce(t.user_id, t1.user_id) user_id
    ,regexp_extract(regexp_replace(t.remark,'[,.，。：:]+',''), '([0-9]+)', 1)  as  bo_id
    ,t1.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.create_time
from odsopr.finance_log_all t
left join idw.fact_borrows t1
on regexp_extract(regexp_replace(t.remark,'[,.，。：:]+',''), '([0-9]+)', 1) = cast(t1.bo_id as string)
left join odsopr.finance_operation_relation t2
on t.operation_relation = t2.id
where t.operation_relation in (738,740,722,742,694,696,714,735,822,753,810,813,816,812,815,818)   --bo_id 

union all

--ba_id
select 
    'remark_ba_id' source_id
    ,t.id
    ,t.account_id
    ,t.role_id
    ,t.operation_relation
    ,t2.source_describe
    ,coalesce(t.user_id, t1.user_id) user_id
    ,cast(t1.bo_id as string) bo_id
    ,t3.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.create_time
from odsopr.finance_log_all t
left join odsopr.borrows_accept t1
on regexp_extract(regexp_replace(t.remark,'[,.，。：:]+',''), '([0-9]+)', 1) = cast(t1.id as string)
left join odsopr.finance_operation_relation t2
on t.operation_relation = t2.id
left join idw.fact_borrows t3
on t1.bo_id = t3.bo_id
where t.operation_relation in (774,720,731,698,700)   --ba_id ????

union all

--br_id
select 
    'remark_br_id' source_id
    ,t.id
    ,t.account_id
    ,t.role_id
    ,t.operation_relation
    ,t2.source_describe
    ,coalesce(t.user_id, t1.user_id) user_id
    ,cast(t1.bo_id as string) bo_id
    ,t1.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.create_time
from odsopr.finance_log_all t
left join idw.fact_borrows_repayment t1
on regexp_extract(regexp_replace(t.remark,'[,.，。：:]+',''), '([0-9]+)', 1) = cast(t1.br_id as string)
left join odsopr.finance_operation_relation t2
on t.operation_relation = t2.id
where  t.operation_relation in (702,757,759,761,775,802,805,715)   --br_id 

union all

--pay_no
select 
    'remark_pay_no' source_id
    ,t.id
    ,t.account_id
    ,t.role_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,t2.borrows_id bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.create_time
from odsopr.finance_log_all t
left join odsopr.acc_pay_back_repay_detail t1
on regexp_extract(regexp_replace(t.remark,'[,.，。：:]+',''), '([0-9]+)', 1) = cast(t1.pay_no as string) 
left join odsopr.trans_repayment_order t2
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.borrows_id as BIGINT) = t4.bo_id
where t.operation_relation in (764,766, 768,770,708,778,711,710,745)   --pay_no 

union all

--无bo_id
select 
    'remark_NULL' source_id
    ,t.id
    ,t.account_id
    ,t.role_id
    ,t.operation_relation
    ,t2.source_describe
    ,t.user_id
    ,NULL as bo_id
    ,NULL p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.create_time
from odsopr.finance_log_all t
left join odsopr.finance_operation_relation t2
on t.operation_relation = t2.id
where t.operation_relation in (692,808,793,792,794,795,681,683,771,825,823,751,794)   

union all

select
    '财神爷爷'                      source_id
    ,'csyy_id'                      id
    ,'csyy_account'                 account_id
    ,'业务_财神爷爷'                role_id
    ,NULL                           operation_relation
    ,'红包奖励'                     source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,invest_amount                  amount
    ,NULL                           income
    ,NULL                           expend
    ,NULL                           balance
    ,NULL                           remark
    ,up.dw_create_time              create_time    
FROM odsopr.user_product up
left join odsopr.account_relation ar
on up.user_code = ar.merchant_user_id
WHERE up.STATUS = 'A'

union all 

select 
    '财神爷爷'                      source_id
    ,'csyy_id'                      id
    ,'csyy_account'                 account_id
    ,'业务_财神爷爷'                role_id
    ,NULL                           operation_relation
    ,'抵扣券'                       source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,privilege_amount               amount
    ,NULL                           income
    ,NULL                           expend
    ,NULL                           balance
    ,NULL                           remark
    ,wpc.create_date                create_time    
FROM odsopr.welfare_privilege_code  wpc
left join odsopr.account_relation ar
on wpc.user_code = ar.merchant_user_id
WHERE wpc.welfare_type=5
AND wpc.use_status=1

union all 

select 
   '财神爷爷'                      source_id
    ,'csyy_id'                      id
    ,'csyy_account'                 account_id
    ,'业务_财神爷爷'                role_id
    ,NULL                           operation_relation
    ,'体验金'                       source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,reward_interest                amount
    ,NULL                           income
    ,NULL                           expend
    ,NULL                           balance
    ,NULL                           remark
    ,ui.created_date                 create_time    
FROM odsopr.user_interest ui
left join odsopr.account_relation ar
on ui.user_code = ar.merchant_user_id
WHERE reward_interest>0

union all 

select 
   '财神爷爷'                      source_id
    ,'csyy_id'                      id
    ,'csyy_account'                 account_id
    ,'业务_财神爷爷'                role_id
    ,NULL                           operation_relation
    ,'现金奖励'                     source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,amount                         amount
    ,NULL                           income
    ,NULL                           expend
    ,NULL                           balance
    ,NULL                           remark
    ,a.create_date                 create_time    
FROM odsopr.user_account_trans_log a
left join odsopr.account_relation ar
on a.user_code = ar.merchant_user_id
WHERE a.operation_type = 3

union all

select
   '财神爷爷'                       source_id
    ,'csyy_id'                      id
    ,'csyy_account'                 account_id
    ,'业务_财神爷爷'                role_id
    ,NULL                           operation_relation
    ,'手续费'                       source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,ROUND(SUM(IF(kind=3,sxf,0)),2)-ROUND(SUM(IF(kind=3,0,sxf)),2)    amount
    ,NULL                           income
    ,NULL                           expend
    ,NULL                           balance
    ,NULL                           remark
    ,a.create_date                 create_time    
FROM 
(
    SELECT 
        a.user_code,FROM_UNIXTIME(UNIX_TIMESTAMP(trans_date,"yyyyMMdd"),"yyyy-MM-dd") create_date,a.trans_code,a.amount
        ,CASE 
            WHEN a.trans_date < "20150929" THEN a.amount*0.003 
            WHEN a.trans_date < "20160101" THEN a.amount*0.002 
            ELSE a.amount*0.0012 
        END sxf
        ,1 kind
    FROM odsopr.trans_detail a
    WHERE a.trans_code IN (0,1)
    AND a.user_code != 999999999 
    AND a.status = '2'
    UNION ALL
    SELECT a.user_code,a.create_date,a.trans_code,-a.withdraw_amount as amount
        ,CASE WHEN a.create_date < "2015-09-29" THEN 1.2 ELSE 1.0 END sxf
        ,2 kind
    FROM odsopr.withdraw_reward a
    WHERE a.user_code != 999999999 
    AND a.status IN (2,3,8) 
    UNION ALL
    SELECT wr.user_code,SUBSTR(wr.create_date,1,10) create_date,wr.trans_code,0 as amount,wml.less_amount as sxf,3 kind
    FROM odsopr.user_withdraw_money_log wml
    LEFT JOIN odsopr.withdraw_reward wr ON wr.orderid= wml.str1
    WHERE wr.user_code != 999999999 
) a
left join odsopr.account_relation ar
on a.user_code = ar.merchant_user_id
group by ar.nono_user_id,a.create_date 
