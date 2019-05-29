set mapreduce.job.name = pdw_report_02_scatterinvest; 
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

insert overwrite table pdw.report_02_scatterinvest 

SELECT
    ""                                                                                          version,                --1.接口版本号
    'CERT20190411026'                                                                           sourceCode,             --2.平台编号
    date_format(bo.create_time,'yyyy-MM-dd HH:mm:ss')                                           productStartTime,       --3.开标时间
    concat(bc.loan_use_name,'需',cast(bo_price as string),'元')                                 productName,            --4.散标名称
    bo.bo_id                                                                                    sourceProductCode,      --5.散标信息编号
    certIdcardHash(coalesce(p2p.id_card,u.id_num))                                              userIdcardHash,         --6.借款用户证件号hash值
    bc.loan_use_key                                                                             loanUse,                --7.借款用途
    '本项目为个人小额信用借款，借款人通过诺诺镑客平台提交借款申请，用途为个人消费或短期周转。'  loanDescribe,           --8.借款说明
    cast(cast(bp.bp_rate_lender/100 as decimal(20,6)) as string)                                loanRate,               --9.借款年利率
    cast(cast(bo.bo_price as decimal(20,2)) as string)                                          amount,                 --10.借款金额
    cast(cast(br2.br_price_b as decimal(20,2)) as string)                                       surplusAmount,          --11.剩余借款本金
    if(bo.bo_expect_cat = 1,bo.bo_expect,bo.bo_expect*30)                                       term,                   --12.借款期限(天)
    case
        when bo.bo_paytype = 'DEBX' then '1'
        when bo.bo_paytype = 'DBDX' then '6'
        when bo.bo_paytype = 'XXHB' then '3'
        when bo.bo_paytype = 'YHBDQFX' then '4'
        when bo.bo_paytype = 'ZYHK' then '5'
        end                                                                                     payType,                --13.还款类型
    cast(cast(br.br_service_fee + coalesce(bo.zx_price,0) as decimal(20,2)) as string)          serviceCost,            --14.服务费（元）
    bt.borrows_category_key                                                                     loanType,               --15.借款类型
    '-1'                                                                                        securityType,           --16.担保方式
    ""                                                                                          securityCompanyAmount,  --17.担保公司数量
    ""                                                                                          securityCompanyName,    --18.第三方担保机构/保险公司的全称
    ""                                                                                          securityCompanyIdcard,  --19.担保机构或保险公司统一社会信用代码
    ""                                                                                          isFinancingAssure,      --20.是否具有融资担保业务经营许可证
    ""                                                                                          securityAmount,         --21.担保手续费（合同金额）（元）
    '诺诺镑客（上海诺诺镑客金融信息服务有限公司）'                                              projectSource,          --22.散标来源 
    "",
    ""
from 
    (
	select distinct t.bo_id from odsopr.debt_exchange_account_20190430 t
	where 1=1
		and bank_flag = 1 
		and price > 0 
        and status in (1,2,3)
		and not exists (select 1 from idw.fact_borrows bo where bo.all_repayed_time < '2019-05-01' and t.bo_id = bo.bo_id)
	) t
left join
    (SELECT bo_id,p_id,user_id,sum(br_service_fee+br_extra_fee+br_post_consult_fee) br_service_fee 
    from idw.fact_borrows_repayment
    GROUP BY bo_id,p_id,user_id) br
on t.bo_id = br.bo_id
left join 
    (SELECT 
        bo_id,p_id,user_id,sum(br_price_b) br_price_b
    from idw.fact_borrows_repayment
    where br_is_repay = 0 or br_repay_time >= '2019-05-01'
    GROUP BY bo_id,p_id,user_id) br2
on t.bo_id = br2.bo_id
left join idw.fact_borrows bo
on t.bo_id = bo.bo_id
left join 
    (select * from msc.tmp_acc_p2p_20190507 where account_type = 'user') p2p
on br.user_id = p2p.owner_id
left join idw.fact_borrows_prepare bp
on bo.bp_id = bp.bp_id
left join msc.bo_purpose_category bc
on bo.bo_purpose = bc.bo_purpose
left join msc.borrows_category bt
on br.p_id = bt.p_id
left join 
    (
    SELECT 
        id,
        regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num,
    FROM ods.t_user_info_hist
    where status = 1
    ) u
on p2p.owner_id = u.id
;
--261893