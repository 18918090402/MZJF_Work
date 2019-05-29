set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=IDW_FACT_MAIYA_USER_INFO_01;
set hive.exec.parallel=true;
set hive.auto.convert.join=true;

insert overwrite table idw.fact_maiya_user_info
  select /*+ mapjoin(r1,r2,r3,sdi1,sdi2,sdi3)*/
   'SYS' as dw_create_by,
   from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
   'SYS' as dw_update_by,
   from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
   ou.id MAIYA_USER_ID,
   ui.id USER_ID,
   ou.USERNAME,
   ou.MOBILE,
   ou.HONOR_LEVEL,
   ou.SALARY,
   ou.IS_QIZHA,
   ou.ONLINE_ACCOUNT_NO,
   oud.NAME,
   oud.SEX,
   oud.IDCARD_ADDRESS,
   oud.IDCARD,
   oud.ADDRESS,
   oud.USER_TYPE,
   oud.PROVINCE_CODE,
   r1.name PROVINCE_NAME,
   oud.CITY_CODE,
   r2.name CITY_NAME,
   oud.COUNTY_CODE,
   r3.name COUNTY_NAME,
   oud.WORK_TYPE,
   sdi3.dic_item_name WORK_TYPE_NAME,
   oud.WORK_POSITION,
   sdi1.dic_item_name WORK_POSITION_NAME,
   oud.COMPANY_NAME,
   oud.ACADEMIC,
   sdi2.dic_item_name ACADEMIC_NAME,
   oud.FAMILY_USER,
   oud.FAMILY_USER_MOBILE,
   oud.EMAIL,
   oud.USE_SOURCE,
   oud.NONO_OLD_USER,
   oud.ENTRY_YEAR,
   oud.SPOUSE_NAME,
   oud.SPOUSE_IDCARD,
   oud.SPOUSE_MOBILE,
   oud.FDD_AUTH_STATUS,
   ms.city MOBILE_ADDRESS
    from odsopr.ORD_USER_HIST ou
    left join (select *,
                      row_number() over(partition by user_id order by id desc) rn
                 from odsopr.ORD_USER_DETAIL_HIST
                where disabled = 0) oud
      on ou.id = oud.user_id
     and oud.rn = 1
    LEFT JOIN odsopr.region_hist r1
      on oud.province_code = cast(r1.code as string)
    LEFT JOIN odsopr.region_hist r2
      on oud.city_code = cast(r2.code as string)
    LEFT JOIN odsopr.region_hist r3
      on oud.county_code = cast(r3.code as string)
    left join odsopr.sys_dic_item_hist sdi1
      on cast(oud.work_position as string) = sdi1.dic_item_value
     and sdi1.disabled = 0
     and sdi1.dic_id = 5
    left join odsopr.sys_dic_item_hist sdi2
      on sdi2.dic_id = 20
     AND sdi2.disabled = 0
     AND cast(oud.academic as string) = sdi2.dic_item_value
    left join odsopr.sys_dic_item_hist sdi3
      on sdi3.dic_id = 4
     AND sdi3.disabled = 0
     AND cast(oud.work_type as string) = sdi3.dic_item_value
    left join odsopr.user_info_hist ui
      on cast(ou.nonobank_userid as bigint) = ui.id
    left join (select phone,
                      city,
                      province,
                      row_number() over(partition by phone order by id desc) rn
                 from odsopr.mobile_site_hist) ms
      on SUBSTRING(ou.mobile, 1, 7) = CAST(ms.phone AS string)
     and ms.rn = 1
   where ou.disabled = 0;