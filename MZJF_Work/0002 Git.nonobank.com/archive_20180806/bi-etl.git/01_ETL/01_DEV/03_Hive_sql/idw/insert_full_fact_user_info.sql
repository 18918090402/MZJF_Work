set mapreduce.job.queuename= etl-kpi;

drop table if exists tmp.tmp_fact_user_info_01;
create table if not exists tmp.tmp_fact_user_info_01 stored as parquet as 
select user_id, max(terminal) terminal
  from odsopr.user_action_log
 where action_type = 7
 group by user_id;

drop table if exists tmp.tmp_fact_user_info_02;
create table if not exists tmp.tmp_fact_user_info_02 stored as parquet as 
select idnum,
       realname,
       school_name,
       edu_auth_time,
       is_student,
       into_school_time
  from (select idnum,
               realname,
               school_name,
               edu_auth_time,
               is_student,
               into_school_time,
               row_number() over(partition by idnum order by create_time) as rn
          from odsopr.nono_authentication
         where is_card = 1) x
 where rn = 1;

drop table if exists tmp.tmp_fact_user_info_03;
create table if not exists tmp.tmp_fact_user_info_03 stored as parquet as 
select user_id,
       max(age) as age,
       max(qq) as qq,
       max(current_province) as current_province
  from odsopr.user_info_detail
 group by user_id;

insert overwrite table idw.fact_user_info
  select /* + mapjoin(al) */
   ui.id as USER_ID, --用户ID
   ui.user_name as USER_NAME, --用户名
   ui.mobile_num as MOBILE_NUM, --手机号
   if(regexp_extract(ui.id_num, '([0-9A-Za-z]+)', 1) = 'null',
      'unknown',
      regexp_extract(ui.id_num, '([0-9A-Za-z]+)', 1)) as ID_NUM, --身份证号
   ui.user_type as USER_TYPE, --用户类型
   coalesce(na.realname, ui.real_name) as REAL_NAME, --真实姓名
   ui.gender as gender, --CASE WHEN ui.gender=1 THEN '男' WHEN ui.gender=2 THEN '女' ELSE '未知' END as GENDER,  --性别
   ui.email as EMAIL, --邮箱
   ui.status as STATUS, --状态
   ui.is_special as IS_SPECIAL, --是否特殊用户
   ui.register_time as REGISTER_TIME, --注册时间
   from_unixtime(unix_timestamp(substr(regexp_extract(ui.id_num,
                                                      '([0-9A-Za-z]+)',
                                                      1),
                                       7,
                                       8),
                                'yyyyMMdd')) as BIRTHDAY, --出生日期
   CASE
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
   END as EDUCATION, --学历
   coalesce(r1.name, '未知') as REGISTER_PROVINCE, --户籍省份
   NULL as REGISTER_CITY, --户籍城市
   coalesce(ss.name, na.school_name, '未知') as SCHOOL, --学校
   coalesce(r2.name, '未知') as SCHOOL_PROVINCE, --学校省份
   coalesce(usi.edu_start_date, cast(na.into_school_time as string), '未知') as EDU_START_DATE, --入学年份
   na.edu_auth_time as STU_AUTH_TIME, --学籍认证时间
   coalesce(na.is_student, ui.is_student) as IS_STUDENT, --学籍认证状态
   al.terminal as TERMINAL,
   coalesce(tn.terminal_name, '未知') as TERMINAL_NAME, --注册终端
   uai.channel_id as CHANNEL_ID,
   coalesce(ad.am_name, '未知') as CHANNEL_NAME, --渠道
   case
     when ui.pc_id = 18 then
      '财神'
     when ui.user_type in (0, 1) then
      'nono'
     when uai.channel_id IN (1867, 1882, 1915) then
      '麦芽'
     when uic.mobile_num is not null or
          length(regexp_extract(ui.id_num, '([0-9A-Za-z]+)', 1)) = 10 or
          uai.landing_page regexp '美国' then
      'unifi'
     when ui.user_type = 5 then
      '名校贷'
     else
      '其他'
   end as P_TYPE, --产品大类
   -- first_borrow_time as FIRST_BORROW_TIME,  --首次借款时间
   'SYS' as DW_CREATE_BY, --系统字段-创建者
   from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME, --系统字段-创建时间
   'SYS' as DW_UPDATE_BY, --系统字段-修改者
   from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME --系统字段-修改时间
    FROM odsopr.user_info ui
    LEFT JOIN tmp.tmp_fact_user_info_02 na
      on regexp_extract(ui.id_num, '([0-9A-Za-z]+)', 1) = na.idnum
    LEFT JOIN tmp.tmp_fact_user_info_03 uid
      ON ui.id = uid.user_id
    LEFT JOIN odsopr.user_student_info usi
      ON usi.user_id = ui.id
    LEFT JOIN tmp.tmp_fact_user_info_01 al
      ON al.user_id = ui.id
    LEFT JOIN idw.dim_terminal tn
      ON al.terminal = tn.terminal
    LEFT JOIN odsopr.user_approach_info uai
      ON uai.user_id = ui.id
    LEFT JOIN odsopr.admin ad
      ON ad.id = uai.channel_id
    LEFT JOIN (SELECT distinct name, province_id FROM odsopr.student_school) ss
      on usi.academy = ss.name
    LEFT JOIN odsopr.region r1
      ON cast(r1.code as string) = uid.current_province
    LEFT JOIN odsopr.region r2
      ON r2.code = ss.province_id
    left join (select distinct mobile_num from odsopr.unifi_interestratecut) uic
      on ui.mobile_num = uic.mobile_num;

drop table if exists tmp.tmp_fact_user_info_01;
drop table if exists tmp.tmp_fact_user_info_02;
drop table if exists tmp.tmp_fact_user_info_03;