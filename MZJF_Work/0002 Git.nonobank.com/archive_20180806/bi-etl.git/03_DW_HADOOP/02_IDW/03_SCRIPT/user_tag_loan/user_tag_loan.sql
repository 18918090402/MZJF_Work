set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_tag_loan_01;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table idw.user_tag_loan partition
  (stat_date)
  select 'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         user_id,
         max(case
               when tag_id = 134 then
                cast(tag_value as string)
             end) as stu_auth_time,
         max(case
               when tag_id = 135 then
                cast(tag_value as string)
             end) as edu_auth_time,
         max(case
               when tag_id = 297 then
                cast(tag_value as string)
             end) as edu_education,
         max(case
               when tag_id = 298 then
                cast(tag_value as string)
             end) as edu_graduate_time,
         max(case
               when tag_id = 140 then
                cast(tag_value as int)
             end) as sesame_number,
         max(case
               when tag_id = 141 then
                cast(tag_value as string)
             end) as phone_online_time,
         max(case
               when tag_id = 142 then
                cast(tag_value as int)
             end) as is_gjj_submit,
         max(case
               when tag_id = 143 then
                cast(tag_value as string)
             end) as gjj_submit_time,
         max(case
               when tag_id = 144 then
                cast(tag_value as int)
             end) as is_sb_submit,
         max(case
               when tag_id = 145 then
                cast(tag_value as string)
             end) as sb_submit_time,
         max(case
               when tag_id = 146 then
                cast(tag_value as int)
             end) as tongdun_score,
         max(case
               when tag_id = 147 then
                cast(tag_value as string)
             end) as user_credit_rank,
         max(case
               when tag_id = 210 then
                cast(tag_value as int)
             end) as is_black_gray,
         max(case
               when tag_id = 139 then
                cast(tag_value as int)
             end) as max_overdue_days,
         max(case
               when tag_id = 182 then
                cast(tag_value as string)
             end) as first_bo_apply_time,
         max(case
               when tag_id = 287 then
                cast(tag_value as string)
             end) as first_ml_time,
         max(case
               when tag_id = 138 then
                cast(tag_value as string)
             end) as first_bo_success_time,
         max(case
               when tag_id = 288 then
                cast(tag_value as string)
             end) as first_actual_bo_time,
         max(case
               when tag_id = 224 then
                cast(tag_value as int)
             end) as mld_credit_apply_cnt,
         max(case
               when tag_id = 225 then
                cast(tag_value as int)
             end) as mld_bo_success_cnt,
         max(case
               when tag_id = 263 then
                cast(tag_value as decimal(38, 10))
             end) as base_amt_110,
         max(case
               when tag_id = 264 then
                cast(tag_value as decimal(38, 10))
             end) as increase_amt_110,
         max(case
               when tag_id = 265 then
                cast(tag_value as decimal(38, 10))
             end) as total_amt_110,
         max(case
               when tag_id = 266 then
                cast(tag_value as decimal(38, 10))
             end) as used_amt_110,
         max(case
               when tag_id = 290 then
                cast(tag_value as int)
             end) as base_amount_type_110,
         max(case
               when tag_id = 267 then
                cast(tag_value as decimal(38, 10))
             end) as amt_111,
         max(case
               when tag_id = 278 then
                cast(tag_value as int)
             end) as has_not_depository_overdue_debt,
         date_sub(current_date(), 1) stat_date
    from idw.user_tag_hist
   where tag_id in (134,
                    135,
                    297,
                    298,
                    140,
                    141,
                    142,
                    143,
                    144,
                    145,
                    146,
                    147,
                    210,
                    139,
                    182,
                    287,
                    138,
                    288,
                    224,
                    225,
                    263,
                    264,
                    265,
                    266,
                    290,
                    267,
                    278)
     and user_id > 0
   group by user_id;