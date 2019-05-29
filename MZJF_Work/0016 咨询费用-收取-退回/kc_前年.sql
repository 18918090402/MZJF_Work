
--1
drop table  if exists tmp.zx_price_st_zfxbd;

create table if not exists tmp.zx_price_st_zfxbd
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
           and to_date(fl.create_day) <= '2016-12-31') t
 where t.bo_id <> ''
   and t.id not in (148080342, 150845704, 150872977, 150876497);

--2
drop table if exists  tmp.zx_price_st_cw_zfxbd;

create table if not exists tmp.zx_price_st_cw_zfxbd
stored as parquet 
as
select t1.*
  from tmp.zx_price_st_zfxbd t1
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
drop table if exists  tmp.zx_price_st_xz_zfxbd;

create table if not exists tmp.zx_price_st_xz_zfxbd
stored as parquet 
as
select t1.*
  from tmp.zx_price_st_zfxbd t1
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
  from tmp.zx_price_st_cw_zfxbd t1
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
  from tmp.zx_price_st_cw_zfxbd t1
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
drop table if exists  tmp.zx_price_sq_zfxbd;

create table if not exists tmp.zx_price_sq_zfxbd
stored as parquet 
as
select bo_id, sum(amount) amount, min(create_time) create_time
  from tmp.zx_price_st_xz_zfxbd
 where operation_relation in (184, 702)
 group by bo_id;


 
 
--5 
drop table if exists tmp.zx_price_th_zfxbd;

create table if not exists tmp.zx_price_th_zfxbd
stored as parquet 
as
select bo_id, min(create_time) create_time
  from tmp.zx_price_st_xz_zfxbd
 where operation_relation in (59, 689)
 group by bo_id;
 
 
--6
--drop table tmp.zx_price_kc_zfxbd ；

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

-- create table if not exists tmp.zx_price_kc_zfxbd
--stored as parquet 
--as

insert overwrite msc.zx_price_kc_zxfbd partition(stat_date)
select bo_id, operation_relation, create_time, '2016-12-31' stat_date
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
                   --and to_date(fl.create_time) >= to_date(date_add(date_sub(trunc('2016-12-31','YEAR'),1),1))
                   and to_date(fl.create_time) <= '2016-12-31'
                   and fl.id <> 1630026343
                union all
                select bo_id, 151 operation_relation, update_time create_time
                  from odsopr.borrows_consulted_fee
                 where zx_state = 2
                   --and to_date(create_time) >= to_date(date_add(date_sub(trunc('2016-12-31','YEAR'),1),1))
                   and to_date(create_time) <= '2016-12-31'
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
                   --and to_date(create_time) >= to_date(date_add(date_sub(trunc('2016-12-31','YEAR'),1),1))
                   and to_date(create_time) <= '2016-12-31'
                   and action <> '退还动作'
                   and txn_type in (1, 3)) t) s
where rn = 1
and operation_relation = 151;

