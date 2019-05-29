set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=IDW_FACT_USER_INFO_01;
set hive.exec.parallel=true;
set hive.auto.convert.join=true;

insert overwrite table idw.fact_user_info
  select /*+ mapjoin(r1,r2,r3,r4,r5,r6,r7)*/
   'SYS' as dw_create_by,
   from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
   'SYS' as dw_update_by,
   from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
   ui.USER_ID,
   case
     when ui.user_name not like '%&%' then
      user_name
   end USER_NAME,
   ui.REAL_NAME,
   ui.GENDER,
   ui.MOBILE_NUM,
   ui.EMAIL,
   ui.IS_EMAIL,
   ui.REGISTER_TIME,
   ui.IS_AUTHENTICATION,
   ui.IS_PHOTO,
   ui.IS_EDUCATION_AUTH,
   ui.IS_STUDENT_AUTH,
   ui.IS_SPECIAL,
   ui.IS_CHEAT,
   ui.STATUS,
   ui.STATUS_DESC,
   ui.PC_ID,
   pc.COMP_NAME PC_ID_DESC,
   ui.RECOMMENDER_ID RECOMMENDER,
   ui.USER_TYPE,
   if(length(ui.id_num) = 15 or length(ui.id_num) = 18, ui.id_num, null) ID_NUM,
   if(length(ui.id_num) = 15 or length(ui.id_num) = 18,
      cil.COU_ADDRESS,
      null) COU_ADDRESS,
   ui.FINANCE_ADVISOR,
   from_unixtime(unix_timestamp(case
                                  when length(ui.id_num) = 15 then
                                   concat('19', substr(ui.id_num, 7, 6))
                                  when length(ui.id_num) = 18 then
                                   substr(ui.id_num, 7, 8)
                                end,
                                'yyyyMMdd'),
                 'yyyy-MM-dd') BIRTHDAY,
   ms.city MOBILE_ADDRESS,
   ms.province MOBILE_ADDRESS_PROVINCE,
   ui.REGISTER_BIZ,
   uid.ENGLISH_NAME AS ENGLISH_NAME,
   if(uid.AGE > 0 and uid.AGE < 100, uid.AGE, null) AS AGE,
   uid.CONSTELLATION AS CONSTELLATION,
   uid.QQ AS QQ,
   uid.CUR_PHONE AS CURRENT_MOBILE_NO,
   uad.REGISTER_PROVINCE AS HJ_PROVINCE,
   r1.name AS HJ_PROVINCE_NAME,
   uad.REGISTER_CITY AS HJ_CITY,
   r2.name AS HJ_CITY_NAME,
   uad.REGISTER_ADDRESS AS HJ_ADDRESS,
   case
     when uad.CURRENT_PROVINCE regexp '^[0-9]*$' then
      uad.CURRENT_PROVINCE
   end AS CURRENT_PROVINCE,
   r3.name AS CURRENT_PROVINCE_NAME,
   case
     when uad.CURRENT_CITY regexp '^[0-9]*$' then
      uad.CURRENT_CITY
   end AS CURRENT_CITY,
   r4.name AS CURRENT_CITY_NAME,
   uid.BIRTH_PROVINCE AS BIRTH_PROVINCE,
   r5.name AS BIRTH_PROVINCE_NAME,
   uad.CURRENT_ADDRESS AS CONTACT_ADDRESS,
   uid.MARRIAGE_STATUS AS MARRIAGE_STATUS,
   CASE uid.MARRIAGE_STATUS
     WHEN 1 THEN
      '已婚'
     WHEN 2 THEN
      '未婚'
     WHEN 3 THEN
      '已婚已育'
     WHEN 4 THEN
      '已婚未育'
     WHEN 5 THEN
      '未婚已育'
     WHEN 6 THEN
      '丧偶'
     WHEN 7 THEN
      '离婚'
     ELSE
      '未知'
   END AS MARRIAGE_STATUS_DESC,
   uid.IS_HAVE_PASSPORT AS IS_HAVE_PASSPORT,
   uid.IS_SOCIAL_SECURITY AS IS_SOCIAL_SECURITY,
   uid.IS_DRIVING_LICENSE AS IS_DRIVING_LICENSE,
   uid.HOUSE_STATUS AS HOUSE_STATUS,
   uid.EDUCATION AS EDUCATION,
   uai.CHANNEL_ID AS CHANNEL_ID,
   a.AM_NAME AS CHANNEL_NAME,
   uai.AD_PLAN,
   uai.AD_UNIT,
   uai.CHANNEL_DETAIL,
   case
     when uai.referer in ('1', '2', '3', '4') then
      uai.referer
   end UNIFI_REGISTER_COUNTRY_CODE,
   case uai.referer
     when '1' then
      '美国'
     when '2' then
      '加拿大'
     when '3' then
      '澳大利亚'
     when '4' then
      '英国'
   end UNIFI_REGISTER_COUNTRY_NAME,
   coalesce(urd.client_type, ual.terminal) REGISTER_TERMINAL,
   coalesce(urd.ip, ual.REGISTER_IP) REGISTER_IP,
   ul.LEVEL USER_RANK,
   CASE ul.LEVEL
     WHEN 0 THEN
      '普通会员'
     WHEN 1 THEN
      'VIP1'
     WHEN 2 THEN
      'VIP2'
     WHEN 3 THEN
      'VIP3'
   END AS USER_RANK_DESC,
   if(regexp_extract(usi.edu_start_date, '^([0-9]{4}).*', 1) = '',
      null,
      CONCAT(regexp_extract(usi.edu_start_date, '^([0-9]{4}).*', 1),
             '-09-01')) edu_start_date,
   case
     when usi.EDU_GRADUATE_DATE regexp
      '^(\\d)*$' and length(usi.EDU_GRADUATE_DATE) = 8 then
      concat(substr(usi.EDU_GRADUATE_DATE, 1, 4),
             '-',
             substr(usi.EDU_GRADUATE_DATE, 5, 2),
             '-',
             substr(usi.EDU_GRADUATE_DATE, 7, 2))
     when usi.EDU_GRADUATE_DATE regexp '^(\\d){4}\\-(\\d){2}\\-(\\d){2}$' then
      usi.EDU_GRADUATE_DATE
   end edu_graduate_date,
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
      '(未知)'
   end mxd_education,
   usi.academy,
   usi.major,
   usi.is_graduate,
   if(usi.campus_approach = 0, null, usi.campus_approach) CAMPUS_APPROACH,
   CASE usi.campus_approach
     WHEN 1 THEN
      '网络搜索'
     WHEN 2 THEN
      '校园大使'
     WHEN 3 THEN
      '朋友介绍'
     WHEN 4 THEN
      '微博'
     WHEN 5 THEN
      '微信'
     WHEN 6 THEN
      '贴吧/论坛'
     WHEN 7 THEN
      'QQ群'
     WHEN 8 THEN
      '海报/宣传品'
     WHEN 9 THEN
      '展柜/活动'
     WHEN 10 THEN
      '其他'
     ELSE
      NULL
   END CAMPUS_APPROACH_DESC,
   usi.student_no,
   usi.campus,
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
   ss.type SCHOOL_TYPE,
   CASE
     WHEN ss.type = '4' THEN
      '专科'
     WHEN ss.type < '4' THEN
      CONCAT(ss.type, '本')
     ELSE
      ss.type
   END SCHOOL_TYPE_DESC,
   ss.province_id SCHOOL_PROVINCE_ID,
   r6.name SCHOOL_PROVINCE_NAME,
   if(ss.city_id = 0, null, ss.city_id) SCHOOL_CITY_ID,
   r7.name SCHOOL_CITY_NAME,
   usi.address_home,
   bdc.INSTRUCTOR_NAME,
   bdc.INSTRUCTOR_MOBILE,
   bdc.INSTRUCTOR_MOBILE_STATE,
   bdc.INSTRUCTOR_MOBILE_ADDRESS,
   bdc.PARENT_NAME,
   bdc.PARENT_MOBILE,
   bdc.PARENT_MOBILE_STATE,
   bdc.PARENT_MOBILE_ADDRESS,
   bdc.FRIEND1_NAME,
   bdc.FRIEND1_MOBILE,
   bdc.FRIEND1_MOBILE_STATE,
   bdc.FRIEND1_MOBILE_ADDRESS,
   bdc.FRIEND2_NAME,
   bdc.FRIEND2_MOBILE,
   bdc.FRIEND2_MOBILE_STATE,
   bdc.FRIEND2_MOBILE_ADDRESS,
   bdc.FRIEND3_NAME,
   bdc.FRIEND3_MOBILE,
   bdc.FRIEND3_MOBILE_STATE,
   bdc.FRIEND3_MOBILE_ADDRESS,
   uwi.job,
   uwi.current_job_time,
   uwi.total_job_time,
   uwi.company_name,
   uwi.company_type,
   uwi.company_business_type,
   uwi.company_tel,
   case
     when nsc.config_value is not null then
      1
     else
      0
   end IS_DFD_ADMIN_MEMBER,
   uka.approach_code KNOW_APPROACH_CODE,
   uka.approach_name KNOW_APPROACH_NAME,
   uwi.company_business_sort,
   uwi.company_address,
   us.spouse_name,
   us.spouse_idnum,
   us.spouse_mobile,
   us.spouse_company,
   uwi.monthly_salary,
   ui.is_deposit,
   FLOOR(DATEDIFF(CURRENT_DATE,from_unixtime(unix_timestamp(case
                                  when length(ui.id_num) = 15 then
                                   concat('19', substr(ui.id_num, 7, 6))
                                  when length(ui.id_num) = 18 then
                                   substr(ui.id_num, 7, 8)
                                end,
                                'yyyyMMdd'),
                 'yyyy-MM-dd'))/365) as birthday_age
    from (SELECT A.ID AS USER_ID,
                 A.USER_NAME AS USER_NAME,
                 A.REAL_NAME AS REAL_NAME,
                 A.GENDER AS GENDER,
                 A.MOBILE_NUM AS MOBILE_NUM,
                 A.EMAIL AS EMAIL,
                 A.IS_EMAIL AS IS_EMAIL,
                 A.REGISTER_TIME AS REGISTER_TIME,
                 A.IS_CARD AS IS_AUTHENTICATION,
                 A.IS_PHOTO AS IS_PHOTO,
                 A.IS_EDUCATION AS IS_EDUCATION_AUTH,
                 A.IS_STUDENT AS IS_STUDENT_AUTH,
                 A.IS_SPECIAL AS IS_SPECIAL,
                 A.IS_CHEAT AS IS_CHEAT,
                 A.STATUS AS STATUS,
                 CASE
                   WHEN A.STATUS = 0 THEN
                    '无效用户'
                   WHEN A.STATUS = 1 THEN
                    '有效用户'
                   WHEN A.STATUS = 2 THEN
                    '锁定用户'
                 END AS STATUS_DESC,
                 A.PC_ID AS PC_ID,
                 A.RECOMMENDER AS RECOMMENDER_ID,
                 A.USER_TYPE,
                 regexp_extract(regexp_replace(id_num, ' ', ''),
                                '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$',
                                1) ID_NUM,
                 A.FINANCE_ADVISOR AS FINANCE_ADVISOR,
                 A.BIZ_CODE REGISTER_BIZ,
                 A.is_deposit
            FROM odsopr.USER_INFO_HIST A) ui
    LEFT JOIN odsopr.PLATFORM_COMPANY_HIST pc
      ON ui.PC_ID = pc.ID
    LEFT JOIN odsopr.county_idnum_list_hist cil
      ON ui.id_num = cast(cil.cou_idnum_part as string)
    left join (select phone,
                      city,
                      province,
                      row_number() over(partition by phone order by id desc) rn
                 from odsopr.mobile_site_hist) ms
      on SUBSTRING(ui.MOBILE_NUM, 1, 7) = CAST(ms.phone AS string)
     and ms.rn = 1
    left join odsopr.user_info_detail_hist uid
      on ui.USER_ID = uid.USER_ID
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
    left join odsopr.region_hist r5
      on uid.birth_province = cast(r5.code as string)
    left join odsopr.user_approach_info_hist uai
      on ui.user_id = uai.user_id
    left join odsopr.admin_hist a
      on uai.channel_id = a.id
    left join odsopr.user_register_detail_log_hist urd
      on ui.user_id = urd.user_id
     and urd.register_status = '0000000'
    left join (SELECT USER_ID,
                      CASE
                        WHEN terminal IN ('0', '11', 'pc') THEN
                         'pc'
                        WHEN terminal IN ('1', '13', '15', '17', '5', '31') THEN
                         'android'
                        WHEN terminal IN
                             ('12', '14', '16', '2', '4', 'app', '30') THEN
                         'ios'
                        WHEN terminal IN ('6') THEN
                         'ipad'
                        WHEN terminal IN ('7') THEN
                         'weixin'
                        WHEN terminal IN ('3', '10') THEN
                         'weizhan'
                        ELSE
                         terminal
                      END terminal,
                      ip REGISTER_IP,
                      row_number() over(partition by user_id order by id desc) rn
                 FROM odsopr.USER_ACTION_LOG_HIST) ual
      on ui.user_id = ual.user_id
     and ual.rn = 1
    left join odsopr.USER_LEVEL_HIST ul
      on ui.user_id = ul.user_id
    left join odsopr.user_student_info_hist usi
      on ui.user_id = usi.user_id
    left join (select name,
                      province_id,
                      city_id,
                      type,
                      row_number() over(partition by name order by id desc) rn
                 from odsopr.student_school_hist) ss
      on usi.academy = ss.name
     and ss.rn = 1
    left join odsopr.region_hist r6
      on ss.province_id = r6.code
    left join odsopr.region_hist r7
      on ss.city_id = r7.code
    left join (select t1.user_id,
                      max(if(t1.groupkwd = '辅导员' and t1.kind = 1,
                             t1.value,
                             null)) INSTRUCTOR_NAME,
                      max(if(t1.groupkwd = '辅导员' and t1.kind = 2,
                             t1.value,
                             null)) INSTRUCTOR_MOBILE,
                      max(if(t1.groupkwd = '辅导员' and t1.kind = 2,
                             t1.call_state,
                             null)) INSTRUCTOR_MOBILE_STATE,
                      max(if(t1.groupkwd = '辅导员' and t1.kind = 2,
                             t2.city,
                             null)) INSTRUCTOR_MOBILE_ADDRESS,
                      max(if(t1.groupkwd = '父母' and t1.kind = 1,
                             t1.value,
                             null)) PARENT_NAME,
                      max(if(t1.groupkwd = '父母' and t1.kind = 2,
                             t1.value,
                             null)) PARENT_MOBILE,
                      max(if(t1.groupkwd = '父母' and t1.kind = 2,
                             t1.call_state,
                             null)) PARENT_MOBILE_STATE,
                      max(if(t1.groupkwd = '父母' and t1.kind = 2,
                             t2.city,
                             null)) PARENT_MOBILE_ADDRESS,
                      max(if(t1.groupkwd = '好友1' and t1.kind = 1,
                             t1.value,
                             null)) FRIEND1_NAME,
                      max(if(t1.groupkwd = '好友1' and t1.kind = 2,
                             t1.value,
                             null)) FRIEND1_MOBILE,
                      max(if(t1.groupkwd = '好友1' and t1.kind = 2,
                             t1.call_state,
                             null)) FRIEND1_MOBILE_STATE,
                      max(if(t1.groupkwd = '好友1' and t1.kind = 2,
                             t2.city,
                             null)) FRIEND1_MOBILE_ADDRESS,
                      max(if(t1.groupkwd = '好友2' and t1.kind = 1,
                             t1.value,
                             null)) FRIEND2_NAME,
                      max(if(t1.groupkwd = '好友2' and t1.kind = 2,
                             t1.value,
                             null)) FRIEND2_MOBILE,
                      max(if(t1.groupkwd = '好友2' and t1.kind = 2,
                             t1.call_state,
                             null)) FRIEND2_MOBILE_STATE,
                      max(if(t1.groupkwd = '好友2' and t1.kind = 2,
                             t2.city,
                             null)) FRIEND2_MOBILE_ADDRESS,
                      max(if(t1.groupkwd = '好友3' and t1.kind = 1,
                             t1.value,
                             null)) FRIEND3_NAME,
                      max(if(t1.groupkwd = '好友3' and t1.kind = 2,
                             t1.value,
                             null)) FRIEND3_MOBILE,
                      max(if(t1.groupkwd = '好友3' and t1.kind = 2,
                             t1.call_state,
                             null)) FRIEND3_MOBILE_STATE,
                      max(if(t1.groupkwd = '好友3' and t1.kind = 2,
                             t2.city,
                             null)) FRIEND3_MOBILE_ADDRESS
                 from odsopr.borrows_dunning_contact_hist t1
                 left join odsopr.mobile_site_hist t2
                   on t1.kind = 2
                  and SUBSTRING(t1.value, 1, 7) = CAST(t2.phone AS string)
                where t1.groupkwd IN
                      ('辅导员', '父母', '好友1', '好友2', '好友3')
                  and t1.kind in (1, 2)
                group by t1.user_id) bdc
      on ui.user_id = bdc.user_id
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
                      row_number() over(partition by user_id order by id desc) rn
                 from odsopr.user_work_info_hist) uwi
      on ui.user_id = uwi.user_id
     and uwi.rn = 1
    left join (select config_value,
                      row_number() over(partition by config_value order by id desc) rn
                 from odsopr.DB_NONO_SYSTEM_CONFIG_hist
                where config_name = 'DfdAdminMembers') nsc
      on ui.user_name = nsc.config_value
     and nsc.rn = 1
    left join odsopr.user_know_approach_hist uka
      on ui.user_id = uka.user_id
    left join odsopr.user_spouse_info_hist us
      on ui.user_id = us.user_id;