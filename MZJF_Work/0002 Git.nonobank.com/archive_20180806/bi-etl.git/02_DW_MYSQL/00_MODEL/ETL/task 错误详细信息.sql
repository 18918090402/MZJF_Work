-- task 错误详细信息 ，从昨天00:00:00 到 当前时间点
-- 日报
SELECT 
        A.RUN_ID
        , A.JOB_ID
        , IFNULL(B.JOB_TYPE, C.JOB_TYPE) JOB_TYPE
        , A.TASK_ID
        , IFNULL(
                B.TO_TABLE_NAME
                , C.TASK_NAME
        ) TASK_NAME
        , IFNULL(
                B.REFRESH_FREQ_NAME
                , C.REFRESH_FREQ_NAME
        ) REFRESH_FREQ_NAME
        
        , A.EVENT_TIME
        , A.EVENT_TYPE
        , A.EVENT_DESC 
FROM
        ETL.ETL_CONTROL_TASK_LOG_DETAIL A 
        INNER JOIN 
                (SELECT 
                        TASK_ID
                        , MAX(RUN_ID) RUN_ID 
                FROM
                        ETL.ETL_CONTROL_TASK_LOG_DETAIL A 
                        LEFT JOIN ETL_CONTROL_TASK_M2M B 
                                ON A.TASK_ID = B.ID 
                        LEFT JOIN ETL_CONTROL_TASK_DW C 
                                ON A.TASK_ID = C.ID 
                WHERE (B.RUN_FLAG = 1 
                                OR C.RUN_FLAG = 1) 
                        AND EVENT_TIME >= DATE_ADD(CURDATE(), INTERVAL - 1 DAY) 
                        AND EVENT_TYPE = 'ERROR' 
                GROUP BY TASK_ID) B 
                ON A.TASK_ID = B.TASK_ID 
                AND A.RUN_ID = B.RUN_ID 
        LEFT JOIN ETL_CONTROL_TASK_M2M B 
                ON A.TASK_ID = B.ID 
        LEFT JOIN ETL_CONTROL_TASK_DW C 
                ON A.TASK_ID = C.ID 
WHERE A.EVENT_TYPE = 'ERROR' 