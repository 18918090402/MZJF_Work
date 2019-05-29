drop table if exists dw_srm.fact_risk_fstpd_quota_d;


CREATE TABLE dw_srm.fact_risk_fstpd_quota_d 
(
    bo_success_month                string,
    ind                             string,
    user_id                         bigint,
    bo_id                           bigint,
    level_cat                       string,
    product_cd                      string,
    bo_expect_type                  int,
    p_key                           int,
    bo_success_time                 string,
    mob                             int,
    bo_finish_price                 decimal(38,10),
    is_first_repay_overdue          bigint,
    first_repay_overdue_days        bigint,
    first_unrepay_price_b           decimal(38,10),
    is_second_repay_overdue         bigint,
    second_repay_overdue_days       bigint,
    second_unrepay_price_b          decimal(38,10),
    is_third_repay_overdue          bigint,
    third_repay_overdue_days        bigint,
    third_unrepay_price_b           decimal(38,10),
    first_1_unrepay_price_b         decimal(38,10),
    first_3_unrepay_price_b         decimal(38,10),
    first_7_unrepay_price_b         decimal(38,10),
    first_15_unrepay_price_b        decimal(38,10),
    first_30_unrepay_price_b        decimal(38,10),
    second_30_unrepay_price_b       decimal(38,10),
    third_30_unrepay_price_b        decimal(38,10)
)
comment '风控FSTPD指标'
partitioned by (stat_date string comment '统计日期 年-月-日')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;


drop view if exists dw_srmopr.fact_risk_fstpd_quota_d;

create view dw_srmopr.fact_risk_fstpd_quota_d as select * from dw_srm.fact_risk_fstpd_quota_d;


