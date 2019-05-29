set mapreduce.job.name = idw_dim_csyy_product_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table IDW.DIM_CSYY_PRODUCT
  select cp.PRODUCT_KEY,
         cp.PRODUCT_CODE,
         cp.PRODUCT_NAME,
         cp.PRICE_MIN,
         cp.PRICE_MAX,
         cp.PRICE_INCREMENT,
         cp.RATE,
         cp.LOCKING_DAY,
         cp.RATE_LIST,
         cp.CATEGORY_CODE_01,
         cp.DW_CREATE_BY,
         cp.DW_CREATE_TIME,
         cp.DW_UPDATE_BY,
         cp.DW_UPDATE_TIME
    from IDW.DIM_CSYY_PRODUCT cp
    left join ods.t_product_info_hist p
      on cp.product_code = p.product_code
     and p.DW_UPDATE_TIME >= '{LAST_DATA_TIME}'
   where p.product_code is null
  union all
  SELECT p.product_code as PRODUCT_KEY,
         p.product_code as PRODUCT_CODE,
         p.product_name as PRODUCT_NAME,
         pu.invest_amount_min as PRICE_MIN,
         pu.invest_amount_max as PRICE_MAX,
         pu.per_copy_amount PRICE_INCREMENT,
         CASE
           WHEN pr.product_rate_id IN (13, 14, 15, 16) THEN
            7.30 + pr.rate
           WHEN pr.product_rate_id IN (6, 7, 8, 9, 12) THEN
            8.88 + pr.rate
           ELSE
            pr.rate
         END RATE,
         pd.lock_day as LOCKING_DAY,
         pd.fee_rate as RATE_LIST,
         CASE
           WHEN p.product_code IN ('NN0005', 'NN00011', 'NN0017') THEN
            2
           ELSE
            1
         END CATEGORY_CODE_01,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_product_info_hist p
    LEFT JOIN ods.t_product_rate_hist pr
      ON p.product_code = pr.product_code
    LEFT JOIN ods.t_product_rule_hist pu
      ON p.product_code = pu.product_code
    left join 
        (select product_code,fee_rate,lock_day,update_date
        from (
        select product_code,fee_rate,lock_day,update_date,
        row_number()over(partition by product_code order by update_date desc) as n
        from ods.t_product_info_detail_hist
        where product_code in ('NN0018')) ta 
        where n=1) pd
    on p.product_code = pd.product_code
   WHERE p.DW_UPDATE_TIME >= '{LAST_DATA_TIME}';
   