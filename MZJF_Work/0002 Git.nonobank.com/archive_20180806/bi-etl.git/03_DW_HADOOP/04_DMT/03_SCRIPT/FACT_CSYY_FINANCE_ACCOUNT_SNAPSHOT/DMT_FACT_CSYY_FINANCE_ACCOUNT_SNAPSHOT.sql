set mapreduce.job.name = DMT_FACT_CSYY_FINANCE_ACCOUNT_SNAPSHOT;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT overwrite TABLE DMT.FACT_CSYY_FINANCE_ACCOUNT_SNAPSHOT PARTITION (STAT_DATE) 
SELECT 
  t2.nono_user_id AS USER_ID,
  t1.user_code,
  SUM(t1.amount) AS AMOUNT,
  'SYS' AS dw_create_by,
  FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd') AS dw_create_time,
  'SYS' AS dw_update_by,
  FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd') AS dw_update_time,
  FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60,'yyyy-MM-dd') AS STAT_DATE 
FROM ods.t_user_account_trans_log_hist t1 
INNER JOIN ods.t_account_relation_hist t2 
    ON t1.user_code = t2.merchant_user_id 
GROUP BY t2.nono_user_id,
                t1.user_code