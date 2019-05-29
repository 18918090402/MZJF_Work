set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_info_01;
set hive.exec.parallel=true;
set hive.auto.convert.join=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table idw.user_info partition
  (stat_date)
  select /*+ mapjoin(r1,r2,r3,r4)*/
         'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         ui.user_id,
         case
           when ui.user_name not like '%&%' then
            regexp_replace(regexp_replace(regexp_replace(ui.user_name,
                                                      '\u0000',
                                                      ''),
                                       '\u0095',
                                       ''),
                        '\u0049',
                        '')
         end user_name,
         case
           when ui.user_id = 772715 then
            null
           when ui.real_name not like '%&%' then
            ui.real_name
         end real_name,
         ui.gender,
         regexp_replace(ui.mobile_num, '\u0000', '') mobile_num,
         ui.email,
         ui.is_email,
         ui.register_time,
         ui.is_authentication,
         ui.is_photo,
         ui.is_education_auth,
         ui.is_student_auth,
         ui.is_special,
         ui.is_cheat,
         ui.status,
         ui.status_desc,
         ui.pc_id,
         ui.recommender_id recommender,
         ui.user_type,
         if(length(ui.id_num) = 15 or length(ui.id_num) = 18,
            ui.id_num,
            null) id_num,
         ui.finance_advisor,
         from_unixtime(unix_timestamp(case
                                        when length(ui.id_num) = 15 then
                                         concat('19', substr(ui.id_num, 7, 6))
                                        when length(ui.id_num) = 18 then
                                         substr(ui.id_num, 7, 8)
                                      end,
                                      'yyyyMMdd'),
                       'yyyy-MM-dd') birthday,
         ms.city mobile_address,
         ms.province mobile_address_province,
         ui.register_biz,
         uid.english_name as english_name,
         year(current_date()) -
         year(from_unixtime(unix_timestamp(case
                                             when length(ui.id_num) = 15 then
                                              concat('19', substr(ui.id_num, 7, 6))
                                             when length(ui.id_num) = 18 then
                                              substr(ui.id_num, 7, 8)
                                           end,
                                           'yyyyMMdd'),
                            'yyyy-MM-dd')) as age,
         uid.constellation as constellation,
         uid.qq as qq,
         uid.cur_phone as current_mobile_no,
         case
           when ui.is_authentication = 1 then
            uad.register_province
         end hj_province,
         case
           when ui.is_authentication = 1 then
            r1.name
         end hj_province_name,
         case
           when ui.is_authentication = 1 then
            uad.register_city
         end hj_city,
         case
           when ui.is_authentication = 1 then
            r2.name
         end hj_city_name,
         uad.register_address as hj_address,
         case
           when uad.current_province regexp '^[0-9]*$' then
            uad.current_province
         end as current_province,
         r3.name as current_province_name,
         case
           when uad.current_city regexp '^[0-9]*$' then
            uad.current_city
         end as current_city,
         r4.name as current_city_name,
         uid.birth_province as birth_province,
         uad.current_address as contact_address,
         uid.marriage_status as marriage_status,
         case uid.marriage_status
           when 1 then
            '已婚'
           when 2 then
            '未婚'
           when 3 then
            '已婚已育'
           when 4 then
            '已婚未育'
           when 5 then
            '未婚已育'
           when 6 then
            '丧偶'
           when 7 then
            '离婚'
           else
            '未知'
         end as marriage_status_desc,
         uid.is_have_passport as is_have_passport,
         uid.is_social_security as is_social_security,
         uid.is_driving_license as is_driving_license,
         uid.house_status as house_status,
         uid.education as education,
         uai.channel_id as channel_id,
         a.am_name as channel_name,
         uai.ad_plan,
         uai.ad_unit,
         uai.channel_detail,
         case
           when uai.referer in ('1', '2', '3', '4') then
            uai.referer
         end register_country_code,
         case uai.referer
           when '1' then
            '美国'
           when '2' then
            '加拿大'
           when '3' then
            '澳大利亚'
           when '4' then
            '英国'
         end register_country_name,
         coalesce(urd.client_type, ual.register_terminal) register_terminal,
         coalesce(urd.ip, ual.register_ip) register_ip,
         uwi.job,
         uwi.current_job_time,
         uwi.total_job_time,
         uwi.company_name,
         uwi.company_type,
         uwi.company_business_type,
         uwi.company_tel,
         uka.approach_code know_approach_code,
         uka.approach_name know_approach_name,
         uwi.company_business_sort,
         uwi.company_address,
         us.spouse_name,
         us.spouse_idnum,
         us.spouse_mobile,
         us.spouse_company,
         uwi.monthly_salary,
         urd.phone_model register_phone_model,
         urd.phone_brand register_phone_brand,
         urd.network register_network,
         fa.id account_id,
         fa.balance - fa.locking balance_amt,
         fa.locking balance_locking_amt,
         fa.balance balance_total_amt,
         ap.account_no hsb_account_no,
         ap.status hsb_status,
         ap.balance hsb_balance,
         ap.freeze_amount hsb_freeze_amount,
         ap.mobile hsb_mobile,
         ap.bank_card hsb_bank_card,
         company_industry as industry,
         date_sub(current_date(), 1) stat_date
    from (select a.id as user_id,
                 a.user_name as user_name,
                 a.real_name as real_name,
                 a.gender as gender,
                 a.mobile_num as mobile_num,
                 a.email as email,
                 a.is_email as is_email,
                 a.register_time as register_time,
                 a.is_card as is_authentication,
                 a.is_photo as is_photo,
                 a.is_education as is_education_auth,
                 a.is_student as is_student_auth,
                 a.is_special as is_special,
                 a.is_cheat as is_cheat,
                 a.status as status,
                 case
                   when a.status = 0 then
                    '无效用户'
                   when a.status = 1 then
                    '有效用户'
                   when a.status = 2 then
                    '锁定用户'
                 end as status_desc,
                 a.pc_id as pc_id,
                 a.recommender as recommender_id,
                 a.user_type,
                 case
                   when a.is_card = 1 then
                    regexp_extract(regexp_replace(id_num, ' ', ''),
                                   '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$',
                                   1)
                 end id_num,
                 a.finance_advisor as finance_advisor,
                 a.biz_code register_biz
            from odsopr.user_info_hist a) ui
    left join (select phone,
                      city,
                      province,
                      row_number() over(partition by phone order by id desc) rn
                 from odsopr.mobile_site_hist) ms
      on substring(ui.mobile_num, 1, 7) = cast(ms.phone as string)
     and ms.rn = 1
    left join odsopr.user_info_detail_hist uid
      on ui.user_id = uid.user_id
    left join odsopr.user_address_info uad
      on ui.user_id = uad.user_id
    left join odsopr.region_hist r1
      on uad.register_province = cast(r1.code as string)
    left join odsopr.region_hist r2
      on uad.register_city = cast(r2.code as string)
    left join odsopr.region_hist r3
      on uad.current_province = cast(r3.code as string)
    left join odsopr.region_hist r4
      on uad.current_city = cast(r4.code as string)
    left join odsopr.user_approach_info_hist uai
      on ui.user_id = uai.user_id
    left join odsopr.admin_hist a
      on uai.channel_id = a.id
    left join odsopr.user_register_detail_log_hist urd
      on ui.user_id = urd.user_id
     and urd.register_status = '0000000'
    left join idw.user_register_action_legacy ual
      on ui.user_id = ual.user_id
    left join (select user_id,
                      job,
                      current_job_time,
                      total_job_time,
                      company_name,
                      company_type,
                      company_business_type,
                      company_tel,
                      company_business_sort,
                      company_address,
                      monthly_salary,
                      company_industry,
                      row_number() over(partition by user_id order by id desc) rn
                 from odsopr.user_work_info_hist) uwi
      on ui.user_id = uwi.user_id
     and uwi.rn = 1
    left join odsopr.user_know_approach_hist uka
      on ui.user_id = uka.user_id
    left join odsopr.user_spouse_info_hist us
      on ui.user_id = us.user_id
    left join odsopr.finance_account_hist fa
      on ui.user_id = fa.owner_id
     and fa.role_id = 7
    left join odsopr.acc_p2p_hist ap
      on ui.user_id = ap.owner_id
     and ap.account_type = 'user';