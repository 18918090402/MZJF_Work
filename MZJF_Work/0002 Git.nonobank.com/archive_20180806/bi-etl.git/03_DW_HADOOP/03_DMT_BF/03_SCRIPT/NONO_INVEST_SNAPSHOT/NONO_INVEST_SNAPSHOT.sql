set mapreduce.job.name = dmt_bf_nono_invest_snapshot_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table DMT_BF.NONO_INVEST_SNAPSHOT partition
  (STAT_DATE = '{T_SUB_1}')
  select USER_ID,
         case
           when sum(INVEST_AMT) < 0 then
            0
           else
            sum(INVEST_AMT)
         end INVEST_AMT,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    from (SELECT VA.USER_ID, VA.AMOUNT INVEST_AMT
            FROM ODS.T_VIP_ACCOUNT_HIST VA
           WHERE VA.IS_CASH = 0
             AND VA.FP_ID IS NOT NULL
          UNION ALL
          SELECT VA.USER_ID,
                 - (DS.TRANSFER_NUM - RESIDUE_NUM) * ONE_PRICE INVEST_AMT
            FROM ODS.T_VIP_ACCOUNT_HIST VA
            JOIN ODS.T_DEBT_SALE_HIST DS
              ON VA.ID = DS.VA_ID
             AND VA.IS_CASH = 0
             AND VA.FP_ID IS NOT NULL
             AND DS.OP_TYPE = 1
          UNION ALL
          SELECT BA.USER_ID, BA.PRICE_PRINCIPAL INVEST_AMT
            FROM ODS.T_BORROWS_ACCEPT_HIST BA
            JOIN ODS.T_BORROWS_HIST B
              ON B.ID = BA.BO_ID
           WHERE B.BO_IS_SUCCESS = 1
             AND BA.IS_PAY = 0
             AND BA.IS_VIP = 0
             AND BA.PRICE > 0) s
   group by USER_ID;