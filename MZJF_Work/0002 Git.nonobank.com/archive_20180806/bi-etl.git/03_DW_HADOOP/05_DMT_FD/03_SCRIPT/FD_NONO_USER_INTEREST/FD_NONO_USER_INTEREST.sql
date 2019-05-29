set mapreduce.job.name = dmt_fd_fd_nono_user_interest_01;
set mapreduce.job.queuename = etl-dw;

drop table if exists TMP.TMP_DMT_FD_FD_NONO_USER_INTEREST_01;
create table if not exists TMP.TMP_DMT_FD_FD_NONO_USER_INTEREST_01
(
   SRC_ID               BIGINT COMMENT '源表ID',
   SRC_TAB              string COMMENT '源表名',
   USER_ID              BIGINT COMMENT '用户ID',
   FP_KEY               BIGINT COMMENT '计划代理键',
   FP_ID                BIGINT COMMENT '计划ID',
   INTEREST_AMT         DECIMAL(38,10) COMMENT '收益金额',
   INTEREST_DATE        string COMMENT '收益日期',
   DW_INVEST_RELATION_NO string COMMENT '投资关联编号 散投、债转:前置_(USER_ID)_(BO_ID) 精选:前置_(USER_ID)_(FP_ID) e诺千金:前置_(USER_ID)_(DT_ID) 前置规则为01:散投、债转 02:精选 03:e诺千金',
   DW_CREATE_BY         string COMMENT '系统字段-创建者',
   DW_CREATE_TIME       string COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         string COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       string COMMENT '系统字段-修改时间')
COMMENT '诺诺用户收益信息临时表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");

set mapreduce.job.name = dmt_fd_fd_nono_user_interest_02;
set mapreduce.job.queuename = etl-dw;

insert into TMP.TMP_DMT_FD_FD_NONO_USER_INTEREST_01
  select fl.id SRC_ID,
         'finance_log' SRC_TAB,
         fl.user_id USER_ID,
         va.fp_id FP_KEY,
         va.fp_id FP_ID,
         fl.amount INTEREST_AMT,
         fl.create_time INTEREST_DATE,
         CONCAT_WS('_',
                   '02',
                   CAST(fl.user_id AS STRING),
                   CAST(va.fp_id AS STRING)) DW_INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    from odsopr.finance_log_all fl
    join odsopr.finance_account fa
      on fl.opposite_account_id = fa.id
    join odsopr.vip_account va
      on fa.owner_id = va.id
   where fl.operation_relation = 122
     and fl.table_name = 'vip_account'
     and fl.DW_UPDATE_TIME >= '{LAST_DATA_TIME}';

 
set mapreduce.job.name = dmt_fd_fd_nono_user_interest_03;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.fd_nono_user_interest
  select nui.SRC_ID,
         nui.SRC_TAB,
         nui.USER_ID,
         nui.FP_KEY,
         nui.FP_ID,
         nui.INTEREST_AMT,
         nui.INTEREST_DATE,
         nui.DW_INVEST_RELATION_NO,
         nui.DW_CREATE_BY,
         nui.DW_CREATE_TIME,
         nui.DW_UPDATE_BY,
         nui.DW_UPDATE_TIME
    from dmt_fd.fd_nono_user_interest nui
    left join TMP.TMP_DMT_FD_FD_NONO_USER_INTEREST_01 tmp1
      on nui.SRC_ID = tmp1.SRC_ID
     and nui.SRC_TAB = tmp1.SRC_TAB
   where tmp1.SRC_ID is null
  union all
  select tmp1.SRC_ID,
         tmp1.SRC_TAB,
         tmp1.USER_ID,
         tmp1.FP_KEY,
         tmp1.FP_ID,
         tmp1.INTEREST_AMT,
         tmp1.INTEREST_DATE,
         tmp1.DW_INVEST_RELATION_NO,
         tmp1.DW_CREATE_BY,
         tmp1.DW_CREATE_TIME,
         tmp1.DW_UPDATE_BY,
         tmp1.DW_UPDATE_TIME
    FROM TMP.TMP_DMT_FD_FD_NONO_USER_INTEREST_01 tmp1;

set mapreduce.job.name = dmt_fd_fd_nono_user_interest_04;
set mapreduce.job.queuename = etl-dw;

drop table if exists TMP.TMP_DMT_FD_FD_NONO_USER_INTEREST_01;