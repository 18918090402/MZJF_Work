set mapreduce.job.name = dmt_bf_nono_90_days_avg_invest_change_log_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table DMT_BF.NONO_90_DAYS_AVG_INVEST_CHANGE_LOG partition
  (STAT_DATE = '{T_SUB_1}')
  SELECT UI.ID USER_ID,
         coalesce(AI.INVEST_AMT, 0) INVEST_AMT,
         coalesce(AI.avg_invest_amt_90, 0) AVG_INVEST_AMT_90,
         CASE
           WHEN UI.REGISTER_TIME >= '{T_SUB_1}' THEN
            1
           ELSE
            0
         END TYPE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ODS.T_USER_INFO_HIST UI
    LEFT JOIN DMT_BF.NONO_90_DAYS_AVG_INVEST_SNAPSHOT AI
      ON AI.USER_ID = UI.ID
     AND AI.STAT_DATE = '{T_SUB_1}'
    LEFT JOIN DMT_BF.NONO_90_DAYS_AVG_INVEST_SNAPSHOT AI2
      ON AI2.USER_ID = UI.ID
     AND AI2.STAT_DATE = '{T_SUB_2}'
   WHERE (UI.REGISTER_TIME >= '{T_SUB_1}' OR
         (coalesce(AI.avg_invest_amt_90, 0) <>
         coalesce(AI2.avg_invest_amt_90, 0)) OR
         (coalesce(AI.INVEST_AMT, 0) <> coalesce(AI2.INVEST_AMT, 0)));