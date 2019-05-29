--监管需求-11.1
select
    ui.user_id 出借人user_id,
    ui.user_name 出借人用户名,
    ui.real_name 出借人姓名,
    dim1.register_time 出借人注册时间 ,
    dim1.register_biz 出借人注册业务线 ,
    dim1.id_num 出借人身份证号 ,
    dim1.last_bind_card_account 出借人绑定银行卡号 ,
    dim1.last_bind_card_bank 出借人绑卡银行名称 ,
    dim1.hsb_bank_card 出借人徽商银行卡号 ,
    bo.user_id 借款人user_id ,
    ui2.user_name 借款人用户名,
    ui2.real_name 借款人姓名,
    dim2.register_time 借款人注册时间 ,
    dim2.register_biz 借款人注册业务线 ,
    dim2.id_num 借款人身份证号 ,
    dim2.last_bind_card_account 借款人绑定银卡号 ,
    dim2.last_bind_card_bank 借款人绑定银行名称 ,
dim2.hsb_bank_card 借款人徽商银行卡号
from odsopr.debt_buy_log dbt
inner join (
    select trim(trans_id_a) trans_id from msc.trans_id where length(trim(trans_id_a)) > 0
    union all
    select trim(trans_id_b) from msc.trans_id where length(trim(trans_id_b)) > 0
    union all
    select trim(trans_id_c) from msc.trans_id where length(trim(trans_id_c)) > 0
) trd
on trd.trans_id = dbt.trans_id

left join idw.fact_user_info ui
on ui.user_id = dbt.user_id

left join idw.dim_user dim1
on ui.user_id = dim1.user_id

left join idw.fact_borrows bo
on bo.bo_id = dbt.bo_id

left join idw.fact_user_info ui2
on ui2.user_id = bo.user_id

left join idw.dim_user dim2
on ui2.user_id = dim2.user_id
;






--监管需求-11.4-投资协议
drop table msc.invt_aggremment_1009;
-- 投资协议
create table msc.invt_aggremment_1009 as
select *
from (select t.*,row_number() over(partition by trans_id order by aggreement_time desc) as rn
from (select
    dbt.user_id,
    ui.user_name,
    ui.real_name,
    dbt.trans_id,
    va.trans_id as va_trans_id,
    va.id as va_id,
    ifnull(e.update_time,logs.update_time) as aggreement_time,
    ifnull(e.fdd_location,logs.signel_location) as aggreement_location
from odsopr.debt_buy_log dbt
left join idw.fact_user_info ui
on dbt.user_id = ui.user_id
join (select trans_id_a from msc.trans_id union all select trans_id_b from msc.trans_id union all select trans_id_c from msc.trans_id) trans
on dbt.trans_id  =trans.trans_id_a
left join odsopr.vip_account va
on dbt.va_id=va.id
LEFT JOIN odsopr.invt_agreement_address e ON va.trans_id=e.trans_id
LEFT JOIN odsopr.invt_agreement_log logs ON logs.trans_id = va.trans_id ) t
) tt
where tt.rn=1;


select t.user_id as 投资用户ID,t.user_id as 投资用户名,t.real_name as 投资用户
,t.trans_id as 交易ID,t.aggreement_location as 投资协议
from msc.invt_aggremment_1009 t;





--监管需求-11.4-债权匹配协议
drop table msc.invt_aggremment_pp_1009;
create table msc.invt_aggremment_pp_1009 as
select *
from (select t.*,row_number() over(partition by trans_id order by aggreement_time desc) as rn
from (select
    dbt.user_id,
    ui.user_name,
    ui.real_name,
    dbt.trans_id,
    ifnull(e.update_time,logs.update_time) as aggreement_time,
    ifnull(e.fdd_location,logs.signel_location) as aggreement_location
from odsopr.debt_buy_log dbt
left join idw.fact_user_info ui
on dbt.user_id = ui.user_id
join (select trans_id_a from msc.trans_id union all select trans_id_b from msc.trans_id union all select trans_id_c from msc.trans_id) trans
on dbt.trans_id  =trans.trans_id_a
LEFT JOIN odsopr.invt_agreement_address e ON dbt.trans_id=e.trans_id
LEFT JOIN odsopr.invt_agreement_log logs ON logs.trans_id = dbt.trans_id ) t
) tt
where tt.rn=1;

select t.user_id as 投资用户ID,t.user_id as 投资用户名,t.real_name as 投资用户
,t.trans_id as 交易ID,t.aggreement_location as 债权匹配协议
from msc.invt_aggremment_pp_1009 t;



--监管需求-11.9
select
    ui.user_id 出借人user_id,
    ui.user_name 出借人user_name,
    ui.real_name 出借人real_name,
    dbt.user_id,
    dbt.bo_id 借款标的id,
    bo.bo_title 借款标的名称,
    bo.bo_finish_time 借款标的上标时间,
    bo.user_id 借款人user_id,
    ui2.user_name 借款人user_name,
    ui2.real_name 借款人real_name,
    dbt.trans_id
from odsopr.debt_buy_log dbt
inner join (
    select trim(trans_id_a) trans_id from msc.trans_id where length(trim(trans_id_a)) > 0
    union all
    select trim(trans_id_b) from msc.trans_id where length(trim(trans_id_b)) > 0
    union all
    select trim(trans_id_c) from msc.trans_id where length(trim(trans_id_c)) > 0
) trd
on trd.trans_id = dbt.trans_id

left join idw.fact_user_info ui
on ui.user_id = dbt.user_id

left join idw.fact_borrows bo
on bo.bo_id = dbt.bo_id

left join idw.fact_user_info ui2
on ui2.user_id = bo.user_id
;


--监管需求-11.10-已结算业务抽标-会计师-交付1010
select
    dbt.trans_id,
    dbt.user_id 出借人user_id,
    dbt.price_in 出借金额,
    dbt.create_time 撮合时间,
    dbt.bo_id 借款bo_id,
    bo.bo_audit_time 借款人借款审批通过时间,
    bo.bo_finish_time  借款时间,
    bo.bo_finish_price 借款金额,
    bo.bo_expect 贷款期限,
    bo.bo_expect_cat 贷款期限单位,
    fp.start_date 产品上线时间,
    fp.id
from odsopr.debt_buy_log dbt
inner join (
    select * from odsopr.vip_account where trans_id = '2017112012223519904001005850173' and user_id = 89645
    union all
    select * from odsopr.vip_account where trans_id = '2018021308395075604001005162060' and user_id = 93197
) trd
on trd.id = dbt.va_id

left join idw.fact_borrows bo
on bo.bo_id = dbt.bo_id

left join odsopr.finance_plan fp
on fp.id = trd.fp_id
;


--麦子抽标-存量业务-(含用户名和姓名)-第5版                      跑脚本时依次修改  trans_id_a  ->  trans_id_b   ->  trans_id_c
select ti.user_id,ui.user_id,ui.user_name,ui.real_name,
ui.mobile_num,
dbt.trans_id,
ti.trans_id_c,
bo.p_id,
bo.p_name,
dbt.bo_id 借款bo_id,
bo.user_id 借款user_id,
ui2.mobile_num
from msc.trans_id ti

left join idw.fact_user_info ui
on cast(ui.user_id as string) = ti.user_id

left join odsopr.debt_buy_log dbt
on dbt.trans_id = ti.trans_id_c
and ti.user_id = cast(dbt.user_id as string)

left join idw.fact_borrows bo
on dbt.bo_id = bo.bo_id

left join idw.fact_user_info ui2
on ui2.user_id = bo.user_id
;



--2018年8月份平台支出明细数据(2018-08-01,2018-08-31)
select
t1.id
,'平台支出账户'  支出账户
,t2.name 对方姓名
,t2.account_no  对方账户号
,t2.id_card 对方身份证号
,case when strright(t2.status,1)='1' then t2.bank_card else null end 对方绑定银行卡号
,t1.source_describe  类型
,t1.income 收入
,t1.expend 支出
,t1.remark 备注
,t1.create_time 时间
from (
            select a.id,fa.user_id,account_id,a.operation_relation,forr.source_describe,a.opposite_account_id
            ,a.income,a.expend,a.create_time,a.remark
            from odsopr.finance_log_all a
            LEFT JOIN odsopr.finance_account fa ON fa.id=a.opposite_account_id
            LEFT JOIN odsopr.finance_role fr ON fr.id=fa.role_id
            LEFT JOIN odsopr.finance_operation_relation forr ON forr.id=a.operation_relation
            where to_date(a.create_time)>='${dt1}'
            and  to_date(a.create_time)<'${dt2}'
            and a.account_id in (18132645)
)t1
left join odsopr.acc_p2p t2
on t1.user_id=t2.owner_id
;

--2018年8月份平台收入明细数据(2018-08-01,2018-08-16)(2018-08-16,2018-09-01)
select
t1.id
,'平台收入账户'  收入账户
,t2.name 对方姓名
,t2.account_no  对方账户号
,t2.id_card 对方身份证号
,case when strright(t2.status,1)='1' then t2.bank_card else null end 对方绑定银行卡号
,t1.source_describe  类型
,t1.income 收入
,t1.expend 支出
,t1.remark 备注
,t1.create_time 时间
from (
            select a.id,fa.user_id,account_id,a.operation_relation,forr.source_describe,a.opposite_account_id
            ,a.income,a.expend,a.create_time,a.remark
            from odsopr.finance_log_all a
            LEFT JOIN odsopr.finance_account fa ON fa.id=a.opposite_account_id
            LEFT JOIN odsopr.finance_role fr ON fr.id=fa.role_id
            LEFT JOIN odsopr.finance_operation_relation forr ON forr.id=a.operation_relation
            where to_date(a.create_time)>='${dt1}'
            and  to_date(a.create_time)<'${dt2}'
            and a.account_id in (18132644)
)t1
left join odsopr.acc_p2p t2
on t1.user_id=t2.owner_id
;


67668001.8500000000 / 4122292173.0100000000
