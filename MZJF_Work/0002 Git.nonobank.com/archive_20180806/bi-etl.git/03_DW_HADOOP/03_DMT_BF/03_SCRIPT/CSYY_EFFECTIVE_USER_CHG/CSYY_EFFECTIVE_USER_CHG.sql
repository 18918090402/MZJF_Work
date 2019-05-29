set mapreduce.job.name = DMT_BF_CSYY_EFFECTIVE_USER_CHG_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table DMT_BF.CSYY_EFFECTIVE_USER_CHG partition
  (STAT_DATE)
  select 'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         coalesce(t1.user_id, t2.user_id) user_id,
         coalesce(t1.user_code, t2.user_code) user_code,
         coalesce(t1.mobile_num, t2.mobile_num) mobile_num,
         coalesce(t1.gender, t2.gender) gender,
         coalesce(t1.real_name, t2.real_name) real_name,
         case
           when t1.user_id is null then
            'D'
           when t2.user_id is null then
            'I'
           when t1.user_id is not null and t2.user_id is not null then
            'U'
         end chg_flag,
         '{T_SUB_1}' stat_date
    from (select user_id, user_code, mobile_num, gender, real_name
            from DMT_BF.CSYY_EFFECTIVE_USER
           where stat_date = '{T_SUB_1}') t1
    full outer join (select user_id,
                            user_code,
                            mobile_num,
                            gender,
                            real_name
                       from (select user_id,
                                    user_code,
                                    mobile_num,
                                    gender,
                                    real_name,
                                    rank() over(order by stat_date desc) rn
                               from DMT_BF.CSYY_EFFECTIVE_USER
                              where stat_date < '{T_SUB_1}') s
                      where rn = 1) t2
      on t1.user_id = t2.user_id
   where t1.user_id is null
      or t2.user_id is null
      or coalesce(t1.user_code, -1) <> coalesce(t2.user_code, -1)
      or coalesce(t1.mobile_num, '-1') <> coalesce(t2.mobile_num, '-1')
      or coalesce(t1.gender, -1) <> coalesce(t2.gender, -1)
      or coalesce(t1.real_name, '-1') <> coalesce(t2.real_name, '-1');