set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=DMT_MXD_FACT_MXD_CHANNEL_COST_DETAIL_01;

drop table if exists tmp.tmp_fact_mxd_channel_cost_01;
create table if not exists tmp.tmp_fact_mxd_channel_cost_01
stored as parquet 
as
select acc.id,
       acc.channel_id,
       ac1.channel_name,
       acc.channel_cost,
       acc.channel_plan,
       acc.channel_unit,
       acc.channel_detail,
       acc.channel_owner,
       acp.total_channel_id,
       ac2.channel_name total_channel_name,
       ac1.channel_type,
       ac1.channel_type_2,
       ac1.channel_type_3,
       ac1.channel_type_4,
       acc.ads_start_date,
       acc.ads_end_date,
       acp.proportion_rate,
       is_detail,
       if(acp.total_channel_id is null, 0, 1) is_proportion
  from odsopr.ADS_CHANNEL_COST acc
  left join odsopr.ADS_CHANNEL_PROPORTION acp
    on acc.channel_id = acp.channel_id
   and acc.ads_start_date = acp.start_date
   and acc.ads_end_date = acp.end_date
   and acc.channel_platform_name = acp.channel_platform_name
   and acp.is_enable = 1
  left join odsopr.ADS_CHANNEL ac1
    on acc.channel_id = ac1.channel_id
   and acc.channel_platform_name = ac1.channel_platform_name
  left join odsopr.ADS_CHANNEL ac2
    on acp.total_channel_id = ac2.channel_id
   and acp.channel_platform_name = ac2.channel_platform_name
 where acc.is_enable = 1
   and acc.channel_platform_name = '名校贷';

set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=DMT_MXD_FACT_MXD_CHANNEL_COST_DETAIL_02;   

drop table if exists tmp.tmp_fact_mxd_channel_cost_02;
create table if not exists tmp.tmp_fact_mxd_channel_cost_02
stored as parquet 
as
select t1.id, ui.id user_id, to_date(ui.register_time) register_date
  from ods.t_user_info_hist ui
  join ods.t_user_approach_info_hist uai
    on ui.id = uai.user_id
  join tmp.tmp_fact_mxd_channel_cost_01 t1
    on uai.channel_id = t1.channel_id
   and t1.is_detail = '是'
   and t1.channel_plan = uai.ad_plan
   and t1.channel_unit = uai.ad_unit
   and t1.channel_detail = uai.channel_detail
 where to_date(ui.register_time) >= t1.ads_start_date
   and to_date(ui.register_time) <= t1.ads_end_date
union all
select t1.id, ui.id user_id, to_date(ui.register_time) register_date
  from ods.t_user_info_hist ui
  join ods.t_user_approach_info_hist uai
    on ui.id = uai.user_id
  join tmp.tmp_fact_mxd_channel_cost_01 t1
    on uai.channel_id = t1.channel_id
   and t1.is_detail = '否'
   and t1.is_proportion = 0
 where to_date(ui.register_time) >= t1.ads_start_date
   and to_date(ui.register_time) <= t1.ads_end_date;

set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=DMT_MXD_FACT_MXD_CHANNEL_COST_DETAIL_03;  
 
drop table if exists tmp.tmp_fact_mxd_channel_cost_03;  
create table if not exists tmp.tmp_fact_mxd_channel_cost_03
stored as parquet 
as
select ui.id user_id,
       to_date(ui.register_time) register_date,
       t1.total_channel_id,
       t1.ads_start_date,
       t1.ads_end_date,
       row_number() over(partition by t1.total_channel_id, t1.ads_start_date, t1.ads_end_date order by ui.id) rn
  from ods.t_user_info_hist ui
  join ods.t_user_approach_info_hist uai
    on ui.id = uai.user_id
  join (select total_channel_id, ads_start_date, ads_end_date
          from tmp.tmp_fact_mxd_channel_cost_01
         where is_proportion = 1
         group by total_channel_id, ads_start_date, ads_end_date) t1
    on uai.channel_id = t1.total_channel_id
 where to_date(ui.register_time) >= t1.ads_start_date
   and to_date(ui.register_time) <= t1.ads_end_date;

set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=DMT_MXD_FACT_MXD_CHANNEL_COST_DETAIL_04;     

drop table if exists tmp.tmp_fact_mxd_channel_cost_04;   
create table if not exists tmp.tmp_fact_mxd_channel_cost_04
stored as parquet 
as
select t1.id,
       t1.total_channel_id,
       t1.ads_start_date,
       t1.ads_end_date,
       floor(cnt * t1.proportion_rate) cnt,
       sum(floor(cnt * t1.proportion_rate)) over(PARTITION BY t1.total_channel_id, t1.ads_start_date, t1.ads_end_date ORDER BY t1.channel_id) range_end
  from tmp.tmp_fact_mxd_channel_cost_01 t1
  join (select total_channel_id, ads_start_date, ads_end_date, count(1) cnt
          from tmp.tmp_fact_mxd_channel_cost_03
         group by total_channel_id, ads_start_date, ads_end_date) t2
    on t1.total_channel_id = t2.total_channel_id
   and t1.ads_start_date = t2.ads_start_date
   and t1.ads_end_date = t2.ads_end_date;

set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=DMT_MXD_FACT_MXD_CHANNEL_COST_DETAIL_05;     
   
insert into tmp.tmp_fact_mxd_channel_cost_02
  select t1.id, t2.user_id, t2.register_date
    from tmp.tmp_fact_mxd_channel_cost_04 t1
    join tmp.tmp_fact_mxd_channel_cost_03 t2
      on t1.total_channel_id = t2.total_channel_id
     and t1.ads_start_date = t2.ads_start_date
     and t1.ads_end_date = t2.ads_end_date
   where t2.rn >= t1.range_end - t1.cnt + 1
     and t2.rn <= t1.range_end;

set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=DMT_MXD_FACT_MXD_CHANNEL_COST_DETAIL_06; 

insert overwrite table DMT_MXD.FACT_MXD_CHANNEL_COST_DETAIL
  select t1.user_id,
         t1.register_date,
         t3.mxd_education EDUCATION,
         t2.channel_id,
         t2.channel_name,
         t2.ads_start_date,
         t2.ads_end_date,
         t2.channel_plan,
         t2.channel_unit,
         t2.channel_detail,
         t2.channel_owner,
         t2.total_channel_id,
         t2.total_channel_name,
         t2.channel_type,
         t2.channel_type_2,
         t2.channel_type_3,
         t2.channel_type_4,
         t2.channel_cost / (count(*) over(partition by t2.id)) avg_cost,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    from tmp.tmp_fact_mxd_channel_cost_02 t1
    join tmp.tmp_fact_mxd_channel_cost_01 t2
      on t1.id = t2.id
    join idw.dim_user t3
      on t1.user_id = t3.user_id;