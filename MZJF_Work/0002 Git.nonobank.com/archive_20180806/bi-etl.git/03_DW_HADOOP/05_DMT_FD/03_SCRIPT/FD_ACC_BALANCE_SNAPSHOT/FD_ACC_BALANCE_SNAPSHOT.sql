set mapreduce.job.name = dmt_fd_fd_acc_balance_snapshot_01;
set mapreduce.job.queuename = etl-dw;

drop table if exists TMP.TMP_DMT_FD_FD_ACC_BALANCE_SNAPSHOT_01;
create table if not exists TMP.TMP_DMT_FD_FD_ACC_BALANCE_SNAPSHOT_01
(
  STAT_DATE string COMMENT '日期',
  ACC_NAME string COMMENT '账户名称',
  ACC_BALANCE decimal(38,10) COMMENT '账户余额',
  DW_CREATE_BY string COMMENT '系统字段-创建者',
  DW_CREATE_TIME string COMMENT '系统字段-创建时间',
  DW_UPDATE_BY string COMMENT '系统字段-修改者',
  DW_UPDATE_TIME string COMMENT '系统字段-修改时间')
COMMENT '账户余额信息临时表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");

set mapreduce.job.name = dmt_fd_fd_acc_balance_snapshot_02;
set mapreduce.job.queuename = etl-dw;

insert into TMP.TMP_DMT_FD_FD_ACC_BALANCE_SNAPSHOT_01
  SELECT '{T_SUB_1}' STAT_DATE,
         CASE
           WHEN a.role_id IN (6, 24) THEN
            '风险备付金账户'
           WHEN a.role_id IN (23) THEN
            '预收咨询费账户'
           ELSE
            '收入账户'
         END ACC_NAME,
         SUM(a.balance - a.locking) ACC_BALANCE,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM ods.t_finance_account_hist a
    LEFT JOIN ods.t_platform_company_hist c
      ON c.id = a.owner_id
   WHERE a.role_id IN (4,
                       23,
                       24,
                       25,
                       8,
                       9,
                       11,
                       17,
                       22,
                       30,
                       32,
                       39,
                       48,
                       12,
                       18,
                       28,
                       33,
                       38,
                       45,
                       46,
                       6,
                       52,
                       56,
                       54,
                       55)
     AND coalesce(c.id, 5) IN (5, 18)
   GROUP BY CASE
              WHEN a.role_id IN (6, 24) THEN
               '风险备付金账户'
              WHEN a.role_id IN (23) THEN
               '预收咨询费账户'
              ELSE
               '收入账户'
            END;

set mapreduce.job.name = dmt_fd_fd_acc_balance_snapshot_03;
set mapreduce.job.queuename = etl-dw;

insert overwrite table dmt_fd.fd_acc_balance_snapshot
  select ab.STAT_DATE,
         ab.ACC_NAME,
         ab.ACC_BALANCE,
         ab.DW_CREATE_BY,
         ab.DW_CREATE_TIME,
         ab.DW_UPDATE_BY,
         ab.DW_UPDATE_TIME
    from dmt_fd.fd_acc_balance_snapshot ab
    left join TMP.TMP_DMT_FD_FD_ACC_BALANCE_SNAPSHOT_01 tmp1
      on ab.STAT_DATE = tmp1.STAT_DATE
     and ab.ACC_NAME = tmp1.ACC_NAME
   where tmp1.STAT_DATE is null
  union all
  select tmp1.STAT_DATE,
         tmp1.ACC_NAME,
         tmp1.ACC_BALANCE,
         tmp1.DW_CREATE_BY,
         tmp1.DW_CREATE_TIME,
         tmp1.DW_UPDATE_BY,
         tmp1.DW_UPDATE_TIME
    FROM TMP.TMP_DMT_FD_FD_ACC_BALANCE_SNAPSHOT_01 tmp1;

set mapreduce.job.name = dmt_fd_fd_acc_balance_snapshot_04;
set mapreduce.job.queuename = etl-dw;

drop table if exists TMP.TMP_DMT_FD_FD_ACC_BALANCE_SNAPSHOT_01;