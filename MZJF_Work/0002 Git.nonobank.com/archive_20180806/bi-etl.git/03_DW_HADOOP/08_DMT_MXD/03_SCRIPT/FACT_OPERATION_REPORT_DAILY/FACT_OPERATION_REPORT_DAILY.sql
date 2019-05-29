set mapreduce.job.name = DMT_MXD_FACT_OPERATION_REPORT_DAILY;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;
SET hive.merge.mapfiles = true;
SET hive.merge.mapredfiles=true;
SET hive.merge.smallfiles.avgsize=1024000000;

--注册用户数-白领贷/名校贷/麦子借款
drop table if exists tmp.tmp_register_user_01;
create table tmp.tmp_register_user_01 as
select 
to_date(register_time) as stat_date
,sum(case when register_biz='mxd' then 1 else 0 end) as register_user_cnt_mxd
,sum(case when register_biz='bld' then 1 else 0 end) as register_user_cnt_bld
,sum(case when register_biz='mzjk' then 1 else 0 end) as register_user_cnt_mzjk
from idw.dim_user
where register_biz in('mxd','bld','mzjk')
and to_date(register_time)>='{LAST_DATA_TIME}'
group by to_date(register_time)
;

--注册用户数-h5
drop table if exists tmp.tmp_register_user_02;
create table tmp.tmp_register_user_02 as
select 
to_date(register_time) as stat_date
,count(user_id) as register_user_cnt_h5
from idw.dim_user
where register_terminal='h5'
and to_date(register_time)>='{LAST_DATA_TIME}'
group by to_date(register_time)
;

--实名认证用户数
drop table if exists tmp.tmp_real_name_user_01;
create table tmp.tmp_real_name_user_01 as
select to_date(auth_time) stat_date
,count(distinct user_id) as real_name_user_cnt_mzjk --实名认证用户数-麦子借款
from ods.t_user_zhima_auth_log_hist
where to_date(auth_time)>='{LAST_DATA_TIME}'
group by to_date(auth_time)
;

--授信提交用户数
drop table if exists tmp.tmp_sx_submit_user_01;
create table tmp.tmp_sx_submit_user_01 as
select to_date(b.stat_date) as stat_date
,count(distinct case when (a.first_bo_success_time is null or b.stat_date=a.first_bo_success_time) and a.register_terminal='h5' then a.user_id end) as sx_submit_user_new_h5--H5注册且新客
,count(distinct case when a.first_bo_success_time is not null and b.stat_date>a.first_bo_success_time then a.user_id end) as sx_submit_user_old--老客
,count(distinct case when (a.first_bo_success_time is null or b.stat_date<=a.first_bo_success_time) then a.user_id end) as sx_submit_user_new --新客
,count(distinct a.user_id) sx_submit_user_cnt --授信提交用户数
from idw.dim_user as a
inner join(
select create_time as stat_date
,user_id
,'mzjk' as type
from ods.t_des_user_credit_hist
where to_date(create_time)>='{LAST_DATA_TIME}'
union all
select create_time as stat_date
,user_id
,'bld' as type
from ods.t_user_pengyuan_edu_record_hist
where to_date(create_time)>='{LAST_DATA_TIME}'
) b on a.user_id=b.user_id
where (a.register_terminal='h5'
or a.register_biz in('mxd','bld','mzjk')
) group by to_date(b.stat_date) 
;

--授信成功用户数
drop table if exists tmp.tmp_sx_success_user_01;
create table tmp.tmp_sx_success_user_01 as
select to_date(b.stat_date) as stat_date
,count(distinct case when a.first_bo_success_time is not null and b.stat_date>a.first_bo_success_time then a.user_id end) as sx_success_user_old--授信成功老客
,count(distinct case when (a.first_bo_success_time is null or b.stat_date<=a.first_bo_success_time) then a.user_id end) as sx_success_user_new--授信成功新客
,count(distinct a.user_id) sx_success_user_cnt--授信成功用户数
from idw.dim_user as a
inner join(
select create_time as stat_date
,user_id
,'mzjk' as type
from ods.t_borrows_credit_amount_hist
where to_date(create_time)>='{LAST_DATA_TIME}'
union all
select create_time as stat_date
,user_id
,'mzjk' as type
from ods.t_borrows_lightning_credit_amount_hist
where to_date(create_time)>='{LAST_DATA_TIME}'
union all
select create_time as stat_date
,user_id
,'bld' as type
from ods.t_user_profile_info_hist
where to_date(create_time)>='{LAST_DATA_TIME}'
and attribute_name='userCreditRank'
and attribute_value is not null
) b on a.user_id=b.user_id
where (a.register_terminal='h5'
or a.register_biz in('mxd','bld','mzjk')
) group by to_date(b.stat_date)
;

--提额用户数
drop table if exists tmp.tmp_promote_user_01;
create table tmp.tmp_promote_user_01 as
select
to_date(create_time) as stat_date
,count(distinct user_id) as promote_user_cnt
from ods.t_borrows_credit_promote_amount_hist
where to_date(create_time)>='{LAST_DATA_TIME}'
group by to_date(create_time)
;

--借款申请用户数
drop table if exists tmp.tmp_apply_user_01;
create table tmp.tmp_apply_user_01 as
SELECT to_date(a.create_time) AS stat_date
,COUNT(distinct a.user_id) AS apply_user_cnt --借款申请用户数
,count(distinct case when a.p_id IN(110,111) then a.user_id end) as apply_user_cnt_mzjk--借款申请用户数-麦子借款
,count(distinct case when a.p_id IN(87) then a.user_id end) as apply_user_cnt_bld--借款申请用户数-白领贷
,count(distinct case when a.p_id IN(77,83,84,88,99,102) then a.user_id end) as apply_user_cnt_mxd--借款申请用户数-名校贷
,count(distinct case when b.first_bo_success_time is not null and a.create_time>b.first_bo_success_time then a.user_id end) as apply_user_cnt_old--借款申请用户数-老客
,count(distinct case when (b.first_bo_success_time is null or a.create_time<=b.first_bo_success_time) then a.user_id end) as apply_user_cnt_new--借款申请用户数-新客
FROM ods.t_borrows_prepare_hist as a
inner join idw.dim_user as b
on a.user_id=b.user_id
WHERE a.p_id IN(110,111,77,83,84,87,88,99,102)
and to_date(a.create_time)>='{LAST_DATA_TIME}'
GROUP BY to_date(a.create_time)
;

--进件用户数
drop table if exists tmp.tmp_ml_user_01;
create table tmp.tmp_ml_user_01 as
SELECT to_date(a.ml_time) AS stat_date
,COUNT(distinct a.user_id) AS ml_user_cnt --进件用户数
,count(distinct case when a.p_id IN(110,111) then a.user_id end) as ml_user_cnt_mzjk--进件用户数-麦子借款
,count(distinct case when a.p_id IN(87) then a.user_id end) as ml_user_cnt_bld--进件用户数-白领贷
,count(distinct case when a.p_id IN(77,83,84,88,99,102) then a.user_id end) as ml_user_cnt_mxd--进件用户数-名校贷
,count(distinct case when b.first_bo_success_time is not null and a.ml_time>b.first_bo_success_time then a.user_id end) as ml_user_cnt_old--进件用户数-老客
,count(distinct case when (b.first_bo_success_time is null or a.ml_time<=b.first_bo_success_time) then a.user_id end) as ml_user_cnt_new--进件用户数-新客
FROM idw.FACT_BORROWS_AUDIT as a
inner join idw.dim_user as b
on a.user_id=b.user_id
WHERE a.p_id IN(110,111,77,83,84,87,88,99,102)
and to_date(a.ml_time)>='{LAST_DATA_TIME}'
GROUP BY to_date(a.ml_time)
;

--放款用户数
drop table if exists tmp.tmp_confirm_user_01;
create table tmp.tmp_confirm_user_01 as
SELECT to_date(a.confirm_pass_time) AS stat_date
,COUNT(distinct a.user_id) AS confirm_user_cnt --放款用户数
,count(distinct case when a.p_id IN(110,111) then a.user_id end) as confirm_user_cnt_mzjk--放款用户数-麦子借款
,count(distinct case when a.p_id IN(87) then a.user_id end) as confirm_user_cnt_bld--放款用户数-白领贷
,count(distinct case when a.p_id IN(77,83,84,88,99,102) then a.user_id end) as confirm_user_cnt_mxd--放款用户数-名校贷
,count(distinct case when b.first_bo_success_time is not null and a.confirm_pass_time>b.first_bo_success_time then a.user_id end) as confirm_user_cnt_old--放款用户数-老客
,count(distinct case when (b.first_bo_success_time is null or a.confirm_pass_time<=b.first_bo_success_time) then a.user_id end) as confirm_user_cnt_new--放款用户数-新客
,count(distinct case when a.p_id IN(110,111) and b.first_bo_success_time is not null and a.confirm_pass_time>b.first_bo_success_time then a.user_id end) as confirm_user_cnt_mzjk_old--放款用户数-麦子借款老客
,count(distinct case when a.p_id IN(110,111) and (b.first_bo_success_time is null or a.confirm_pass_time<=b.first_bo_success_time) then a.user_id end) as confirm_user_cnt_mzjk_new--放款用户数-麦子借款新客
,count(distinct case when a.p_id IN(87) and b.first_bo_success_time is not null and a.confirm_pass_time>b.first_bo_success_time then a.user_id end) as confirm_user_cnt_bld_old--放款用户数-白领贷老客
,count(distinct case when a.p_id IN(87) and (b.first_bo_success_time is null or a.confirm_pass_time<=b.first_bo_success_time) then a.user_id end) as confirm_user_cnt_bld_new--放款用户数-白领贷新客
,count(distinct case when a.p_id IN(77,83,84,88,99,102) and b.first_bo_success_time is not null and a.confirm_pass_time>b.first_bo_success_time then a.user_id end) as confirm_user_cnt_mxd_old--放款用户数-名校贷老客
,count(distinct case when a.p_id IN(77,83,84,88,99,102) and (b.first_bo_success_time is null or a.confirm_pass_time<=b.first_bo_success_time) then a.user_id end) as confirm_user_cnt_mxd_new--放款用户数-名校贷新客
FROM idw.FACT_BORROWS as a
inner join idw.dim_user as b
on a.user_id=b.user_id
WHERE a.p_id IN(110,111,77,83,84,87,88,99,102)
and to_date(a.confirm_pass_time)>='{LAST_DATA_TIME}'
GROUP BY to_date(a.confirm_pass_time)
;

insert overwrite table DMT_MXD.FACT_OPERATION_REPORT_DAILY partition(stat_date) 
select 
'SYS' AS DW_CREATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
,'SYS' AS DW_UPDATE_BY
,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
,register_user_cnt_h5--注册用户数-H5
,register_user_cnt_mxd--注册用户数-白领贷
,register_user_cnt_bld--注册用户数-名校贷
,register_user_cnt_mzjk--注册用户数-麦子借款
,real_name_user_cnt_mzjk --实名认证用户数-麦子借款
,0 as real_name_user_cnt_bld --实名认证用户数-麦子借款
,real_name_user_cnt_mzjk as  real_name_user_cnt--实名认证用户数
,sx_submit_user_new_h5--授信提交用户数-H5注册且新客
,sx_submit_user_old--授信提交用户数-老客
,sx_submit_user_new --授信提交用户数-新客
,sx_submit_user_cnt --授信提交用户数
,sx_success_user_old--授信成功老客
,sx_success_user_new--授信成功新客
,sx_success_user_cnt--授信成功用户数
,promote_user_cnt--提额用户数
,apply_user_cnt --借款申请用户数
,apply_user_cnt_mzjk--借款申请用户数-麦子借款
,apply_user_cnt_bld--借款申请用户数-白领贷
,apply_user_cnt_mxd--借款申请用户数-名校贷
,apply_user_cnt_old--借款申请用户数-老客
,apply_user_cnt_new--借款申请用户数-新客
,ml_user_cnt --进件用户数
,ml_user_cnt_mzjk--进件用户数-麦子借款
,ml_user_cnt_bld--进件用户数-白领贷
,ml_user_cnt_mxd--进件用户数-名校贷
,ml_user_cnt_old--进件用户数-老客
,ml_user_cnt_new--进件用户数-新客
,confirm_user_cnt --放款用户数
,confirm_user_cnt_mzjk--放款用户数-麦子借款
,confirm_user_cnt_bld--放款用户数-白领贷
,confirm_user_cnt_mxd--放款用户数-名校贷
,confirm_user_cnt_old--放款用户数-老客
,confirm_user_cnt_new--放款用户数-新客
,confirm_user_cnt_mzjk_old--放款用户数-麦子借款老客
,confirm_user_cnt_mzjk_new--放款用户数-麦子借款新客
,confirm_user_cnt_bld_old--放款用户数-白领贷老客
,confirm_user_cnt_bld_new--放款用户数-白领贷新客
,confirm_user_cnt_mxd_old--放款用户数-名校贷老客
,confirm_user_cnt_mxd_new--放款用户数-名校贷新客
,day_short_desc as stat_date
from idw.dim_date as a
left join tmp.tmp_register_user_01 as t
on a.day_short_desc=t.stat_date
left join tmp.tmp_register_user_02 as t1
on a.day_short_desc=t1.stat_date
left join tmp.tmp_sx_submit_user_01 as t2
on a.day_short_desc=t2.stat_date
left join tmp.tmp_sx_success_user_01 as t3
on a.day_short_desc=t3.stat_date
left join tmp.tmp_promote_user_01 as t4
on a.day_short_desc=t4.stat_date
left join tmp.tmp_apply_user_01 as t5
on a.day_short_desc=t5.stat_date
left join tmp.tmp_ml_user_01 as t6
on a.day_short_desc=t6.stat_date
left join tmp.tmp_confirm_user_01 as t7
on a.day_short_desc=t7.stat_date
left join tmp.tmp_real_name_user_01 as t8
on a.day_short_desc=t8.stat_date
where day_short_desc>='{LAST_DATA_TIME}'
and day_short_desc<'{T}'
;