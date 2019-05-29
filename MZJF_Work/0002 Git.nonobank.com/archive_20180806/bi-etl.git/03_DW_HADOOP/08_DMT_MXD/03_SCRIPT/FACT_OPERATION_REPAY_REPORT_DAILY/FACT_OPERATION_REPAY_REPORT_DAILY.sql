set mapreduce.job.name = DMT_MXD_FACT_OPERATION_REPAY_REPORT_DAILY;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;
SET hive.merge.mapfiles = true;
SET hive.merge.mapredfiles=true;
SET hive.merge.smallfiles.avgsize=1024000000;

insert overwrite table DMT_MXD.FACT_OPERATION_REPAY_REPORT_DAILY partition(stat_date) 
select 
'SYS' AS DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
,'SYS' AS DW_UPDATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
,b.p_id --产品PID
,sum(case when a.br_time='{T_SUB_1}' and a.br_overdue_terms>0 then 1 else 0 end) as first_overdue_repay_cnt--首还逾期笔数
,sum(case when a.br_time='{T_SUB_1}' and a.br_overdue_terms>0 then a.br_price else 0 end) as first_overdue_repay_price--首还逾期金额
,sum(case when a.br_time='{T_SUB_1}' then 1 else 0 end) as first_repay_cnt--首还笔数
,sum(case when a.br_time='{T_SUB_1}' then a.br_price else 0 end) as first_repay_price--首还金额
,sum(case when a.br_time=date_sub('{T_SUB_1}',6) and a.br_overdue_terms>0 then 1 else 0 end) as first7_overdue_repay_cnt--T-7首还逾期笔数
,sum(case when a.br_time=date_sub('{T_SUB_1}',6) and a.br_overdue_terms>0 then a.br_price else 0 end) as first7_overdue_repay_price--T-7首还逾期金额
,sum(case when a.br_time=date_sub('{T_SUB_1}',6) then 1 else 0 end) as first7_repay_cnt--T-7首还笔数
,sum(case when a.br_time=date_sub('{T_SUB_1}',6) then a.br_price else 0 end) as first7_repay_price--T-7首还金额
,'{T_SUB_1}' as stat_date
from odsopr.borrows_repayment as a
inner join odsopr.borrows as b
on a.bo_id=b.id
where a.br_expect_num=1
and b.p_id IN(110,111,77,83,84,87,88,99,102)
and a.br_time>=date_sub('{T_SUB_1}',7)
group by b.p_id
;