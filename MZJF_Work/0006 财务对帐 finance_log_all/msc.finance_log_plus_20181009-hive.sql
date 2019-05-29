/*
    梳理finance_log表数据, 分别对应到资金 or 资产, 分4步骤:  **新增科目必须, 需要判读此科目适合于哪种解析方法
    1. 使用remark / key_value中的编码, 从bo表中获取相关信息
    2. 使用remark中的编码, 从br表中获取相关信息
    3. 活期利息发放, 无法解析
    4. 从投资/借款信息中获取相关信息
*/


--DDL
drop table if exists msc.finance_log_plus;

create table msc.finance_log_plus
(
    finance_ind             string
    ,category               string          --投资        or   借款
    ,type                   string          --nono/csyy   or   biz_name
    ,id                     bigint
    ,operation_relation     bigint
    ,source_describe        string
    ,user_id                bigint
    ,bo_id                  bigint
    ,p_key                  bigint
    ,amount                 decimal(38,2)
    ,income                 decimal(38,2)
    ,expend                 decimal(38,2)
    ,create_time            string
)
COMMENT '资金日志升级版'
ROW FORMAT DELIMITED NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY")
; 



--hive 


-------------------------------------------------------------------------
set mapreduce.job.name = msc_finance_log_plus_1; 
set mapreduce.job.queuename = etl-dw;  
set hive.exec.parallel = true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict; 
set hive.exec.max.dynamic.partitions.pernode = 100000000;
set hive.exec.max.dynamic.partitions = 100000000;
set hive.exec.max.created.files = 100000000;


-- 01 利息发放 不区分投资借款
insert overwrite table msc.finance_log_plus
select 
    "01" finance_ind
    ,NULL category
    ,NULL type
    ,t.id
    ,t.operation_relation
    ,t2.source_describe
    ,t.user_id
    ,NULL bo_id
    ,NULL p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
from odsopr.finance_log_all t
left join odsopr.finance_operation_relation t2
on t.operation_relation = t2.id
where t.operation_relation in (792,793,794)
and to_date(t.create_time) >= "2017-08-18"
;



-- 02 归属于 nono 资金 
insert into table msc.finance_log_plus
select 
    "02" finance_ind
    ,"资金" category
    ,"nono" type
    ,t.id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.borrows_id as bigint) bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
from odsopr.finance_log_all t
left join odsopr.acc_depository_trans_record t1
on t.proof_id = t1.proof_id
left join odsopr.trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.borrows_id as BIGINT) = t4.bo_id
where t.operation_relation = 698    --部分数据关联不到bo_id
and to_date(t.create_time) >= "2017-08-18"
;




-- 03 从remark获取bo_id
insert into table msc.finance_log_plus
select 
    "03_remark_bo_id" finance_ind
    ,"资产" category
    ,t3.biz_name type
    ,t.id
    ,t.operation_relation
    ,t2.source_describe
    ,coalesce(t.user_id, t1.user_id) user_id
    ,t1.bo_id
    ,t1.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
from odsopr.finance_log_all t 
inner join idw.fact_borrows t1 
on regexp_extract(regexp_replace(t.remark,"[,.，。：:]+",""), "([0-9]+)", 1) = cast(t1.bo_id as string) 
left join odsopr.finance_operation_relation t2 
on t.operation_relation = t2.id 
left join odsopr.dim_bia_asset_product t3
on t1.p_key = t3.p_key
where t.operation_relation in ( 714,722,735,738,740,742,753,  812,815,818,822,702 )
and to_date(t.create_time) >= "2017-08-18"
;



-- 03 parse 702 
insert into table msc.finance_log_plus
select
    "03_remark_bo_id" finance_ind
    ,"资产" category
    ,t5.biz_name type
    ,t.id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.borrows_id as bigint) bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
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
left join odsopr.dim_bia_asset_product t5
on t4.p_key = t5.p_key
where t.operation_relation = 702
and to_date(t.create_time) >= "2017-08-18"
;



-- 03 parse 702 
insert into table msc.finance_log_plus
select 
    "03_remark_bo_id" finance_ind
    ,"资产" category
    ,t5.biz_name type
    ,t.id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.bo_id as bigint) bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
from odsopr.finance_log_all t
left join odsopr.acc_depository_trans_record t1
on t.proof_id = t1.proof_id
inner join odsopr.fund_trans_repayment_order t2
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.bo_id as BIGINT) = t4.bo_id  
left join odsopr.dim_bia_asset_product t5
on t4.p_key = t5.p_key
where t.operation_relation = 702
and to_date(t.create_time) >= "2017-08-18"
;




-------------------------------------------------------------------------
set mapreduce.job.name=msc_finance_log_plus_2; 
set mapreduce.job.queuename = etl-dw;  
set hive.exec.parallel = true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict; 
set hive.exec.max.dynamic.partitions.pernode = 100000000;
set hive.exec.max.dynamic.partitions = 100000000;
set hive.exec.max.created.files = 100000000;



-- 03 从key_value获取bo_id
insert into table msc.finance_log_plus
select 
    "03_key_value_bo_id" finance_ind
    ,"资产" category
    ,t3.biz_name type
    ,t.id
    ,t.operation_relation
    ,t2.source_describe
    ,coalesce(t.user_id, t1.user_id) user_id
    ,t1.bo_id
    ,t1.p_key   
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
from odsopr.finance_log_all t
left join idw.fact_borrows t1
on t.key_value = cast(t1.bo_id as string)
left join odsopr.finance_operation_relation t2
on t.operation_relation = t2.id
left join odsopr.dim_bia_asset_product t3
on t1.p_key = t3.p_key
where t.operation_relation in (774,720,700)
and to_date(t.create_time) >= "2017-08-18"
;




-- 03 从remark中获取br_id          
insert into table msc.finance_log_plus     
select 
    "03_remark_br_id" finance_ind
    ,"资产" category
    ,t3.biz_name type
    ,t.id
    ,t.operation_relation
    ,t2.source_describe
    ,coalesce(t.user_id, t1.user_id) user_id
    ,t1.bo_id
    ,t1.p_key 
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
from odsopr.finance_log_all t
left join idw.fact_borrows_repayment t1 
on regexp_extract(regexp_replace(t.remark,"\[\,\.\，\。\：\:\]\+",""), "\(\[0\-9\]\+)", 1) = cast(t1.br_id as string)
left join odsopr.finance_operation_relation t2
on t.operation_relation = t2.id
left join odsopr.dim_bia_asset_product t3
on t1.p_key = t3.p_key
where t.operation_relation in (715,757,759,761,775,802,805)
and t.id not in (1672056447, 1675850419)
and to_date(t.create_time) >= "2017-08-18"
--代偿数据  存管上线时，徽商有不明确的交易单码，人工修复的数据 不应该计入日志表，其他业务已经删除
;


-- 03   731          
drop table if exists tmp.tmp_finance_log_plus1_731;

create table tmp.tmp_finance_log_plus1_731
stored as parquet 
as
select 
    "03_proof_id" finance_ind 
    ,"资产" category
    ,t5.biz_name type
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.borrows_id as bigint) bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
    ,t.proof_id
    ,t.remark
    ,t.key_value
from odsopr.finance_log_all t
left join odsopr.acc_depository_trans_record t1
on t.proof_id = t1.proof_id
left join odsopr.trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.borrows_id as BIGINT) = t4.bo_id
left join odsopr.dim_bia_asset_product t5
on t4.p_key = t5.p_key
where t.operation_relation = 731
and to_date(t.create_time) >= "2017-08-18"
;


insert into table msc.finance_log_plus     
select 
    finance_ind 
    ,category
    ,type
    ,id
    ,operation_relation
    ,source_describe
    ,user_id
    ,bo_id
    ,p_key
    ,amount
    ,income
    ,expend
    ,create_time
from tmp.tmp_finance_log_plus1_731 t
where t.bo_id is not null
;


drop table if exists tmp.tmp_finance_log_plus2_731;

create table tmp.tmp_finance_log_plus2_731
stored as parquet 
as
select 
    "03_proof_id" finance_ind
    ,"资产" category    
    ,t5.biz_name type
    ,t.id
    ,t.account_id
    ,t.opposite_account_id    
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) as user_id
    ,t1.bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
    ,t.proof_id
    ,t.remark
    ,t.key_value
from tmp.tmp_finance_log_plus1_731 t
left join odsopr.tb_p2p_file_detail_repayment t1 
on t.proof_id = t1.proof_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t1.bo_id as BIGINT) = t4.bo_id
left join odsopr.dim_bia_asset_product t5
on t4.p_key = t5.p_key
where t.bo_id is null 
;




insert into table msc.finance_log_plus     
select 
    finance_ind 
    ,category
    ,type
    ,id
    ,operation_relation
    ,source_describe
    ,user_id
    ,bo_id
    ,p_key
    ,amount
    ,income
    ,expend
    ,create_time 
from tmp.tmp_finance_log_plus2_731 t
where t.bo_id is not null
;



-------------------------------------------------------------------------
set mapreduce.job.name=msc_finance_log_plus_3; 
set mapreduce.job.queuename = etl-dw;  
set hive.exec.parallel = true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict; 
set hive.exec.max.dynamic.partitions.pernode = 100000000;
set hive.exec.max.dynamic.partitions = 100000000;
set hive.exec.max.created.files = 100000000;




/* 以下从多张业务系统表拆分出bo_id            begin */

-- 03
drop table if exists tmp.tmp_finance_log_plus1;

create table tmp.tmp_finance_log_plus1
stored as parquet 
as
select 
    "03_proof_id" finance_ind 
    ,"资产" category
    ,t5.biz_name type
    ,t.id
    ,t.account_id
    ,t.opposite_account_id
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.borrows_id as bigint) bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
    ,t.proof_id
    ,t.remark
from odsopr.finance_log_all t
left join odsopr.acc_depository_trans_record t1
on t.proof_id = t1.proof_id
left join odsopr.trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.borrows_id as BIGINT) = t4.bo_id
left join odsopr.dim_bia_asset_product t5
on t4.p_key = t5.p_key
where t.operation_relation in (708,710,711,764,766,768,770,778)
and to_date(t.create_time) >= "2017-08-18"
;


insert into table msc.finance_log_plus     
select 
    finance_ind 
    ,category
    ,type
    ,id
    ,operation_relation
    ,source_describe
    ,user_id
    ,bo_id
    ,p_key
    ,amount
    ,income
    ,expend
    ,create_time
from tmp.tmp_finance_log_plus1 t
where t.bo_id is not null
;


--03 
/*
drop table if exists msc.finance_log_plus2;
create table msc.finance_log_plus2
stored as parquet 
as
select 
    '03_proof_id' finance_ind
    ,t5.biz_name type
    ,t.id
    ,t.account_id
    ,t.opposite_account_id    
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) as user_id
    ,t1.bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
    ,t.proof_id
    ,t.remark
from msc.finance_log_plus1 t
left join odsopr.tb_p2p_file_detail_repayment t1 
on t.proof_id = t1.proof_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t1.bo_id as BIGINT) = t4.bo_id
left join odsopr.dim_bia_asset_product t5
on t4.p_key = t5.p_key
where t.bo_id is null 
;

insert overwrite table msc.finance_log_plus     
select 
    finance_ind 
    ,type
    ,id
    ,operation_relation
    ,source_describe
    ,user_id
    ,bo_id
    ,p_key
    ,amount
    ,income
    ,expend
    ,create_time
from msc.finance_log_plus2 t
where t.bo_id is not null
;

*/


--03
--plus1中bo_id为null的创建临时表
drop table if exists tmp.tmp_finance_log_plus2;

create table tmp.tmp_finance_log_plus2
stored as parquet 
as
select 
    "03_proof_id" finance_ind
    ,"资产" category
    ,t5.biz_name type    
    ,t.id
    ,t.account_id
    ,t.opposite_account_id    
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,cast(t2.borrows_id as bigint) bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
    ,t.proof_id
    ,t.remark    
from tmp.tmp_finance_log_plus1 t
left join odsopr.acc_pay_back_repay_detail t1
on regexp_extract(regexp_replace(t.remark,"\[\,\.\，\。\：\:\]\+",""), "\(\[0\-9\]\+)", 1) = cast(t1.pay_no as string) 
left join odsopr.trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.borrows_id as BIGINT) = t4.bo_id
left join odsopr.dim_bia_asset_product t5
on t4.p_key = t5.p_key
where t.bo_id is null
;


insert into table msc.finance_log_plus     
select 
    finance_ind 
    ,category
    ,type
    ,id
    ,operation_relation
    ,source_describe
    ,user_id
    ,bo_id
    ,p_key
    ,amount
    ,income
    ,expend
    ,create_time
from tmp.tmp_finance_log_plus2 t
where t.bo_id is not null
;


--537条为NULL
-- 38        30 快钱 sitebill 快钱冲值手续费累积账户
-- 18318829  66 归还代偿公司支出账户 sitebalance_out_pay_back 归还代偿公司支出账户


/*
--03
drop table if exists msc.finance_log_plus4;
create table msc.finance_log_plus4
stored as parquet 
as
select 
    '03_proof_id' finance_ind
    ,t5.biz_name type
    ,t.id
    ,t.account_id
    ,t.opposite_account_id    
    ,t.operation_relation
    ,t3.source_describe
    ,coalesce(t.user_id, t4.user_id) user_id
    ,t2.bo_id
    ,t4.p_key
    ,t.amount
    ,t.income
    ,t.expend
    ,t.create_time
from msc.finance_log_plus3 t
left join odsopr.acc_depository_trans_record t1
on t.proof_id = t1.proof_id
inner join odsopr.fund_trans_repayment_order t2 
on t1.trd_no = t2.trans_id
left join odsopr.finance_operation_relation t3
on t.operation_relation = t3.id
left join idw.fact_borrows t4
on cast(t2.bo_id as BIGINT) = t4.bo_id
left join odsopr.dim_bia_asset_product t5
on t4.p_key = t5.p_key
where t.bo_id is null 
;



insert overwrite table msc.finance_log_plus     
select 
    finance_ind 
    ,type
    ,id
    ,operation_relation
    ,source_describe
    ,user_id
    ,bo_id
    ,p_key
    ,amount
    ,income
    ,expend
    ,create_time
from msc.finance_log_plus4 t
where t.bo_id is not null
;

*/

/* ===========================            end        */


-------------------------------------------------------------------------
set mapreduce.job.name=msc_finance_log_plus_4; 
set mapreduce.job.queuename = etl-dw;  
set hive.exec.parallel = true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict; 
set hive.exec.max.dynamic.partitions.pernode = 100000000;
set hive.exec.max.dynamic.partitions = 100000000;
set hive.exec.max.created.files = 100000000;




--04 资产
drop table if exists tmp.tmp_finance_log_invest;

create table tmp.tmp_finance_log_invest
stored as parquet 
as
select t.id, t.user_id, t.platform, t.opposite_account_id, t.operation_relation
from 
(
    select * from 
    (
        select b.user_id,c.invest_time,c.code,c.product_category,c.platform,a.create_time,a.id,a.account_id,a.opposite_account_id, a.operation_relation
            ,row_number() over(partition by a.id, b.user_id, a.operation_relation order by c.invest_time desc ) rn 
        from odsopr.finance_log_all a
        left join odsopr.finance_account b
        on b.id = a.opposite_account_id
        left join 
        (
            select user_id,invest_time,cast(fp_id as string) code, product_category,"nono" platform from idw.fact_biz_nono_invest 
            union all 
            select user_id,invest_time,product_code code, product_category,"csyy" platform from idw.fact_biz_csyy_invest 
        ) c
        on c.user_id = b.user_id
        --and c.invest_time <= a.create_time   --投资时间距离资金记录最近的
        where a.operation_relation in (751,   771,694,696,681,683,692,745,808 ,842,846)
        and to_date(a.create_time) >= "2017-08-18"
    ) z 
    where z.invest_time <= z.create_time

) t  
where t.rn = 1 
;


drop table if exists tmp.tmp_finance_log_loan;

create table tmp.tmp_finance_log_loan
stored as parquet 
as
select t.id, t.user_id, t.p_key, t.p_name, t.biz_name, t.opposite_account_id, t.operation_relation
from 
(
    select * from 
    (
        select b.user_id,c.bo_finish_time,c.p_id,c.p_key,c.p_name,d.biz_name,a.create_time,a.id,a.account_id,a.opposite_account_id, a.operation_relation
            ,row_number() over(partition by a.id, b.user_id, a.operation_relation order by c.bo_finish_time desc ) rn 
        from odsopr.finance_log_all a
        left join odsopr.finance_account b
        on b.id = a.opposite_account_id
        left join idw.fact_borrows c
        on c.user_id = b.user_id
        and c.bo_is_finish = 1
        --and c.bo_finish_time <= a.create_time     --贷款时间距离资金记录最近的
        left join odsopr.dim_bia_asset_product d
        on d.p_key = c.p_key
        where a.operation_relation in (751,   771,694,696,681,683,692,745,808 ,842,846)
        and to_date(a.create_time) >= "2017-08-18"
    ) z
    where z.bo_finish_time <= z.create_time
) t  
where t.rn = 1 
;


insert into table msc.finance_log_plus
select
    tt.finance_ind
    ,case when tt.type in ("nono","csyy") then "资金" else "资产" end category
    ,tt.type
    ,tt.id
    ,tt.operation_relation
    ,tt.source_describe
    ,tt.user_id
    ,tt.bo_id
    ,tt.p_key
    ,tt.amount
    ,tt.income
    ,tt.expend
    ,tt.create_time
from 
(
    select 
        "04_loan_first" finance_ind
        ,case 
            when d.biz_name is not null then d.biz_name --借款优先
            when d.biz_name is null and c.platform is not null then c.platform --投资其次
            else e.register_biz --以上没有, 取注册端
        end type
        ,a.id
        ,a.operation_relation
        ,f.source_describe
        ,b.user_id
        ,NULL bo_id
        ,d.p_key
        ,a.amount
        ,a.income
        ,a.expend
        ,a.create_time
    from odsopr.finance_log_all a
    left join odsopr.finance_account b
    on b.id = a.opposite_account_id
    left join tmp.tmp_finance_log_invest c   
    on c.id = a.id
    and c.operation_relation = a.operation_relation
    left join tmp.tmp_finance_log_loan d
    on d.id = a.id
    and d.operation_relation = a.operation_relation
    left join idw.fact_user_info e
    on e.user_id = b.user_id 
    left join odsopr.finance_operation_relation f
    on a.operation_relation = f.id
    where a.operation_relation in (751)
    and to_date(a.create_time) >= "2017-08-18"
) tt
;


insert into table msc.finance_log_plus    
select
    tt.finance_ind
    ,case when tt.type in ("nono","csyy") then "资金" else "资产" end  category
    ,tt.type
    ,tt.id
    ,tt.operation_relation
    ,tt.source_describe
    ,tt.user_id
    ,tt.bo_id
    ,tt.p_key
    ,tt.amount
    ,tt.income
    ,tt.expend
    ,tt.create_time
from
(
    select 
        "04_invest_first" finance_ind
        ,case 
            when c.platform is not null then c.platform --投资优先
            when c.platform is null and d.biz_name is not null then d.biz_name --借款其次
            else e.register_biz --以上没有, 取注册端
        end type 
        ,a.id
        ,a.operation_relation
        ,f.source_describe
        ,b.user_id
        ,NULL bo_id
        ,d.p_key
        ,a.amount
        ,a.income
        ,a.expend
        ,a.create_time
    from odsopr.finance_log_all a
    left join odsopr.finance_account b
    on b.id = a.opposite_account_id
    left join tmp.tmp_finance_log_invest c   
    on c.id = a.id
    and c.operation_relation = a.operation_relation
    left join tmp.tmp_finance_log_loan d
    on d.id = a.id
    and d.operation_relation = a.operation_relation
    left join idw.fact_user_info e
    on e.user_id = b.user_id 
    left join odsopr.finance_operation_relation f
    on a.operation_relation = f.id
    where a.operation_relation in (771,694,696,681,683,692,745,808,842,846)
    and to_date(a.create_time) >= "2017-08-18" 
) tt
;


-------------------------------------------------------------------------
set mapreduce.job.name=msc_finance_log_plus_5; 
set mapreduce.job.queuename = etl-dw;  
set hive.exec.parallel = true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict; 
set hive.exec.max.dynamic.partitions.pernode = 100000000;
set hive.exec.max.dynamic.partitions = 100000000;
set hive.exec.max.created.files = 100000000;



--财神爷爷
insert into table msc.finance_log_plus    
select
    "csyy"                          finance_ind
    ,NULL                           category
    ,NULL                           type   
    ,NULL                           id
    ,NULL                           operation_relation
    ,"红包奖励"                     source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,invest_amount                  amount
    ,NULL                           income
    ,invest_amount                  expend
    ,up.dw_create_time              create_time    
FROM odsopr.user_product up
left join odsopr.account_relation ar
on up.user_code = ar.merchant_user_id
WHERE up.STATUS = "A"
;

insert into table msc.finance_log_plus    
select 
    "csyy"                          finance_ind
    ,NULL                           category    
    ,NULL                           type   
    ,NULL                           id
    ,NULL                           operation_relation
    ,"抵扣券"                       source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,privilege_amount               amount
    ,NULL                           income
    ,privilege_amount               expend
    ,wpc.create_date                create_time    
FROM odsopr.welfare_privilege_code  wpc
left join odsopr.account_relation ar
on wpc.user_code = ar.merchant_user_id
WHERE wpc.welfare_type = 5
AND wpc.use_status = 1
;

insert into table msc.finance_log_plus    
select
    "csyy"                          finance_ind
    ,NULL                           category    
    ,NULL                           type    
    ,NULL                           id
    ,NULL                           operation_relation
    ,"体验金"                       source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,reward_interest                amount
    ,NULL                           income
    ,reward_interest                expend
    ,ui.created_date                create_time    
FROM odsopr.user_interest ui
left join odsopr.account_relation ar
on ui.user_code = ar.merchant_user_id
WHERE reward_interest > 0
;

insert into table msc.finance_log_plus    
select
    "csyy"                          finance_ind
    ,NULL                           category    
    ,NULL                           type    
    ,NULL                           id
    ,NULL                           operation_relation
    ,"现金奖励"                     source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,amount                         amount
    ,NULL                           income
    ,amount                         expend
    ,a.create_date                  create_time    
FROM odsopr.user_account_trans_log a
left join odsopr.account_relation ar
on a.user_code = ar.merchant_user_id
WHERE a.operation_type = 3
;


--
drop table if exists tmp.tmp_finance_log_plus_sxf ;
create table tmp.tmp_finance_log_plus_sxf 
as 
    SELECT 
        a.user_code ,FROM_UNIXTIME(UNIX_TIMESTAMP(trans_date,"yyyyMMdd"),"yyyy-MM-dd") create_date ,a.trans_code ,a.amount
        ,CASE 
            WHEN a.trans_date < "20150929" THEN a.amount*0.003 
            WHEN a.trans_date < "20160101" THEN a.amount*0.002 
            ELSE a.amount*0.0012 
        END sxf
        ,1 kind
    FROM odsopr.trans_detail a
    WHERE a.trans_code IN (0,1)
    AND a.user_code <> 999999999 
    AND a.status = "2"
    ;
    
insert into tmp.tmp_finance_log_plus_sxf
SELECT a.user_code ,to_date(a.create_date) create_date ,a.trans_code ,-a.withdraw_amount as amount
        ,CASE WHEN to_date(a.create_date) < "2015-09-29" THEN 1.2 ELSE 1.0 END sxf
        ,2 kind
    FROM odsopr.withdraw_reward a
    WHERE a.user_code <> 999999999 
    AND a.status IN (2,3,8) 
    ;
    
insert into tmp.tmp_finance_log_plus_sxf
    SELECT wr.user_code ,SUBSTR(wr.create_date,1,10) create_date ,wr.trans_code ,0 as amount ,wml.less_amount as sxf 
    ,3 kind
    FROM odsopr.user_withdraw_money_log wml
    LEFT JOIN odsopr.withdraw_reward wr ON wr.orderid= wml.str1
    WHERE wr.user_code <> 999999999 
;    

insert into table msc.finance_log_plus    
select
    "csyy"                          finance_ind
    ,NULL                           category    
    ,NULL                           type       
    ,NULL                           id
    ,NULL                           operation_relation
    ,"手续费"                       source_describe
    ,ar.nono_user_id                user_id
    ,NULL                           bo_id
    ,NULL                           p_key
    ,ROUND(SUM(IF(kind=3,sxf,0)),2)-ROUND(SUM(IF(kind=3,0,sxf)),2)    amount
    ,NULL                           income
    ,ROUND(SUM(IF(kind=3,sxf,0)),2)-ROUND(SUM(IF(kind=3,0,sxf)),2)    expend
    ,a.create_date                  create_time
FROM tmp.tmp_finance_log_plus_sxf a
left join odsopr.account_relation ar
on a.user_code = ar.merchant_user_id
group by ar.nono_user_id,a.create_date 
;

