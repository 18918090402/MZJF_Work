set mapreduce.job.name = idw_fact_nono_user_cost_01_01;
set mapreduce.job.queuename = etl-dw;

drop table if exists TMP.TMP_IDW_FACT_NONO_USER_COST_01_01;
create table if not exists TMP.TMP_IDW_FACT_NONO_USER_COST_01_01
(
   COST_DATE            string comment '成本发生日期',
   USER_ID              bigint comment '用户ID',
   COST_TYPE_CODE       int comment '成本类型 1:线下 2:线上 ',
   COST_CATEGORY_CODE   int comment '费用分类 1:现金券 2:加息券 3:红包 4:磅客大使',
   CHANNEL_ID           bigint comment '渠道ID',
   CHANNEL_NAME         string comment '渠道名称',
   CHANNEL_TYPE         string comment '渠道类型',
   COST_AMT             decimal(38,10) comment '金额',
   COST_SRC_ID          bigint comment '成本源表ID',
   COST_SRC_TAB         string comment '成本源表名',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '诺诺用户成本临时表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");

set mapreduce.job.name = idw_fact_nono_user_cost_01_02;
set mapreduce.job.queuename = etl-dw;

drop table if exists TMP.TMP_IDW_FACT_NONO_USER_COST_01_02;
create table TMP.TMP_IDW_FACT_NONO_USER_COST_01_02 as 
select user_id, invest_time
  from (select user_id,
               invest_time,
               row_number() over(partition by user_id order by invest_time) as rn
          from idw.FACT_NONO_INVEST_ORDER t
         where t.status in (1, 2)) x
 where rn = 1;

set mapreduce.job.name = idw_fact_nono_user_cost_01_03;
set mapreduce.job.queuename = etl-dw; 

drop table if exists TMP.TMP_IDW_FACT_NONO_USER_COST_01_03;
create table TMP.TMP_IDW_FACT_NONO_USER_COST_01_03 as
select t1.id,
       t1.channel_id,
       t1.channel_cost,
       ui.id user_id,
       ui.register_time
  from (select ccw.id,
               ccw.week_start,
               nc.channel_id sub_channel_id,
               ccw.channel_id,
               ccw.channel_cost
          from ods.t_nnbk_ads_channel_cost_weekly_hist ccw
          join ods.t_nnbk_ads_channel_hist nc
            on ccw.channel_id =
               coalesce(nc.parent_channel_id, nc.channel_id)
           and ccw.week_start >= date_sub('{LAST_DATA_TIME}', 40)) t1
  join ods.t_user_approach_info_hist uai
    on t1.sub_channel_id = uai.channel_id
  join ods.t_user_info_hist ui
    on uai.user_id = ui.id
  join TMP.TMP_IDW_FACT_NONO_USER_COST_01_02 tmp2
    on ui.id = tmp2.user_id
 where ui.register_time >= t1.week_start
   and ui.register_time < date_add(t1.week_start, 7)
   and date_add(ui.register_time, 90) >= tmp2.invest_time;

set mapreduce.job.name = idw_fact_nono_user_cost_01_04;
set mapreduce.job.queuename = etl-dw;

INSERT INTO TMP.TMP_IDW_FACT_NONO_USER_COST_01_01
  select to_date(t3.register_time) COST_DATE,
         t3.user_id USER_ID,
         1 COST_TYPE_CODE,
         null COST_CATEGORY_CODE,
         t3.channel_id CHANNEL_ID,
         nc.channel_name CHANNEL_NAME,
         nc.channel_type CHANNEL_TYPE,
         t1.COST_AMT,
         t3.id COST_SRC_ID,
         'nnbk_ads_channel_cost_weekly' COST_SRC_TAB,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    from (select tmp3.id, tmp3.channel_cost / count(1) COST_AMT
            from TMP.TMP_IDW_FACT_NONO_USER_COST_01_03 tmp3
           group by tmp3.id, tmp3.channel_cost) t1
    join TMP.TMP_IDW_FACT_NONO_USER_COST_01_03 t3
      on t1.id = t3.id
    join ods.t_nnbk_ads_channel_hist nc
      on t3.channel_id = nc.channel_id;

set mapreduce.job.name = idw_fact_nono_user_cost_01_05;
set mapreduce.job.queuename = etl-dw;

insert overwrite table idw.FACT_NONO_USER_COST
  select uc.COST_DATE,
         uc.USER_ID,
         uc.COST_TYPE_CODE,
         uc.COST_CATEGORY_CODE,
         uc.CHANNEL_ID,
         uc.CHANNEL_NAME,
         uc.CHANNEL_TYPE,
         uc.COST_AMT,
         uc.COST_SRC_ID,
         uc.COST_SRC_TAB,
         uc.DW_CREATE_BY,
         uc.DW_CREATE_TIME,
         uc.DW_UPDATE_BY,
         uc.DW_UPDATE_TIME
    from idw.FACT_NONO_USER_COST uc
    left join TMP.TMP_IDW_FACT_NONO_USER_COST_01_01 tmp1
      on uc.COST_DATE = tmp1.COST_DATE
     and uc.USER_ID = tmp1.USER_ID
     and uc.CHANNEL_ID = tmp1.CHANNEL_ID
   where tmp1.COST_DATE is null
  union all
  SELECT tmp1.COST_DATE,
         tmp1.USER_ID,
         tmp1.COST_TYPE_CODE,
         tmp1.COST_CATEGORY_CODE,
         tmp1.CHANNEL_ID,
         tmp1.CHANNEL_NAME,
         tmp1.CHANNEL_TYPE,
         tmp1.COST_AMT,
         tmp1.COST_SRC_ID,
         tmp1.COST_SRC_TAB,
         tmp1.DW_CREATE_BY,
         tmp1.DW_CREATE_TIME,
         tmp1.DW_UPDATE_BY,
         tmp1.DW_UPDATE_TIME
    FROM TMP.TMP_IDW_FACT_NONO_USER_COST_01_01 tmp1;

set mapreduce.job.name = idw_fact_nono_user_cost_01_06;
set mapreduce.job.queuename = etl-dw;

drop table if exists TMP.TMP_IDW_FACT_NONO_USER_COST_01_01;
drop table if exists TMP.TMP_IDW_FACT_NONO_USER_COST_01_02;
drop table if exists TMP.TMP_IDW_FACT_NONO_USER_COST_01_03;