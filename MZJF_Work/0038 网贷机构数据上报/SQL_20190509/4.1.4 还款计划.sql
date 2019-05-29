set mapreduce.job.name = pdw_report_04_repayplan; 
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

insert overwrite table pdw.report_04_repayplan 

SELECT
    ""                                                                          version,                --1.接口版本号
    'CERT20190411026'                                                           sourceCode,             --2.平台编号
    bo.bo_id                                                                    sourceProductCode,      --3.散标信息编号
    certIdcardHash(coalesce(p2p.id_card,u.id_num))                              userIdcardHash,         --4.借款用户证件号hash值
    bo.bo_expect                                                                totalIssue,             --5.还款总期数
    br.br_expect_num                                                            issue,                  --6.本条记录（当期）所属期数
    br.br_id                                                                    replanId,               --7.还款计划编号
    cast(cast(br.br_price_b as decimal(20,2)) as string)                        curFund,                --8.本条记录（当期）应还本金（元）
    cast(cast(br.br_price_l as decimal(20,2)) as string)                        curInterest,            --9.本条记录（当期）应还利息（元）
    cast(cast(br_service_fee + price_return - br_repayed_tech_fee + 
    br_extra_fee + br_service_fee_other + br_post_consult_fee 
	as decimal(20,2)) as string)                							    curServiceCharge,       --10.本条记录（当期）应还服务费（元）
    date_format(br.br_time,'yyyy-MM-dd HH:mm:ss')                               repayTime,              --11.本条记录（当期）应还款时间点
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
left join idw.fact_borrows_repayment br
on t.bo_id = br.bo_id
left join idw.fact_borrows bo
on t.bo_id = bo.bo_id
left join 
    (select * from msc.tmp_acc_p2p_20190507 where account_type = 'user') p2p
on br.user_id = p2p.owner_id
left join 
    (
    SELECT 
        id,
        regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
    FROM ods.t_user_info_hist
    where status = 1
    ) u
on bo.user_id = u.id
where br_is_repay = 0 or br.br_repay_time > '2019-05-01'
;
--4349320