set mapreduce.job.name=DMT_RM_FACT_USER_CONTACT_02; 
set mapreduce.job.queuename = etl-dw;  

set hive.exec.parallel=true ;
set hive.map.aggr = true ; 

set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict; 
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

DROP TABLE IF EXISTS TMP.DMT_RM_FACT_USER_CONTACT_02;
CREATE TABLE TMP.DMT_RM_FACT_USER_CONTACT_02
-- 所有标的情况（用户ID，通讯录号码个数，联系人是否在通讯录里）
as 
select 
a.user_id,
count(distinct bo.user_id) BO_USER_CNT,
count(bo.id) BO_CNT,
count(case when bo.bo_is_success=1 then bo.id end) BO_S_CNT,
count(c.bo_id) BO_OVER_DUE_CNT
from 
idw.dim_user_contact_list a
inner join 
ODS.T_user_info_hist  ui 
on nvl(a.phone_no,'-1')=nvl(ui.mobile_num,'1') and a.phone_no<>''
left join ODS.T_borrows_hist  bo 
on ui.id=bo.user_id
left join 
(
select bo_id
from 
(
select user_id,ba.id as ba_id,ba.bo_id,
  cast(br_time as string)br_time,
  cast(nvl(FROM_UNIXTIME(UNIX_TIMESTAMP(ba.br_repay_time),'yyyy-MM-dd '),FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd ')) as string) br_repay_time
from ods.t_borrows_repayment_hist ba
  ) a
where (UNIX_TIMESTAMP(br_repay_time)-UNIX_TIMESTAMP(br_time))/60.0/1440>60
group by bo_id
  ) c
  on bo.id=c.bo_id
group by user_id
;








