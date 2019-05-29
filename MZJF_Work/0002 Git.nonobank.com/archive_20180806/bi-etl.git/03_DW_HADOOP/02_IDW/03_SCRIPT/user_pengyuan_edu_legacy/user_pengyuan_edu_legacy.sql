set mapreduce.job.queuename=etl-dw;
set mapreduce.job.name=idw_user_pengyuan_edu_legacy_01;
set hive.exec.parallel=true;

insert overwrite table idw.user_pengyuan_edu_legacy
  select 'SYS' as dw_create_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_create_time,
         'SYS' as dw_update_by,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as dw_update_time,
         user_id,
         college,
         degree,
         specialityname,
         graduatetime,
         studyresult,
         studystyle,
         create_time
    from (select user_id,
                 college,
                 degree,
                 specialityname,
                 graduatetime,
                 studyresult,
                 studystyle,
                 create_time,
                 row_number() over(partition by user_id order by graduatetime desc, id) rn
            from odsopr.user_pengyuan_edu_record_hist
           where status = '1') t
   where rn = 1;