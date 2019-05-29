set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_23_02;

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.auto.convert.join=true;
set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

INSERT OVERWRITE TABLE IDW.USER_TAG_HIST PARTITION
  (TAG_ID, HASH_PARTITION_ID)
  SELECT t1.USER_ID,
         case
           when t2.user_id is null then
            1
           else
            0
         end TAG_VALUE,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         128 TAG_ID,
         CAST(PMOD(t1.USER_ID, 10) AS INT) HASH_PARTITION_ID
    from (select user_id
            from idw.dim_user
           where stat_date = '2017-01-18'
             and nono_first_invest_time < '2017-01-01') t1
    left join (SELECT user_id, SUM(zt)
                 FROM ods.t_xcw_members_day_balance_log_hist
                WHERE dd >= DATE_SUB('2017-01-01', 91)
                  AND dd < '2017-01-01'
                GROUP BY user_id
               HAVING SUM(zt) > 0) t2
      on t1.user_id = t2.user_id;