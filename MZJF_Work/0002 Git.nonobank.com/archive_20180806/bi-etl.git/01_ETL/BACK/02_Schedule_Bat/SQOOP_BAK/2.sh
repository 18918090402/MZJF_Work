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




 # ---    ETL_SCHEDULING_PLATFORM_22222 ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_SCHEDULING_PLATFORM_22222-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_22222_$etllog.log

# sqoop import \
# -D mapreduce.job.queuename=etl-dw \
# -D mapreduce.job.name==Sqoop_TMP_FINANCE_LOG \
# --connect jdbc:mysql://172.16.0.109:3306/db_nono?zeroDateTimeBehavior=round --username risk --password "WYTn1Q1q" \
# --query 'SELECT A.`ID`,A.`ACCOUNT_ID`,A.`OPPOSITE_ACCOUNT_ID`,A.`OPERATION_RELATION`,A.`USER_ID`,A.`ROLE_ID`,A.`OWNER_ID`,A.`AMOUNT`,A.`INCOME`,A.`EXPEND`,A.`BALANCE`,A.`LOCKING`,A.`REMARK`,A.`CREATE_YEAR`,A.`CREATE_MONTH`,A.`VERSION`,A.`CREATE_TIME`,A.`UPDATE_TIME`,A.`TABLE_NAME`,A.`KEY_VALUE`,A.`PROOF_ID` ,"SYS" AS DW_CREATE_BY , SYSDATE() AS DW_CREATE_TIME , "SYS" AS DW_UPDATE_BY , SYSDATE() AS DW_UPDATE_TIME FROM db_nono.finance_log AS A WHERE (update_time>="2016-11-24 13:51:14" OR "F" LIKE "F%" ) AND $CONDITIONS' \
# --split-by id \
# -m 1 \
# --hive-drop-import-delims \
# --fields-terminated-by '\001' --lines-terminated-by '\n' --null-string '\\N' --null-non-string '\\N' \
# --hive-import \
# --hive-database tmp \
# --hive-overwrite \
# --hive-table TMP_FINANCE_LOG_aaa \
# --delete-target-dir \
# --target-dir "/user/hive/warehouse/tmp.db/TMP_FINANCE_LOG_aaa" \
# -- --default-character-set=utf-8 ;

sqoop export \
-D mapred.job.name=t_finance_log_all_export \
--connect jdbc:mysql://172.16.0.165:3307/ODS   \
--username BI  --password kVyzlxsD+jKYgbUG \
--table T_FINANCE_LOG        \
--export-dir /user/hive/warehouse/stg.db/t_finance_log_hist  \
--input-null-string '\\N' \
--input-null-non-string '\\N' \
--fields-terminated-by '\001';


    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts finish ....------ETL_SCHEDULING_PLATFORM_22222-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_22222_$etllog.log

