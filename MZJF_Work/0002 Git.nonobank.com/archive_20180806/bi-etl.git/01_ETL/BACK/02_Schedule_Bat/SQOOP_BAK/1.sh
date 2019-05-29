#!/bin/bash
cd /home/localadmin/ETL/02_Schedule_Bat
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%Y%m%d_%H_%M_%S")


JAVA_HOME=/usr/local/java
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH


export CDH_HOME=/opt/cloudera/parcels/CDH
export PATH=$CDH_HOME/bin:$PATH


date="$(date +"%Y-%m-%d %H:%M:%S")"

export LANG="en_US.UTF-8"




 # ---    ETL_SCHEDULING_PLATFORM_11111 ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_SCHEDULING_PLATFORM_11111-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_11111_$etllog.log

# sqoop import \
# -D mapreduce.job.queuename=etl-dw \
# -D mapreduce.job.name==Sqoop_TMP_USER_ACTION_LOG_aaa \
# --connect jdbc:mysql://172.16.0.109:3306/db_nono?zeroDateTimeBehavior=round --username risk --password "WYTn1Q1q" \
# --query 'SELECT A.`ID`,A.`USER_ID`,A.`ACTION_CONTENT`,CAST(A.`ACTION_TYPE` AS SIGNED ) AS `ACTION_TYPE`,A.`TERMINAL`,A.`IP`,A.`CREATE_TIME`,A.`UPDATE_TIME`,A.`CREATER`,A.`UPDATER`,A.`VERSION`,A.`ACTION_FROM` ,"SYS" AS DW_CREATE_BY , SYSDATE() AS DW_CREATE_TIME , "SYS" AS DW_UPDATE_BY , SYSDATE() AS DW_UPDATE_TIME FROM db_nono.user_action_log AS A WHERE (update_time>="2016-11-24 13:51:14" OR "F" LIKE "F%" ) AND $CONDITIONS' \
# --split-by id \
# -m 1 \
# --hive-drop-import-delims \
# --fields-terminated-by '\001' --lines-terminated-by '\n' --null-string '\\N' --null-non-string '\\N' \
# --hive-import \
# #--create-hive-table #CREATE TABLE 
# --hive-database tmp \
# --hive-overwrite \
# --hive-table TMP_USER_ACTION_LOG_aaa \
# --delete-target-dir \
# --target-dir "/user/hive/warehouse/tmp.db/TMP_USER_ACTION_LOG_aaa" \
# -- --default-character-set=utf-8 ;


sqoop export \
-D mapred.job.name=t_user_action_log_all_export \
--connect jdbc:mysql://172.16.0.165:3307/ODS   \
--username BI  --password kVyzlxsD+jKYgbUG \
--table T_USER_ACTION_LOG        \
--export-dir /user/hive/warehouse/stg.db/t_user_action_log_hist  \
--input-null-string '\\N' \
--input-null-non-string '\\N' \
--fields-terminated-by '\001';


    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts finish ....------ETL_SCHEDULING_PLATFORM_11111-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_11111_$etllog.log

