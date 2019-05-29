set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_pengyuan_stu_legacy_01;
set hive.exec.parallel=true;

insert overwrite table idw.user_pengyuan_stu_legacy
  select 'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         ui.user_id,
         t.college_level,
         t.college,
         t.start_time,
         t.create_time
    from (select idnum,
                 college_level,
                 college,
                 start_time,
                 create_time,
                 row_number() over(partition by idnum order by create_time desc) rn
            from odsopr.pengyuan_recharge_log_hist prl
           where (prl.response LIKE "%customerType>2</customerType>%" OR
                 prl.response LIKE "%customerType>3</customerType>%" OR
                 prl.response LIKE "%一致%")
             and prl.response NOT LIKE "%不一致%"
             and query_id IN ('25126', '25159', '25184')
             and status = 1) t
    join idw.user_info ui
      on ui.id_num = t.idnum
     and ui.stat_date = '{T_SUB_1}'
     and t.rn = 1;