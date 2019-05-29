

-- 逾期率、滚动率、迁徙率、损失率月表


drop table if exists dw_srm.fact_risk_overdue_quota_m;


CREATE TABLE dw_srm.fact_risk_overdue_quota_m 
(
    user_id                         bigint,
    level_type                      string,                 --modify
    bo_id                           bigint,
    product_cd                      string,
    p_key                           int,
    expect_type                     int,                    --modify
    bo_success_date                 string,                 --modify
    amc_type                        int,                    --new
    graduate_type                   int,                    --new
    m3p_type                        int,                    --new
    m6p_type                        int,                    --new
    bo_finish_price                 decimal(38,10),
    overdue_unrepay_days            int,
    unrepay_price_b                 decimal(38,10),
    m0_unrepay_price_b              decimal(38,10),
    m1_unrepay_price_b              decimal(38,10),
    m2_unrepay_price_b              decimal(38,10),
    m3_unrepay_price_b              decimal(38,10),
    m4_unrepay_price_b              decimal(38,10),
    m2p_unrepay_price_b             decimal(38,10),
    m4p_unrepay_price_b             decimal(38,10),
    m2p_unrepay_price_b_exloss      decimal(38,10),
    m4p_unrepay_price_b_exloss      decimal(38,10),
    unrepay_price_b_exloss          decimal(38,10),
    last_m0_unrepay_price_b         decimal(38,10),
    last_m1_unrepay_price_b         decimal(38,10),
    last_m2_unrepay_price_b         decimal(38,10),
    last_m3_unrepay_price_b         decimal(38,10),
    new_loss                        int,
    new_loss_unrepay_price_b        decimal(38,10),
    mob                             int,
    fraud_loss                      int,
    fraud_loss_unrepay_price_b      decimal(38,10),
    recover_loss                    int,
    new_loss_repayed_price_b        decimal(38,10),
    net_new_loss_price              decimal(38,10),
    fraud_loss_repayed_price_b      decimal(38,10),
    net_fraud_loss_price            decimal(38,10),
    m0_m1_roll_unrepay_price_b      decimal(38,10),
    m1_m2_roll_unrepay_price_b      decimal(38,10),
    m2_m3_roll_unrepay_price_b      decimal(38,10),
    m3_m4_roll_unrepay_price_b      decimal(38,10),
    m4_roll_unrepay_price_b         decimal(38,10),
    m0_roll_unrepay_price_b         decimal(38,10)
)
comment '风控逾期/损失/滚动/迁徙率指标'
partitioned by (stat_date string comment '统计日期 年-月')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;



--view 
drop view dw_srmopr.fact_risk_overdue_quota_m ;


create view dw_srmopr.fact_risk_overdue_quota_m 
as 
SELECT user_id,
       level_type,
       bo_id,
       product_cd,
       p_key,
       expect_type,
       bo_success_date,
       amc_type,
       graduate_type,
       m3p_type,
       m6p_type,
       bo_finish_price,
       overdue_unrepay_days,
       
       unrepay_price_b,
       if(unrepay_price_b>0,1,0) unrepay_price_b_flag,
       
       m0_unrepay_price_b,
       if(m0_unrepay_price_b>0,1,0) m0_unrepay_price_b_flag,
       
       m1_unrepay_price_b,
       if(m1_unrepay_price_b>0,1,0) m1_unrepay_price_b_flag,
       
       m2_unrepay_price_b,
       if(m2_unrepay_price_b>0,1,0) m2_unrepay_price_b_flag,
       
       m3_unrepay_price_b,
       if(m3_unrepay_price_b>0,1,0) m3_unrepay_price_b_flag,
       
       m4_unrepay_price_b,
       if(m4_unrepay_price_b>0,1,0) m4_unrepay_price_b_flag,
       
       m2p_unrepay_price_b,
       if(m2p_unrepay_price_b>0,1,0) m2p_unrepay_price_b_flag,
       
       m4p_unrepay_price_b,
       if(m4p_unrepay_price_b>0,1,0) m4p_unrepay_price_b_flag,
       
       m2p_unrepay_price_b_exloss,
       if(m2p_unrepay_price_b_exloss>0,1,0) m2p_unrepay_price_b_exloss_flag,
       
       m4p_unrepay_price_b_exloss,
       if(m4p_unrepay_price_b_exloss>0,1,0) m4p_unrepay_price_b_exloss_flag,
       
       unrepay_price_b_exloss,
       if(unrepay_price_b_exloss>0,1,0) unrepay_price_b_exloss_flag,
       
       last_m0_unrepay_price_b,
       if(last_m0_unrepay_price_b>0,1,0) last_m0_unrepay_price_b_flag,
       
       last_m1_unrepay_price_b,
       if(last_m1_unrepay_price_b>0,1,0) last_m1_unrepay_price_b_flag,
       
       last_m2_unrepay_price_b,
       if(last_m2_unrepay_price_b>0,1,0) last_m2_unrepay_price_b_flag,
       
       last_m3_unrepay_price_b,
       if(last_m3_unrepay_price_b>0,1,0) last_m3_unrepay_price_b_flag,
       
       new_loss,
       new_loss_unrepay_price_b,
       mob,
       fraud_loss,
       fraud_loss_unrepay_price_b,
       recover_loss,
       new_loss_repayed_price_b,
       net_new_loss_price,
       fraud_loss_repayed_price_b,
       net_fraud_loss_price,
       m0_m1_roll_unrepay_price_b,
       m1_m2_roll_unrepay_price_b,
       m2_m3_roll_unrepay_price_b,
       m3_m4_roll_unrepay_price_b,
       m4_roll_unrepay_price_b,
       m0_roll_unrepay_price_b,
       stat_date
from dw_srm.fact_risk_overdue_quota_m ;



