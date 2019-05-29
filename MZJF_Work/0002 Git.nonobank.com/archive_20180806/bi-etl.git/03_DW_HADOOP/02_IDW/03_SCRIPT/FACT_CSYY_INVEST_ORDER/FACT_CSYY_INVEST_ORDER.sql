set mapreduce.job.name = idw_fact_csyy_invest_order_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table idw.fact_csyy_invest_order
  SELECT up.user_product_id AS INVEST_SRC_ID,
         'user_product' AS INVEST_SRC_TAB,
         up.user_code AS USER_CODE,
         ar.nono_user_id AS USER_ID,
         up.product_code as PRODUCT_KEY,
         up.product_code AS PRODUCT_CODE,
         up.created_date AS INVEST_TIME,
         up.invest_amount AS INVEST_AMT,
         up.remaining_principal AS REMAINING_PRINCIPAL,
         up.total_interest AS TOTAL_INTEREST,
         up.remaining_interest AS REMAINING_INTEREST,
         DATEDIFF(up.invest_end_date, up.invest_begin_date) + 1 AS EXPECT,
         1 AS EXPECT_UNIT_CODE,
         up.invest_begin_date AS LOCK_BEGIN_TIME,
         up.invest_end_date AS LOCK_END_TIME,
         CASE
           WHEN pr.product_rate_id IN (13, 14, 15, 16) THEN
            7.30 + pr.rate
           WHEN pr.product_rate_id IN (6, 7, 8, 9, 12) THEN
            8.88 + pr.rate
           ELSE
            pr.rate
         END AS RATE,
         wpc.privilege_amount as DEDUCTIBLE_AMT,
         1 as INVEST_TYPE_CODE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when up.product_code = 'NN0018' then
            up.invest_amount * 1 / 12
          else
            up.invest_amount * (DATEDIFF(up.invest_end_date, up.invest_begin_date) + 1) / 365
         end INVEST_AMT_YEARLY
    FROM ods.t_user_product_hist up
    LEFT JOIN ods.t_product_rate_hist pr
      ON up.product_code = pr.product_code
    LEFT JOIN ods.t_account_relation_hist ar
      ON up.user_code = ar.merchant_user_id
    left join ods.t_welfare_privilege_code_hist wpc
      on up.order_id = wpc.order_id
     and wpc.welfare_type = 5
     AND wpc.use_status = 1
   WHERE up.product_code NOT IN ('NN0005', 'NN00011', 'NN0017')
     AND up.trans_code = 1
     AND up.status = '1'
  union all
  SELECT td.trans_detail_id as INVEST_SRC_ID,
         'trans_detail' as INVEST_SRC_TAB,
         td.user_code as USER_CODE,
         ar.nono_user_id as USER_ID,
         td.product_code as PRODUCT_KEY,
         td.product_code as PRODUCT_CODE,
         from_unixtime(unix_timestamp(CONCAT(td.trans_date,
                                             ' ',
                                             td.trans_time),
                                      'yyyyMMdd HHmmss'),
                       'yyyy-MM-dd HH:mm:ss') as INVEST_TIME,
         td.amount as INVEST_AMT,
         up.REMAINING_PRINCIPAL as REMAINING_PRINCIPAL,
         up.TOTAL_INTEREST as TOTAL_INTEREST,
         up.REMAINING_INTEREST as REMAINING_INTEREST,
         null as EXPECT,
         null as EXPECT_UNIT_CODE,
         up.invest_begin_date as LOCK_BEGIN_TIME,
         up.invest_end_date as LOCK_END_TIME,
         pr.rate as RATE,
         wpc.privilege_amount as DEDUCTIBLE_AMT,
         2 as INVEST_TYPE_CODE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,         
         null INVEST_AMT_YEARLY
    FROM ODS.T_TRANS_DETAIL_HIST td
    JOIN ODS.T_PRODUCT_RATE_HIST pr
      ON td.product_code = pr.product_code
    LEFT JOIN ODS.T_ACCOUNT_RELATION_HIST ar
      ON td.user_code = ar.merchant_user_id
    LEFT JOIN (select REMAINING_PRINCIPAL,
                      TOTAL_INTEREST,
                      REMAINING_INTEREST,
                      invest_begin_date,
                      invest_end_date,
                      order_id,
                      row_number() over(partition by order_id order by user_product_id desc) cn
                 from ODS.t_user_product_hist
                where trans_code = 1
                  and status = '1') up
      on td.order_id = up.order_id
     and up.cn = 1
    LEFT JOIN ODS.t_welfare_privilege_code_hist wpc
      ON td.order_id = wpc.order_id
     AND wpc.welfare_type = 5
     AND wpc.use_status = 1
   WHERE td.status = '2'
     AND td.trans_code IN (1, 8)
     AND td.product_code IN ('NN0005', 'NN00011', 'NN0017');