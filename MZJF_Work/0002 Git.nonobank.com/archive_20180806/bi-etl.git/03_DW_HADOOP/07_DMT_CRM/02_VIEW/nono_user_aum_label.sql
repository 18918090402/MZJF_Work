CREATE VIEW dmt_crm.nono_user_aum_label AS 
 SELECT stat_date, user_id, aum, max_aum, max_aum_date
 , 'SYS' dw_create_by
 ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') dw_create_time
 , 'SYS' asdw_update_by
 , from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') dw_update_time 
 FROM idw.FACT_NONO_USER_STAT_DAILY
 WHERE stat_date = from_unixtime(unix_timestamp() - 1 * 24 * 60 * 60, 'yyyy-MM-dd')