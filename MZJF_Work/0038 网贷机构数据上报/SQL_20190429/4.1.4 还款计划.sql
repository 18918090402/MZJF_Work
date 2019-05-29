SELECT
                                                                                    'version',               --1.接口版本号
                                                                                    sourceCode,             --2.平台编号
    bo.bo_id                                                                        sourceProductCode,      --3.散标信息编号
    u.id_num_n                                                                      userIdcardHash,         --4.借款用户证件号hash值
    bo.bo_expect                                                                    totalIssue,             --5.还款总期数
    br.br_expect_num                                                                issue,                  --6.本条记录（当期）所属期数
    br.br_id                                                                        replanId,               --7.还款计划编号
    br.br_price_b                                                                   curFund,                --8.本条记录（当期）应还本金（元）
    br.br_price_l                                                                   curInterest,            --9.本条记录（当期）应还利息（元）
    br_service_fee + price_return - br_repayed_tech_fee + 
    br_extra_fee + br_service_fee_other + br_post_consult_fee                       curServiceCharge,       --10.本条记录（当期）应还服务费（元）
    br.br_time                                                                      repayTime               --11.本条记录（当期）应还款时间点
from idw.fact_borrows_repayment br
left join idw.fact_borrows bo
on br.bo_id = bo.bo_id
left join
    (
    SELECT 
        u.*,
        regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num_n
    FROM ods.t_user_info_hist u where status = 1 
    ) u
on br.user_id = u.id
where 1=1
    and bo.create_time < '2019-05-01'
    and (br.br_is_repay = 0 or br.br_repay_time > '2019-05-01')
ORDER BY userIdcardHash,sourceProductCode,replanId
--4566638