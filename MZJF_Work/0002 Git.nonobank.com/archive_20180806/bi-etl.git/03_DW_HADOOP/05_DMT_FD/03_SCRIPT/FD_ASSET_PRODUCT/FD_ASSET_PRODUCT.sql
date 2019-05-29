set mapreduce.job.name = dmt_fd_fd_asset_product_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.fd_asset_product
  select ap.P_ID,
         ap.P_NAME,
         ap.BUSI_LINE,
         ap.DW_CREATE_BY,
         ap.DW_CREATE_TIME,
         ap.DW_UPDATE_BY,
         ap.DW_UPDATE_TIME
    from dmt_fd.fd_asset_product ap
    left join ods.t_products_hist p
      on ap.p_id = p.id
     and p.DW_UPDATE_TIME >= '{LAST_DATA_TIME}'
   where p.id is null
  union all
  SELECT p.id P_ID,
         p.p_name P_NAME,
         CASE
           WHEN p.id IN (77, 83, 87, 88) THEN
            '名校贷'
           WHEN p.id = 86 THEN
            '大房东'
           WHEN p.id = 92 THEN
            '非标'
           WHEN p.id = 93 THEN
            '过桥'
           WHEN p.id IN (94, 97) THEN
            'Unifi'
           WHEN p.id = 96 THEN
            '麦芽分期'
           ELSE
            '融易贷'
         END BUSI_LINE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_products_hist p
   WHERE p.DW_UPDATE_TIME >= '{LAST_DATA_TIME}';