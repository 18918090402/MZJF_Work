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
    certIdcardHash(p2p.id_card)                                                 userIdcardHash,         --4.借款用户证件号hash值
    bo.bo_expect                                                                totalIssue,             --5.还款总期数
    br.br_expect_num                                                            issue,                  --6.本条记录（当期）所属期数
    br.br_id                                                                    replanId,               --7.还款计划编号
    round(br.br_price_b,2)                                                      curFund,                --8.本条记录（当期）应还本金（元）
    round(br.br_price_l,2)                                                      curInterest,            --9.本条记录（当期）应还利息（元）
    round(br_service_fee + price_return - br_repayed_tech_fee + 
    br_extra_fee + br_service_fee_other + br_post_consult_fee,2)                curServiceCharge,       --10.本条记录（当期）应还服务费（元）
    concat(cast(br.br_time as string),' 00:00:00')                              repayTime,              --11.本条记录（当期）应还款时间点
    "",
    ""
from 
    (select distinct bo_id from odsopr.debt_exchange_account_20190430 where bank_flag = 1 and price > 0) t
left join idw.fact_borrows_repayment br
on t.bo_id = br.bo_id
left join idw.fact_borrows bo
on t.bo_id = bo.bo_id
left join ods.t_acc_p2p_hist p2p
on br.user_id = p2p.owner_id
ORDER BY userIdcardHash,sourceProductCode,replanId
;
--7513151