set mapreduce.job.name = idw_fact_csyy_aum_detail_snapshot_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;

insert overwrite table idw.fact_csyy_aum_detail_snapshot partition(stat_date)
SELECT   up.user_code           AS USER_CODE,
         up.USER_ID             AS USER_ID,
         up.PRODUCT_KEY         AS PRODUCT_KEY,
         up.product_code        AS PRODUCT_CODE,
         up.INVEST_TYPE_CODE    AS INVEST_TYPE_CODE,
         up.INVEST_AMT          AS INVEST_AMT,
         up.remaining_principal AS AUM,
         up.INVEST_SRC_ID       AS INVEST_SRC_ID,
         up.INVEST_SRC_TAB      AS INVEST_SRC_TAB,
         'SYS'                  AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS'                                                  AS DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         up.remaining_interest AS REMAINING_INTEREST,
         up.total_interest AS TOTAL_INTEREST,
         date_sub(current_date(),1)                             AS STAT_DATE
    FROM idw.fact_csyy_invest_order up
     where up.remaining_principal > 0;



