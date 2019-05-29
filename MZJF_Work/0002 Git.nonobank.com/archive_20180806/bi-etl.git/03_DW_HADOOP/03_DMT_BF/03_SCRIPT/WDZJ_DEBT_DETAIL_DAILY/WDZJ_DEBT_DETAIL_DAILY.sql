-- WDZJ_DEBT_DETAIL_DAILY.sql 
set mapreduce.job.name = DMT_BF_WDZJ_BORROWS_DETAIL_DAILY;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_BF.WDZJ_DEBT_DETAIL_DAILY partition
    (STAT_DATE)

SELECT 
    dbl.id dbl_id
    ,dbl.user_id
    ,dbl.price
    ,dbl.pay_time
    ,WB.BO_ID 
    ,'SYS' AS DW_CREATE_BY
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME
    ,'SYS' DW_UPDATE_BY
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
     ,dbl.p_type
    ,FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') as stat_date
FROM odsopr.debt_buy_log dbl 
INNER JOIN (SELECT BO_ID ,max(if(bo_type=1,1,0)) is_td_zt
FROM DMT_BF.WDZJ_BORROWS_DETAIL_DAILY WHERE STAT_DATE=FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') 
GROUP BY BO_ID) WB ON dbl.bo_id=WB.BO_ID  
WHERE dbl.status = 1
and ((
dbl.pay_time  >= FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') 
AND dbl.pay_time < FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd')
AND dbl.p_type in(0,1,3)
)
or (WB.is_td_zt=1 and dbl.p_type=2 )
)

;