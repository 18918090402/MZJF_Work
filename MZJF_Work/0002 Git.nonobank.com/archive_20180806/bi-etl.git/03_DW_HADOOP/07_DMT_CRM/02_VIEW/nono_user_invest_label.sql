 CREATE VIEW dmt_crm.nono_user_invest_label AS 
 SELECT user_id, total_invest_amt
 ,TOTAL_ANNUALIZED_INVEST_AMT as total_invest_amt_yearly
 ,total_invest_cnt
 , 'SYS' dw_create_by
 , from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') dw_create_time
 , 'SYS' dw_update_by
 , from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') dw_update_time 
 FROM idw.FACT_NONO_USER_STAT_DAILY
 where stat_date = from_unixtime(unix_timestamp() - 1 * 24 * 60 * 60, 'yyyy-MM-dd')
 and total_invest_amt>0