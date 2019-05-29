set mapreduce.job.name = dmt_fd_fd_nono_product_01;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.FD_NONO_PRODUCT
  SELECT p.FP_KEY,
         p.FP_ID,
         p.FP_NAME,
         p.LOCKING_DAY,
         p.RATE_LIST,
         p.CATEGORY_CODE_01,
         p.CATEGORY_CODE_02,
         p.CATEGORY_NAME_02,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM idw.dim_nono_product p;