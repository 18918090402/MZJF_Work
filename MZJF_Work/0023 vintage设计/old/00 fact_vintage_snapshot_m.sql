--table DDL

use dw_srm;

drop table if exists dw_srm.fact_vintage_snapshot_m ;

CREATE TABLE dw_srm.fact_vintage_snapshot_m 
(
     dw_create_by            string          comment '数据创建者'
    ,dw_create_time          string          comment '数据创建时间'
    ,bo_id                   bigint          comment '标的ID'
    ,user_id                 bigint          comment '用户ID'
    ,user_type_cd            string          comment '客户分类'
    ,level                   string          comment '等级'
    ,score                   string          comment '得分'
    ,level_type              string          comment '等级分类'
    ,confirm_pass_time       string          comment '终审通过时间'
    ,bo_agree_time           string          comment '借款协议生成时间'
    ,bo_finish_time          string          comment '借款满标时间'
    ,bo_success_time         string          comment '借款放款时间'
    ,bo_finish_price         decimal(32,10)  comment '放款金额'
    ,mob                     string          comment '帐龄'
    ,bo_expect               int             comment '期限'
    ,bo_expect_cat           int             comment '期限单位'
    ,expect_type             string          comment '期限分类'
    ,p_key                   int             comment 'BIA产品key'
    ,product_cd              string          comment '产品代码'
    ,is_overdue              string          comment '是否逾期'
    ,is_overdue_unrepay      string          comment '是否逾期未还'
    ,overdue_unrepay_days    int             comment '当前逾期未还天数'
    ,unrepay_price_b         decimal(32,10)  comment '逾期未还本金'
)
comment 'vintage每月快照表'
partitioned by (stat_date string comment '统计日期 年-月-日')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;

--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.fact_vintage_snapshot_m ;

create view dw_srmopr.fact_vintage_snapshot_m
(
     dw_create_by            comment '数据创建者'
    ,dw_create_time          comment '数据创建时间'
    ,bo_id                   comment '标的ID'
    ,user_id                 comment '用户ID'
    ,user_type_cd            comment '客户分类'
    ,level                   comment '等级'
    ,score                   comment '得分'
    ,level_type              comment '等级分类'
    ,confirm_pass_time       comment '终审通过时间'
    ,bo_agree_time           comment '借款协议生成时间'
    ,bo_finish_time          comment '借款满标时间'
    ,bo_success_time         comment '借款放款时间'
    ,bo_finish_price         comment '放款金额'
    ,mob                     comment '帐龄'
    ,bo_expect               comment '期限'
    ,bo_expect_cat           comment '期限单位'
    ,expect_type             comment '期限分类'
    ,p_key                   comment 'BIA产品key'
    ,product_cd              comment '产品代码'
    ,is_overdue              comment '是否逾期'
    ,is_overdue_unrepay      comment '是否逾期未还'
    ,overdue_unrepay_days    comment '当前逾期未还天数'
    ,unrepay_price_b         comment '逾期未还本金'
    ,stat_date               comment '统计日期 年-月-日'
)
comment 'vintage每月快照表'
as
select 
     dw_create_by            
    ,dw_create_time          
    ,bo_id                   
    ,user_id                 
    ,user_type_cd            
    ,level                   
    ,score                   
    ,level_type              
    ,confirm_pass_time       
    ,bo_agree_time           
    ,bo_finish_time          
    ,bo_success_time         
    ,bo_finish_price         
    ,mob                     
    ,bo_expect               
    ,bo_expect_cat           
    ,expect_type             
    ,p_key                   
    ,product_cd              
    ,is_overdue              
    ,is_overdue_unrepay      
    ,overdue_unrepay_days    
    ,unrepay_price_b
    ,stat_date
from dw_srm.fact_vintage_snapshot_m
;

