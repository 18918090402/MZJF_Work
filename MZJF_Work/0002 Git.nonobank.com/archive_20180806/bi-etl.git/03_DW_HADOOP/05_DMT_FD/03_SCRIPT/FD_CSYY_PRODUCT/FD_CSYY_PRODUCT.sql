set mapreduce.job.name = dmt_fd_fd_csyy_product_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.FD_CSYY_PRODUCT
  select cp.PRODUCT_CODE,
         cp.PRODUCT_NAME,
         cp.CATEGORY_CODE_01,
         cp.DW_CREATE_BY,
         cp.DW_CREATE_TIME,
         cp.DW_UPDATE_BY,
         cp.DW_UPDATE_TIME
    from dmt_fd.FD_CSYY_PRODUCT cp
    left join ods.t_product_info_hist p
      on cp.product_code = p.product_code
     and p.DW_UPDATE_TIME >= '{LAST_DATA_TIME}'
   where p.product_code is null
  union all
  SELECT p.product_code PRODUCT_CODE,
         p.product_name PRODUCT_NAME,
         CASE
           WHEN product_code IN ('NN0005', 'NN00011', 'NN0017') THEN
            2
           ELSE
            1
         END CATEGORY_CODE_01,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_product_info_hist p
   WHERE p.DW_UPDATE_TIME >= '{LAST_DATA_TIME}';