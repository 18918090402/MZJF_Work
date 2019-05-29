drop table if exists idw.dim_insensitive_data;

create table idw.dim_insensitive_data
(	
    user_id bigint comment '用户ID'
    ,real_name string comment '用户姓名'
    ,mobile_num string comment '用户手机号'
    ,id_num string comment '用户身份证编号'
    ,dw_create_by string comment '系统字段-创建者'
    ,dw_create_time string comment '系统字段-创建时间'
    ,dw_update_by string comment '系统字段-修改者'
    ,dw_update_time string comment '系统字段-修改时间'
)
comment '数据脱敏表'
row format delimited null defined as '' stored as parquet
tblproperties ("parquet.compression"="snappy")
;



--SQL
set mapreduce.job.name=idw_dim_insensitive_data; 
set mapreduce.job.queuename =etl-dw;  

set hive.exec.parallel=true ;
set hive.groupby.skewindata=true ;
set hive.map.aggr=true ; 
set hive.enforce.bucketing=true;
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict; 
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;


 insert overwrite table idw.dim_insensitive_data
 select user_id
        ,case
            when length(trim(a.real_name)) = 0
                 or a.real_name    is NULL
                 then ''
            when length(trim(a.real_name)) = 1
                 then a.real_name
            when length(trim(a.real_name)) = 2
                 then CONCAT(substr(a.real_name,1,1) ,'*')
            when length(trim(a.real_name)) = 3
                 then CONCAT(substr(a.real_name,1,1) ,'*' ,substr(trim(a.real_name),-1))
            when length(trim(a.real_name)) > 3
                 then
                 case
                    when a.real_name like '%公司'
                        then CONCAT(substr(a.real_name,1,1) ,'*' ,substr(trim(a.real_name),-2))
                        else CONCAT(substr(a.real_name,1,1) ,'*' ,substr(trim(a.real_name),-1))
                 end
        end real_name
       ,case
              when length(trim(a.mobile_num)) = 0
                     or a.mobile_num    is NULL
                     then ''
                     else CONCAT(substr(trim(a.mobile_num),1,3), '****' ,substr(trim(a.mobile_num),-4,4))
       end mobile_num
        ,case
              when length(trim(a.id_num)) = 0
                     or a.id_num    is NULL
                     then ''
              when length(trim(a.id_num)) = 9
                     then CONCAT(substr(trim(a.id_num),1,2), '*****' ,substr(trim(a.id_num),-2,2))
              when length(trim(a.id_num)) = 15
                     then CONCAT(substr(trim(a.id_num),1,3), '*********' ,substr(trim(a.id_num),-3,3))
              when length(trim(a.id_num)) = 18
                     then CONCAT(substr(trim(a.id_num),1,3), '***********' ,substr(trim(a.id_num),-4,4))
                     else CONCAT(substr(trim(a.id_num),1,2), '***********' ,substr(trim(a.id_num),-2,2))
        end id_num
        ,'SYS' AS DW_CREATE_BY
        ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
        ,'SYS' AS DW_UPDATE_BY
        ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
  from (
             select a.id user_id
                    ,regexp_replace(a.real_name,'\[\-\·\)\_1\]\+','') real_name 
                    ,regexp_replace(a.mobile_num,'\[\_\-\]\+','') mobile_num
                    ,regexp_replace(a.id_num,'\[\-\_1\]\+','')  id_num
               from ods.t_user_info_hist a
       ) a
  ;
