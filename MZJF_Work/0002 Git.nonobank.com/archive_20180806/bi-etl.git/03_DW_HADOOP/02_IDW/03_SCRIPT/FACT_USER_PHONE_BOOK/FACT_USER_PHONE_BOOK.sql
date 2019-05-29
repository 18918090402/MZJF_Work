set mapreduce.job.name = idw_fact_user_phone_book_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table IDW.FACT_USER_PHONE_BOOK
  select 'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         user_id,
         last_name,
         middle_name,
         first_name,
         real_name,
         phone
    from (select user_id,
                 first_name,
                 middle_name,
                 last_name,
                 real_name,
                 regexp_extract(phone, '^(17951)?(.*)', 2) phone,
                 row_number() over(partition by user_id, regexp_extract(phone, '^(17951)?(.*)', 2) order by real_name desc) rn
            from (select t1.user_id,
                         if(t1.first_name = '无' or t1.first_name is null,
                            '',
                            t1.first_name) first_name,
                         if(t1.last_name = '无' or t1.last_name is null,
                            '',
                            t1.last_name) last_name,
                         if(t1.middle_name = '无' or t1.middle_name is null,
                            '',
                            t1.middle_name) middle_name,
                         concat(if(t1.last_name = '无' or t1.last_name is null,
                                   '',
                                   t1.last_name),
                                if(t1.middle_name = '无' or
                                   t1.middle_name is null,
                                   '',
                                   t1.middle_name),
                                if(t1.first_name = '无' or
                                   t1.first_name is null,
                                   '',
                                   t1.first_name)) real_name,
                         regexp_replace(t2.phone_arr, '(\\D+)', '') phone
                    from odsopr.user_relation_person_info_hist t1 lateral view explode(Split(regexp_replace(phone_arr, '\\+86', ''), ',')) t2 as phone_arr
                   where t1.flag = 0) s) x
   where length(phone) >= 5
     and length(phone) <= 11
     and rn = 1;