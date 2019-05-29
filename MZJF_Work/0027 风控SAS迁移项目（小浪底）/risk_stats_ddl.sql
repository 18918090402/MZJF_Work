
drop table if exists dw_srm.fact_risk_stats_m  ;


CREATE TABLE dw_srm.fact_risk_stats_m 
(
    bo_id                        bigint             comment '借款ID'
    ,user_id                     bigint             comment '用户ID'
    ,statis_dt                   string             comment '统计日期'
    ,product_line_name           string             comment '产品线名称'
    ,product_type_name           string             comment '产品大类名称'
    ,product_name                string             comment '产品小类名称'
    ,disbursed_date              string             comment '放款日'
    ,disbursed_amt               decimal(38,10)     comment '放款金额'
    ,term                        int                comment '期限'
    ,status                      string             comment '状态 closed/current/overdue'
    ,repay_date                  string             comment '当月应还款日'
    ,actrepay_date               string             comment '当月实际还款日'
    ,overdue_day                 int                comment '逾期天数'
    ,max_overdue_days            int                comment '最大逾期天数'
    ,currperiod_overdue_day      int                comment '当期实际逾期天数'
    ,overdue_term                bigint             comment '逾期期数'
    ,outstanding_amt             decimal(38,10)     comment '剩余本金'
    ,term_paid                   bigint             comment '已还期数'
    ,overdue_principal_amt       decimal(38,10)     comment '逾期本金金额'
    ,principal_tmonth_amt        decimal(38,10)     comment '本月已还本金'
    ,fpd_1_flag                  int                comment 'fpd_1_flag'
    ,fpd_3_flag                  int                comment 'fpd_3_flag'
    ,fpd_7_flag                  int                comment 'fpd_7_flag'
    ,fpd_15_flag                 int                comment 'fpd_15_flag'
    ,fpd_30_flag                 int                comment 'fpd_30_flag'
    ,spd_30_flag                 int                comment 'spd_30_flag'
    ,tpd_30_flag                 int                comment 'tpd_30_flag'
    ,qpd_30_flag                 int                comment 'qpd_30_flag'
    ,fifthpd_30_flag             int                comment 'fifthpd_30_flag'
    ,sixthpd_30_flag             int                comment 'sixthpd_30_flag'
    ,seventhpd_30_flag           int                comment 'seventhpd_30_flag'
    ,eighthpd_30_flag            int                comment 'eighthpd_30_flag'
    ,ninthpd_30_flag             int                comment 'ninthpd_30_flag'
    ,tenthpd_30_flag             int                comment 'tenthpd_30_flag'
    ,eleventhpd_30_flag          int                comment 'eleventhpd_30_flag'
    ,twelfthpd_30_flag           int                comment 'twelfthpd_30_flag'
    ,aging                       string             comment '账龄'
    ,mob                         int                comment 'MOB'
    ,year                        string             comment '放款年份'
    ,quarter                     string             comment '放款季度'
    ,month                       string             comment '放款月份'
    ,loss_mark                   int                comment '是否损失账户'
    ,loss_amt                    decimal(38,10)     comment '损失金额'
    ,loss_date                   string             comment '损失日期'
    ,net_loss_amt                decimal(38,10)     comment '净损失金额'
    ,stock_amt                   decimal(38,10)     comment '剔除损失后的剩余本金'
    ,recovery_mark               int                comment '是否发生回收'
    ,recovery_amt                decimal(38,10)     comment '回收金额'
    ,recover_date                string             comment '回收日期'
    ,floss_mark                  int                comment '是否欺诈损失账户'
    ,floss_amt                   decimal(38,10)     comment '欺诈损失金额'
    ,frecovery_amt               decimal(38,10)     comment '欺诈回收金额'
    ,net_floss_amt               decimal(38,10)     comment '净欺诈损失金额'
)
comment '风控统计月表'
partitioned by (stat_date string comment '分区键 年-月-日')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.fact_risk_stats_m ;

create view dw_srmopr.fact_risk_stats_m
(
    bo_id                        comment '借款ID'
    ,user_id                     comment '用户ID'
    ,statis_dt                   comment '统计日期 年-月-日'
    ,product_line_name           comment '产品线名称'
    ,product_type_name           comment '产品大类名称'
    ,product_name                comment '产品小类名称'
    ,disbursed_date              comment '放款日'
    ,disbursed_amt               comment '放款金额'
    ,term                        comment '期限'
    ,status                      comment '状态 closed/current/overdue'
    ,repay_date                  comment '当月应还款日'
    ,actrepay_date               comment '当月实际还款日'
    ,overdue_day                 comment '逾期天数'
    ,max_overdue_days            comment '最大逾期天数'
    ,currperiod_overdue_day      comment '当期实际逾期天数'
    ,overdue_term                comment '逾期期数'
    ,outstanding_amt             comment '剩余本金'
    ,term_paid                   comment '已还期数'
    ,overdue_principal_amt       comment '逾期本金金额'
    ,principal_tmonth_amt        comment '本月已还本金'
    ,fpd_1_flag                  comment 'fpd_1_flag'
    ,fpd_3_flag                  comment 'fpd_3_flag'
    ,fpd_7_flag                  comment 'fpd_7_flag'
    ,fpd_15_flag                 comment 'fpd_15_flag'
    ,fpd_30_flag                 comment 'fpd_30_flag'
    ,spd_30_flag                 comment 'spd_30_flag'
    ,tpd_30_flag                 comment 'tpd_30_flag'
    ,qpd_30_flag                 comment 'qpd_30_flag'
    ,fifthpd_30_flag             comment 'fifthpd_30_flag'
    ,sixthpd_30_flag             comment 'sixthpd_30_flag'
    ,seventhpd_30_flag           comment 'seventhpd_30_flag'
    ,eighthpd_30_flag            comment 'eighthpd_30_flag'
    ,ninthpd_30_flag             comment 'ninthpd_30_flag'
    ,tenthpd_30_flag             comment 'tenthpd_30_flag'
    ,eleventhpd_30_flag          comment 'eleventhpd_30_flag'
    ,twelfthpd_30_flag           comment 'twelfthpd_30_flag'
    ,aging                       comment '账龄'
    ,mob                         comment 'MOB'
    ,year                        comment '放款年份'
    ,quarter                     comment '放款季度'
    ,month                       comment '放款月份'
    ,loss_mark                   comment '是否损失账户'
    ,loss_amt                    comment '损失金额'
    ,loss_date                   comment '损失日期'
    ,net_loss_amt                comment '净损失金额'
    ,stock_amt                   comment '剔除损失后的剩余本金'
    ,recovery_mark               comment '是否发生回收'
    ,recovery_amt                comment '回收金额'
    ,recover_date                comment '回收日期'
    ,floss_mark                  comment '是否欺诈损失账户'
    ,floss_amt                   comment '欺诈损失金额'
    ,frecovery_amt               comment '欺诈回收金额'
    ,net_floss_amt               comment '净欺诈损失金额'
    ,stat_date                   comment '分区键 年-月-日'
)
comment '风控统计月表'
as
select 
    bo_id                        
    ,user_id                     
    ,statis_dt                   
    ,product_line_name           
    ,product_type_name           
    ,product_name                
    ,disbursed_date              
    ,disbursed_amt               
    ,term                        
    ,status                      
    ,repay_date                  
    ,actrepay_date               
    ,overdue_day                 
    ,max_overdue_days
    ,currperiod_overdue_day
    ,overdue_term                
    ,outstanding_amt             
    ,term_paid                   
    ,overdue_principal_amt       
    ,principal_tmonth_amt        
    ,fpd_1_flag                  
    ,fpd_3_flag                  
    ,fpd_7_flag                  
    ,fpd_15_flag                 
    ,fpd_30_flag                 
    ,spd_30_flag                 
    ,tpd_30_flag                 
    ,qpd_30_flag                 
    ,fifthpd_30_flag             
    ,sixthpd_30_flag             
    ,seventhpd_30_flag           
    ,eighthpd_30_flag            
    ,ninthpd_30_flag             
    ,tenthpd_30_flag             
    ,eleventhpd_30_flag          
    ,twelfthpd_30_flag           
    ,aging                       
    ,mob                         
    ,year                        
    ,quarter                     
    ,month                       
    ,loss_mark                   
    ,loss_amt                    
    ,loss_date                   
    ,net_loss_amt                
    ,stock_amt                   
    ,recovery_mark               
    ,recovery_amt                
    ,recover_date                
    ,floss_mark                  
    ,floss_amt                   
    ,frecovery_amt               
    ,net_floss_amt               
    ,stat_date                   
from dw_srm.fact_risk_stats_m
;
