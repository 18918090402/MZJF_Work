set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=dmt_crm_bld_user_info_01;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table dmt_crm.bld_user_info partition
  (stat_date)
  select 'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         t1.user_id,
         t1.user_name,
         t1.mobile_num,
         t1.real_name,
         case
           when t1.gender = 1 then
            '男'
           when t1.gender = 2 then
            '女'
           else
            '未知'
         end gender,
         t1.age,
         t1.id_num,
         t1.marriage_status_desc marriage_status,
         t1.hj_province_name,
         t1.hj_city_name,
         t1.job,
         t1.is_education_auth,
         t1.is_student_auth,
         t1.email,
         t1.register_time,
         t1.register_phone_model,
         t1.register_network,
         t1.qq,
         t1.channel_id,
         t1.channel_name,
         t1.monthly_salary,
         t3.monthly_debt,
         t1.stat_date
    from idw.user_info t1
    left join idw.user_tag t2
      on t1.user_id = t2.user_id
     and t2.stat_date = date_sub(current_date(), 1)
    left join idw.user_info_loan_extend t3
      on t1.user_id = t3.user_id
     and t3.stat_date = date_sub(current_date(), 1)
   where (t1.register_biz = 'bld' or t2.bld_first_apply_time is not null)
     and t1.stat_date = date_sub(current_date(), 1);