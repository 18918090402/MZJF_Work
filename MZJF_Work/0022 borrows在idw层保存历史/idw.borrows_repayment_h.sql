drop table if exists idw.borrows_repayment_h ;

CREATE TABLE idw.borrows_repayment_h
(	
    dw_create_by                        string              COMMENT '系统字段-创建者', 	
    dw_create_time                      string              COMMENT '系统字段-创建时间', 	
    dw_update_by                        string              COMMENT '系统字段-修改者', 	
    dw_update_time                      string              COMMENT '系统字段-修改时间', 	
    id                                  bigint              COMMENT '主键ID', 	
    user_id                             bigint              COMMENT '用户ID', 	
    bo_id                               bigint              COMMENT '借款ID', 	
    br_price                            decimal(38,10)      COMMENT '还款金额', 	
    br_price_b                          decimal(38,10)      COMMENT '本金', 	
    br_price_l                          decimal(38,10)      COMMENT '利息', 	
    br_price_punish                     decimal(38,10)      COMMENT '罚息和违约金', 	
    br_price_punish_lender              decimal(38,10)      COMMENT '罚金借出者收取', 	
    br_price_punish_pc                  decimal(38,10)      COMMENT '罚金机构收取', 	
    br_time                             string              COMMENT '计划还款时间', 	
    br_repay_time                       string              COMMENT '实际还款时间', 	
    br_is_repay                         int                 COMMENT '是否还款 0没有/1借款人还款/2担保人还款', 	
    br_repay_status                     int                 COMMENT '还款状态：0无状态 1进入还款队列 2进入逾期还款队列 3正常还款 4提前还款 5逾期还款', 	
    br_transfer_fa_id                   bigint              COMMENT '债转对应的FA_ID', 	
    br_call_record                      string              COMMENT '电话记录', 	
    br_repayed_tech_fee                 decimal(38,10)      COMMENT '当期归还的技术的服务费', 	
    dunning_way                         string              COMMENT '催收方式', 	
    br_locked                           int                 COMMENT '是否锁定，0未锁定，1锁定，2', 	
    br_overdue_terms                    int                 COMMENT '当前逾期总数', 	
    br_is_hnapay_deduct                 int                 COMMENT '是否代划扣', 	
    br_service_fee                      decimal(38,10)      COMMENT '平台服务费', 	
    br_is_send_sms                      int                 COMMENT '是否已发送短信通知', 	
    br_expect_num                       int                 COMMENT '当前标的第几期还款数据', 	
    version                             int                 COMMENT '版本', 	
    creator                             bigint              COMMENT '创建人', 	
    updator                             bigint              COMMENT '更新人', 	
    create_time                         string              COMMENT '创建时间', 	
    update_time                         string              COMMENT '更新时间', 	
    price_return                        decimal(38,10)      COMMENT '使用减息券之后平台返回给借入者的资金', 	
    punish_proc_date                    string              COMMENT '罚息更新处理时间', 	
    sys_already_deduct_fee              decimal(38,10)      COMMENT '系统已扣除金额(只在每次扣除累加)', 	
    hum_already_cancel_fee              decimal(38,10)      COMMENT '人工已撤销金额(<=系统已扣除金额)', 	
    hum_already_return_fee              decimal(38,10)      COMMENT '人工已退还金额(<=人工已撤销金额)', 	
    zxf_update_time                     string              COMMENT '最近咨询费扣除时间', 	
    hum_can_return_fee                  decimal(38,10)      COMMENT '人工可退还金额', 	
    br_extra_fee                        decimal(38,10)      COMMENT '额外费用', 	
    br_service_fee_other                decimal(38,10)      COMMENT '其他服务费(星河服务费)', 	
    br_post_consult_fee                 decimal(38,10)      COMMENT '后置咨询费', 	
    br_business_processed_time          string              COMMENT '跟BR相关的业务JOB处理完成的时间'
)	
COMMENT '自20181119始,保存borrows_repayment生命周期内的所有历史情况, 用update_time排序后去重br_id'
ROW FORMAT DELIMITED
NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;


set hive.exec.parallel = true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict; 
set hive.exec.max.dynamic.partitions.pernode = 100000000;
set hive.exec.max.dynamic.partitions = 100000000;
set hive.exec.max.created.files = 100000000;

insert into idw.borrows_repayment_h 
select 
     dw_create_by                        
    ,dw_create_time                      
    ,dw_update_by                        
    ,dw_update_time                      
    ,id                                  
    ,user_id                             
    ,bo_id                               
    ,br_price                            
    ,br_price_b                          
    ,br_price_l                          
    ,br_price_punish                     
    ,br_price_punish_lender              
    ,br_price_punish_pc                  
    ,br_time                             
    ,br_repay_time                       
    ,br_is_repay                         
    ,br_repay_status                     
    ,br_transfer_fa_id                   
    ,br_call_record                      
    ,br_repayed_tech_fee                 
    ,dunning_way                         
    ,br_locked                           
    ,br_overdue_terms                    
    ,br_is_hnapay_deduct                 
    ,br_service_fee                      
    ,br_is_send_sms                      
    ,br_expect_num                       
    ,version                             
    ,creator                             
    ,updator                             
    ,create_time                         
    ,update_time                         
    ,price_return                        
    ,punish_proc_date                    
    ,sys_already_deduct_fee              
    ,hum_already_cancel_fee              
    ,hum_already_return_fee              
    ,zxf_update_time                     
    ,hum_can_return_fee                  
    ,br_extra_fee                        
    ,br_service_fee_other                
    ,br_post_consult_fee                 
    ,br_business_processed_time 
from odsopr.borrows_repayment 
;



--br有新增

set mapreduce.job.name = idw_borrows_repayment_h_1; 
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


insert into idw.borrows_repayment_h
select 
    'SYS_NEW' AS dw_create_by
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS dw_create_time
    ,'SYS_NEW' AS dw_update_by
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS dw_update_time
    ,t.id                                  
    ,t.user_id                             
    ,t.bo_id                               
    ,t.br_price                            
    ,t.br_price_b                          
    ,t.br_price_l                          
    ,t.br_price_punish                     
    ,t.br_price_punish_lender              
    ,t.br_price_punish_pc                  
    ,t.br_time                             
    ,t.br_repay_time                       
    ,t.br_is_repay                         
    ,t.br_repay_status                     
    ,t.br_transfer_fa_id                   
    ,t.br_call_record                      
    ,t.br_repayed_tech_fee                 
    ,t.dunning_way                         
    ,t.br_locked                           
    ,t.br_overdue_terms                    
    ,t.br_is_hnapay_deduct                 
    ,t.br_service_fee                      
    ,t.br_is_send_sms                      
    ,t.br_expect_num                       
    ,t.version                             
    ,t.creator                             
    ,t.updator                             
    ,t.create_time                         
    ,t.update_time                         
    ,t.price_return                        
    ,t.punish_proc_date                    
    ,t.sys_already_deduct_fee              
    ,t.hum_already_cancel_fee              
    ,t.hum_already_return_fee              
    ,t.zxf_update_time                     
    ,t.hum_can_return_fee                  
    ,t.br_extra_fee                        
    ,t.br_service_fee_other                
    ,t.br_post_consult_fee                 
    ,t.br_business_processed_time 
from 
(
    select br.*, 
           brh.id brh_id, 
           brh.update_time brh_update_time
    from odsopr.borrows_repayment br
    left join idw.borrows_repayment_h brh 
    on brh.id = br.id 
) t 
where t.brh_id is null    -- 新增的br
;


--br有更新
set mapreduce.job.name = idw_borrows_repayment_h_2; 
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


insert into idw.borrows_repayment_h
select 
    'SYS_UTIME' AS dw_create_by
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS dw_create_time
    ,'SYS_UTIME' AS dw_update_by
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS dw_update_time
    ,t.id                                  
    ,t.user_id                             
    ,t.bo_id                               
    ,t.br_price                            
    ,t.br_price_b                          
    ,t.br_price_l                          
    ,t.br_price_punish                     
    ,t.br_price_punish_lender              
    ,t.br_price_punish_pc                  
    ,t.br_time                             
    ,t.br_repay_time                       
    ,t.br_is_repay                         
    ,t.br_repay_status                     
    ,t.br_transfer_fa_id                   
    ,t.br_call_record                      
    ,t.br_repayed_tech_fee                 
    ,t.dunning_way                         
    ,t.br_locked                           
    ,t.br_overdue_terms                    
    ,t.br_is_hnapay_deduct                 
    ,t.br_service_fee                      
    ,t.br_is_send_sms                      
    ,t.br_expect_num                       
    ,t.version                             
    ,t.creator                             
    ,t.updator                             
    ,t.create_time                         
    ,t.update_time                         
    ,t.price_return                        
    ,t.punish_proc_date                    
    ,t.sys_already_deduct_fee              
    ,t.hum_already_cancel_fee              
    ,t.hum_already_return_fee              
    ,t.zxf_update_time                     
    ,t.hum_can_return_fee                  
    ,t.br_extra_fee                        
    ,t.br_service_fee_other                
    ,t.br_post_consult_fee                 
    ,t.br_business_processed_time 
from 
(
    select br.*, 
           brh.id brh_id, 
           brh.update_time brh_update_time
    from odsopr.borrows_repayment br
    left join idw.borrows_repayment_h brh 
    on brh.id = br.id 
) t 
where t.brh_id is not null                --非新增br
and t.update_time <> t.brh_update_time    --br信息有更新
;







--验证
select count(1) from odsopr.borrows_repayment where to_date(update_time) <= '2018-11-20' ;



select count(1) from 
(select a.*, row_number() over( partition by a.id order by a.update_time desc) rn from idw.borrows_repayment_h a) t 
where t.rn = 1 
and to_date(t.update_time) <= '2018-11-20' ;


