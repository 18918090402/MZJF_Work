DROP VIEW IDWOPR.FACT_FIN_LOG_ALL;


CREATE VIEW IDWOPR.FACT_FIN_LOG_ALL 
AS 
--从remark获取bo_id    全部能匹配  !!
select 
    'remark_bo_id' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t2.source_describe
    ,coalesce(t.user_id, t1.user_id) user_id
    ,regexp_extract(regexp_replace(t.remark,'[,.，。：:]+',''), '([0-9]+)', 1)  as  bo_id
    ,t1.p_key
    ,t1.p_id
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from odsopr.finance_log_all t 
inner join idw.fact_borrows t1 
on regexp_extract(regexp_replace(t.remark,'[,.，。：:]+',''), '([0-9]+)', 1) = cast(t1.bo_id as string) 
left join odsopr.finance_operation_relation t2 
on t.operation_relation = t2.id 
where t.operation_relation in ( 694,696,714,722,735,738,740,742,753,  812,815,818,822,702 )     -- or=14, final rows=18133600

--810,813,816

union all

select 
    'remark_bo_id' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t2.source_describe
    ,coalesce(t.user_id, t1.user_id) user_id
    ,cast(t1.bo_id as string) bo_id
    ,t1.p_key
    ,t1.p_id
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from odsopr.finance_log_all t 
left join idw.fact_borrows t1 
on regexp_replace(regexp_extract(t.remark,'借款([0-9]+)<',0),'借款|<','') = cast(t1.bo_id as string) 
left join odsopr.finance_operation_relation t2 
on t.operation_relation = t2.id 
where t.operation_relation in (109,217) -- 217有的关联不上 bo

union all

select
    'proof_id' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.borrows_id as string) bo_id
    ,t4.p_key
    ,t4.p_id
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from odsopr.finance_log_all t
left join odsopr.acc_depository_trans_record t1
on t.proof_id = t1.proof_id
inner join odsopr.trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.borrows_id as BIGINT) = t4.bo_id
where t.operation_relation = 702            --final rows=25752

union all 

select 
    'proof_id' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.bo_id as string) bo_id
    ,t4.p_key
    ,t4.p_id
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from odsopr.finance_log_all t   --rows=346318
left join odsopr.acc_depository_trans_record t1
on t.proof_id = t1.proof_id
inner join odsopr.fund_trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.bo_id as BIGINT) = t4.bo_id  
where t.operation_relation = 702            --final rows=5441

union all

--从key_value获取bo_id     全部能匹配  !!
select 
    'key_value_bo_id' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t2.source_describe
    ,coalesce(t.user_id, t1.user_id) user_id
    ,cast(t1.bo_id as string) bo_id
    ,t1.p_key
    ,t1.p_id    
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from odsopr.finance_log_all t
left join idw.fact_borrows t1
on t.key_value = cast(t1.bo_id as string)
left join odsopr.finance_operation_relation t2
on t.operation_relation = t2.id
where t.operation_relation in (774,720,700)     --or=3, rows=7159822

union all

--从remark中获取br_id               
-- or=715, 有2条数据bo_id为NULL   id=1672056447 / id=1675850419
select 
    'remark_br_id' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t2.source_describe
    ,coalesce(t.user_id, t1.user_id) user_id
    ,cast(t1.bo_id as string) bo_id
    ,t1.p_key
    ,t1.p_id    
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from odsopr.finance_log_all t
left join idw.fact_borrows_repayment t1 
on regexp_extract(regexp_replace(t.remark,'[,.，。：:]+',''), '([0-9]+)', 1) = cast(t1.br_id as string)
left join odsopr.finance_operation_relation t2
on t.operation_relation = t2.id
where t.operation_relation in (715,757,759,761,775,802,805)   --or=7, rows=4695781+2
and t.id not in (1672056447, 1675850419)    --代偿数据  存管上线时，徽商有不明确的交易单码，人工修复的数据 不应该计入日志表，其他已经删除

union all

--无bo_id
select 
    '没有标的信息' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t2.source_describe
    ,t.user_id
    ,NULL as bo_id
    ,NULL p_key
    ,NULL p_id    
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from odsopr.finance_log_all t
left join odsopr.finance_operation_relation t2
on t.operation_relation = t2.id
where t.operation_relation in (681,683,692,745,751,792,793,794,795,808)  --or=12, rows=6080764 



union all

-- 以下从多张系统表拆分出bo_id            start

select 
    'proof_id' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.borrows_id as string) bo_id
    ,t4.p_key
    ,t4.p_id    
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from odsopr.finance_log_all t
left join odsopr.acc_depository_trans_record t1
on t.proof_id = t1.proof_id
inner join odsopr.trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.borrows_id as BIGINT) = t4.bo_id
where t.operation_relation in (771,698,708,710,711,764,766,768,770,778,731)  --(or=11, all rows=32949345)  final rows=24444536

union all

select 
    'proof_id' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) as user_id
    ,cast(t1.bo_id as string) bo_id
    ,t4.p_key
    ,t4.p_id    
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from msc.oper_rela_other t     --rows=8504809
inner join odsopr.tb_p2p_file_detail_repayment t1 
on t.proof_id = t1.proof_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t1.bo_id as BIGINT) = t4.bo_id      --final rows=7210677

union all

select 
    'remark_pay_no' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,t2.borrows_id bo_id
    ,t4.p_key
    ,t4.p_id    
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from msc.oper_rela_other1 t         --rows=1294132
left join odsopr.acc_pay_back_repay_detail t1
on regexp_extract(regexp_replace(t.remark,'[,.，。：:]+',''), '([0-9]+)', 1) = cast(t1.pay_no as string) 
inner join odsopr.trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.borrows_id as BIGINT) = t4.bo_id    --final rows=947814

union all

select 
    'proof_id' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.bo_id as string) bo_id
    ,t4.p_key
    ,t4.p_id    
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from msc.oper_rela_other2 t   --rows=346318
left join odsopr.acc_depository_trans_record t1
on t.proof_id = t1.proof_id
inner join odsopr.fund_trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.bo_id as BIGINT) = t4.bo_id   --final rows=345687

--剩余631
--select count(1) from msc.oper_rela_other3      --rows=631

-- /* ===========================            end        */

union all

--财神爷爷
select
    '财神爷爷'                      source_id
    ,NULL                           id
    ,NULL                           account_id
    ,NULL                           opposite_account_id
    ,NULL                           role_id
    ,NULL                           operation_relation
    ,'红包奖励'                     source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,NULL                           p_id
    ,invest_amount                  amount
    ,NULL                           income
    ,NULL                           expend
    ,NULL                           balance
    ,NULL                           remark
    ,NULL                           key_value
    ,NULL                           proof_id
    ,up.dw_create_time              create_time    
FROM odsopr.user_product up
left join odsopr.account_relation ar
on up.user_code = ar.merchant_user_id
WHERE up.STATUS = 'A'

union all 

select 
    '财神爷爷'                      source_id
    ,NULL                           id
    ,NULL                           account_id
    ,NULL                           opposite_account_id
    ,NULL                           role_id
    ,NULL                           operation_relation
    ,'抵扣券'                       source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,NULL                           p_id
    ,privilege_amount               amount
    ,NULL                           income
    ,NULL                           expend
    ,NULL                           balance
    ,NULL                           remark
    ,NULL                           key_value
    ,NULL                           proof_id
    ,wpc.create_date                create_time    
FROM odsopr.welfare_privilege_code  wpc
left join odsopr.account_relation ar
on wpc.user_code = ar.merchant_user_id
WHERE wpc.welfare_type=5
AND wpc.use_status=1

union all 

select 
   '财神爷爷'                      source_id
    ,NULL                           id
    ,NULL                           account_id
    ,NULL                           opposite_account_id
    ,NULL                           role_id
    ,NULL                           operation_relation
    ,'体验金'                       source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,NULL                           p_id
    ,reward_interest                amount
    ,NULL                           income
    ,NULL                           expend
    ,NULL                           balance
    ,NULL                           remark
    ,NULL                           key_value
    ,NULL                           proof_id
    ,ui.created_date                create_time    
FROM odsopr.user_interest ui
left join odsopr.account_relation ar
on ui.user_code = ar.merchant_user_id
WHERE reward_interest>0

union all 

select 
   '财神爷爷'                      source_id
    ,NULL                           id
    ,NULL                           account_id
    ,NULL                           opposite_account_id
    ,NULL                           role_id
    ,NULL                           operation_relation
    ,'现金奖励'                     source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,NULL                           p_id
    ,amount                         amount
    ,NULL                           income
    ,NULL                           expend
    ,NULL                           balance
    ,NULL                           remark
    ,NULL                           key_value
    ,NULL                           proof_id
    ,a.create_date                  create_time    
FROM odsopr.user_account_trans_log a
left join odsopr.account_relation ar
on a.user_code = ar.merchant_user_id
WHERE a.operation_type = 3

union all

select
   '财神爷爷'                       source_id
    ,NULL                           id
    ,NULL                           account_id
    ,NULL                           opposite_account_id
    ,NULL                           role_id
    ,NULL                           operation_relation
    ,'手续费'                       source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,NULL                           p_id
    ,ROUND(SUM(IF(kind=3,sxf,0)),2)-ROUND(SUM(IF(kind=3,0,sxf)),2)    amount
    ,NULL                           income
    ,NULL                           expend
    ,NULL                           balance
    ,NULL                           remark
    ,NULL                           key_value
    ,NULL                           proof_id
    ,a.create_date                  create_time
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
