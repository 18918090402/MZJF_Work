drop table if exists idw.borrows_h ;

CREATE TABLE idw.borrows_h 
(	
    dw_create_by                    string                  COMMENT '系统字段-创建者', 
    dw_create_time                  string                  COMMENT '系统字段-创建时间', 
    dw_update_by                    string                  COMMENT '系统字段-修改者', 
    dw_update_time                  string                  COMMENT '系统字段-修改时间', 
    id                              bigint                  COMMENT '主键ID', 	
    p_id                            bigint                  COMMENT '产品ID', 	
    bp_id                           bigint                  COMMENT '预发标ID', 	
    user_id                         bigint                  COMMENT '用户ID', 	
    am_id_add                       int                     COMMENT '表示当时标的销售归属', 	
    bo_aim                          string                  COMMENT '借款目的', 	
    bo_title                        string                  COMMENT '借款标题', 	
    bo_des                          string                  COMMENT '借款详情', 	
    bo_finance                      string                  COMMENT '借款人财务状况', 	
    bo_repaysrc                     string                  COMMENT '还款来源', 	
    bo_price                        decimal(38,10)          COMMENT '借款金额', 	
    bo_finish_price                 decimal(38,10)          COMMENT '完成金额', 	
    bo_expect                       int                     COMMENT '借款期限', 	
    bo_expect_cat                   int                     COMMENT '借款期限单位 年、月、日', 	
    bo_bidding_type                 int                     COMMENT '0：V3即协议用户  1：促销标 2：VIP用户', 	
    bo_safeguard_type               int                     COMMENT '保障方式  0无保障计划，1本金保障计划', 	
    bo_type                         int                     COMMENT '借款类型  1竞标，2公益标,3新客标', 	
    is_assurance                    int                     COMMENT '是否请求担保', 	
    bo_ba_owner_rate                decimal(38,10)          COMMENT '借出者的BA表利率部分', 	
    bo_sort                         int                     COMMENT '借款标排线', 	
    bo_rate                         decimal(38,10)          COMMENT '借款年利率', 	
    bo_time                         int                     COMMENT '有效时间', 	
    bo_paytype                      string                  COMMENT '还款方式', 	
    bo_is_index                     int                     COMMENT '是否推荐', 	
    bo_is_state                     int                     COMMENT '借款状态  1为发布,0为草稿', 	
    bo_hurry                        int                     COMMENT '是否加急终审取现', 	
    bo_capital                      int                     COMMENT '本金补足制度', 	
    publish_time                    string                  COMMENT '发布时间', 	
    bo_finish_rate                  decimal(38,10)          COMMENT '完成度,百分比', 	
    bo_is_finish                    int                     COMMENT '是否完成', 	
    bo_finish_time                  string                  COMMENT '完成时间', 	
    bo_sign_am_id                   bigint                  COMMENT '签约人员', 	
    bo_sign_time                    string                  COMMENT '签约时间', 	
    bo_sign_result                  int                     COMMENT '签约结果:1表示通过，2表示拒绝，0表示未处理,3表示待处理', 	
    bo_sign_remark                  string                  COMMENT '签约备注', 	
    bo_audit_am_id                  bigint                  COMMENT '审核人员', 	
    bo_audit_time                   string                  COMMENT '审核时间', 	
    bo_audit_remark                 string                  COMMENT '审核备注', 	
    bo_is_success                   int                     COMMENT '是否审核通过  1通过，2拒绝，3超时流标，4回退', 	
    transfer_account_time           string                  COMMENT '实际划转成功时间', 	
    bo_can_success                  int                     COMMENT '是否可以审核通过', 	
    bo_is_republish                 int                     COMMENT '是否已重发', 	
    bo_is_case                      int                     COMMENT '是否推荐案例', 	
    bo_guid                         string                  COMMENT '电子协议GUID', 	
    bo_extno                        string                  COMMENT '协议编号', 	
    bo_agree_generated              int                     COMMENT '协议是否生成', 	
    bo_agree_time                   string                  COMMENT '协议生成时间', 	
    bo_all_repayed                  int                     COMMENT '借款还款结束', 	
    bo_last_repayed_time            string                  COMMENT '最近还款时间', 	
    bo_audit_delay_days             int                     COMMENT '延长自动流标时间', 	
    bo_loan_agreement               string                  COMMENT '纸质合同', 	
    bo_loan_template                string                  COMMENT '借贷模板', 	
    bo_change_remark                string                  COMMENT '变更记录', 	
    bo_sorce_talk                   int                     COMMENT '谈吐分值', 	
    bo_sorce_instrument             int                     COMMENT '仪表分值', 	
    bo_sorce_face                   int                     COMMENT '面相分值', 	
    bo_sorce_cooperation            int                     COMMENT '配合度分值', 	
    bo_pledge                       int                     COMMENT '是否抵押', 	
    bo_house                        string                  COMMENT '房产信息', 	
    bo_overdue_day_count            int                     COMMENT '逾期天数', 	
    bo_overdue_remark               string                  COMMENT '逾期备注', 	
    bo_contract                     string                  COMMENT '协议加密数据', 	
    bo_repay_monitor                bigint                  COMMENT '还款监控人员', 	
    bo_overdue                      bigint                  COMMENT '逾期催收人员', 	
    bo_mxjb_match_time              string                  COMMENT '名校聚宝匹配时间', 	
    is_auto_overdue_debt_transfer   int                     COMMENT '是否支持逾期债权自动转让--第三方 0--不支持   1-支持', 	
    version                         int                     COMMENT '版本', 	
    voice_to_text                   string                  COMMENT '朗读文字', 	
    creator                         bigint                  COMMENT '创建人', 	
    updator                         bigint                  COMMENT '更新人', 	
    create_time                     string                  COMMENT '创建时间', 	
    update_time                     string                  COMMENT '更新时间', 	
    bo_identify                     string                  COMMENT '同步给徽商银行的标的编号', 	
    bo_video_remark                 string                  COMMENT '签约的视频摘要，使用SHA-1算法', 	
    depository_flag                 int                     COMMENT '存管标记：0-初始，1-走存管，2-不走存管',
    bo_cancel_time                  string                  COMMENT '流标时间', 	
    rc_id                           bigint                  COMMENT '资方ID', 	
    exceedlimit_flag                int                     COMMENT '0-P2P-正常（默认值） 1-P2P-超限-已代偿  2-非P2P超限-未代偿 ',
    bo_is_success_idx               bigint                  COMMENT '条件唯一索引字段 0正式标进行中，BOID 生命周期结束'
)	
COMMENT 'borrows_h历史表'
ROW FORMAT DELIMITED
NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;




insert overwrite table idw.borrows_h
select
    'SYS' AS dw_create_by
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS dw_create_time
    ,'SYS' AS dw_update_by
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS dw_update_time
    ,id
    ,p_id                            
    ,bp_id                           
    ,user_id                         
    ,am_id_add                       
    ,bo_aim                          
    ,bo_title                        
    ,bo_des                          
    ,bo_finance                      
    ,bo_repaysrc                     
    ,bo_price                        
    ,bo_finish_price                 
    ,bo_expect                       
    ,bo_expect_cat                   
    ,bo_bidding_type                 
    ,bo_safeguard_type               
    ,bo_type                         
    ,is_assurance                    
    ,bo_ba_owner_rate                
    ,bo_sort                         
    ,bo_rate                         
    ,bo_time                         
    ,bo_paytype                      
    ,bo_is_index                     
    ,bo_is_state                     
    ,bo_hurry                        
    ,bo_capital                      
    ,publish_time                    
    ,bo_finish_rate                  
    ,bo_is_finish                    
    ,bo_finish_time                  
    ,bo_sign_am_id                   
    ,bo_sign_time                    
    ,bo_sign_result                  
    ,bo_sign_remark                  
    ,bo_audit_am_id                  
    ,bo_audit_time                   
    ,bo_audit_remark                 
    ,bo_is_success                   
    ,transfer_account_time           
    ,bo_can_success                  
    ,bo_is_republish                 
    ,bo_is_case                      
    ,bo_guid                         
    ,bo_extno                        
    ,bo_agree_generated              
    ,bo_agree_time                   
    ,bo_all_repayed                  
    ,bo_last_repayed_time            
    ,bo_audit_delay_days             
    ,bo_loan_agreement               
    ,bo_loan_template                
    ,bo_change_remark                
    ,bo_sorce_talk                   
    ,bo_sorce_instrument             
    ,bo_sorce_face                   
    ,bo_sorce_cooperation            
    ,bo_pledge                       
    ,bo_house                        
    ,bo_overdue_day_count            
    ,bo_overdue_remark               
    ,bo_contract                     
    ,bo_repay_monitor                
    ,bo_overdue                      
    ,bo_mxjb_match_time              
    ,is_auto_overdue_debt_transfer   
    ,version                         
    ,voice_to_text                   
    ,creator                         
    ,updator                         
    ,create_time                     
    ,update_time                     
    ,bo_identify                     
    ,bo_video_remark                 
    ,depository_flag                 
    ,bo_cancel_time                  
    ,rc_id                           
    ,exceedlimit_flag                
    ,bo_is_success_idx               
from odsopr.borrows 
;






--bo有新增
select * from odsopr.borrows bo 
where not exists ( select 1 from idw.borrows_h boh where bo.id = boh.id ) 
;

set mapreduce.job.name = idw_borrows_h_1; 
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

insert into idw.borrows_h
select 
    'SYS' AS dw_create_by
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS dw_create_time
    ,'SYS' AS dw_update_by
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS dw_update_time
    ,t.id
    ,t.p_id                            
    ,t.bp_id                           
    ,t.user_id                         
    ,t.am_id_add                       
    ,t.bo_aim                          
    ,t.bo_title                        
    ,t.bo_des                          
    ,t.bo_finance                      
    ,t.bo_repaysrc                     
    ,t.bo_price                        
    ,t.bo_finish_price                 
    ,t.bo_expect                       
    ,t.bo_expect_cat                   
    ,t.bo_bidding_type                 
    ,t.bo_safeguard_type               
    ,t.bo_type                         
    ,t.is_assurance                    
    ,t.bo_ba_owner_rate                
    ,t.bo_sort                         
    ,t.bo_rate                         
    ,t.bo_time                         
    ,t.bo_paytype                      
    ,t.bo_is_index                     
    ,t.bo_is_state                     
    ,t.bo_hurry                        
    ,t.bo_capital                      
    ,t.publish_time                    
    ,t.bo_finish_rate                  
    ,t.bo_is_finish                    
    ,t.bo_finish_time                  
    ,t.bo_sign_am_id                   
    ,t.bo_sign_time                    
    ,t.bo_sign_result                  
    ,t.bo_sign_remark                  
    ,t.bo_audit_am_id                  
    ,t.bo_audit_time                   
    ,t.bo_audit_remark                 
    ,t.bo_is_success                   
    ,t.transfer_account_time           
    ,t.bo_can_success                  
    ,t.bo_is_republish                 
    ,t.bo_is_case                      
    ,t.bo_guid                         
    ,t.bo_extno                        
    ,t.bo_agree_generated              
    ,t.bo_agree_time                   
    ,t.bo_all_repayed                  
    ,t.bo_last_repayed_time            
    ,t.bo_audit_delay_days             
    ,t.bo_loan_agreement               
    ,t.bo_loan_template                
    ,t.bo_change_remark                
    ,t.bo_sorce_talk                   
    ,t.bo_sorce_instrument             
    ,t.bo_sorce_face                   
    ,t.bo_sorce_cooperation            
    ,t.bo_pledge                       
    ,t.bo_house                        
    ,t.bo_overdue_day_count            
    ,t.bo_overdue_remark               
    ,t.bo_contract                     
    ,t.bo_repay_monitor                
    ,t.bo_overdue                      
    ,t.bo_mxjb_match_time              
    ,t.is_auto_overdue_debt_transfer   
    ,t.version                         
    ,t.voice_to_text                   
    ,t.creator                         
    ,t.updator                         
    ,t.create_time                     
    ,t.update_time                     
    ,t.bo_identify                     
    ,t.bo_video_remark                 
    ,t.depository_flag                 
    ,t.bo_cancel_time                  
    ,t.rc_id                           
    ,t.exceedlimit_flag                
    ,t.bo_is_success_idx               
from 
(
    select bo.*, 
           boh.id boh_id, 
           boh.update_time boh_update_time
    from odsopr.borrows bo
    left join idw.borrows_h boh 
    on boh.id = bo.id 
) t 
where t.boh_id is null    -- 新增的bo
;









--bo有更新   772 
select * from odsopr.borrows bo 
where exists ( select 1 from idw.borrows_h boh where bo.id = boh.id and bo.update_time <> boh.update_time )
;


set mapreduce.job.name = idw_borrows_h_2; 
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

insert into idw.borrows_h
select 
    'SYS_UTIME' AS dw_create_by
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS dw_create_time
    ,'SYS_UTIME' AS dw_update_by
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS dw_update_time
    ,t.id
    ,t.p_id                            
    ,t.bp_id                           
    ,t.user_id                         
    ,t.am_id_add                       
    ,t.bo_aim                          
    ,t.bo_title                        
    ,t.bo_des                          
    ,t.bo_finance                      
    ,t.bo_repaysrc                     
    ,t.bo_price                        
    ,t.bo_finish_price                 
    ,t.bo_expect                       
    ,t.bo_expect_cat                   
    ,t.bo_bidding_type                 
    ,t.bo_safeguard_type               
    ,t.bo_type                         
    ,t.is_assurance                    
    ,t.bo_ba_owner_rate                
    ,t.bo_sort                         
    ,t.bo_rate                         
    ,t.bo_time                         
    ,t.bo_paytype                      
    ,t.bo_is_index                     
    ,t.bo_is_state                     
    ,t.bo_hurry                        
    ,t.bo_capital                      
    ,t.publish_time                    
    ,t.bo_finish_rate                  
    ,t.bo_is_finish                    
    ,t.bo_finish_time                  
    ,t.bo_sign_am_id                   
    ,t.bo_sign_time                    
    ,t.bo_sign_result                  
    ,t.bo_sign_remark                  
    ,t.bo_audit_am_id                  
    ,t.bo_audit_time                   
    ,t.bo_audit_remark                 
    ,t.bo_is_success                   
    ,t.transfer_account_time           
    ,t.bo_can_success                  
    ,t.bo_is_republish                 
    ,t.bo_is_case                      
    ,t.bo_guid                         
    ,t.bo_extno                        
    ,t.bo_agree_generated              
    ,t.bo_agree_time                   
    ,t.bo_all_repayed                  
    ,t.bo_last_repayed_time            
    ,t.bo_audit_delay_days             
    ,t.bo_loan_agreement               
    ,t.bo_loan_template                
    ,t.bo_change_remark                
    ,t.bo_sorce_talk                   
    ,t.bo_sorce_instrument             
    ,t.bo_sorce_face                   
    ,t.bo_sorce_cooperation            
    ,t.bo_pledge                       
    ,t.bo_house                        
    ,t.bo_overdue_day_count            
    ,t.bo_overdue_remark               
    ,t.bo_contract                     
    ,t.bo_repay_monitor                
    ,t.bo_overdue                      
    ,t.bo_mxjb_match_time              
    ,t.is_auto_overdue_debt_transfer   
    ,t.version                         
    ,t.voice_to_text                   
    ,t.creator                         
    ,t.updator                         
    ,t.create_time                     
    ,t.update_time                     
    ,t.bo_identify                     
    ,t.bo_video_remark                 
    ,t.depository_flag                 
    ,t.bo_cancel_time                  
    ,t.rc_id                           
    ,t.exceedlimit_flag                
    ,t.bo_is_success_idx      
from 
(
    select bo.*, 
           boh.id boh_id, 
           boh.update_time boh_update_time
    from odsopr.borrows bo
    left join idw.borrows_h boh 
    on boh.id = bo.id 
) t
where t.boh_id is not null                --非新增bo
and t.update_time <> t.boh_update_time    --bo信息有更新
;



--验证
select count(1) from odsopr.borrows where to_date(update_time) <= '2018-11-20' ;

select count(1) from 
( select a.*, row_number() over(partition by a.id order by a.update_time desc) rn from idw.borrows_h a ) t 
where t.rn = 1 
and to_date(t.update_time) <= '2018-11-20' ;

