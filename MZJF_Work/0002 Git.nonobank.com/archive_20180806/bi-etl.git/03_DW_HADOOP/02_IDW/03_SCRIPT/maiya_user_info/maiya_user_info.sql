set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_maiya_user_info_01;
set hive.exec.parallel=true;
set hive.auto.convert.join=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table idw.maiya_user_info partition
  (stat_date)
  select /*+ mapjoin(r1,r2,r3,sdi1,sdi2,sdi3)*/
         'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         ou.id maiya_user_id,
         ou.nonobank_userid user_id,
         ou.username,
         ou.mobile,
         ou.honor_level,
         ou.salary,
         ou.is_qizha,
         ou.online_account_no,
         oud.name,
         oud.sex,
         oud.idcard_address,
         oud.idcard,
         oud.address,
         oud.user_type,
         oud.province_code,
         r1.name province_name,
         oud.city_code,
         r2.name city_name,
         oud.county_code,
         r3.name county_name,
         oud.work_type,
         sdi3.dic_item_name work_type_name,
         oud.work_position,
         sdi1.dic_item_name work_position_name,
         oud.company_name,
         oud.academic,
         sdi2.dic_item_name academic_name,
         oud.family_user,
         oud.family_user_mobile,
         oud.email,
         oud.use_source,
         oud.nono_old_user,
         oud.entry_year,
         oud.spouse_name,
         oud.spouse_idcard,
         oud.spouse_mobile,
         oud.fdd_auth_status,
         ms.city mobile_address,
         date_sub(current_date(), 1) stat_date
    from (select *,
                 row_number() over(partition by nonobank_userid order by id) rn
            from odsopr.ord_user_hist
           where disabled = 0) ou
    left join (select *,
                      row_number() over(partition by user_id order by id) rn
                 from odsopr.ord_user_detail_hist
                where disabled = 0) oud
      on ou.id = oud.user_id
     and oud.rn = 1
    left join odsopr.region_hist r1
      on oud.province_code = cast(r1.code as string)
    left join odsopr.region_hist r2
      on oud.city_code = cast(r2.code as string)
    left join odsopr.region_hist r3
      on oud.county_code = cast(r3.code as string)
    left join odsopr.sys_dic_item_hist sdi1
      on cast(oud.work_position as string) = sdi1.dic_item_value
     and sdi1.disabled = 0
     and sdi1.dic_id = 5
    left join odsopr.sys_dic_item_hist sdi2
      on sdi2.dic_id = 20
     and sdi2.disabled = 0
     and cast(oud.academic as string) = sdi2.dic_item_value
    left join odsopr.sys_dic_item_hist sdi3
      on sdi3.dic_id = 4
     and sdi3.disabled = 0
     and cast(oud.work_type as string) = sdi3.dic_item_value
    left join (select phone,
                      city,
                      province,
                      row_number() over(partition by phone order by id desc) rn
                 from odsopr.mobile_site_hist) ms
      on substring(ou.mobile, 1, 7) = cast(ms.phone as string)
     and ms.rn = 1
   where ou.rn = 1;