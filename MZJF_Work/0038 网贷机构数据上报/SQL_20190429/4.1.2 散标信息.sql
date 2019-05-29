SELECT
                                                                                    -- 'version',              --1.接口版本号
                                                                                    -- sourceCode,             --2.平台编号
    bo.create_time                                                                  productStartTime,       --3.开标时间
    concat(bc.loan_use_name,'需',cast(bo_price as string),'元')                     productName,            --4.散标名称
    bo.bo_id                                                                        sourceProductCode,      --5.散标信息编号
    u.id_num_n                                                                      userIdcardHash,         --6.借款用户证件号hash值
    bc.loan_use_name                                                                loanUse,                --7.借款用途
    '本项目为个人小额信用借款，借款人通过诺诺镑客平台提交借款申请，用途为个人消费或短期周转。' loanDescribe,           --8.借款说明
    bp.bp_rate_lender                                                               loanRate,               --9.借款年利率
    bo.bo_price                                                                     amount,                 --10.借款金额
    br2.br_price_b                                                                  surplusAmount,          --11.剩余借款本金
    if(bo.bo_expect_cat = 1,bo.bo_expect,bo.bo_expect*30)                           term,                   --12.借款期限(天)
    bo.bo_paytype                                                                   payType,                --13.还款类型
    br.br_service_fee + bo.zx_price                                                 serviceCost,            --14.服务费（元）
    bt.borrows_category_name                                                        loanType,               --15.借款类型
    '-1'                                                                            securityType,           --16.担保方式
                                                                                    -- securityCompanyAmount   --17.担保公司数量
                                                                                    -- securityCompanyName     --18.第三方担保机构/保险公司的全称
                                                                                    -- securityCompanyIdcard   --19.担保机构或保险公司统一社会信用代码
                                                                                    -- isFinancingAssure       --20.是否具有融资担保业务经营许可证
                                                                                    -- securityAmount          --21.担保手续费（合同金额）（元）
    '诺诺镑客（上海诺诺镑客金融信息服务有限公司）'                                  projectSource           --22.散标来源                                              
from 
    (SELECT bo_id,p_id,user_id,sum(br_service_fee+br_extra_fee+br_post_consult_fee) br_service_fee 
    from idw.fact_borrows_repayment
    GROUP BY 1,2,3) br
left join 
    (SELECT 
        bo_id,p_id,user_id,sum(br_price_b) br_price_b
    from idw.fact_borrows_repayment
    where br_is_repay = 0 or br_repay_time >= '2019-05-01'
    GROUP BY 1,2,3) br2
on br.bo_id = br2.bo_id
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
left join idw.fact_borrows_prepare bp
on bo.bp_id = bp.bp_id
left join msc.bo_purpose_category bc
on bc.bo_purpose = bo.bo_purpose
left join msc.borrows_category bt
on bt.p_id = br.p_id
where bo.create_time < '2019-05-01' and (bo.all_repayed_time is null or bo.all_repayed_time > '2019-05-01')
order by sourceProductCode
;

--289121