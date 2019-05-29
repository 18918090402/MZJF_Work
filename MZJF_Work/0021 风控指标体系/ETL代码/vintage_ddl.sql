--table DDL

use dw_srm;

drop table if exists dw_srm.fact_risk_vintage_quota_m ;

CREATE TABLE dw_srm.fact_risk_vintage_quota_m 
(
     bo_id                          bigint              comment '标的ID'
    ,user_id                        bigint              comment '用户ID'
    ,bo_success_date                string              comment '放款时间'
    ,bo_finish_price                decimal(38,10)      comment '放款金额'
    ,user_type                      string              comment '客户类型'
    ,level_type                     string              comment '客户等级'
    ,mob                            int                 comment 'MOB'
    ,expect_type                    int                 comment '产品期限'
    ,p_key                          int                 comment 'p_key'
    ,product_cd                     string              comment '产品小类编码'
    ,gender_type                    int                 comment '性别'
    ,age_type                       int                 comment '年龄'
    ,education_type                 int                 comment '学历'
    ,school_type                    int                 comment '学校类型'
    ,loan_amt_type                  int                 comment '放款金额分类'
    ,province_cd                    string              comment '省份编码'
    ,td_score_type                  int                 comment '同盾分'
    ,td_platform_7d_type            int                 comment '同盾7天多头'
    ,td_platform_1m_type            int                 comment '同盾1个月多头'
    ,td_platform_3m_type            int                 comment '同盾3个月多头'
    ,td_platform_6m_type            int                 comment '同盾6个月多头'
    ,amc_type                       int                 comment 'AMC类型'
    ,graduate_type                  int                 comment '是否已毕业'
    ,m3p_type                       int                 comment '是否逾期90天及以上'
    ,m6p_type                       int                 comment '是否逾期180天及以上'
    ,overdue_unrepay_days           int                 comment '逾期天数'
    ,unrepay_price_b                decimal(38,10)      comment '未还本金'
    ,dpd1_unrepay_price_b           decimal(38,10)      comment 'dpd1+未还本金'
    ,dpd10_unrepay_price_b          decimal(38,10)      comment 'dpd10+未还本金'
    ,dpd30_unrepay_price_b          decimal(38,10)      comment 'dpd30+未还本金'
    ,dpd60_unrepay_price_b          decimal(38,10)      comment 'dpd60+未还本金'
    ,dpd90_unrepay_price_b          decimal(38,10)      comment 'dpd90+未还本金'
)
comment '风控vintage指标月表'
partitioned by (stat_date string comment '统计日期 年-月')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;



--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.fact_risk_vintage_quota_m ;

create view dw_srmopr.fact_risk_vintage_quota_m
(
     bo_id                          comment '标的ID'
    ,user_id                        comment '用户ID'
    ,bo_success_date                comment '放款时间'
    ,bo_finish_price                comment '放款金额'
    ,user_type                      comment '客户类型'
    ,level_type                     comment '客户等级'
    ,mob                            comment 'MOB'
    ,expect_type                    comment '产品期限'
    ,p_key                          comment 'p_key'
    ,product_cd                     comment '产品小类编码'
    ,gender_type                    comment '性别'
    ,age_type                       comment '年龄'
    ,education_type                 comment '学历'
    ,school_type                    comment '学校类型'
    ,loan_amt_type                  comment '放款金额分类'
    ,province_cd                    comment '省份编码'
    ,td_score_type                  comment '同盾分'
    ,td_platform_7d_type            comment '同盾7天多头'
    ,td_platform_1m_type            comment '同盾1个月多头'
    ,td_platform_3m_type            comment '同盾3个月多头'
    ,td_platform_6m_type            comment '同盾6个月多头'
    ,amc_type                       comment 'AMC类型'
    ,graduate_type                  comment '是否已毕业'
    ,m3p_type                       comment '是否逾期90天及以上'
    ,m6p_type                       comment '是否逾期180天及以上'
    ,overdue_unrepay_days           comment '逾期天数'
    ,unrepay_price_b                comment '未还本金'
    ,dpd1_unrepay_price_b           comment 'dpd1+未还本金'
    ,dpd10_unrepay_price_b          comment 'dpd10+未还本金'
    ,dpd30_unrepay_price_b          comment 'dpd30+未还本金'
    ,dpd60_unrepay_price_b          comment 'dpd60+未还本金'
    ,dpd90_unrepay_price_b          comment 'dpd90+未还本金'
    ,stat_date                      comment '统计日期 年-月-日'
)
comment '风控vintage指标月表'
as
select 
     bo_id                          
    ,user_id                        
    ,bo_success_date                
    ,bo_finish_price                
    ,user_type                      
    ,level_type                     
    ,mob                            
    ,expect_type                    
    ,p_key                          
    ,product_cd
    ,gender_type                    
    ,age_type                       
    ,education_type                 
    ,school_type                    
    ,loan_amt_type                  
    ,province_cd                    
    ,td_score_type                  
    ,td_platform_7d_type            
    ,td_platform_1m_type            
    ,td_platform_3m_type            
    ,td_platform_6m_type
    ,amc_type
    ,graduate_type
    ,m3p_type
    ,m6p_type
    ,overdue_unrepay_days
    ,unrepay_price_b
    ,dpd1_unrepay_price_b           
    ,dpd10_unrepay_price_b          
    ,dpd30_unrepay_price_b          
    ,dpd60_unrepay_price_b          
    ,dpd90_unrepay_price_b          
    ,stat_date                     
from dw_srm.fact_risk_vintage_quota_m
;


--depend
210000366	dw_srm.fact_risk_vintage_quota_m

210000019	IDW.FACT_BORROWS_REPAYMENT
210000018	IDW.FACT_BORROWS
110000003	db_nono.borrows_prepare
110001015	risk.des_main
110001343	db_nono.borrows_external_mapping
210000123	IDW.FACT_MAIYA_ORDER
110000021	finance_order.ORD_ORDER
110000004	usr_member.user_info
110001181	usr_member.user_loan_auth_info
110001174	usr_member.user_edu_auth_log
210000340	idw.user_pengyuan_edu_legacy
110000009	db_nono.student_school
110001408	DMT_RM.BORROWS_CREDIT_INFO_MERGE


210000019	IDW.FACT_BORROWS_REPAYMENT
210000018	IDW.FACT_BORROWS
110000003	db_nono.borrows_prepare
110001015	risk.des_main
110001343	db_nono.borrows_external_mapping
210000123	IDW.FACT_MAIYA_ORDER
210000123	finance_order.ORD_ORDER
