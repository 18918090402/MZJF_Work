set mapreduce.job.name=DMT_RM_FACT_APPROVAL_MXDMY_DATA_01_01; 
set mapreduce.job.queuename = etl-dw;  

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 

set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict; 
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;




INSERT OVERWRITE TABLE dmt_rm.FACT_APPROVAL_MXDMY_DATA_01 partition (STAT_DATE)
SELECT  
oo.order_no AS ORDER_NO
,nvl(oo.bo_id,-1) as APPLY_NO
,su.realname as AUDIT_NAME
,'麦芽分期' as PRODUCT
,ooch.pass_time AS PROCESS_BEGIN_TIME
,sdi.dic_name AS PROCESS_NAME
,NULL AS PROCESS_END_TIME
,'SYS' AS DW_CREATE_BY
,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
,'SYS' AS DW_UPDATE_BY
,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
,regexp_replace(cast(to_date(ooch.pass_time) as string),'-','') as STAT_DATE
FROM 
ods.t_ORD_ORDER_CHECK_HISTORY_hist ooch 
 JOIN ods.t_ORD_ORDER_hist oo ON ooch.order_id=oo.id AND oo.disabled='0'
LEFT JOIN ods.t_SYS_DIC_hist sdi ON ooch.operator_type=sdi.dic_code
AND sdi.disabled='0'
  LEFT JOIN ods.t_SYS_USER_hist su ON ooch.`create_user`=su.id AND su.`disabled`='0'
WHERE ooch.order_id IS NOT NULL 
  AND ooch.status<>'0'
AND ooch.disabled='0'
 AND ooch.pass_time>=date_sub(CURRENT_DATE(),10)
;