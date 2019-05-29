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




 # ---    ETL_SCHEDULING_PLATFORM_44444 ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_SCHEDULING_PLATFORM_44444-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_44444_$etllog.log

# sqoop import \
# -D mapreduce.job.queuename=etl-dw \
# -D mapreduce.job.name==Sqoop_TMP_USER_LOGON_INFO \
# --connect jdbc:mysql://172.16.0.109:3308/nonobank_app?zeroDateTimeBehavior=round --username risk --password "WYTn1Q1q" \
# --query 'SELECT A.`ID`,A.`USER_CODE`,A.`LOGON_TIME`,A.`LOGON_STATUS`,A.`LOGON_STATUS_DESC`,A.`LOGON_TYPE`,A.`OS_TYPE`,A.`OS_VERSION`,A.`APP_NAME`,A.`APP_VERSION`,A.`IP`,A.`GUID`,A.`REMARK`,A.`CREATE_TIME`,A.`UPDATE_TIME`,A.`CREATER`,A.`UPDATER`,A.`VERSION` ,"SYS" AS DW_CREATE_BY , SYSDATE() AS DW_CREATE_TIME , "SYS" AS DW_UPDATE_BY , SYSDATE() AS DW_UPDATE_TIME FROM nonobank_app.user_logon_info AS A WHERE (update_time>="2016-11-24 13:51:14" OR "F" LIKE "F%" ) AND $CONDITIONS' \
# --split-by id \
# -m 1 \
# --hive-drop-import-delims \
# --fields-terminated-by '\001' --lines-terminated-by '\n' --null-string '\\N' --null-non-string '\\N' \
# --hive-import \
# --hive-database tmp \
# --hive-overwrite \
# --hive-table TMP_USER_LOGON_INFO_aaa \
# --delete-target-dir \
# --target-dir "/user/hive/warehouse/tmp.db/TMP_USER_LOGON_INFO_aaa" \
# -- --default-character-set=utf-8 ;


sqoop export \
-D mapred.job.name=t_user_logon_info_all_export \
--connect jdbc:mysql://172.16.0.165:3307/ODS   \
--username BI  --password kVyzlxsD+jKYgbUG \
--table T_USER_LOGON_INFO        \
--export-dir /user/hive/warehouse/stg.db/t_user_logon_info_hist  \
--input-null-string '\\N' \
--input-null-non-string '\\N' \
--fields-terminated-by '\001';


    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts finish ....------ETL_SCHEDULING_PLATFORM_44444-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_44444_$etllog.log

