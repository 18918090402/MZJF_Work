set mapreduce.job.name = IDW_FACT_FINANCE_ACCOUNT_SNAPSHOT;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT.FACT_FINANCE_ACCOUNT_SNAPSHOT partition
  (STAT_DATE)
SELECT 'SYS' as dw_create_by
	,unix_timestamp() as dw_create_time
	,'SYS' as dw_update_by
	,unix_timestamp() as dw_update_time
	,a.id
	,a.role_id
	,a.user_id
	,a.owner_id
	,a.balance
	,a.locking
	,a.version
	,a.create_time
	,a.update_time
	,from_unixtime(unix_timestamp()- 1 * 24 * 60 * 60, 'yyyy-MM-dd') as STAT_DATE
FROM ODSOPR.FINANCE_ACCOUNT a
WHERE role_id NOT IN(3,42,43)
AND a.balance<>0
;
