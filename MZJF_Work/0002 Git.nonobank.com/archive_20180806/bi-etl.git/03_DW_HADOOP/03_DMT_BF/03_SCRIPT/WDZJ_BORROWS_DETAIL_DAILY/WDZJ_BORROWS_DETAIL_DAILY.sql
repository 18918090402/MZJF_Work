-- WDZJ_BORROWS_DETAIL_DAILY.sql 


set mapreduce.job.name = DMT_BF_WDZJ_BORROWS_DETAIL_DAILY;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_BF.WDZJ_BORROWS_DETAIL_DAILY partition
    (STAT_DATE)
SELECT
    bo.id as bo_id
    ,bo.bo_title
    ,bo.bo_price
    -- ,bo.bo_rate
    ,COALESCE(bp.bp_rate_lender,bo.bo_rate) as bo_rate
    ,bo.bo_expect
    ,bo.bo_expect_cat
    ,bo.p_id
    ,bo.bo_paytype 
    ,ui.hj_province_name as PROVINCE_NAME
    ,ui.hj_city_name as CITY_NAME
    ,bo.user_id
    ,bo.bo_des
    ,bo.bo_finish_time
    ,bo.publish_time
    ,'SYS' AS DW_CREATE_BY
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME
    ,'SYS' DW_UPDATE_BY
    ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    ,tid.bo_type
    ,FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') as stat_date
FROM odsopr.borrows bo
LEFT JOIN idw.user_info ui  ON bo.user_id = ui.user_id AND bo.id=tid.bo_id where ui.stat_date = FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd')
 -- INNER JOIN odsopr.user_info ui ON bo.user_id = ui.id
left join odsopr.borrows_prepare bp ON bo.bp_id = bp.id
 inner join (
  select bo_id,bo_type from 
(
SELECT bo.id as bo_id,1 as bo_type
FROM odsopr.borrows bo
WHERE bo_finish_time >= FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') 
AND bo_finish_time < FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') 
AND bo.bo_is_finish = 1
union all
SELECT dbl.bo_id,2 as bo_type
FROM odsopr.debt_buy_log dbl
WHERE dbl.p_type in (0,1,3) and dbl.status = 1
and dbl.pay_time  >= FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') 
AND dbl.pay_time < FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd')
) ta group by bo_id,bo_type
  ) tid;
