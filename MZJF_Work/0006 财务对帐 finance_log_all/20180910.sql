
--------
select   --24444389
    'proof_id_acc_depository_trans_record' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.borrows_id as string) bo_id
    ,t4.p_key
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
where t.operation_relation in (771,698,708,710,711,764,766,768,770,778,731)  --32889688

---------
select   --7151167
    'proof_id_tb_p2p_file_detail_repayment' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) as user_id
    ,t1.bo_id
    ,t4.p_key
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
on cast(t1.bo_id as BIGINT) = t4.bo_id

---------------------------------------


select --947814
    'remark_pay_no_acc_pay_back_repay_detail' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
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
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from msc.oper_rela_other1 t         --rows=1294132
left join odsopr.acc_pay_back_repay_detail t1
on regexp_extract(regexp_replace(t.remark,'[,.£¬¡££º:]+',''), '([0-9]+)', 1) = cast(t1.pay_no as string) 
inner join odsopr.trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.borrows_id as BIGINT) = t4.bo_id

-----


select --345687
    'proof_id_acc_depository_trans_record' source_id
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.role_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.bo_id as string) bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.balance
    ,t.remark
    ,t.key_value
    ,t.proof_id
    ,t.create_time
from msc.oper_rela_other2 t
left join odsopr.acc_depository_trans_record t1
on t.proof_id = t1.proof_id
inner join odsopr.fund_trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.bo_id as BIGINT) = t4.bo_id

------------



Ê£Óà 631 ÌõÊý¾Ý 
