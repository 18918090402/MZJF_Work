
drop table if exists dw_srm.fact_risk_payment_delay_d  ;


CREATE TABLE dw_srm.fact_risk_payment_delay_d 
(
    bo_id                                bigint        
    ,ind                                 string        
    ,user_id                             bigint        
    ,statis_dt                           string        
    ,level_type                          string        
    ,product_cd                          string        
    ,product_line_name                   string        
    ,product_type_name                   string        
    ,product_name                        string        
    ,expect_type                         int           
    ,p_key                               int           
    ,bo_success_time                     string        
    ,bo_finish_price                     decimal(38,10)
    ,fpd_1_flag                          int           
    ,fpd_1_time                          string        
    ,fpd_1_outstanding                   decimal(38,10)
    ,fpd_3_flag                          int           
    ,fpd_3_time                          string        
    ,fpd_3_outstanding                   decimal(38,10)
    ,fpd_7_flag                          int           
    ,fpd_7_time                          string        
    ,fpd_7_outstanding                   decimal(38,10)
    ,fpd_15_flag                         int           
    ,fpd_15_time                         string        
    ,fpd_15_outstanding                  decimal(38,10)
    ,fpd_30_flag                         int           
    ,fpd_30_time                         string        
    ,fpd_30_outstanding                  decimal(38,10)
    ,spd_30_flag                         int           
    ,spd_30_time                         string        
    ,spd_30_outstanding                  decimal(38,10)
    ,tpd_30_flag                         int           
    ,tpd_30_time                         string        
    ,tpd_30_outstanding                  decimal(38,10)
    ,qpd_30_flag                         int           
    ,qpd_30_time                         string        
    ,qpd_30_outstanding                  decimal(38,10)
    ,fifthpd_30_flag                     int           
    ,fifthpd_30_time                     string        
    ,fifthpd_30_outstanding              decimal(38,10)
    ,sixthpd_30_flag                     int           
    ,sixthpd_30_time                     string        
    ,sixthpd_30_outstanding              decimal(38,10)
    ,seventhpd_30_flag                   int           
    ,seventhpd_30_time                   string        
    ,seventhpd_30_outstanding            decimal(38,10)
    ,eighthpd_30_flag                    int           
    ,eighthpd_30_time                    string        
    ,eighthpd_30_outstanding             decimal(38,10)
    ,ninthpd_30_flag                     int           
    ,ninthpd_30_time                     string        
    ,ninthpd_30_outstanding              decimal(38,10)
    ,tenthpd_30_flag                     int           
    ,tenthpd_30_time                     string        
    ,tenthpd_30_outstanding              decimal(38,10)
    ,eleventhpd_30_flag                  int           
    ,eleventhpd_30_time                  string        
    ,eleventhpd_30_outstanding           decimal(38,10)
    ,twelfthpd_30_flag                   int           
    ,twelfthpd_30_time                   string        
    ,twelfthpd_30_outstanding            decimal(38,10)
    ,thirteenthpd_30_flag                int           
    ,thirteenthpd_30_time                string        
    ,thirteenthpd_30_outstanding         decimal(38,10)
    ,fourteenthpd_30_flag                int           
    ,fourteenthpd_30_time                string        
    ,fourteenthpd_30_outstanding         decimal(38,10)
    ,fifteenthpd_30_flag                 int           
    ,fifteenthpd_30_time                 string        
    ,fifteenthpd_30_outstanding          decimal(38,10)
    ,sixteenthpd_30_flag                 int           
    ,sixteenthpd_30_time                 string        
    ,sixteenthpd_30_outstanding          decimal(38,10)
    ,seventeenthpd_30_flag               int           
    ,seventeenthpd_30_time               string        
    ,seventeenthpd_30_outstanding        decimal(38,10)
    ,eighteenthpd_30_flag                int           
    ,eighteenthpd_30_time                string        
    ,eighteenthpd_30_outstanding         decimal(38,10)
    ,nineteenthpd_30_flag                int           
    ,nineteenthpd_30_time                string        
    ,nineteenthpd_30_outstanding         decimal(38,10)
    ,twentiethpd_30_flag                 int           
    ,twentiethpd_30_time                 string        
    ,twentiethpd_30_outstanding          decimal(38,10)
    ,twenty_firstpd_30_flag              int           
    ,twenty_firstpd_30_time              string        
    ,twenty_firstpd_30_outstanding       decimal(38,10)
    ,twenty_secondpd_30_flag             int           
    ,twenty_secondpd_30_time             string        
    ,twenty_secondpd_30_outstanding      decimal(38,10)
    ,twenty_thirdpd_30_flag              int           
    ,twenty_thirdpd_30_time              string        
    ,twenty_thirdpd_30_outstanding       decimal(38,10)
    ,twenty_fourthpd_30_flag             int           
    ,twenty_fourthpd_30_time             string        
    ,twenty_fourthpd_30_outstanding      decimal(38,10)
    ,twenty_fifthpd_30_flag              int           
    ,twenty_fifthpd_30_time              string        
    ,twenty_fifthpd_30_outstanding       decimal(38,10)
    ,twenty_sixthpd_30_flag              int           
    ,twenty_sixthpd_30_time              string        
    ,twenty_sixthpd_30_outstanding       decimal(38,10)
    ,twenty_seventhpd_30_flag            int           
    ,twenty_seventhpd_30_time            string        
    ,twenty_seventhpd_30_outstanding     decimal(38,10)
    ,twenty_eighthpd_30_flag             int           
    ,twenty_eighthpd_30_time             string        
    ,twenty_eighthpd_30_outstanding      decimal(38,10)
    ,twenty_ninthpd_30_flag              int           
    ,twenty_ninthpd_30_time              string        
    ,twenty_ninthpd_30_outstanding       decimal(38,10)
    ,thirtiethpd_30_flag                 int           
    ,thirtiethpd_30_time                 string        
    ,thirtiethpd_30_outstanding          decimal(38,10)
    ,thirty_firstpd_30_flag              int           
    ,thirty_firstpd_30_time              string        
    ,thirty_firstpd_30_outstanding       decimal(38,10)
    ,thirty_secondpd_30_flag             int           
    ,thirty_secondpd_30_time             string        
    ,thirty_secondpd_30_outstanding      decimal(38,10)
    ,thirty_thirdpd_30_flag              int           
    ,thirty_thirdpd_30_time              string        
    ,thirty_thirdpd_30_outstanding       decimal(38,10)
    ,thirty_fourthpd_30_flag             int           
    ,thirty_fourthpd_30_time             string        
    ,thirty_fourthpd_30_outstanding      decimal(38,10)
    ,thirty_fifthpd_30_flag              int           
    ,thirty_fifthpd_30_time              string        
    ,thirty_fifthpd_30_outstanding       decimal(38,10)
    ,thirty_sixthpd_30_flag              int           
    ,thirty_sixthpd_30_time              string        
    ,thirty_sixthpd_30_outstanding       decimal(38,10)
    ,stat_date                           string        
)
comment '还款延期明细表'
partitioned by (stat_date string comment '统计日期 年-月-日')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;


--view
drop view if exists dw_srmopr.fact_risk_payment_delay_d  ;

create view dw_srmopr.fact_risk_payment_delay_d as select * from dw_srm.fact_risk_payment_delay_d  ;

