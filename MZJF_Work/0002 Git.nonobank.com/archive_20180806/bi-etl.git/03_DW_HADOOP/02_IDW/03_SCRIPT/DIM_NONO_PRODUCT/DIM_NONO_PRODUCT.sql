set mapreduce.job.name = idw_dim_nono_product_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table idw.dim_nono_product
  SELECT fp.id FP_KEY,
         fp.id FP_ID,
         fp.title FP_NAME,
         fp.price_min PRICE_MIN,
         fp.price_max PRICE_MAX,
         fp.price_increment PRICE_INCREMENT,
         fp.rate_min RATE_MIN,
         fp.rate_max RATE_MAX,
         fp.publish_date PUBLISH_DATE,
         fp.finish_date FINISH_DATE,
         fp.expect EXPECT,
         CASE
           WHEN fp.expect_unit = 0 THEN
            2
           ELSE
            fp.expect_unit
         END EXPECT_UNIT,
         fp.start_date START_DATE,
         fp.use_coupon USE_COUPON_CODE,
         fp.collection_mode COLLECTION_MODE_CODE,
         ifp.locking_day LOCKING_DAY,
         ifp.rate_all RATE_LIST,
         1 CATEGORY_CODE_01,
         fp.scope CATEGORY_CODE_02,
         fps.label CATEGORY_NAME_02,
         'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_finance_plan_hist fp
    LEFT JOIN ods.t_finance_plan_scope_hist fps
      ON fp.scope = fps.id
    LEFT JOIN ods.t_invt_finance_plan_stage_info_hist ifp
      ON fp.scope = 15
     AND fp.id = ifp.fp_id;