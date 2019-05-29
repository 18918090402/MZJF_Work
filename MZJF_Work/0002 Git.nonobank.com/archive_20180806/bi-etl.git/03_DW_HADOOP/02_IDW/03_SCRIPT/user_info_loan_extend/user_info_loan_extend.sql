set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_info_loan_extend_01;
set hive.exec.parallel=true;
set hive.auto.convert.join=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table idw.user_info_loan_extend partition
  (stat_date)
  select /*+ mapjoin(r1,r2)*/
         'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         ui.id user_id,
         CASE
           WHEN usi.education regexp '专科以下|初中|高中|中专' THEN
            '专科以下'
           WHEN usi.education regexp '专科|大专' THEN
            '专科'
           when usi.education regexp '专升本|大学本科|本科' THEN
            '本科'
           when usi.education regexp '博士|博士研究生' THEN
            '博士'
           when usi.education regexp '研究生|硕士及以上|硕士研究生' THEN
            '硕士'
           ELSE
            'NA'
         end stu_education,
         if(regexp_extract(usi.edu_start_date, '^([0-9]{4}).*', 1) = '',
            null,
            CONCAT(regexp_extract(usi.edu_start_date, '^([0-9]{4}).*', 1),
                   '-09-01')) stu_start_date,
         case
           when usi.edu_graduate_date regexp
            '^(\\d)*$' and length(usi.EDU_GRADUATE_DATE) = 8 then
            concat(substr(usi.edu_graduate_date, 1, 4),
                   '-',
                   substr(usi.edu_graduate_date, 5, 2),
                   '-',
                   substr(usi.edu_graduate_date, 7, 2))
           when usi.edu_graduate_date regexp
            '^(\\d){4}\\-(\\d){2}\\-(\\d){2}$' then
            usi.edu_graduate_date
         end stu_graduate_date,
         usi.is_graduate stu_is_graduate,
         usi.academy stu_academy,
         usi.campus stu_campus,
         usi.major stu_major,
         usi.student_no stu_student_no,
         ss.type stu_school_type,
         case
           when ss.type = '4' then
            '专科'
           when ss.type < '4' then
            concat(ss.type, '本')
           else
            ss.type
         end stu_school_type_desc,
         ss.province_id stu_school_province_id,
         r1.name stu_school_province_name,
         if(ss.city_id = 0, null, ss.city_id) stu_school_city_id,
         r2.name stu_school_city_name,
         if(usi.campus_approach = 0, null, usi.campus_approach) campus_approach,
         case usi.campus_approach
           when 1 then
            '网络搜索'
           when 2 then
            '校园大使'
           when 3 then
            '朋友介绍'
           when 4 then
            '微博'
           when 5 then
            '微信'
           when 6 then
            '贴吧/论坛'
           when 7 then
            'QQ群'
           when 8 then
            '海报/宣传品'
           when 9 then
            '展柜/活动'
           when 10 then
            '其他'
           else
            null
         end campus_approach_desc,
         usi.family_income,
         case usi.family_income
           when 0 then
            '未设置'
           when 1 then
            '5万以下'
           when 3 then
            '10-20万'
           when 4 then
            '20万以上'
         end family_income_desc,
         usi.address_home,
         bdc.instructor_name,
         bdc.instructor_mobile,
         bdc.instructor_mobile_state,
         bdc.instructor_mobile_address,
         bdc.parent_name,
         bdc.parent_mobile,
         bdc.parent_mobile_state,
         bdc.parent_mobile_address,
         bdc.friend1_name,
         bdc.friend1_mobile,
         bdc.friend1_mobile_state,
         bdc.friend1_mobile_address,
         bdc.friend2_name,
         bdc.friend2_mobile,
         bdc.friend2_mobile_state,
         bdc.friend2_mobile_address,
         bdc.friend3_name,
         bdc.friend3_mobile,
         bdc.friend3_mobile_state,
         bdc.friend3_mobile_address,
         case
           when ulin.monthly_debt = '' then
            null
           else
            ulin.monthly_debt
         end monthly_debt,
         date_sub(current_date(), 1) stat_date
    from odsopr.user_info_hist ui
    left join odsopr.user_student_info_hist usi
      on ui.id = usi.user_id
    left join (select name,
                      province_id,
                      city_id,
                      type,
                      row_number() over(partition by name order by id desc) rn
                 from odsopr.student_school_hist) ss
      on usi.academy = ss.name
     and ss.rn = 1
    left join odsopr.region_hist r1
      on ss.province_id = r1.code
    left join odsopr.region_hist r2
      on ss.city_id = r2.code
    left join (select t1.user_id,
                      max(if(t1.groupkwd = '辅导员' and t1.kind = 1,
                             t1.value,
                             null)) instructor_name,
                      max(if(t1.groupkwd = '辅导员' and t1.kind = 2,
                             t1.value,
                             null)) instructor_mobile,
                      max(if(t1.groupkwd = '辅导员' and t1.kind = 2,
                             t1.call_state,
                             null)) instructor_mobile_state,
                      max(if(t1.groupkwd = '辅导员' and t1.kind = 2,
                             t2.city,
                             null)) instructor_mobile_address,
                      max(if(t1.groupkwd = '父母' and t1.kind = 1,
                             t1.value,
                             null)) parent_name,
                      max(if(t1.groupkwd = '父母' and t1.kind = 2,
                             t1.value,
                             null)) parent_mobile,
                      max(if(t1.groupkwd = '父母' and t1.kind = 2,
                             t1.call_state,
                             null)) parent_mobile_state,
                      max(if(t1.groupkwd = '父母' and t1.kind = 2,
                             t2.city,
                             null)) parent_mobile_address,
                      max(if(t1.groupkwd = '好友1' and t1.kind = 1,
                             t1.value,
                             null)) friend1_name,
                      max(if(t1.groupkwd = '好友1' and t1.kind = 2,
                             t1.value,
                             null)) friend1_mobile,
                      max(if(t1.groupkwd = '好友1' and t1.kind = 2,
                             t1.call_state,
                             null)) friend1_mobile_state,
                      max(if(t1.groupkwd = '好友1' and t1.kind = 2,
                             t2.city,
                             null)) friend1_mobile_address,
                      max(if(t1.groupkwd = '好友2' and t1.kind = 1,
                             t1.value,
                             null)) friend2_name,
                      max(if(t1.groupkwd = '好友2' and t1.kind = 2,
                             t1.value,
                             null)) friend2_mobile,
                      max(if(t1.groupkwd = '好友2' and t1.kind = 2,
                             t1.call_state,
                             null)) friend2_mobile_state,
                      max(if(t1.groupkwd = '好友2' and t1.kind = 2,
                             t2.city,
                             null)) friend2_mobile_address,
                      max(if(t1.groupkwd = '好友3' and t1.kind = 1,
                             t1.value,
                             null)) friend3_name,
                      max(if(t1.groupkwd = '好友3' and t1.kind = 2,
                             t1.value,
                             null)) friend3_mobile,
                      max(if(t1.groupkwd = '好友3' and t1.kind = 2,
                             t1.call_state,
                             null)) friend3_mobile_state,
                      max(if(t1.groupkwd = '好友3' and t1.kind = 2,
                             t2.city,
                             null)) friend3_mobile_address
                 from odsopr.borrows_dunning_contact_hist t1
                 left join odsopr.mobile_site_hist t2
                   on t1.kind = 2
                  and SUBSTRING(t1.value, 1, 7) = CAST(t2.phone AS string)
                where t1.groupkwd IN
                      ('辅导员', '父母', '好友1', '好友2', '好友3')
                  and t1.kind in (1, 2)
                group by t1.user_id) bdc
      on ui.id = bdc.user_id
    left join odsopr.user_loan_info_new_hist ulin
      on ui.id = ulin.user_id;