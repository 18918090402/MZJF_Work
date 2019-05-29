set mapreduce.job.name=msc.zx_price_kc_zxfbd; 
set mapreduce.job.queuename = etl-dw;  

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 

set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict; 
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

--1
drop table  if exists msc.zx_price_st_zfxbd;
create table if not exists msc.zx_price_st_zfxbd
stored as parquet 
as 
select id,
       account_id,
       opposite_account_id,
       operation_relation,
       amount,
       income,
       expend,
       balance,
       create_time,
       bo_id
  from (select id,
               fl.account_id,
               fl.opposite_account_id,
               fl.operation_relation,
               fl.amount,
               fl.income,
               fl.expend,
               fl.balance,
               fl.create_time,
               case
                 when fl.operation_relation in (59, 689) then
                  if(regexp_extract(fl.remark,
                                    '借款([\\d]+)[信用奖励|</a>]',
                                    1) = '',
                     key_value,
                     regexp_extract(fl.remark,
                                    '借款([\\d]+)[信用奖励|</a>]',
                                    1))
                 else
                  coalesce(key_value,
                           regexp_extract(fl.remark, '借款([\\d]+)</a>', 1))
               end bo_id
          from odsopr.finance_log_all fl
         where fl.operation_relation in (59, 184, 702, 689)
           and to_date(fl.create_day) <= '{T_SUB_1}') t
 where t.bo_id <> ''
   and t.id not in (148080342, 150845704, 150872977, 150876497);

--2
drop table if exists  msc.zx_price_st_cw_zfxbd;

create table if not exists msc.zx_price_st_cw_zfxbd
stored as parquet 
as
select t1.*
  from msc.zx_price_st_zfxbd t1
  left join (select a.bo_id, a.all_repayed_time, b.id account_id
               from idw.fact_borrows a
               left join odsopr.finance_account b
                 on a.user_id = b.user_id
                and b.role_id = 7
                and b.owner_id > 0) t2
    on cast(t1.bo_id as bigint) = t2.bo_id
   and t1.opposite_account_id = t2.account_id
 where t2.bo_id is null;

--3
drop table if exists  msc.zx_price_st_xz_zfxbd;

create table if not exists msc.zx_price_st_xz_zfxbd
stored as parquet 
as
select t1.*
  from msc.zx_price_st_zfxbd t1
  left join (select a.bo_id, a.all_repayed_time, b.id account_id
               from idw.fact_borrows a
               left join odsopr.finance_account b
                 on a.user_id = b.user_id
                and b.role_id = 7
                and b.owner_id > 0) t2
    on cast(t1.bo_id as bigint) = t2.bo_id
   and t1.opposite_account_id = t2.account_id
 where t2.bo_id is not null
union all
select t1.*
  from msc.zx_price_st_cw_zfxbd t1
  left join idw.fact_borrows_repayment t2
    on cast(t1.bo_id as bigint) = t2.br_id
  left join (select a.bo_id, a.all_repayed_time, b.id account_id
               from idw.fact_borrows a
               left join odsopr.finance_account b
                 on a.user_id = b.user_id
                and b.role_id = 7
                and b.owner_id > 0) t3
    on t2.bo_id = t3.bo_id
   and t1.opposite_account_id = t3.account_id
 where t3.bo_id is null
union all
select t1.id,
       t1.account_id,
       t1.opposite_account_id,
       t1.operation_relation,
       t1.amount,
       t1.income,
       t1.expend,
       t1.balance,
       t1.create_time,
       cast(t2.bo_id as string) bo_id
  from msc.zx_price_st_cw_zfxbd t1
  left join idw.fact_borrows_repayment t2
    on cast(t1.bo_id as bigint) = t2.br_id
  left join (select a.bo_id, a.all_repayed_time, b.id account_id
               from idw.fact_borrows a
               left join odsopr.finance_account b
                 on a.user_id = b.user_id
                and b.role_id = 7
                and b.owner_id > 0) t3
    on t2.bo_id = t3.bo_id
   and t1.opposite_account_id = t3.account_id
 where t3.bo_id is not null;

 
 
--4
drop table if exists  msc.zx_price_sq_zfxbd;

create table if not exists msc.zx_price_sq_zfxbd
stored as parquet 
as
select bo_id, sum(amount) amount, min(create_time) create_time
  from msc.zx_price_st_xz_zfxbd
 where operation_relation in (184, 702)
 group by bo_id;


 
 
--5 
drop table if exists msc.zx_price_th_zfxbd;

create table if not exists msc.zx_price_th_zfxbd
stored as parquet 
as
select bo_id, min(create_time) create_time
  from msc.zx_price_st_xz_zfxbd
 where operation_relation in (59, 689)
 group by bo_id;
 
 
--6
--drop table msc.zx_price_kc_zfxbd ；

truncate table msc.zx_price_kc_zxfbd ; 
 
create table msc.zx_price_kc_zxfbd
(
    BO_ID BIGINT,
    OPERATION_RELATION BIGINT,
    CREATE_TIME STRING
)
COMMENT '费用扣除快照表'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY")
; 

-- create table if not exists msc.zx_price_kc_zfxbd
--stored as parquet 
--as

insert overwrite table msc.zx_price_kc_zxfbd partition(stat_date)
select bo_id, operation_relation, create_time, '{T_SUB_1}' stat_date
  from (select bo_id,
               operation_relation,
               create_time,
               row_number() over(partition by bo_id order by create_time desc) rn
          from (select case
                         when fl.table_name = 'borrows_repayment' then
                          br.bo_id
                         else
                          cast(fl.key_value as bigint)
                       end bo_id,
                       fl.operation_relation,
                       fl.create_time
                  from odsopr.finance_log_all fl
                  left join idw.fact_borrows_repayment br
                    on fl.table_name = 'borrows_repayment'
                   and cast(fl.key_value as bigint) = br.br_id
                 where fl.operation_relation in (151, 209)
                   and to_date(fl.create_time) >= to_date(date_add(date_sub(trunc('{T_SUB_1}','YEAR'),1),1))
                   and to_date(fl.create_time) <= '{T_SUB_1}'
                   and fl.id <> 1630026343
                union all
                select bo_id, 151 operation_relation, update_time create_time
                  from odsopr.borrows_consulted_fee
                 where zx_state = 2
                   and to_date(create_time) >= to_date(date_add(date_sub(trunc('{T_SUB_1}','YEAR'),1),1))
                   and to_date(create_time) <= '{T_SUB_1}'
                union all
                select bo_id, 
                       case
                         when txn_type = 1 then
                          151
                         when txn_type = 3 then
                          209
                       end operation_relation,
                       create_time
                  from odsopr.borrows_consulted_fee_log
                  where status in (0, 1)
                   and to_date(create_time) >= to_date(date_add(date_sub(trunc('{T_SUB_1}','YEAR'),1),1))
                   and to_date(create_time) <= '{T_SUB_1}'
                   and action <> '退还动作'
                   and txn_type in (1, 3)) t) s
where rn = 1
and operation_relation = 151;


   
--7 
drop table if exists  msc.tmp_zx_price_snapshot_zfxbd;

create table if not exists msc.tmp_zx_price_snapshot_zfxbd
stored as parquet 
as
select cast(t1.bo_id as bigint) bo_id,
       t1.create_time sq_time,
       t1.amount,
       case
         when t5.bo_id is not null then
          '直接收取'
         when t2.bo_id is not null then
          '退还'
         when t4.bo_id is not null then
          '扣除'
         else
          '暂扣'
       end status,
       case
         when t2.bo_id is not null then
          t2.create_time
       end th_time,
       case
         when t2.bo_id is null and t4.bo_id is not null then t4.create_time 
       end kc_time
  from (select * from msc.zx_price_sq_zfxbd  where to_date(create_time) <= '2018-01-31') t1
  left join msc.zx_price_th_zfxbd t2
    on t1.bo_id = t2.bo_id 
  left join  (
      select a.* from (select t.*, row_number() over(partition by t.bo_id order by t.create_time desc ) rn 
    from msc.zx_price_kc_zxfbd t ) a where a.rn = 1 
  ) t4 
    on cast(t1.bo_id as bigint) = t4.bo_id
  left join idw.fact_borrows t5
    on cast(t1.bo_id as bigint) = t5.bo_id
   and t5.p_id = 102;  

   
   
--8   
drop table msc.zx_price_snapshot_zxfbd_xz;
 
--create table if not exists msc.zx_price_snapshot_zxfbd_xz
--stored as parquet 
--as

CREATE TABLE msc.zx_price_snapshot_zxfbd_xz
(
    bo_id bigint, 
    sq_time string, 
    amount decimal(38,10), 
    status string, 
    th_time string, 
    kc_time string
)
COMMENT '余额快照表'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY")
; 

insert overwrite msc.zx_price_snapshot_zxfbd_xz partition(stat_date)
select t1.bo_id,t1.sq_time,t1.amount,
case when b.bo_id is not null then '扣除' else t1.status end status
,t1.th_time,
case when t1.kc_time is not null then t1.kc_time else b.all_repayed_time end kc_time,
'{T_SUB_1}' stat_date   --new
from(
select *
  from msc.tmp_zx_price_snapshot_zfxbd) t1
left join 
(select t1.*,all_repayed_time
  from msc.tmp_zx_price_snapshot_zfxbd t1
  left join idw.fact_borrows t2
    on t1.bo_id = t2.bo_id
   and to_date(t2.all_repayed_time) <= '{T_SUB_1}'
 where t1.status = '暂扣'
   and t2.bo_id is not null) b on t1.bo_id=b.bo_id 
 ;
 
