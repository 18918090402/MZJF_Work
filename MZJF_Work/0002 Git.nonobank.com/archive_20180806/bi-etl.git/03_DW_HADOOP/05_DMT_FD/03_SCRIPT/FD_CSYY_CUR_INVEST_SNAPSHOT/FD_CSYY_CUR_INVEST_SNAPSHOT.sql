set mapreduce.job.name = dmt_fd_fd_csyy_cur_invest_snapshot_01;
set mapreduce.job.queuename = etl-dw;

drop table if exists TMP.TMP_DMT_FD_FD_CSYY_CUR_INVEST_SNAPSHOT_01;
create table if not exists TMP.TMP_DMT_FD_FD_CSYY_CUR_INVEST_SNAPSHOT_01
(
   STAT_DATE            string comment '日期',
   USER_ID              bigint comment '用户ID',
   USER_CODE            bigint comment '用户编号',
   PRODUCT_CODE         string comment '产品编码',
   BALANCE              decimal(38,10) comment '金额',
   RATE                 decimal(38,10) comment '利率',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '财神爷爷活期在投信息临时表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");

set mapreduce.job.name = dmt_fd_fd_csyy_cur_invest_snapshot_02;
set mapreduce.job.queuename = etl-dw;

insert into TMP.TMP_DMT_FD_FD_CSYY_CUR_INVEST_SNAPSHOT_01
  SELECT '{T_SUB_1}' STAT_DATE,
         coalesce(ar.nono_user_id, -99998888) USER_ID,
         up.user_code USER_CODE,
         up.product_code PRODUCT_CODE,
         SUM(up.remaining_principal) BALANCE,
         pr.rate RATE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_user_product_hist up
    JOIN ods.t_product_rate_hist pr
      ON up.product_code = pr.product_code
    LEFT JOIN ods.t_account_relation_hist ar
      ON up.user_code = ar.merchant_user_id
   WHERE up.trans_code = 1
     AND up.status = '1'
     AND up.product_code IN ('NN0005', 'NN00011', 'NN0017')
     AND up.remaining_principal > 0
     AND up.user_code <> 999999999
   GROUP BY up.user_code, ar.nono_user_id, up.product_code, pr.rate;

set mapreduce.job.name = dmt_fd_fd_csyy_cur_invest_snapshot_03;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.fd_csyy_cur_invest_snapshot
  select cis.STAT_DATE,
         ar.nono_user_id USER_ID,
         cis.USER_CODE,
         cis.PRODUCT_CODE,
         cis.BALANCE,
         cis.RATE,
         cis.DW_CREATE_BY,
         cis.DW_CREATE_TIME,
         cis.DW_UPDATE_BY,
         case
           when cis.user_id <> ar.nono_user_id then
            from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss')
           else
            cis.DW_UPDATE_TIME
         end DW_UPDATE_TIME
    from dmt_fd.fd_csyy_cur_invest_snapshot cis
    left join TMP.TMP_DMT_FD_FD_CSYY_CUR_INVEST_SNAPSHOT_01 tmp1
      on cis.STAT_DATE = tmp1.STAT_DATE
     and cis.USER_CODE = tmp1.USER_CODE
    left join ods.t_account_relation_hist ar
      ON cis.user_code = ar.merchant_user_id
   where tmp1.STAT_DATE is null
  union all
  select tmp1.STAT_DATE,
         tmp1.USER_ID,
         tmp1.USER_CODE,
         tmp1.PRODUCT_CODE,
         tmp1.BALANCE,
         tmp1.RATE,
         tmp1.DW_CREATE_BY,
         tmp1.DW_CREATE_TIME,
         tmp1.DW_UPDATE_BY,
         tmp1.DW_UPDATE_TIME
    FROM TMP.TMP_DMT_FD_FD_CSYY_CUR_INVEST_SNAPSHOT_01 tmp1;

set mapreduce.job.name = dmt_fd_fd_csyy_cur_invest_snapshot_04;
set mapreduce.job.queuename = etl-dw;

drop table if exists TMP.TMP_DMT_FD_FD_CSYY_CUR_INVEST_SNAPSHOT_01;