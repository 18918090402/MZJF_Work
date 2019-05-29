set mapreduce.job.name = idw_dim_asset_product_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table idw.DIM_ASSET_PRODUCT
  SELECT p.id P_KEY,
         p.id P_ID,
         p.p_code P_CODE,
         p.p_type P_TYPE,
         p.p_name P_NAME,
         p.p_pay_type P_PAY_TYPE,
         p.p_accept_type P_ACCEPT_TYPE,
         p.p_expect P_EXPECT,
         p.p_delay_month P_DELAY_MONTH,
         p.p_assure_type P_ASSURE_TYPE,
         p.p_approach P_APPROACH,
         p.p_price_min P_PRICE_MIN,
         p.p_price_max P_PRICE_MAX,
         p.p_compensation P_COMPENSATION,
         p.p_compensation_overdue P_COMPENSATION_OVERDUE,
         p.p_enabled P_ENABLED,
         p.p_creator P_CREATOR,
         p.p_updator P_UPDATOR,
         p.create_time CREATE_TIME,
         p.update_time UPDATE_TIME,
         pc.category_name CATEGORY_NAME_01,
         pc.biz_code BIZ_CODE_01,
         pc.biz_name BIZ_NAME_01,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM odsopr.products p
    left join odsopr.dim_asset_product_category pc
      on p.id = pc.p_id;